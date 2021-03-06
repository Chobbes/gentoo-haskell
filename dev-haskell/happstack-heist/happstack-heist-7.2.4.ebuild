# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

# ebuild generated by hackport 0.4.6.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Support for using Heist templates in Happstack"
HOMEPAGE="http://www.happstack.com/"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/blaze-builder-0.2:=[profile?]
	>=dev-haskell/either-3.4:=[profile?] <dev-haskell/either-5:=[profile?]
	>=dev-haskell/happstack-server-7.0:=[profile?]
	>=dev-haskell/heist-0.13:=[profile?]
	dev-haskell/lens:=[profile?]
	>=dev-haskell/mtl-2:=[profile?] <dev-haskell/mtl-3:=[profile?]
	>=dev-haskell/text-0.10:=[profile?] <dev-haskell/text-1.3:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.6
"

src_prepare() {
	epatch "${FILESDIR}"/${P}-heist-0.14.patch

	cabal_chdeps \
		'heist            >= 0.13 && < 0.14' 'heist            >= 0.13' \
		'blaze-builder    >= 0.2 && <0.4' 'blaze-builder    >= 0.2' \
		'happstack-server >= 7.0 && < 7.4' 'happstack-server >= 7.0'
}
