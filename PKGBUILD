# $Id$
# Maintainer: Eric Bélanger <eric@archlinux.org>

pkgname=xscreensaver
pkgver=5.39
pkgrel=1
pkgdesc="Screen saver and locker for the X Window System"
arch=('x86_64')
url="http://www.jwz.org/xscreensaver/"
license=('BSD')
depends=('libglade' 'libxmu' 'glu' 'xorg-appres' 'perl-libwww')
makedepends=('bc' 'intltool' 'libxpm')
backup=('etc/pam.d/xscreensaver')
source=(http://www.jwz.org/xscreensaver/${pkgname}-${pkgver}.tar.gz
	LICENSE)
sha1sums=('7166c9f4a860785e0829df046f0328f5be74c0d7'
          '3eedb8b91b13c29df9b1fe5cbb027e1470b802d2')

source+=(no-delay.diff
         starry.diff
	 flasher.png meteor_l.png meteor_r.png)
sha1sums+=('bd032f4592a7df20c1ffeb8dfafa8be5a99a1725'
           '502882128c0244f1108b558d074dd9187f8d8f8f'
           '2e1e43f599125dd554d068a011e98226bbe4963b'
           'c670620b5201c1e04804b4cbef74068dbf61f9fc'
           '5826224ef9d1285a67185673df296e81f7a3545a')

prepare() {
  cd ${pkgname}-${pkgver}
  patch -Np1 -i "${srcdir}/no-delay.diff"
  patch -Np1 -i "${srcdir}/starry.diff"
  cp ../{flasher,meteor_l,meteor_r}.png hacks/images/
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
