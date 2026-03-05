EAPI=8

inherit cmake desktop xdg git-r3

DESCRIPTION="2D MMORPG client for The Mana World / Evol Online (ManaPlus)"
HOMEPAGE="https://manaplus.org/ https://gitlab.com/manaplus/manaplus"
EGIT_REPO_URI="https://gitlab.com/manaplus/manaplus.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls pulseaudio"

RDEPEND="
    >=dev-games/physfs-1.0.0
    dev-libs/libxml2
    net-misc/curl
    sys-libs/zlib
    media-libs/libpng:0
    media-fonts/dejavu
    >=dev-games/guichan-0.8.1[sdl]

    media-libs/libsdl[X,video]
    media-libs/sdl-image[png]
    media-libs/sdl-mixer[vorbis]
    media-libs/sdl-net
    media-libs/sdl-ttf
    media-libs/sdl-gfx

    x11-apps/xmessage
    x11-libs/libX11
    x11-misc/xdg-utils
    x11-misc/xsel

    nls? ( virtual/libintl )
"

DEPEND="${RDEPEND}"

BDEPEND="
    virtual/pkgconfig
    nls? ( sys-devel/gettext )
"

src_prepare() {

    if [[ -f CMakeLists.txt.legacy ]]; then
        mv CMakeLists.txt.legacy CMakeLists.txt || die
    fi

    eapply "${FILESDIR}/remove-manaplus-appdata-xml.patch"
    eapply "${FILESDIR}/cmake-cmp0015-new.patch"
    eapply "${FILESDIR}/manaplus-wallpaper-ctime.patch"
    eapply "${FILESDIR}/xml-version-patch.patch"
    eapply "${FILESDIR}/libxml-header.patch"
    eapply "${FILESDIR}/rename-info-txt.patch"

    if grep -Rqs -- '-DDEBUG' "${S}"; then
        einfo "Removing hardcoded -DDEBUG (conflicts with enum DEBUG)"
        grep -Rsl -- '-DDEBUG' "${S}" | while read -r f; do
            sed -i -e 's/[[:space:]]-DDEBUG//g' "$f" || die
        done
    fi

    cmake_src_prepare
}

src_configure() {

    CMAKE_BUILD_DIR="${WORKDIR}/${P}_build"

    rm -rf "${CMAKE_BUILD_DIR}/data" || die
    ln -snf "${S}/data" "${CMAKE_BUILD_DIR}/data" || die

    cmake_src_configure
}

src_install() {
    cmake_src_install
}
