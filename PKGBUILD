# Contributer: v2punkt0 <v2punkt0@gmail.com>
# Contributor: Devin J. Pohly <djpohly+arch@gmail.com>

pkgname='dwm-djp-hg'
pkgver=1537.19
pkgrel=1
pkgdesc="The latest hg pull of dwm, with my own patchqueue"
url="http://dwm.suckless.org"
license='MIT'
arch=('i686' 'x86_64')
depends=('libx11')
makedepends=('mercurial')
conflicts=('dwm')
provides=('dwm')

_hgroot='http://hg.suckless.org'
_hgrepo='dwm'
_hgmq='https://bitbucket.org/djpohly/dwm-patches'

build() {
  cd "$srcdir"
  msg "Connecting to Mercurial server...."

  if [ -d $_hgrepo ] ; then
    cd $_hgrepo
    hg pull -u
    hg pull -u --mq
    msg "The local files are updated."
  else
    hg qclone -p $_hgmq $_hgroot $_hgrepo
  fi

  msg "Mercurial checkout done or server timeout"
  msg "Starting make..."

  rm -rf "$srcdir/$_hgrepo-build"
  hg qclone "$srcdir/$_hgrepo" "$srcdir/$_hgrepo-build"
  cd "$srcdir/$_hgrepo-build"

  # Apply patches
  hg qgoto myprefs

  # add correct settings to config.mk
  sed -i "s|^PREFIX =.*|PREFIX = /usr|" config.mk
  sed -i "s|^X11INC =.*|X11INC = /usr/include/X11|" config.mk
  sed -i "s|^X11LIB =.*|X11LIB = /usr/lib/X11|" config.mk
  sed -i "s|^CFLAGS =|CFLAGS +=|" config.mk
  sed -i "/^CFLAGS/s| -Os\b||" config.mk
  sed -i "s|^LDFLAGS =|LDFLAGS +=|" config.mk
  sed -i "/^LDFLAGS/s| -s\b||" config.mk

  msg "Starting build process."
  make
}

package() {
  cd "$srcdir/$_hgrepo-build"
  make PREFIX="$pkgdir/usr" install

  mkdir -p "$pkgdir/usr/share/licenses/dwm"
  cp LICENSE "$pkgdir/usr/share/licenses/dwm"
}
# vim:set ts=2 sw=2 et:
