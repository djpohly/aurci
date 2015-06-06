# $Id$
# Contributor: tobias [tobias [at] archlinux.org]
# Maintainer: Gaetan Bisson <bisson@archlinux.org>

pkgname=mutt
pkgver=1.5.23
pkgrel=2
pkgdesc='Small but very powerful text-based mail client'
url='http://www.mutt.org/'
license=('GPL')
backup=('etc/Muttrc')
arch=('i686' 'x86_64')
optdepends=('smtp-forwarder: to send mail')
depends=('gpgme' 'ncurses' 'openssl' 'libsasl' 'gdbm' 'libidn' 'mime-types' 'krb5')
source=("ftp://ftp.mutt.org/mutt/${pkgname}-${pkgver}.tar.gz"
        'cve-2014-9116.patch')
sha1sums=('8ac821d8b1e25504a31bf5fda9c08d93a4acc862'
          '776e3e00fcf8a325e7b9c2bb456d3e9ba2c82307')

makedepends=('mercurial')
source=('hg+http://dev.mutt.org/hg/mutt#revision=0255b37be491bf11347c91d2197a4d9031423010')
sha1sums=('SKIP')
pkgver=1.5.23.hg.20150606

#prepare() {
#	cd "${srcdir}/${pkgname}-${pkgver}"
#	patch -p1 -i ../cve-2014-9116.patch
#}

build() {
#	cd "${srcdir}/${pkgname}-${pkgver}"
	cd "${srcdir}/${pkgname}"
#	./configure \
	./prepare \
		--prefix=/usr \
		--sysconfdir=/etc \
		--enable-gpgme \
		--enable-pop \
		--enable-imap \
		--enable-smtp \
		--enable-hcache \
		--with-curses=/usr \
		--with-regex \
		--with-gss=/usr \
		--with-ssl=/usr \
		--with-sasl \
		--with-idn \

	make
}

package() {
#	cd "${srcdir}/${pkgname}-${pkgver}"
	cd "${srcdir}/${pkgname}"
	make DESTDIR="${pkgdir}" install

	rm "${pkgdir}"/etc/mime.types{,.dist}
	rm "${pkgdir}"/usr/bin/{flea,muttbug}
	rm "${pkgdir}"/usr/share/man/man1/{flea,muttbug}.1
	install -Dm644 contrib/gpg.rc "${pkgdir}"/etc/Muttrc.gpg.dist
}
