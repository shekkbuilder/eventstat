#
# Copyright (C) 2011-2015 Canonical, Ltd.
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
#

VERSION=0.02.00

CFLAGS += -Wall -Wextra -DVERSION='"$(VERSION)"' -O2

BINDIR=/usr/bin
MANDIR=/usr/share/man/man8

eventstat: eventstat.o
	$(CC) $(CFLAGS) $< -lm -o $@ $(LDFLAGS)

eventstat.8.gz: eventstat.8
	gzip -c $< > $@

dist:
	rm -rf eventstat-$(VERSION)
	mkdir eventstat-$(VERSION)
	cp -rp Makefile eventstat.c eventstat.8 COPYING eventstat-$(VERSION)
	tar -zcf eventstat-$(VERSION).tar.gz eventstat-$(VERSION)
	rm -rf eventstat-$(VERSION)

clean:
	rm -f eventstat eventstat.o eventstat.8.gz
	rm -f eventstat-$(VERSION).tar.gz

install: eventstat eventstat.8.gz
	mkdir -p ${DESTDIR}${BINDIR}
	cp eventstat ${DESTDIR}${BINDIR}
	mkdir -p ${DESTDIR}${MANDIR}
	cp eventstat.8.gz ${DESTDIR}${MANDIR}
