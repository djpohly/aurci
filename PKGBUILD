# $Id$
# Maintainer: Eric Bélanger <eric@archlinux.org>

pkgname=xscreensaver
pkgver=5.37
pkgrel=1
pkgdesc="Screen saver and locker for the X Window System"
arch=('i686' 'x86_64')
url="http://www.jwz.org/xscreensaver/"
license=('BSD')
depends=('libglade' 'libxmu' 'glu' 'xorg-appres' 'perl-libwww')
makedepends=('bc' 'intltool' 'libxpm')
backup=('etc/pam.d/xscreensaver')
source=(http://www.jwz.org/xscreensaver/${pkgname}-${pkgver}.tar.gz
        xscreensaver-add-electricsheep.diff
	LICENSE)
sha1sums=('22e438589c25a485a12ba5ae8462e38c5f5f0e07'
          'e8dc57b6471fb3867ee099304ac6bf628351cb98'
          '3eedb8b91b13c29df9b1fe5cbb027e1470b802d2')

source+=(no-delay.diff
         starry.diff)
sha1sums+=('bd032f4592a7df20c1ffeb8dfafa8be5a99a1725'
           '75eb105c2e1cfafca8bd7ca2b19477b3d146ba06')

prepare() {
  cd ${pkgname}-${pkgver}
  patch -p0 -i "${srcdir}/xscreensaver-add-electricsheep.diff"
  patch -Np1 -i "${srcdir}/no-delay.diff"
  patch -Np1 -i "${srcdir}/starry.diff"
}

build() {
  cd ${pkgname}-${pkgver}
  ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var \
    --libexecdir=/usr/lib --with-x-app-defaults=/usr/share/X11/app-defaults \
    --with-pam --without-login-manager --with-gtk --with-gl \
    --without-gle --with-pixbuf --with-jpeg
  make
}

package() {
  cd ${pkgname}-${pkgver}
  install -d "${pkgdir}/etc/pam.d"
  make install_prefix="${pkgdir}" install
  install -D -m644 ../LICENSE "${pkgdir}/usr/share/licenses/${pkgname}/LICENSE"
  chmod 755 "${pkgdir}/usr/bin/xscreensaver"
  echo "NotShowIn=KDE;GNOME;" >> "${pkgdir}/usr/share/applications/xscreensaver-properties.desktop"
}
