# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

# ebuild generated by hackport 0.4.6.9999
#hackport: flags: +release,-freestanding,-ci,-execonly

CABAL_FEATURES="bin lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Functional Programming Language with Dependent Types"
HOMEPAGE="http://www.idris-lang.org/"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="curses ffi gmp"

RDEPEND=">=dev-haskell/annotated-wl-pprint-0.7:=[profile?] <dev-haskell/annotated-wl-pprint-0.8:=[profile?]
	<dev-haskell/ansi-terminal-0.7:=[profile?]
	<dev-haskell/ansi-wl-pprint-0.7:=[profile?]
	<dev-haskell/base64-bytestring-1.1:=[profile?]
	>=dev-haskell/binary-0.7:=[profile?] <dev-haskell/binary-0.8:=[profile?]
	>=dev-haskell/blaze-html-0.6.1.3:=[profile?] <dev-haskell/blaze-html-0.9:=[profile?]
	>=dev-haskell/blaze-markup-0.5.2.1:=[profile?] <dev-haskell/blaze-markup-0.8:=[profile?]
	<dev-haskell/cheapskate-0.2:=[profile?]
	>=dev-haskell/fingertree-0.1:=[profile?] <dev-haskell/fingertree-0.2:=[profile?]
	>=dev-haskell/haskeline-0.7:=[profile?] <dev-haskell/haskeline-0.8:=[profile?]
	>=dev-haskell/mtl-2.1:=[profile?] <dev-haskell/mtl-2.3:=[profile?]
	<dev-haskell/network-2.7:=[profile?]
	>=dev-haskell/optparse-applicative-0.11:=[profile?] <dev-haskell/optparse-applicative-0.12:=[profile?]
	>=dev-haskell/parsers-0.9:=[profile?] <dev-haskell/parsers-0.13:=[profile?]
	dev-haskell/safe:=[profile?]
	<dev-haskell/split-0.3:=[profile?]
	>=dev-haskell/text-1.2.1.0:=[profile?] <dev-haskell/text-1.3:=[profile?]
	<dev-haskell/transformers-0.5:=[profile?]
	>=dev-haskell/transformers-compat-0.3:=[profile?]
	>=dev-haskell/trifecta-1.1:=[profile?] <dev-haskell/trifecta-1.6:=[profile?]
	>=dev-haskell/uniplate-1.6:=[profile?] <dev-haskell/uniplate-1.7:=[profile?]
	<dev-haskell/unordered-containers-0.3:=[profile?]
	<dev-haskell/utf8-string-1.1:=[profile?]
	dev-haskell/vector:=[profile?]
	<dev-haskell/vector-binary-instances-0.3:=[profile?]
	>dev-haskell/zip-archive-0.2.3.5:=[profile?] <dev-haskell/zip-archive-0.2.4:=[profile?]
	dev-haskell/zlib:=[profile?]
	>=dev-lang/ghc-7.10.1:=
	curses? ( <dev-haskell/hscurses-1.5:=[profile?] )
	ffi? ( <dev-haskell/libffi-0.2:=[profile?] )
	gmp? ( <dev-haskell/libffi-0.2:=[profile?]
		dev-libs/gmp:0= )
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.22.2.0
"

src_prepare() {
	# runs dist/build/idris directly and breaks sandboxing
	export LD_LIBRARY_PATH="${S}/dist/build${LD_LIBRARY_PATH+:}${LD_LIBRARY_PATH}"

	# when built with -O2 takes 10GB RAM at least on ghc-7.10.2
	replace-hcflags -g ''

	cabal_chdeps \
		'zlib < 0.6' 'zlib' \
		'vector < 0.12' 'vector'
}

src_configure() {
	haskell-cabal_src_configure \
		--flag=-ci \
		$(cabal_flag curses curses) \
		--flag=-execonly \
		$(cabal_flag ffi ffi) \
		--flag=-freestanding \
		$(cabal_flag gmp gmp) \
		--flag=release
}