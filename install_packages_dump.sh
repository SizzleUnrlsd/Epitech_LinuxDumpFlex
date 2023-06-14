#!/usr/bin/env bash

clear
echo "INSTALLING PACKAGES FOR EPITECH'S DUMP"

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Detect package manager
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$NAME
else
    echo "Not able to determine the system."
    exit 1
fi

case $OS in
    "Fedora"*)
        PM=dnf
        ;;
    "Ubuntu"*)
        PM=apt
        ;;
    "Arch Linux"*)
        PM=pacman
        ;;
    "openSUSE Leap"*)
        PM=zypper
        ;;
    *)
        echo "Your OS is not supported by this script."
        exit 1
        ;;
esac

echo "Detected package manager: $PM"

echo "Press ENTER to continue..."
read

# System upgrade
if [[ $PM == "dnf" ]]; then
   $PM upgrade -y
elif [[ $PM == "apt" ]]; then
   $PM update && $PM upgrade -y
elif [[ $PM == "pacman" ]]; then
   $PM -Syu --noconfirm
elif [[ $PM == "zypper" ]]; then
   $PM up -y
fi

# Adjust your package list for each distribution
if [[ $PM == "dnf" ]]; then
   packages_list=(gcc make git)
elif [[ $PM == "apt" ]]; then
   packages_list=(gcc make git)
elif [[ $PM == "pacman" ]]; then
   packages_list=(gcc make git)
elif [[ $PM == "zypper" ]]; then
   packages_list=(gcc make git)
fi

packages_list=(boost-devel.x86_64
               boost-static.x86_64
               ca-certificates.noarch
               clang.x86_64
               cmake.x86_64
               CUnit-devel.x86_64
               curl.x86_64
               flac-devel.x86_64
               freetype-devel.x86_64
               gcc.x86_64
               gcc-c++.x86_64
               gdb.x86_64
               git
               glibc.x86_64
               glibc-devel.x86_64
               glibc-locale-source.x86_64
               gmp-devel.x86_64
               ksh.x86_64
               elfutils-libelf-devel.x86_64
               libjpeg-turbo-devel.x86_64
               libvorbis-devel.x86_64
               SDL2.x86_64
               SDL2-static.x86_64
               SDL2-devel.x86_64
               libX11-devel.x86_64
               libXext-devel.x86_64
               ltrace.x86_64
               make.x86_64
               nasm.x86_64
               ncurses.x86_64
               ncurses-devel.x86_64
               ncurses-libs.x86_64
               net-tools.x86_64
               openal-soft-devel.x86_64
               python3-numpy.x86_64
               python3.x86_64
               rlwrap.x86_64
               ruby.x86_64
               strace.x86_64
               tar.x86_64
               tcsh.x86_64
               tmux.x86_64
               sudo.x86_64
               tree.x86_64
               unzip.x86_64
               valgrind.x86_64
               vim
               emacs-nox
               which.x86_64
               xcb-util-image.x86_64
               xcb-util-image-devel.x86_64
               zip.x86_64
               zsh.x86_64
               avr-gcc.x86_64
               qt-devel
               docker
               docker-compose
               java-17-openjdk
               java-17-openjdk-devel
               boost
               boost-math
               boost-graph
               autoconf
               automake
               tcpdump
               wireshark
               nodejs
               emacs-tuareg
               libvirt
               libvirt-devel
               virt-install
               haskell-platform
               golang
               systemd-devel
               libgudev-devel
               php.x86_64
               php-devel.x86_64
               php-bcmath.x86_64
               php-cli.x86_64
               php-gd.x86_64
               php-mbstring.x86_64
               php-mysqlnd.x86_64
               php-pdo.x86_64
               php-pear.noarch
               php-xml.x86_64
               php-gettext-gettext.noarch
               php-phar-io-version.noarch
               php-theseer-tokenizer.noarch
               SFML.x86_64
               SFML-devel.x86_64
               CSFML.x86_64
               CSFML-devel.x86_64
               irrlicht.x86_64
               irrlicht-devel.x86_64
               rust.x86_64
               cargo.x86_64
               mariadb-server.x86_64
               x264.x86_64
               lightspark.x86_64
               lightspark-mozilla-plugin.x86_64
               teams.x86_64)

$PM -y install ${packages_list[@]}

# Install Criterion for all distros
curl -sSL "https://github.com/Snaipe/Criterion/releases/download/v2.4.0/criterion-2.4.0-linux-x86_64.tar.xz" -o criterion-2.4.0.tar.xz
tar xf criterion-2.4.0.tar.xz

# Install Criterion at different locations depending on the distro
if [[ $PM == "dnf" ]]; then
   cp -r criterion-2.4.0/* /usr/local/
   echo "/usr/local/lib" > /etc/ld.so.conf.d/usr-local.conf
elif [[ $PM == "apt" ]]; then
   cp -r criterion-2.4.0/* /usr/local/
   echo "/usr/local/lib" > /etc/ld.so.conf.d/usr-local.conf
elif [[ $PM == "pacman" ]]; then
   cp -r criterion-2.4.0/* /usr/local/
   echo "/usr/local/lib" > /etc/ld.so.conf.d/usr-local.conf
elif [[ $PM == "zypper" ]]; then
   cp -r criterion-2.4.0/* /usr/local/
   echo "/usr/local/lib" > /etc/ld.so.conf.d/usr-local.conf
fi

ldconfig
rm -rf criterion-2.4.0.tar.xz criterion-2.4.0/

# The remaining parts of the script for installing specific tools should also be adapted as necessary, depending on the package manager and the specific versions and repositories used for each tool.
