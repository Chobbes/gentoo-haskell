# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

# ebuild generated by hackport 0.4.5.9999

CABAL_FEATURES="bin"
inherit eutils haskell-cabal

DESCRIPTION="Command-line image paste utility"
HOMEPAGE="https://bitbucket.org/balta2ar/imagepaste"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/http:=
	dev-haskell/json:=
	dev-haskell/mtl:=
	dev-haskell/network:=
	dev-haskell/regex-posix:=
	dev-haskell/tagsoup:=
	dev-haskell/transformers:=
	dev-haskell/vcs-revision:=
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.6
"

src_prepare() {
	epatch "${FILESDIR}"/${P}-ghc-7.10.patch

	cabal_chdeps \
		'network' 'network, network-uri'
}
