#!/usr/bin/env bash

# Installing kernel if in version is version 3
if uname -r | grep -l "^3" ; then
  echo "Installing kernel"
  # Add ELRepo gpg key to the system.
  rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org

  # Add new ELRepo repository with rpm command.
  rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm

  # Install kernel
  yum -y --enablerepo=elrepo-kernel install kernel-ml

  # Set grub
  grub2-set-default 0
  grub2-mkconfig -o /boot/grub2/grub.cfg

  echo "Doing reboot"
  echo "Run 'vagrant up --provision' again"
  reboot
fi
