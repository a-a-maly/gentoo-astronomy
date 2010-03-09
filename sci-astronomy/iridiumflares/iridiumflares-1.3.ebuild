# Copyright 2010 Ivan Boldyrev
# 
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit eutils java-pkg-2 java-ant-2

MY_PN="IridiumFlares"

DESCRIPTION="Iridium flares prediction software."
HOMEPAGE="http://iridiumflares.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/iridiumflares-src/${PV}/${MY_PN}-${PV}.src.zip"
LICENSE="GPL"
IUSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-arch/unzip
        >=virtual/jdk-1.4
        dev-java/sun-java3d-bin"
RDEPEND=">=virtual/jre-1.4
         dev-java/sun-java3d-bin"

# j3dcore.jar
# j3dutils.jar
# vecmath.jar

S=${WORKDIR}

src_unpack () {
           unpack ${A}
           cd ${S}
           cp ${FILESDIR}/build-1.3.xml build.xml
           rm -rf iridiumflares/tests/
           java-pkg_jar-from sun-java3d-bin vecmath.jar
}

src_install () {
            java-pkg_dojar internationalization.jar iridiumflares.jar resources.jar
            java-pkg_dolauncher ${MY_PN} --main iridiumflares.Main \
                    -Djava.library.path=/usr/$(get_libdir)/${PN}
}