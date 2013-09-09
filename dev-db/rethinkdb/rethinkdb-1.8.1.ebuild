# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils user

DESCRIPTION="Open-source distributed database built with love"
HOMEPAGE="http://www.rethinkdb.com/"
SRC_URI="http://download.rethinkdb.com/dist/rethinkdb-${PV}.tgz"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-lang/coffee-script
	dev-lang/v8
	dev-libs/boost
	dev-libs/openssl
	dev-libs/protobuf
	dev-util/ctags
	dev-util/google-perftools[static-libs]
	net-libs/nodejs
	net-misc/curl
"

DEPEND="${RDEPEND}
	dev-lang/less
	sys-devel/m4
"

src_prepare() {
    epatch "${FILESDIR}/fix-init.patch"
}

src_configure() {
    einfo test
    ./configure --sysconfdir=/etc --localstatedir=/var/lib  --prefix=/usr
}

src_compile() {
    NPM_CONFIG_PYTHON='python2' emake
}

pkg_postinst() {
    eadduser rethinkdb
}
