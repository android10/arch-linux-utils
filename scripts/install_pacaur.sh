#!/bin/bash

#Make sure the system is up to date.
sudo pacman -Syu --noconfirm


#Install dependency packages we'll need to build Pacaur on Arch.
sudo pacman -S binutils make gcc fakeroot expac yajl git --noconfirm


#Create a temporary working directory for installing Pacaur.
mkdir -p ~/tmp/pacaur_install
cd ~/tmp/pacaur_install


#Dependency needed: "cower", which is used to get information and download packages from AUR.
gpg --recv-keys --keyserver hkp://pgp.mit.edu 1EB2638FF56C0C53
curl -o PKGBUILD https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=cower
makepkg -i PKGBUILD --skippgpcheck --noconfirm
sudo pacman -U cower*.tar.xz --noconfirm
#This command generates a .tar.xz file which we can install using Pacman.


#Install pacaur from AUR: Download the files from git and build a .tar.xz file then install it.
curl -o PKGBUILD https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=pacaur
makepkg -i PKGBUILD --noconfirm
sudo pacman -U pacaur*.tar.xz --noconfirm


#Now clean up system: deleting temporary directory.
rm -r ~/tmp/pacaur_install
cd -
