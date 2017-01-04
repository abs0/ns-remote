# $Id$
#
# Very simple Makefile used to compile Netscape's ns-remote program
#

PROG	= ns-remote
PKGNAME = ${PROG}
FILES   = Makefile vroot.h remote.c ns-open README
VERSION = 1.12

INSTALL_DATA	?= install -m 0644
INSTALL_DIR	?= install -d
INSTALL_MAN	?= install -m 0644
INSTALL_PROGRAM ?= install -m 0755
INSTALL_SCRIPT	?= install -m 0755
PKG_SYSCONFDIR	?= ${PREFIX}/etc
PREFIX 		?= /usr/local

all:	${PROG}

${PROG}:	remote.c
	${CC} -Wall ${CFLAGS} -o ${PROG} remote.c -DSTANDALONE \
	    ${LDFLAGS} -lXmu -lXt -lSM -lICE -lXext -lX11

clean:
	rm -f ${PROG}

install: ${PROG}
	${INSTALL_DIR} ${DESTDIR}${PREFIX}/bin
	${INSTALL_DIR} ${DESTDIR}${PREFIX}/share/doc
	${INSTALL_PROGRAM} ${PROG} ${DESTDIR}${PREFIX}/bin
	${INSTALL_SCRIPT} ns-open ${DESTDIR}${PREFIX}/bin
	${INSTALL_DATA} README ${DESTDIR}${PREFIX}/share/doc/ns-remote.README

tar:
	rm -rf ${PKGNAME}-${VERSION}
	mkdir ${PKGNAME}-${VERSION}
	cp  ${FILES} ${PKGNAME}-${VERSION}
	tar cvf - ${PKGNAME}-${VERSION} | bzip2 -9 > ${PKGNAME}-${VERSION}.tbz
	rm -rf ${PKGNAME}-${VERSION}
