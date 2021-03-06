# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

# For resurrectors:
#   hugs98 has major problems with upstream,
#   autotools, sandbox and automagic stuff:
#     gentoo bug #303665
#     gentoo bug #240036

inherit base flag-o-matic eutils versionator multilib

IUSE="X opengl openal doc"

# version numbering of Hugs is rather strange
# we have to transform 2003.11 -> Nov2003
HUGS_MONTH_NR=$(get_version_component_range 2)

transform_month() {
	case "$1" in
		1) echo "Jan";;
		2) echo "Feb";;
		3) echo "Mar";;
		4) echo "Apr";;
		5) echo "May";;
		6) echo "Jun";;
		7) echo "Jul";;
		8) echo "Aug";;
		9) echo "Sep";;
		10) echo "Oct";;
		11) echo "Nov";;
		12) echo "Dec";;
		*) echo "";;
	esac
}

transform_month_num() {
	case "$1" in
		[1-9]) echo 0$1;;
		1[0-2]) echo $1;;
	esac
}

HUGS_MONTH=$(transform_month ${HUGS_MONTH_NR})
HUGS_MONTH0=$(transform_month_num ${HUGS_MONTH_NR})
MY_PV="${HUGS_MONTH}$(get_major_version )"
MY_PV0="$(get_version_component_range 1)-${HUGS_MONTH0}"
MY_P="${PN}-plus-${MY_PV}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="The Hugs98 Haskell interpreter"
SRC_URI="http://cvs.haskell.org/Hugs/downloads/${MY_PV0}/${MY_P}.tar.gz"
HOMEPAGE="http://www.haskell.org/hugs/"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
LICENSE="BSD"

RDEPEND="
	X? ( || ( x11-libs/libX11 virtual/x11 ) )
	opengl? ( virtual/opengl media-libs/freeglut )
	openal? ( media-libs/openal )"
DEPEND="${RDEPEND}
	~app-text/docbook-sgml-dtd-4.2"

# the testsuite is not included in the tarball
RESTRICT="test"

src_unpack() {
	base_src_unpack

	cd "${S}"
	epatch "${FILESDIR}/hugs98-2005.3-find.patch"
	epatch "${FILESDIR}/hugs98-2005.3-conditional-doc.patch"
}

src_compile() {
	local myconf

	# Strip -O? from CFLAGS because of bugs
	# in the garbage collection of gcc on ppc.
	# See bug #73611
	[ "${ARCH}" = "ppc" ] && filter-flags "-O?"

	econf \
		--build=${CHOST} \
		--enable-ffi \
		--enable-profiling \
		$(use_enable X x11) \
		$(use_enable opengl) \
		$(use_enable openal) \
		${myconf} || die "econf failed"
	emake || die "make failed"

	if use doc; then
		emake doc || die "make doc failed"
	fi
}

src_install() {
	emake install DESTDIR="${D}" || die "make install failed"

	if use doc; then
		emake install_doc DESTDIR="${D}" || die "make install_doc failed"
	fi

	#somewhat clean-up installation of few docs
	cd "${S}"
	dodoc Credits License Readme
	cd "${D}/usr/$(get_libdir)/hugs"
	rm Credits License Readme
	mv demos/ docs/ "${D}/usr/share/doc/${PF}"
}
