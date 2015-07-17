# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

# ebuild generated by hackport 0.4.5.9999
#hackport: flags: -use-mock-network

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="TCP instantiation of Network.Transport"
HOMEPAGE="http://haskell-distributed.github.com"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/data-accessor-0.2:=[profile?] <dev-haskell/data-accessor-0.3:=[profile?]
	>=dev-haskell/network-2.3:=[profile?] <dev-haskell/network-2.7:=[profile?]
	>=dev-haskell/network-transport-0.4.1.0:=[profile?] <dev-haskell/network-transport-0.5:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.10
	test? ( >=dev-haskell/network-transport-tests-0.2.1.0 <dev-haskell/network-transport-tests-0.3 )
"

src_configure() {
	haskell-cabal_src_configure \
		--flag=-use-mock-network
}