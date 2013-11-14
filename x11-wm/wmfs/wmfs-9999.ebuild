# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
inherit eutils git-2

DESCRIPTION="Windows Manager From Scratch"
HOMEPAGE="https://www.wmfs.info"
EGIT_REPO_URI="https://github.com/xorg62/wmfs.git"
EGIT_PROJECT="wmfs"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="xinerama xrandr imlib2"

DEPEND="
	x11-libs/libX11
	x11-libs/libSM
	x11-libs/libXft
	imlib2? ( media-libs/imlib2 )
	xrandr? ( x11-libs/libXrandr )
	xinerama? ( x11-libs/libXinerama )
	"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_configure() {
	./configure --prefix /usr --man-prefix /usr/share/man --xdg-config-dir /etc/xdg \
			$(use_with imlib2) \
			$(use_with xrandr) \
			$(use_with xinerama)
}

src_install() {
	dobin  "${S}/${PN}" || die
	doman  "${S}/${PN}.1" || die
	insinto /etc/xdg/wmfs
	doins wmfsrc
	insinto /usr/share/xsessions/
	doins wmfs.desktop
}
