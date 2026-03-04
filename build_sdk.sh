#!/bin/sh

set -e 

ARCH=$1

./scripts/feeds update
./scripts/feeds install -a

cp -v configs/${ARCH}.config .config
make defconfig

make -j$(nproc) tools/install
make -j$(nproc) toolchain/install
make -j$(nproc) target/compile
make -j$(nproc) target/sdk/compile

for file in $PWD/bin/targets/${ARCH}/*/entware-sdk-${ARCH}*; do
    dir=$(dirname $file)
    name=$(basename $file)
    (cd $dir; sha256sum $name) >> $dir/$name.sha256
done