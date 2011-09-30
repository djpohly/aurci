# $Id$
# Maintainer: Eric Bélanger <eric@archlinux.org>

pkgname=xscreensaver
pkgver=5.15
pkgrel=2
pkgdesc="Screen saver and locker for the X Window System"
arch=('i686' 'x86_64')
url="http://www.jwz.org/xscreensaver/"
license=('BSD')
depends=('libxxf86vm' 'libglade' 'mesa' 'pam' 'xorg-appres' 'libxmu' 'perl-libwww')
makedepends=('bc')
backup=('etc/pam.d/xscreensaver')
source=(http://www.jwz.org/xscreensaver/${pkgname}-${pkgver}.tar.gz \
        add-electricsheep.diff xscreensaver.pam LICENSE)
sha1sums=('b5ce7caa19f4d57c3bac83377a36dddbe7095052'
          '677496218b81a42d90bee400026e94dd87fb8ffb'
          '106635aa1aae51d6f0668b1853f6c49a4fe9d3d8'
          '4209ea586b204fd1d81c382a0522c654f9fd9134')

build() {
  cd "${srcdir}/${pkgname}-${pkgver}"
  patch -Np0 -i "${srcdir}/add-electricsheep.diff"
  ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var \
    --libexecdir=/usr/lib --with-x-app-defaults=/usr/share/X11/app-defaults \
    --with-pam --without-motif --with-gtk --with-gl \
    --without-gle --with-pixbuf --with-jpeg
  make
}

package() {
  cd "${srcdir}/${pkgname}-${pkgver}"
  make install_prefix="${pkgdir}" install
  install -D -m644 ../LICENSE "${pkgdir}/usr/share/licenses/${pkgname}/LICENSE"
  install -D -m644 ../xscreensaver.pam "${pkgdir}/etc/pam.d/xscreensaver"
  chmod 755 "${pkgdir}/usr/bin/xscreensaver"
  echo "NotShowIn=KDE;GNOME;" >> "${pkgdir}/usr/share/applications/xscreensaver-properties.desktop"
}
