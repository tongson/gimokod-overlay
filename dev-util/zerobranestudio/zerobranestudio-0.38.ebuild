EAPI=2

inherit eutils cmake-utils

DESCRIPTION="A lightweight IDE for Lua"
HOMEPAGE="http://studio.zerobrane.com/"
SRC_URI="https://github.com/pkulchenko/ZeroBraneStudio/archive/${PV}.tar.gz -> ZeroBraneStudio-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="=dev-lang/lua-5.1*
         dev-lua/wxlua
         dev-lua/LuaBitOp
         dev-lua/luasocket"
DEPEND="${RDEPEND}
	dev-util/cmake"
	
S="${WORKDIR}/ZeroBraneStudio-${PV}/build"
	
src_prepare() {
	sed -i \
	-e 's:bin/linux/$ARCH/lua:@LUA_EXECUTABLE@:g' \
	../zbstudio/zbstudio.in || die
}

src_configure() {
	MYCMAKEARGS="-DCMAKE_BUILD_TYPE=RelWithDebInfo -DLUA_EXECUTABLE=/usr/bin/lua"
	cmake-utils_src_configure || die "configure failed"
}
