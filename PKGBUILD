# Maintainer:  Bartłomiej Piotrowski <bpiotrowski@archlinux.org>
# Contributor: Thomas Bächler <thomas@archlinux.org>

pkgname=wpa_supplicant
pkgver=2.9
pkgrel=5
epoch=2
pkgdesc='A utility providing key negotiation for WPA wireless networks'
url='http://hostap.epitest.fi/wpa_supplicant'
arch=(x86_64)
license=(GPL)
depends=(openssl libdbus readline libnl)
install=wpa_supplicant.install
source=(https://w1.fi/releases/${pkgname}-${pkgver}.tar.gz{,.asc}
        CVE-2019-16275.patch
        tls.patch     # More permissive TLS fallback
        config)
validpgpkeys=('EC4AA0A991A5F2464582D52D2B6EF432EFC895FA') # Jouni Malinen
sha256sums=('fcbdee7b4a64bea8177973299c8c824419c413ec2e3a95db63dd6a5dc3541f17'
            'SKIP'
            'bf91a135e717265969f1ab0319297c9d2e6f695928a17e3b3fa5accc8ef7b297'
            '449c7dad67b246b5b93e796f57c2f90c5c32cfc5b16f7aa4f17802dc260d3414'
            '6f71a04875465178992e78216603d3c4735ee717a31738a6e30702c7a81c6c4e')

prepare() {
  cd "$srcdir/$pkgname-$pkgver"
  local i; for i in "${source[@]}"; do
    case $i in
      *.patch)
        echo "Applying patch $i"
        patch -p1 -i "$srcdir/$i"
        ;;
    esac
  done

  cd "$srcdir/$pkgname-$pkgver/$pkgname"
  cp "$srcdir/config" ./.config
}

build() {
  cd "$srcdir/$pkgname-$pkgver/$pkgname"

  make LIBDIR=/usr/lib BINDIR=/usr/bin
  make LIBDIR=/usr/lib BINDIR=/usr/bin eapol_test
}

package() {
  cd "$srcdir/$pkgname-$pkgver/$pkgname"
  make LIBDIR=/usr/lib BINDIR=/usr/bin DESTDIR="$pkgdir" install
  install -Dm755 eapol_test "$pkgdir/usr/bin/eapol_test"

  install -d -m755 "$pkgdir/etc/wpa_supplicant"
  install -Dm644 wpa_supplicant.conf \
    "$pkgdir/usr/share/doc/wpa_supplicant/wpa_supplicant.conf"


install -d -m755 "$pkgdir"/usr/share/dbus-1/{system.d,system-services}
install -m644 \
dbus/fi.w1.wpa_supplicant1.service \
"$pkgdir/usr/share/dbus-1/system-services/"

 install -Dm644 dbus/dbus-wpa_supplicant.conf \
"$pkgdir/usr/share/dbus-1/system.d/wpa_supplicant.conf"

  install -d -m755 "$pkgdir/usr/share/man/man"{5,8}
  install -m644 doc/docbook/*.5 "$pkgdir/usr/share/man/man5/"
  install -m644 doc/docbook/*.8 "$pkgdir/usr/share/man/man8/"
  rm -f "$pkgdir/usr/share/man/man8/wpa_"{priv,gui}.8
}

source+=(config-dir.patch)
sha256sums+=(405af2562412f1a18fa19f879813c0251fc8197af82384c45b099ef746c5f6d6)
