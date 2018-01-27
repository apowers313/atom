[![Build Status](https://travis-ci.org/apowers313/atom.svg?branch=master)](https://travis-ci.org/apowers313/atom)

## Android Terminal Object Manager (atom)

This is a package manager for embedded Android development. It installs binaries and shared libraries on rooted Android devices, like the [Raspberry Pi](https://developer.android.com/things/hardware/raspberrypi.html) and the [ASUS Tinker Board](https://www.asus.com/us/Single-Board-Computer/Tinker-Board/).

The intent is for this package manger to be cross-platform (OSX and Linux for now) and install packages in a fashion similar to Debian & Ubuntu's [dpkg](https://wiki.debian.org/Teams/Dpkg) & [apt](https://github.com/Debian/apt); and / or RedHat & CentOS's [RPM](https://github.com/rpm-software-management) & [yum](https://github.com/rpm-software-management/yum); and / or OSX's MacPorts & Homebrew. Since none of those package managers can actually be installed and used on the other platforms (believe me, I tried!), this package manager is based on FreeBSD's [pkgng](https://github.com/freebsd/pkg) (I :heart: you FreeBSD).

The currently available packages can be found here:

https://dist.ato.ms

## Installation Prerequisites

* [Android SDK Tools](https://developer.android.com/studio/index.html)
    * We only need `abi`, you don't have to download all of Android Studio, you can just download the "sdk tools" zip at the bottom of the page
* [Android NDK](https://developer.android.com/ndk/downloads/index.html)
    * You can just download the zip
* [FreeBSD pkgng](https://github.com/freebsd/pkg)
    * On OSX you will also have to install `libarchive` as a dependency of pkg

### Install commands

``` bash
sudo make install
```

The `make install` will install the `atom` script in `/usr/bin` and default configuration files in `/etc/atom`. You can use `make DESTDIR=/usr/local install` if you would like to install `atom` and the configuration files to another directory.

## Commands

These generally follow the options and syntax of [pkg(8)](https://www.freebsd.org/cgi/man.cgi?query=pkg):

* `atom search <pkg-name>` - finds packages with names like `pkg-name`
* `atom install <pkg-name>` - installs the package named `pkg-name`
* `atom delete <pkg-name>` - uninstalls the package named `pkg-name`

These commands are features added to `pkg`:

* `atom init`
    * Initializes atom for a new user
* `atom push [android-serial]`
    * Pushes the currently installed packages to the device with `android-serial`. (The `android-serial` can be found by running `adb devices`). If the environment variable `ANDROID_SERIAL` is set, the `android-serial` command line option is not required.
* `atom manifest-template`
    * Create a boilerplate YAML manifest file with good default values for creating a new package

## Creating a package

Of course, none of this is going to be useful without packages to install. If you would like to contribute a package to the community here are the steps to doing it:

1. Type `atom create-template <package-name>`. This will create a new folder with sample template files.
2. Edit `package-name/+MANIFEST`. This is the metadata for your package. See [pkg-create](https://www.freebsd.org/cgi/man.cgi?query=pkg-create&sektion=8) for information about the manifest.
3. Edit `package-name/+DESC`. This is the description of your package.
4. Edit `package-name/Makefile`. These are the instructions to build your package using [GNU Make](https://www.gnu.org/software/make/manual/make.html).
5. Type `make` in your package's directory.
6. [Create an issue on GitHub](https://github.com/apowers313/atom/issues) with your package attached. (The submission process will be a bit different in the future.)

## Roadmap

* Multiple targets
    * Currently atom only supports one set of installed packages, one android API, etc.; however, it is conceivable that a developer could have multiple target architectures, multiple android API levels, multiple groups of packages, etc. The plan is to have command-line switches and / or environment variables for atom that will allow it to support multiple systems at the same time.