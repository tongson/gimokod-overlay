EAPI=2

inherit eutils

DESCRIPTION="Luajit bindings for wxGTK"
HOMEPAGE="http://wxlua.sourceforge.net/"
SRC_URI="https://launchpad.net/~zerobranestudio/+archive/zerobranestudio/+files/wxlua_${PV}.orig.tar.gz"

LICENSE="wxWinLL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="=dev-lang/lua-5.1*
	>=x11-libs/wxGTK-2.8.12.1"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	sed -i \
	-e 's:include/lua5.1:include:g' \
	-e 's:-llua5.1:-llua:g' \
	configure || die
	
	sed -i \
	-e 's:-llua5.1:-llua:g' \
	-e "/include\/lauxlib\.h/d" \
	modules/Makefile.in || die
}

src_configure() {
        econf --disable-wxlua-app \
              --disable-wxluacan-app \
              --disable-wxluaedit-app \
              --disable-wxluafreeze-app \
              --enable-wxluadebug \
              --enable-wxluasocket \
              --enable-systemlua || die "configure failed"
}

src_compile() {
        emake CC="$(tc-getCC)" CXXFLAGS="${CXXFLAGS}" LIBFLAG="-shared ${LDFLAGS}" -j1 || die "make failed"
}

src_install() {
        emake DESTDIR="${D}" -j1 install || die "make failed"
}
