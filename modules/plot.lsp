;; @module plot.lsp
;; @description Routines for creating data plots.
;; @version 1.1 initial release
;; @version 1.2 allow different length data vectors
;; @author Lutz Mueller, September 2011
;;
;; In its initial release the <tt>plot.lsp</tt> module can draw
;; simple line plots from one to five data sets. In its simplest
;; form only the <tt>plot</tt> command is necessary. A group of
;; parameters can be set to further customize the plot. Plots can
;; be save to a graphics file.
;;
;; Load the module using:
;; <pre>(load "plot.lsp")</pre>
;; This module runs the newLISP Java based Guiserver. The file
;; <tt>guiserver.jar</tt> is installed by one of the newLISP binary
;; installers in a standard location. Executing <tt>(test-plot)</tt>
;; will generate a test plot which also can be seen 
;; @link http://newlisp.org/code/example-plot.png here .

;; @syntax (plot <list-data> [<list-data> . . . ])
;; @param <list-data> One to five lists of data points.
;; <br>
;; The function draws one or more horizontal data lines from up
;; to five data sets in <list-data>. Colors are chosen in the sequence
;; red, green, blue, yellow and purple.
;; <br><br>
;; The following example doesn't set any extra options and plots to random
;; data sets. Scale and labels on the vertical and horizontal axis
;; will be set automatically. No title, sub-title and legends will
;; be printed. 
;;
;; @example
;; (plot (random 10 5 50) (normal 10 0.5 50))

;; Several variables can be set optionally to change the size,
;; and positioning of the plot area in the image.
;; Other variables can be set to control the partioning of the grid,
;; labeling of the horizontal axis and legend.
;; The following list shows all parameters with their default
;; values:
;; <pre>
;; ; mandatory
;; plot:wwidth        640 ; window width in pixels
;; plot:wheight       420 ; window height in pixels<br>
;; plot:origin-x       64 ; top left x of plot area
;; plot:origin-y       64 ; top left y of plot area<br>
;; plot:pwidth        520 ; width of plot area
;; plot:pheight       280 ; height of plot area<br><br>
;; ; optional
;; plot:data-min      nil ; minimum value on the Y axis 
;; plot:data-max      nil ; maximum value on the Y axis 
;; plot:title         nil ; top centered main title
;; plot:sub-title     nil ; sub title under main title<br>
;; plot:unit          nil ; a unit label centered left to the Y axis
;; plot:labels        nil ; a list of string labels for vertical grid
;; plot:legend        nil ; a list of string labels
;; </pre>
;;
;; Only the the first group of variables is mandatory and preset to
;; the values shown above. Options in the second group will be either
;; suppressed:
;; <tt>plot:title</tt>, <tt>plot:sub-title</tt>, <tt>plot:unit</tt>, <tt>plot:legend</tt><br><br>
;; or set automatically calculating optimal values from the data points:
;; <tt>plot:data-min</tt>, <tt>plot:data-max</tt>, <tt>plot:labels</tt>.<br><br>
;; Both, <tt>plot:data-min</tt> and <tt>plot:data-max</tt> values must be set at the same
;; time. Setting only one will not have any effect.<br><br>

