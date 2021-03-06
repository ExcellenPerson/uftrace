#!/bin/sh

if [ "x$(id -u)" != x0 ]; then
    echo "You might have to run it as root user."
    echo "Please run it again with 'sudo'."
    echo
    return
fi

OPT="${@}"

distro=$(cat /etc/os-release | grep "^ID=" | cut -d\= -f2 | sed -e 's/"//g')

case $distro in
    "ubuntu")
        apt-get $OPT install pandoc libdw-dev libpython2.7-dev libncursesw5-dev pkg-config ;;
    "fedora")
        dnf install $OPT pandoc elfutils-devel python2-devel ncurses-devel pkgconf-pkg-config ;;
    "rhel" | "centos")
        rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
        yum install $OPT pandoc elfutils-devel python2-devel ncurses-devel pkgconfig ;;
    *) # we can add more install command for each distros.
        echo "\"$distro\" is not supported distro, so please install packages manually." ;;
esac

