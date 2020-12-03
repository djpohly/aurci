# Maintainer: Levente Polyak <anthraxx[at]archlinux[dot]org>
# Contributor: Eric Bélanger <eric@archlinux.org>

pkgname=xscreensaver
pkgver=5.44
pkgrel=1
pkgdesc='Screen saver and locker for the X Window System'
url='https://www.jwz.org/xscreensaver/'
arch=('x86_64')
license=('BSD')
depends=('libglade' 'libxmu' 'glu' 'xorg-appres' 'perl-libwww')
makedepends=('bc' 'intltool' 'libxpm')
backup=('etc/pam.d/xscreensaver')
source=(https://www.jwz.org/xscreensaver/${pkgname}-${pkgver}.tar.gz
        LICENSE)
sha512sums=('9d9144dec6f075c2d6a1c3cd45123a98d6d0cd732d6c3e3389e97b3f802b8f8765a188d1e35f97f123ca0a64661ea616b7b710577063c311da3d99d8439f1dae'
            '863c699479b2ec2775a0d1cba22e615929194a14af164b3513e46a0c04229da6547255a4da8f7f1bbb40906898c124ed3c9ec2436b76b62affcb62385af9783e')

prepare() {
  cd ${pkgname}-${pkgver}
  sed 's|-std=c89||' -i configure.in
  patch -Np1 -i "$srcdir/no-delay.diff"
  patch -Np1 -i "$srcdir/starry.diff"
  cp ../{flasher,meteor_l,meteor_r}.png hacks/images/
  autoreconf -fiv
}

build() {
  cd ${pkgname}-${pkgver}
  ./configure \
    --prefix=/usr \
    --sysconfdir=/etc \
    --localstatedir=/var \
    --libexecdir=/usr/lib \
    --with-x-app-defaults=/usr/share/X11/app-defaults \
    --with-pam \
    --without-login-manager \
    --with-gtk \
    --with-gl \
    --without-gle \
    --with-pixbuf \
    --with-jpeg
  make
}

package() {
  cd ${pkgname}-${pkgver}
  install -d "${pkgdir}/etc/pam.d"
  make install_prefix="${pkgdir}" install
  install -D -m644 ../LICENSE "${pkgdir}/usr/share/licenses/${pkgname}/LICENSE"
  chmod 755 "${pkgdir}/usr/bin/xscreensaver"
}

source+=(no-delay.diff
         starry.diff
         flasher.png meteor_l.png meteor_r.png)
sha512sums+=('1f32ea38696e061c03849bf95c8c9dcf879d0324af92212f4462b238d0896eec19209f28e83c890b6b4c70a9b0b14cda362be17795737c8b9d7189d2887210fd'
             '95025c8d2661dfdf9ba489977f81fb0d313868e38f71425477d97c3ea5ee2b4f81279ed8e86bcc042bcafb48811dd16ecd9dc07e383e01746648aa4e37c2e958'
             'db77727c27416dfa601e5e9a12b3e02575fe55e3891517121861713341b2e9d575265335ba302264490678b8ca433c8e10dd699c02350d1dbcbffaaf0205481d'
             'da7cbc0d72fc95ba35929b9a73a45d0a56862ef683fc0f069a8968d4cd73595fc693917265bc93558e35a73fb8ef5f808e84797b50c46429b5d4e30a856573bc'
             '55689096d3e6a41484f548300c54e6e1dc9dc755e3ef0a21294a195393cd84a86ceb055593fe6e5d0ea6dc15d79297e2749a7cd5a7b7d411a7714a3efe6b6578')
