#
# USAGE:
#
# make <option>
#
# to see a list of all options, enter 'make help'
#
# Note! on some systems do 'gmake' instead of 'make' (most BSD)
#
# for 'make install' you have to login as 'root' else do 'make install_home'
# note that 'make install_home' will not install guiserver files which
# must be in /usr/share/newlisp in MacOX X and UNIX machines
#
# to make the distribution archive:  'make dist'
#
# to clean up (delete .o *~ core etc.):  'make clean'
#
#
# Compile flags used:
#
# NANOSLEEP enables capability to return time in milli secs in 'time'
# READLINE enables commandline editing and history, requires readline lib
# NOIMPPORT disables the 'import' shared library import primitive
#
# Regular expressions now on all platforms Perl Compatible Regular Expresssions PCRE
# see http://www.pcre.org. PCRE can be localized to other languages than English
# by generating different character tables, see documentation at www.pcre.org
# and file LOCALIZATION for details
#

VERSION = 10.1.5
INT_VERSION = 10105

default: makefile_configure
	make -f makefile_configure

makefile_configure:
	./configure

all: default

help:
	@echo "Do one of the following:"
	@echo
	@echo "  make linux           # newlisp for LINUX with readline support"
	@echo "  make linux_utf8      # newlisp for LINUX UTF-8 and readline support"
	@echo "  make linux_lib       # newlisp.so as shared library for LINUX"
	@echo "  make linux_lib_utf8  # newlisp.so as shared library for LINUX with UTF-8"
	@echo "  make bsd             # newlisp for FreeBSD and OpenBSD"
	@echo "  make bsd_utf8        # newlisp for FreeBSD and OpenBSD with UTF-8"
	@echo "  make bsd_lib         # newlisp.so as shared library for FreeBSD, OpenBSD, NetBSD"
	@echo "  make netbsd          # newlisp for NetBSD, readline support"
	@echo "  make netbsd_utf8     # newlisp for NetBSD, readline and UTF-8 support)"
	@echo "  make darwin          # newlisp for Mac OSX v.10.4 or later, readline support"
	@echo "  make darwin_utf8     # newlisp for Mac OSX v.10.4 or later, readline and UTF-8 support"
	@echo "  make darwinLP64_utf8 # newlisp for Mac OSX v.10.5 or later, 64-bit, readline and UTF-8 support"
	@echo "  make darwin_lib      # newlisp for Mac OSX v.10.3 or later as shared library"
	@echo "  make universal_utf8  # like makefile_darwin_utf8, but both architectures"
	@echo "  make llvm            # make for OSX with UTF-8 support using the LLVM compiler"
	@echo "  make opensolaris     # newlisp for Sun SOLARIS on Intel processor (little tested)"
	@echo "  make sunos           # newlisp for SunOS (tested on Sparc)"
	@echo "  make sunos_utf8      # newlisp for SunOS UTF-8 (tested on Sparc)"
	@echo "  gmake aix            # newlisp for IBM AIX 32-bit using the xlc_r compiler and for UTF-8"
	@echo "  gmake aix_gcc        # newlisp for IBM AIX 32-bit using the gcc compiler and for UTF-8"
	@echo "  make mingw           # newlisp.exe for Win32 (MinGW compiler)"
	@echo "  make mingw_utf8      # newlisp.exe for Win32 UTF-8 (MinGW icompiler)"
	@echo "  make mingwdll        # newlisp.dll for Win32 (MinGW compiler)"
	@echo "  make mingwdll_utf8   # newlisp.dll for Win32 UTF-8 (MinGW compiler)"
	@echo "  make os2             # newlisp for OS/2 GCC 3.3.5 with libc061.dll"
	@echo "  make tru64           # newlisp for HP tru64 with 32 bit pointers - read doc/TRU64BUILD"
	@echo 
	@echo "  make install         # install on LINUX/UNIX in /usr/bin and /usr/share (need to be root)"
	@echo "  make uninstall       # uninstall on LINUX/UNIX from /usr/bin and /usr/share (need to be root)"
	@echo "  make install_home    # install on LINUX/UNIX in users home directory "
	@echo "  make uninstall_home  # uninstall on LINUX/UNIX from users home directory "
	@echo
	@echo "  make clean           # remove all *.o and .tar files etc. USE BETWEEN FLAVORS!"
	@echo "  make check           # run qa-dot, qa-net, qa-xml etc. test scripts"
	@echo "  make test            # same as 'make check'"
	@echo "  make version         # replace version number in several files after changing in Makefile"
	@echo
	@echo "Note! on some systems use gmake instead of make."
	@echo "Note! not all makefiles are listed in this help, specifically 64-bit versions."
	@echo " "
	@echo "For not listed makefiles do a: make -f makefile_xxxxx."
	@echo "Readline is for commandline editing support and requires libreadline and headerfiles."
	@echo "Not all makefiles contain libreadline support, but is easy to add (see other makefieles)."
	@echo "If there is no UTF-8 option for your OS, consult makefile_xxx."

