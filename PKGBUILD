#Maintainer: Xyne <ac xunilhcra enyx, backwards>
pkgname=powerpill
pkgver=2020.12.15
pkgrel=2
pkgdesc='Pacman wrapper for faster downloads.'
arch=(any)
license=(GPL)
url="https://xyne.archlinux.ca/projects/powerpill"
depends=(aria2 'pm2ml>2012.12.12' pyalpm python3 python3-xcgf python3-xcpf)
optdepends=('python3-threaded_servers: internal Pacserve support' 'reflector: Reflector and Rsync support' 'rsync: Rsync download support')
backup=(etc/powerpill/powerpill.json)
source=(
  https://xyne.archlinux.ca/projects/powerpill/src/powerpill-2020.12.15.tar.xz
  https://xyne.archlinux.ca/projects/powerpill/src/powerpill-2020.12.15.tar.xz.sig
)
sha512sums=(
  f858b2b9c38fb9f4b0ed681c724a2632a602c3273e880afe2341161e8a6f42058b65dd4aa7f9fef55d3494382a9babcc799ffaf0abd0dff8076c31bd6c90f713
  316911ef8ea81fc38d78c7f40812aa79bd9f9d0a2daabe11a5153f85c8576f9361e8360da5514d6f28a5f253ccfd3eefd4ca9a06897e749808a24ffe2566cd0f
)
md5sums=(
  25ef523aeee95f04bf2a441d95f39831
  4b24129d639df8697c54592fa4956e70
)
validpgpkeys=('EC3CBE7F607D11E663149E811D1F0DC78F173680')

package ()
{
  cd "$srcdir/$pkgname-$pkgver"
  python3 setup.py install --prefix=/usr --root="$pkgdir" --optimize=1
  install -Dm644 'powerpill.json' "$pkgdir/etc/powerpill/powerpill.json"
  install -Dm644 'man/powerpill.json.1.gz' "$pkgdir/usr/share/man/man1/powerpill.json.1.gz"
  install -Dm644 'powerpill-bash-completion.sh' "$pkgdir/usr/share/bash-completion/completions/powerpill"
  install -Dm644 '_powerpill.zsh' "$pkgdir/usr/share/zsh/site-functions/_powerpill"
}

# vim: set ts=2 sw=2 et:
