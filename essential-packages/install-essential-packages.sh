#!/bin/bash

sudo apt clean
sudo apt autoclean
sudo apt update
sudo apt -y upgrade
sudo apt -y dist-upgrade
sudo apt clean
sudo apt autoclean
sudo apt -y install gawk tcpdump gcc g++ build-essential git tig man-db manpages-dev manpages-posix-dev wget curl htop netcat iperf nmap gzip bzip2 zip unzip unrar p7zip lzma xz-utils subversion less sed hexedit elfutils strace ltrace finger tree pciutils usbutils lsof bash bash-completion pwgen host gdb valgrind ctags cscope python2.7 parted gcc-multilib vim-nox iotop nasm apt-file lynx ncftp sysstat dlocate ldap-utils mailutils net-tools ethtool avahi-daemon tmux screen dtach dnsutils coreutils bsdmainutils flex bison nmap perl lshw hwinfo dmidecode pydf libncurses-dev libyaml-dev socat uuid-runtime python3-pip
# virtualization/emulation stuff (for Unikraft)
sudo apt -y install qemu-kvm qemu-system-x86 qemu-system-aarch64 gcc-aarch64-linux-gnu bridge-utils gdb-multiarch
sudo apt-file update
