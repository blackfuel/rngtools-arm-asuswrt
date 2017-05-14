#!/bin/bash
#############################################################################
# Rng-tools for AsusWRT
#
# This script downloads and compiles all packages needed for adding 
# rng-tools capability to Asus ARM routers.
#
# Before running this script, you must first compile your router firmware so
# that it generates the AsusWRT libraries.  Do not "make clean" as this will
# remove the libraries needed by this script.
#############################################################################
PATH_CMD="$(readlink -f $0)"

set -e
set -x

#REBUILD_ALL=0
PACKAGE_ROOT="$HOME/asuswrt-merlin-addon/asuswrt"
SRC="$PACKAGE_ROOT/src"
ASUSWRT_MERLIN="$HOME/asuswrt-merlin"
TOP="$ASUSWRT_MERLIN/release/src/router"
BRCMARM_TOOLCHAIN="$ASUSWRT_MERLIN/release/src-rt-6.x.4708/toolchains/hndtools-arm-linux-2.6.36-uclibc-4.5.3"
SYSROOT="$BRCMARM_TOOLCHAIN/arm-brcm-linux-uclibcgnueabi/sysroot"
echo $PATH | grep -qF /opt/brcm-arm || export PATH=$PATH:/opt/brcm-arm/bin:/opt/brcm-arm/arm-brcm-linux-uclibcgnueabi/bin:/opt/brcm/hndtools-mipsel-linux/bin:/opt/brcm/hndtools-mipsel-uclibc/bin
[ ! -d /opt ] && sudo mkdir -p /opt
[ ! -h /opt/brcm ] && sudo ln -sf $HOME/asuswrt-merlin/tools/brcm /opt/brcm
[ ! -h /opt/brcm-arm ] && sudo ln -sf $HOME/asuswrt-merlin/release/src-rt-6.x.4708/toolchains/hndtools-arm-linux-2.6.36-uclibc-4.5.3 /opt/brcm-arm
[ ! -d /projects/hnd/tools/linux ] && sudo mkdir -p /projects/hnd/tools/linux
[ ! -h /projects/hnd/tools/linux/hndtools-arm-linux-2.6.36-uclibc-4.5.3 ] && sudo ln -sf /opt/brcm-arm /projects/hnd/tools/linux/hndtools-arm-linux-2.6.36-uclibc-4.5.3
#sudo apt-get install  xutils-dev libltdl-dev automake1.11
#MAKE="make -j`nproc`"
MAKE="make -j1"

################### #########################################################
# ARGP-STANDALONE # #########################################################
################### #########################################################

DL="argp-standalone-1.3.tar.gz"
#DL="argp-standalone-1.4-test2.tar.gz"
URL="https://www.lysator.liu.se/~nisse/misc/$DL"
mkdir -p $SRC/argp-standalone && cd $SRC/argp-standalone
FOLDER="${DL%.tar.gz*}"
FOLDER_ARGP="$SRC/argp-standalone/$FOLDER" # workaround because 'make install' doesn't work
[ "$REBUILD_ALL" == "1" ] && rm -rf "$FOLDER"
if [ ! -f "$FOLDER/__package_installed" ]; then
[ ! -f "$DL" ] && wget $URL
[ ! -d "$FOLDER" ] && tar xzvf $DL
cd $FOLDER

# https://dev.openwrt.org/browser/trunk/package/libs/argp-standalone/patches/
PATCHES_FOLDER="${PATH_CMD%/*}/argp-standalone/patches"
for PATCH_NAME in $PATCHES_FOLDER/*.patch; do
  patch --dry-run --silent -p1 -i "$PATCH_NAME" >/dev/null 2>&1 && \
    patch -p1 -i "$PATCH_NAME" || \
    echo "The patch was not applied."
done

PKG_CONFIG_PATH="$PACKAGE_ROOT/lib/pkgconfig" \
OPTS="-ffunction-sections -fdata-sections -O3 -pipe -march=armv7-a -mtune=cortex-a9 -fno-caller-saves -mfloat-abi=soft -Wall -fPIC -std=gnu99" \
CFLAGS="$OPTS" CPPFLAGS="$OPTS" \
LDFLAGS="-ffunction-sections -fdata-sections -Wl,--gc-sections" \
./configure \
--host=arm-brcm-linux-uclibcgnueabi \
'--build=' \
--prefix=$PACKAGE_ROOT

$MAKE
make install
touch __package_installed
fi

########## ##################################################################
# GCRYPT # ##################################################################
########## ##################################################################

DL="libgcrypt-1.7.6.tar.bz2"
URL="https://gnupg.org/ftp/gcrypt/libgcrypt/$DL"
mkdir -p $SRC/gcrypt && cd $SRC/gcrypt
FOLDER="${DL%.tar.bz2*}"
[ "$REBUILD_ALL" == "1" ] && rm -rf "$FOLDER"
if [ ! -f "$FOLDER/__package_installed" ]; then
[ ! -f "$DL" ] && wget $URL
[ ! -d "$FOLDER" ] && tar xvjf $DL
cd $FOLDER

PKG_CONFIG_PATH="$PACKAGE_ROOT/lib/pkgconfig" \
OPTS="-ffunction-sections -fdata-sections -O3 -pipe -march=armv7-a -mtune=cortex-a9 -fno-caller-saves -mfloat-abi=soft -Wall -fPIC -std=gnu99" \
CFLAGS="$OPTS" CPPFLAGS="$OPTS" \
LDFLAGS="-ffunction-sections -fdata-sections -Wl,--gc-sections" \
./configure \
--host=arm-brcm-linux-uclibcgnueabi \
'--build=' \
--prefix=$PACKAGE_ROOT \
--enable-shared \
--enable-static \
--disable-amd64-as-feature-detection \
--with-gpg-error-prefix=$PACKAGE_ROOT

$MAKE
make install
touch __package_installed
fi

############# ###############################################################
# RNG-TOOLS # ###############################################################
############# ###############################################################

DL="rng-tools-5.tar.gz"
URL="https://downloads.sourceforge.net/project/gkernel/rng-tools/5/$DL"
FOLDER="${DL%.tar.gz*}"
#DL="rng-tools_2-unofficial-mt.14.orig.tar.bz2"
#URL="https://launchpad.net/ubuntu/+archive/primary/+files/$DL"
#FOLDER="rng-tools-2-unofficial-mt.14"
mkdir -p $SRC/rng-tools && cd $SRC/rng-tools
[ "$REBUILD_ALL" == "1" ] && rm -rf "$FOLDER"
if [ ! -f "$FOLDER/__package_installed" ]; then
[ ! -f "$DL" ] && wget $URL

[ ! -d "$FOLDER" ] && tar xzvf $DL
#[ ! -d "$FOLDER" ] && tar xjvf $DL

cd $FOLDER

[ ! -f "configure" ] && [ -f "autogen.sh" ] && ./autogen.sh

PKG_CONFIG_PATH="$PACKAGE_ROOT/lib/pkgconfig" \
OPTS="-ffunction-sections -fdata-sections -O3 -pipe -march=armv7-a -mtune=cortex-a9 -fno-caller-saves -mfloat-abi=soft -Wall -fPIC -std=gnu99 -I$PACKAGE_ROOT/include -I$FOLDER_ARGP" \
CFLAGS="$OPTS" CPPFLAGS="$OPTS" \
LDFLAGS="-ffunction-sections -fdata-sections -Wl,--gc-sections -L$PACKAGE_ROOT/lib -L$FOLDER_ARGP" \
LIBS="-largp" \
./configure \
--host=arm-brcm-linux-uclibcgnueabi \
'--build=' \
--prefix=$PACKAGE_ROOT \
--disable-silent-rules

$MAKE
make install
touch __package_installed
fi