linux:
	make -f makefile_linux

linux_utf8:
	make -f makefile_linux_utf8

linux_lib:
	make -f makefile_linux_lib

linux_lib_utf8:
	make -f makefile_linux_lib_utf8

tru64:
	make -f makefile_tru64

bsd:
	make -f makefile_bsd

bsd_utf8:
	make -f makefile_bsd_utf8

bsd_lib:
	make -f makefile_bsd_lib

netbsd:
	make -f makefile_netbsd

netbsdi_utf8:
	make -f makefile_netbsd_utf8

darwin_lib:
	make -f makefile_darwin_lib

universal_utf8:
	make -f makefile_darwin_universal_utf8

darwin:
	make -f makefile_darwin
	
darwin_utf8:
	make -f makefile_darwin_utf8

darwinLP64_utf8:
	make -f makefile_darwinLP64_utf8

llvm:
	make -f makefile_darwin_utf8_llvm

sunos:
	make -f makefile_sunos

sunos_utf8:	
	make -f makefile_sunos_utf8

opensolaris:
	make -f makefile_opensolaris

aix:
	gmake -f makefile_aix_utf8_xlc

aix_gcc:
	gmake -f makefile_aix_utf8_gcc


mingw:
	make -f makefile_mingw

mingw_utf8:
	make -f makefile_mingw_utf8

mingwdll:
	make -f makefile_mingwdll

mingwdll_utf8:
	make -f makefile_mingwdll_utf8

os2: 
	make -f makefile_os2 
	
winall:
	make clean
	make -f makefile_mingw
	rm *.o
	make -f makefile_mingwdll
	rm *.o
	./newlisp qa-dot

winall_utf8:
	make clean
	make -f makefile_mingw_utf8
	rm *.o
	make -f makefile_mingwdll_utf8
	rm *.o
	./newlisp qa-dot
	tar czvf newlisp-win-utf8.tgz newlisp.exe newlisp.dll


wings:
	make -f makefile_wings
	

# scripts for making UBUNTU linux packages

dpkg:
	make clean
	make -f makefile_linux
	cp util/description-pak .
	sudo checkinstall --nodoc --maintainer "lutz@nuevatec.com" --pkgrelease 1 --default
	rm description-pak
	mv *.deb ../Desktop

dpkg_utf8:
	make clean
	make -f makefile_linux_utf8
	cp util/description-pak .
	sudo checkinstall --nodoc --maintainer "lutz@nuevatec.com" --pkgrelease utf8 --default
	rm description-pak
	mv *.deb ../Desktop

# scripts for making Mac OS X disk image installers
# Note that since Mac OX X update 10.5.6 'PackageMaker -d -o'
# bombs out in the following script, but is fixed in 10.6.0
# Snow Leopard.
dmg_ppc:
	lipo newlisp-universal -output newlisp -thin ppc
	sudo rm -rf ../Package_contents
	make -f makefile_darwin_package
	/Developer/Applications/Utilities/PackageMaker.app/Contents/MacOS/PackageMaker \
		-d ~/newlisp/OSX-package/newLISPpackage-project.pmdoc/ -o \
		~/newlisp/OSX-package/newLISP-image/newLISPpackage.pkg
	-rm ~/newlisp/OSX-package/newlisp-$(VERSION)-ppc.dmg
	hdiutil create -srcfolder ~/newlisp/OSX-package/newLISP-image \
		~/newlisp/OSX-package/newlisp-$(VERSION)-ppc.dmg

