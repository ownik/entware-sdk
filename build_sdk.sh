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
