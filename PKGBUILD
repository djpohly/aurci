# Contributor: Lukas Braun <koomi+aur at hackerspace-bamberg dot de>
# Contributor: David Arroyo <droyo@aqwari.us>
_pkgname=skalibs
pkgname=$_pkgname-musl-git
pkgver=v2.7.0.0
pkgrel=1
pkgdesc="A set of general-purpose C programming libraries [static-musl; GIT]"
arch=('i686' 'x86_64')
url="http://www.skarnet.org/software/skalibs"
license=('custom:ISC')
makedepends=('musl' 'git')
options=('staticlibs')
source=(git+git://git.skarnet.org/skalibs)
sha256sums=('SKIP')
provides=($_pkgname $_pkgname-musl)
conflicts=($_pkgname $_pkgname-musl)

pkgver() {
    cd $_pkgname
    git describe --abbrev=4 --dirty | tr - .
}

build() {
    cd $_pkgname

    export CPPFLAGS='-nostdinc -isystem /usr/lib/musl/include -isystem /usr/include'
    export CC="musl-gcc"
    ./configure --disable-shared
    make
}

package() {
    cd $_pkgname

    make DESTDIR="$pkgdir/" install
    install -D -m644 COPYING "$pkgdir/usr/share/licenses/$_pkgname/LICENSE"
}