dmg_intel:
	lipo newlisp-universal -output newlisp -thin i386
	sudo rm -rf ../Package_contents
	make -f makefile_darwin_package
	/Developer/Applications/Utilities/PackageMaker.app/Contents/MacOS/PackageMaker \
		-d ~/newlisp/OSX-package/newLISPpackage-project.pmdoc/ -o \
		~/newlisp/OSX-package/newLISP-image/newLISPpackage.pkg
	-rm ~/newlisp/OSX-package/newlisp-$(VERSION)-intel.dmg
	hdiutil create -srcfolder ~/newlisp/OSX-package/newLISP-image \
		~/newlisp/OSX-package/newlisp-$(VERSION)-intel.dmg

# this cleans up the distribution directory for a clean build
distclean: clean
	-rm -f config.h makefile_configure newlisp test-*

# alternate naming for clean
clean:
	-rm -f *~ *.bak *.o *.obj *.map *.core core *.tgz guiserver/java/._* TEST newlisp-universal
	-rm -f guiserver/*.class doc/*~ util/*~ examples/*~ modules/*~
	-rm -f doc/*.bak util/*.bak examples/*.bak modules/*.bak
	-chmod 644 *.h *.c *.lsp Makefile makefile*
	-chmod 755 configure configure-alt examples/*
	-chmod 644 doc/* modules/*.lsp examples/*.lsp examples/*.html
	-chmod 644 guiserver/*
	-chmod 755 guiserver/images
	-chmod 644 guiserver/images/*
	-chmod 755 guiserver/java
	-chmod 644 guiserver/java/*
	-rm -f makefile_configure

# run test scripts
check:
	./newlisp qa-dot
	./newlisp qa-dictionary
	./newlisp qa-xml
	./newlisp qa-setsig
	./newlisp qa-net
	./newlisp qa-cilk
	./newlisp qa-ref
	./newlisp qa-message
	./newlisp qa-win32dll

# old naming for check 
test: check

# NOTE when changing PREFIX, then newlisp should only run
# run in an environment, where NEWLISPDIR is predefined,
# else NEWLISPDIR will be defined during newlisp startup
# as /usr/share/newlisp which is hardcoded in newlisp.c
prefix=/usr
datadir=$(prefix)/share
bindir=$(prefix)/bin
mandir=$(prefix)/share/man

# if prefix is not /usr then several places in the file 
# guiserver/newlisp-exit.lsp must change too
GUISERVER = $(prefix)/share/newlisp/guiserver

# this is the standard install in /usr/bin and usr/share (with prefix=/usr)
# which as to be done as 'root' with supersuser permissions
# for an install in your home directory use make install_home
#
# One-line description for distribution packages: 
# newLISP is a LISP like, general purpose scripting language. 
#
# Longer description for distribution packages: 
# newLISP is a scripting language for developing web applications and programs 
# in general and in the domains of artificial intelligence (AI) and statistics.

install:
	-install -d $(datadir)/newlisp
	-install -d $(datadir)/newlisp/modules
	-install -d $(datadir)/newlisp/util
	-install -d $(datadir)/doc/newlisp
	-rm $(bindir)/newlisp
	-install -m 755  newlisp $(bindir)/newlisp-$(VERSION)
	-ln -s $(bindir)/newlisp-$(VERSION) $(bindir)/newlisp
	-install -m 644 examples/init.lsp.example $(datadir)/newlisp/init.lsp.example
	-install -m 755 util/newlispdoc $(bindir)/newlispdoc
	-install -m 644 util/syntax.cgi $(datadir)/newlisp/util/syntax.cgi
	-install -m 644 util/newlisp.vim $(datadir)/newlisp/util/newlisp.vim
	-install -m 644 util/nanorc $(datadir)/newlisp/util/nanorc
	-install -m 644 util/link.lsp $(datadir)/newlisp/util/link.lsp
	-install -m 644 util/httpd-conf.lsp $(datadir)/newlisp/util/httpd-conf.lsp
	-install -m 644 doc/COPYING $(datadir)/doc/newlisp/COPYING
	-install -m 644 doc/CREDITS $(datadir)/doc/newlisp/CREDITS
	-install -m 644 doc/newlisp_manual.html $(datadir)/doc/newlisp/newlisp_manual.html
	-install -m 644 doc/newlisp_index.html $(datadir)/doc/newlisp/newlisp_index.html
	-install -m 644 doc/manual_frame.html $(datadir)/doc/newlisp/manual_frame.html
	-install -m 644 doc/CodePatterns.html $(datadir)/doc/newlisp/CodePatterns.html
	-install -m 644 doc/newLISPdoc.html $(datadir)/doc/newlisp/newLISPdoc.html
	-install -m 644 doc/newLISP-10.1-Release.html $(datadir)/doc/newlisp/newLISP-10.1-Release.html
	-install -m 644 doc/newlisp.1 $(mandir)/man1/newlisp.1
	-install -m 644 doc/newlispdoc.1 $(mandir)/man1/newlispdoc.1
	-install -m 644 modules/canvas.lsp $(datadir)/newlisp/modules/canvas.lsp
	-install -m 644 modules/cgi.lsp $(datadir)/newlisp/modules/cgi.lsp
	-install -m 644 modules/crypto.lsp $(datadir)/newlisp/modules/crypto.lsp
	-install -m 644 modules/ftp.lsp $(datadir)/newlisp/modules/ftp.lsp
	-install -m 644 modules/gmp.lsp $(datadir)/newlisp/modules/gmp.lsp
	-install -m 644 modules/infix.lsp $(datadir)/newlisp/modules/infix.lsp
	-install -m 644 modules/mysql.lsp $(datadir)/newlisp/modules/mysql.lsp
	-install -m 644 modules/odbc.lsp $(datadir)/newlisp/modules/odbc.lsp
	-install -m 644 modules/pop3.lsp $(datadir)/newlisp/modules/pop3.lsp
	-install -m 644 modules/postgres.lsp $(datadir)/newlisp/modules/postgres.lsp
	-install -m 644 modules/postscript.lsp $(datadir)/newlisp/modules/postscript.lsp
	-install -m 644 modules/smtp.lsp $(datadir)/newlisp/modules/smtp.lsp
	-install -m 644 modules/smtpx.lsp $(datadir)/newlisp/modules/smtpx.lsp
	-install -m 644 modules/sqlite3.lsp $(datadir)/newlisp/modules/sqlite3.lsp
	-install -m 644 modules/stat.lsp $(datadir)/newlisp/modules/stat.lsp
	-install -m 644 modules/unix.lsp $(datadir)/newlisp/modules/unix.lsp
	-install -m 644 modules/xmlrpc-client.lsp $(datadir)/newlisp/modules/xmlrpc-client.lsp
	-install -m 644 modules/zlib.lsp $(datadir)/newlisp/modules/zlib.lsp
	# GUI-Server install
	-install -d $(datadir)/newlisp/guiserver
	-install -d $(datadir)/doc/newlisp/guiserver
	-install -m 755 guiserver/newlisp-edit.lsp $(bindir)/newlisp-edit
	-install -m 644 guiserver/guiserver.jar $(datadir)/newlisp/guiserver.jar
	-install -m 644 guiserver/guiserver.lsp $(datadir)/newlisp/guiserver.lsp
	-install -m 644 guiserver/images/newLISP128.png $(datadir)/newlisp/newLISP128.png
	-install -m 644 guiserver/COPYING $(datadir)/doc/newlisp/guiserver/COPYING
	-install -m 644 guiserver/index.html $(datadir)/doc/newlisp/guiserver/index.html
	-install -m 644 guiserver/guiserver.lsp.html $(datadir)/doc/newlisp/guiserver/guiserver.lsp.html
	-install -m 644 util/newlispdoc.css $(datadir)/doc/newlisp/guiserver/newlispdoc.css
	-install -m 644 guiserver/allfonts-demo.lsp $(datadir)/newlisp/guiserver/allfonts-demo.lsp
	-install -m 644 guiserver/animation-demo.lsp $(datadir)/newlisp/guiserver/animation-demo.lsp
	-install -m 644 guiserver/border-layout-demo.lsp $(datadir)/newlisp/guiserver/border-layout-demo.lsp
	-install -m 644 guiserver/button-demo.lsp $(datadir)/newlisp/guiserver/button-demo.lsp
	-install -m 644 guiserver/clipboard-demo.lsp $(datadir)/newlisp/guiserver/clipboard-demo.lsp
	-install -m 644 guiserver/cursor-demo.lsp $(datadir)/newlisp/guiserver/cursor-demo.lsp
	-install -m 644 guiserver/drag-demo.lsp $(datadir)/newlisp/guiserver/drag-demo.lsp
	-install -m 644 guiserver/font-demo.lsp $(datadir)/newlisp/guiserver/font-demo.lsp
	-install -m 644 guiserver/frameless-demo.lsp $(datadir)/newlisp/guiserver/frameless-demo.lsp
	-install -m 644 guiserver/html-demo.lsp $(datadir)/newlisp/guiserver/html-demo.lsp
	-install -m 644 guiserver/image-demo.lsp $(datadir)/newlisp/guiserver/image-demo.lsp
	-install -m 644 guiserver/midi-demo.lsp $(datadir)/newlisp/guiserver/midi-demo.lsp
	-install -m 644 guiserver/midi2-demo.lsp $(datadir)/newlisp/guiserver/midi2-demo.lsp
	-install -m 644 guiserver/mouse-demo.lsp $(datadir)/newlisp/guiserver/mouse-demo.lsp
	-install -m 644 guiserver/move-resize-demo.lsp $(datadir)/newlisp/guiserver/move-resize-demo.lsp
	-install -m 644 guiserver/pinballs-demo.lsp $(datadir)/newlisp/guiserver/pinballs-demo.lsp
	-install -m 644 guiserver/properties-demo.lsp $(datadir)/newlisp/guiserver/properties-demo.lsp
	-install -m 644 guiserver/rotation-demo.lsp $(datadir)/newlisp/guiserver/rotation-demo.lsp
	-install -m 644 guiserver/shapes-demo.lsp $(datadir)/newlisp/guiserver/shapes-demo.lsp
	-install -m 644 guiserver/sound-demo.lsp $(datadir)/newlisp/guiserver/sound-demo.lsp
	-install -m 644 guiserver/stroke-demo.lsp $(datadir)/newlisp/guiserver/stroke-demo.lsp
	-install -m 644 guiserver/tabs-demo.lsp $(datadir)/newlisp/guiserver/tabs-demo.lsp
	-install -m 644 guiserver/textrot-demo.lsp $(datadir)/newlisp/guiserver/textrot-demo.lsp
	-install -m 644 guiserver/widgets-demo.lsp $(datadir)/newlisp/guiserver/widgets-demo.lsp
	-install -m 644 guiserver/word-count.lsp $(datadir)/newlisp/guiserver/word-count.lsp
	-install -m 644 guiserver/uppercase.lsp $(datadir)/newlisp/guiserver/uppercase.lsp


uninstall:
	-rm  $(bindir)/newlisp
	-rm  $(bindir)/newlispdoc
	-rm  $(bindir)/newlisp-edit
	-rm  -rf $(datadir)/newlisp
	-rm  -rf $(datadir)/doc/newlisp
	-rm  $(mandir)/man1/newlisp.1
	-rm  $(mandir)/man1/newlispdoc.1

# installs newLISP in home directory, but without guiserver files except
# documentation. To make guiserver run from ~/share/newlisp. The loading
# from guiserver.lsp at the beginning of a guiserver app and loading
# of guiserver.jar from inside of guiserver.lsp have to be changed.

install_home:
	-install -d $(HOME)/bin
	-install -d $(HOME)/share/newlisp
	-install -d $(HOME)/share/newlisp/modules
	-install -d $(HOME)/share/newlisp/util
	-install -d $(HOME)/share/doc/newlisp/
	-install -d $(HOME)/share/doc/newlisp/guiserver
	-install -d $(HOME)/share/man/man1
	-install -m 755 newlisp $(HOME)/bin/newlisp
	-install -m 644 examples/init.lsp.example $(HOME)/share/newlisp/init.lsp.example
	-install -m 755 util/newlispdoc $(HOME)/bin/newlispdoc
	-install -m 644 util/syntax.cgi $(HOME)/share/newlisp/util/syntax.cgi
	-install -m 644 util/newlisp.vim $(HOME)/share/newlisp/util/newlisp.vim
	-install -m 644 util/nanorc $(HOME)/share/newlisp/util/nanorc
	-install -m 644 util/link.lsp $(HOME)/share/newlisp/util/link.lsp
	-install -m 644 util/httpd-conf.lsp $(HOME)/share/newlisp/util/httpd-conf.lsp
	-install -m 644 guiserver/index.html $(HOME)/share/doc/newlisp/guiserver/index.html
	-install -m 644 guiserver/guiserver.lsp.html $(HOME)/share/doc/newlisp/guiserver/guiserver.lsp.html
	-install -m 644 doc/COPYING $(HOME)/share/doc/newlisp/COPYING
	-install -m 644 doc/COPYING $(HOME)/share/doc/newlisp/guiserver/COPYING
	-install -m 644 doc/CREDITS $(HOME)/share/doc/newlisp/CREDITS
	-install -m 644 doc/newlisp_manual.html $(HOME)/share/doc/newlisp/newlisp_manual.html
	-install -m 644 doc/newlisp_index.html $(HOME)/share/doc/newlisp/newlisp_index.html
	-install -m 644 doc/manual_frame.html $(HOME)/share/doc/newlisp/manual_frame.html
	-install -m 644 doc/CodePatterns.html $(HOME)/share/doc/newlisp/CodePatterns.html
	-install -m 644 doc/newLISPdoc.html $(HOME)/share/doc/newlisp/newLISPdoc.html
	-install -m 644 doc/newLISP-10.1-Release.html $(HOME)/share/doc/newlisp/newLISP-10.1-Release.html
	-install -m 644 doc/newlisp.1 $(HOME)/share/man/man1/newlisp.1
	-install -m 644 doc/newlispdoc.1 $(HOME)/share/man/man1/newlispdoc.1
	-install -m 644 modules/canvas.lsp $(HOME)/share/newlisp/modules/canvas.lsp
	-install -m 644 modules/cgi.lsp $(HOME)/share/newlisp/modules/cgi.lsp
	-install -m 644 modules/crypto.lsp $(HOME)/share/newlisp/modules/crypto.lsp
	-install -m 644 modules/ftp.lsp $(HOME)/share/newlisp/modules/ftp.lsp
	-install -m 644 modules/gmp.lsp $(HOME)/share/newlisp/modules/gmp.lsp
	-install -m 644 modules/infix.lsp $(HOME)/share/newlisp/modules/infix.lsp
	-install -m 644 modules/mysql.lsp $(HOME)/share/newlisp/modules/mysql.lsp
	-install -m 644 modules/odbc.lsp $(HOME)/share/newlisp/modules/odbc.lsp
	-install -m 644 modules/pop3.lsp $(HOME)/share/newlisp/modules/pop3.lsp
	-install -m 644 modules/postgres.lsp $(HOME)/share/newlisp/modules/postgres.lsp
	-install -m 644 modules/postscript.lsp $(HOME)/share/newlisp/modules/postscript.lsp
	-install -m 644 modules/smtp.lsp $(HOME)/share/newlisp/modules/smtp.lsp
	-install -m 644 modules/smtpx.lsp $(HOME)/share/newlisp/modules/smtpx.lsp
	-install -m 644 modules/sqlite3.lsp $(HOME)/share/newlisp/modules/sqlite3.lsp
	-install -m 644 modules/stat.lsp $(HOME)/share/newlisp/modules/stat.lsp
	-install -m 644 modules/unix.lsp $(HOME)/share/newlisp/modules/unix.lsp
	-install -m 644 modules/xmlrpc-client.lsp $(HOME)/share/newlisp/modules/xmlrpc-client.lsp
	-install -m 644 modules/zlib.lsp $(HOME)/share/newlisp/modules/zlib.lsp


uninstall_home:
	-rm  -rf $(HOME)/share/newlisp
	-rm  -rf $(HOME)/share/doc/newlisp
	-rm  $(HOME)/share/man/man1/newlisp.1
	-rm $(HOME)/bin/newlisp
	-rm $(HOME)/bin/newlispdoc

# this makes the distribution newlisp-x.x.x.tgz from inside newlisp-x.x.x directory
# you shouldn't use this, but send me the changed files with your contribution/fixes 
# to lutz@nuevatec.com put the word: newlisp in the subject line
#
dist: distclean
	-mkdir newlisp-$(VERSION)
	-mkdir newlisp-$(VERSION)/guiserver
	-mkdir newlisp-$(VERSION)/guiserver/images
	-mkdir newlisp-$(VERSION)/guiserver/java
	-mkdir newlisp-$(VERSION)/modules
	-mkdir newlisp-$(VERSION)/examples
	-mkdir newlisp-$(VERSION)/doc
	-mkdir newlisp-$(VERSION)/util
	cp README newlisp-$(VERSION)
	cp nl*.c newlisp.c *.h pcre*.c newlisp-$(VERSION)
	cp win3*.* unix*.c newlisp-$(VERSION)
	cp Makefile configure* makefile* qa* newlisp-$(VERSION)
	cp modules/* newlisp-$(VERSION)/modules
	cp examples/* newlisp-$(VERSION)/examples
	cp doc/* newlisp-$(VERSION)/doc
	cp util/* newlisp-$(VERSION)/util
	cp -R guiserver/* newlisp-$(VERSION)/guiserver

	tar czvf newlisp-$(VERSION).tgz newlisp-$(VERSION)/*
	rm -rf newlisp-$(VERSION)
	mv newlisp-$(VERSION).tgz ..

# this changes to the current version number in several files
#
# before doing a 'make version' the VERSION variable at the beginning
# of this file has to be changed to the new number
#
version:
	sed -i.bak -E 's/int version = .+;/int version = $(INT_VERSION);/' newlisp.c
	sed -i.bak -E 's/newLISP v.[[:digit:]]+.[[:digit:]]+.[[:digit:]]+ /newLISP v.$(VERSION) /' newlisp.c
	sed -i.bak -E 's/newLISP\/[[:digit:]]+.[[:digit:]]+.[[:digit:]]+/newLISP\/$(VERSION)/' nl-web.c
	sed -i.bak -E 's/newLISP v.+ Manual/newLISP v.$(VERSION) Manual/' doc/newlisp_manual.html
	sed -i.bak -E 's/Reference v.+<\/h2>/Reference v.$(VERSION)<\/h2>/' doc/newlisp_manual.html
	sed -i.bak -E 's/newlisp-.....-win/newlisp-$(INT_VERSION)-win/' guiserver/newlisp-gs.nsi
	sed -i.bak -E 's/and newLISP .+ on /and newLISP $(VERSION) on /' guiserver/newlisp-gs.nsi

# Prepare the manual file for PDF conversion, byt replaceing all <span class="function"></span>
# with <font color="#DD0000"></font> in the syntax statements and replacing &rarr; (one line
# arrow with &rArr; (double line arrow). This is necessary when using OpenOffcice PDF conversion 
#
preparepdf:
	util/preparepdf doc/newlisp_manual.html doc/newlisp_manual_preparepdf.html

# end of file