;; The following example sets several options then plots and 
;; exports the image to a PNG graphics file:
;;
;; @example
;; (set 'plot:title "The Example Plot")
;; (set 'plot:sub-title "several random data sets")
;; (set 'plot:labels '("1" "" "20" "" "40" "" "60" "" "80" "" "100"))
;; (set 'plot:legend  '("first" "second" "third" "fourth"))
;;
;; ; display plot image
;; (plot (random 10 5 100) 
;;       (normal 10 0.5 100)
;;       (normal 8 2 100) 
;;       (normal 5 1 100) )
;;
;; ; save the displayed image to a file
;; (plot:export "example-plot.png")
;; 

;; @syntax (plot:export <str-file-name>)
;; @param <str-file-name> The name of the file.
;;
;; Exports the current plot shown to a file in PNG format.
;;
;; @example
;; (plot:export "example-plot.png")

;; See the example plot
;; @link http://newlisp.org/code/example-plot.png here .

(define (plot:export file-name)
    (gs:export file-name))


(set-locale "C")
(load (append (env "NEWLISPDIR") "/guiserver.lsp")) 

(context 'plot)

(set 'wwidth 640)
(set 'wheight 420)

(set 'origin-x 64)
(set 'origin-y 64)

(set 'pwidth 520)
(set 'pheight 280)

(set 'title nil)
(set 'sub-title nil)
(set 'unit nil)
(set 'data-min nil)
(set 'data-max nil)
(set 'labels nil)
(set 'legend nil)

; colors
(set 'text-color '(1.0 1.0 1.0))
(set 'grid-color '(0.4 0.4 0.4))

(set 'line-color (array 5 '(
    (1.0 0.35 0.35) ; red
    (0.0 0.9 0.0)   ; green
    (0.6 0.6 1.0)   ; blue
    (0.9 0.7 0.0)   ; orange
    (0.9 0.3 0.9)   ; purple
)))

; round to 3 digits precision
; calculate rounding digits from (sub max min)
; then apply to all numbers
(define (rnd num)
     (round num (- (log num 10) 2)))

; take one or more date vectors (lists) as arguments
(define (plot:plot)
    (gs:init) 
    ;; describe the GUI
    (gs:frame 'PlotWindow 100 100 wwidth wheight "Plot")
    (gs:set-resizable 'PlotWindow nil)
    (gs:canvas 'PlotCanvas)
    (gs:set-background 'PlotCanvas 0.3 0.3 0.3)
    (gs:add-to 'PlotWindow 'PlotCanvas)
    (gs:set-stroke 1.0)
    (gs:set-translation  origin-x origin-y)
    (gs:draw-rect 'PlotArea -1 -1  (+ pwidth 3) (+ pheight 3))
    (gs:color-tag 'PlotArea text-color)
    (set 'start (time-of-day))

    (gs:set-visible 'PlotWindow true)
    ; draw title
    (when title 
        (gs:set-font 'PlotCanvas "Lucida Sans Typewriter Regular" 18 "bold")        
        (gs:draw-text 'title title 
            (/ (- pwidth (* (length title) 11)) 2) -34 text-color)
    )
    ; draw sub title
    (when sub-title
        (gs:set-font 'PlotCanvas "Lucida Sans Typewriter Regular" 12 "plain")       
        (gs:draw-text 'title sub-title 
            (/ (- pwidth (* (length sub-title) 7)) 2) -18 text-color)
    )

    ; set data min, max and range over all plot vectors
    (set 'M (length (args)))
    (set 'N 0)
    (unless (and data-min data-max)
        (dotimes (m M)
            (set 'data (args m) )
            (set 'N (max N (length data)))
            (if (= 0 m)
                (begin
                    (set 'ymin (apply min data))
                    (set 'ymax (apply max data)) )
                (begin
                    (set 'ymin (min ymin (apply min data)))
                    (set 'ymax (max ymax (apply max data))))
            )
        )
    )

    ; overwrite ymin and ymax if data-min/mx are defined
    (when (and data-min data-max)
        (set 'ymin data-min)
        (set 'ymax data-max))

    (set 'y-range (sub ymax ymin))

    ; draw horizontal grid lines
    (for (i 1 4)
        (let (y (/ (* i pheight) 5) )
            (gs:draw-line 'Grid 1 y pwidth y grid-color))
    )

    ; draw vertical grid lines
    (if labels
        (set 'L (- (length labels) 1))
        (set 'L (if (< N 50) (- N 1) 10)))

    (for (i 1 (- L 1))
        (let (x (/ (* i pwidth) L) )
             (gs:draw-line 'Grid x 1 x pheight grid-color)
        )
    )

    ; draw labels for x-range under vertical grid lines
    (gs:set-font 'PlotCanvas "Monospaced" 12 "plain")
    (if labels
      (let (step (div pwidth (- (length labels) 1))
          cnt 0 )
         (dolist (t labels)
           (unless (empty? t)
             (gs:draw-text 'Grid t (int (sub (mul step cnt) (mul (length t) 3.5)))  
                (+ pheight 14) text-color))
           (inc cnt))
      )
      ; else if no labels
      (begin
        (gs:draw-text 'Grid (format "%5d" 1) -32 (+ pheight 15) text-color)
        (gs:draw-text 'Grid (format "%5d" N) (- pwidth 26) (+ pheight 15) text-color)
      )
    )
 
                
    ; draw y labels as of y-range ledt to horizontal grid lines
    (gs:set-font 'PlotCanvas "Monospaced" 12 "plain")
    (set 'y-format (if 
            (< y-range 1)   "%8.3f"
            (< y-range 10)  "%8.2f"  
            (< y-range 100) "%8.1f"
            true            "%8.0f"))
    (dotimes (i 6)
        (let (y (- pheight -4 (* i (/ pheight 5))))
            (gs:draw-text 'Grid 
            (format y-format (add ymin (mul i (div y-range 5)))) 
                   -64 y text-color))
    )

    ; draw unit label to left center of grid
    (when unit
        (gs:draw-text 'Grid unit -50 (+ (/ pheight 2) 4) text-color))

    ; for each data vector draw data
    (gs:set-stroke 1.5)
    (dotimes (m M)
        (set 'data (args m))
        ; draw data
        (set 'last-x nil 'last-y nil)
        (dotimes (i (length data))
            (let (x (div (mul i pwidth) (- N 1)) 
                  y (div (mul (sub (pop data) ymin) pheight) y-range))
                (when last-x 
                    (gs:draw-line 'seg last-x (- pheight last-y) 
                        (int x) (int (- pheight y)) (line-color m)))
                (set 'last-x (int x) 'last-y (int y))
            )
        )
    )

    ; draw legend depending on the number of plot lines
    ; style below 
    (dotimes (m M)
        (let (x (* m (/ pwidth 5)))
            (when (and (list? legend) (= M (length  legend))) 
                (gs:draw-line 'legend x (+ pheight 30) (+ x 25) (+ pheight 30) (line-color m))
                (gs:draw-text 'legend (legend m) (+ x 1 30) (+ pheight 33) text-color)
            )
        )
    )
    ; style to the right
    (gs:set-visible 'PlotWindow true)
)

(context MAIN)

; test
(define (test-plot)
    (set 'plot:title "The Example Plot")
    (set 'plot:sub-title "several random data sets")
    (set 'plot:labels '("1" "" "20" "" "40" "" "60" "" "80" "" "100"))
    (set 'plot:legend  '("first" "second" "third" "fourth"))
    ;(set 'plot:data-min 0 'plot:data-max 20)

    (set 'plot:unit "unit")
    ; display plot
    (plot (random 10 5 100) 
          (normal 10 0.5 100)
          (normal 8 2 100) 
          (normal 5 1 100) )

    ; save the display to a file
    (plot:export "example-plot.png")
)

;(plot (random 10 5 50) (normal 10 0.5 50))

;(test-plot)
;(exit)
