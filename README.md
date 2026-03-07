# Entware SDK [![Latest version](https://img.shields.io/github/v/tag/ownik/entware-sdk?label=version&logoColor=violet)](https://github.com/ownik/entware-sdk/releases/latest) [![Build Status](https://img.shields.io/github/actions/workflow/status/ownik/entware-sdk/build_sdk.yaml?logo=Github)](https://github.com/ownik/entware-sdk/actions/workflows/build_sdk.yaml) [![PR's Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat)](https://github.com/ownik/entware-sdk/pulls) [![status: active](https://github.com/GIScience/badges/raw/master/status/active.svg)](https://github.com/GIScience/badges#active)

**Entware SDK** provides prebuilt SDK archives (toolchain + build
system) for the [Entware project](https://github.com/Entware/Entware).

Entware uses the [OpenWrt build system](https://openwrt.org/docs/guide-developer/toolchain/use-buildsystem), but unlike [OpenWrt](https://github.com/openwrt), it
does not publish prebuilt SDK archives.

This repository fills that gap by automatically building and publishing
ready-to-use SDK bundles.

> 💡 If you want to build Entware packages via **GitHub Actions**, you can use the [gh-action-entware-sdk](https://github.com/ownik/gh-action-entware-sdk)

## 🚀 Why use this?

Without a prebuilt SDK, building even a single Go package in GitHub
Actions can take **\~1 hour 40 minutes**.

With the SDK, build time drops to **\~20 minutes**.

This significantly speeds up CI pipelines and local development.

## 🐳 Build Environment (Recommended)

It is strongly recommended to use the official OpenWrt build worker container:

[ghcr.io/openwrt/buildbot/buildworker-v3.11.3:latest](https://github.com/openwrt/buildbot/pkgs/container/buildbot%2Fbuildworker-v3.11.3)

This is the latest image that still includes **Python 2**.

[Entware](https://github.com/Entware/Entware) still depends on Python 2 in its build system, so using newer `buildworker` images may result in build failures.

Alternatively, you may build on a native system — but in that case your environment must match the one used in the image above (Python 2 and related dependencies availability).

### Example

```bash
docker run --rm -it \
  -v $(pwd):/work \
  -w /work \
  ghcr.io/openwrt/buildbot/buildworker-v3.11.3:latest \
  bash
```

All SDK build steps should be executed inside this environment.

## 📥 Download SDK

Download the latest SDK for your platform:

- [aarch64-3.10](https://github.com/ownik/entware-sdk/releases/latest/download/entware-sdk-aarch64-3.10_gcc-8.4.0_glibc-2.27.Linux-x86_64.tar.zst)
- [armv7-3.2](https://github.com/ownik/entware-sdk/releases/latest/download/entware-sdk-armv7-3.2_gcc-8.4.0_glibc-2.27.Linux-x86_64.tar.zst)
- [mips-3.4](https://github.com/ownik/entware-sdk/releases/latest/download/entware-sdk-mips-3.4_gcc-8.4.0_glibc-2.27.Linux-x86_64.tar.zst)
- [mipsel-3.4](https://github.com/ownik/entware-sdk/releases/latest/download/entware-sdk-mipsel-3.4_gcc-8.4.0_glibc-2.27.Linux-x86_64.tar.zst)
- [x64-3.2](https://github.com/ownik/entware-sdk/releases/latest/download/entware-sdk-x64-3.2_gcc-8.4.0_glibc-2.27.Linux-x86_64.tar.zst)


See full list on [Release page](https://github.com/ownik/entware-sdk/releases/latest).

## 🛠 How to use

### 1️⃣ Extract SDK

```bash
tar xf entware-sdk-*.tar.zst --strip=1 --no-same-owner -C .
```

### 2️⃣ Update and install feeds

```bash
./scripts/feeds update -a
./scripts/feeds install -a
```

### 3️⃣ Add your package

Place your package inside `./package` or create a symlink:

```bash
ln -s <path-to-your-package> ./package/<PACKAGE_NAME>
```

### 4️⃣ Generate default config

```bash
make defconfig
```

### 5️⃣ Build your package

```bash
make package/<PACKAGE_NAME>/compile
```

# 🔗 Related Projects

+ **gh-action-entware-sdk** https://github.com/ownik/entware-sdk
+ **Entware project** https://github.com/Entware/Entware
