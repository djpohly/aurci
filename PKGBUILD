# Maintainer: Levente Polyak <anthraxx[at]archlinux[dot]org>
# Contributor: Eric Bélanger <eric@archlinux.org>

pkgname=xscreensaver
pkgver=5.44
pkgrel=3
pkgdesc='Screen saver and locker for the X Window System'
url='https://www.jwz.org/xscreensaver/'
arch=('x86_64')
license=('BSD')
depends=('libglade' 'libxmu' 'glu' 'xorg-appres' 'perl-libwww'
         'libxcrypt' 'libcrypt.so' 'libxi' 'libxxf86vm' 'libxrandr' 'libxinerama'
         'libxt' 'libx11' 'libxext' 'pam' 'glibc' 'gdk-pixbuf-xlib')
makedepends=('bc' 'intltool' 'libxpm')
backup=('etc/pam.d/xscreensaver')
source=(https://www.jwz.org/xscreensaver/${pkgname}-${pkgver}.tar.gz
        LICENSE)
sha512sums=('9d9144dec6f075c2d6a1c3cd45123a98d6d0cd732d6c3e3389e97b3f802b8f8765a188d1e35f97f123ca0a64661ea616b7b710577063c311da3d99d8439f1dae'
            '863c699479b2ec2775a0d1cba22e615929194a14af164b3513e46a0c04229da6547255a4da8f7f1bbb40906898c124ed3c9ec2436b76b62affcb62385af9783e')
b2sums=('102025aa2f57672ed3547f0e9bab989566fb8e50ecae8b9e4078ec5ee5de3cad09fec107695335ef236ad9fe19b2638978366a180a998d77b0ce8a2a5d1ebde3'
        'cacb6ba39d6ecb8703ef5f5a7dc74de0ca805cce73b43a8b9b6b4c255c909aa9b5e692de76c2fbd4da26ce6efb5f2a46138c43b1b37f53cee6d20fd6ed41f4a9')

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
    --without-systemd \
    --with-gtk \
    --with-gl \
    --without-gle \
    --with-pixbuf \
    --with-jpeg
  make all
}

package() {
  cd ${pkgname}-${pkgver}
  install -d "${pkgdir}/etc/pam.d"
  make install_prefix="${pkgdir}" install
  install -Dm 644 ../LICENSE -t "${pkgdir}/usr/share/licenses/${pkgname}"
  # remove sticky bit
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
b2sums+=('c8c95fd90c907f13bbb79f145899b9a366bb4b854db9bcc48246fa7d96f944e4888a2627bfa2e4e2792f2da00f96b508ab8cd7f94e8320d2352103b68407c6af'
         'b7fa8bb7f518df2756def90ca4fa782521cc8e199f0fc1e90fc128b02fa3fc28122614b2618b14eb98108c5a63f30edbf7f46e34234d1986a1979cb44c246392'
         '3c72ef884fb657963c150a666c753b335cacc10f423bb0e385cd1b1f015abbafe09540eaf47907ff178866f46f0558a35f9d6b97ac39157bf0ae5665f14a8399'
         'ea6b522193fd56e8b2792fc14de9190869a4a41dfc48b7d7c47d3cef17c0326472d4093e78406567610ad058fcb5d443245b64473589874b2925caa3d946f139'
         '9504e9cabd2a575d320121c8d6868a7a5e009303f2d18d0fe284314bb425a6fb213aaf1b59ad802f2f3d6272823a4f76edfecac1fde93a0d005fb18141fc8776')

# vim: ts=2 sw=2 et:
