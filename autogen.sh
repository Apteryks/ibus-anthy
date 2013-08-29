#!/bin/sh
set -e
set -x

autopoint --force || exit 1
libtoolize --automake --copy --force || exit 1
intltoolize --copy --force || exit 1
aclocal -I m4 --force || exit 1
autoheader --force || exit 1
automake --add-missing --copy --force || exit 1
autoconf --force || exit 1

if `echo "$@" | grep -q CFLAGS > /dev/null` ; then
    ./configure "$@" || exit 1
else
    CFLAGS=${CFLAGS-"-Wall -Werror -Wformat -Werror=format-security"}
    CXXFLAGS="$CFLAGS"
    ./configure "$@" CFLAGS="$CFLAGS" CXXFLAGS="$CXXFLAGS" || exit 1
fi
