#!/bin/bash
# Diego H, 24/03/2021
# Update 2022 by Harald Pretl, Institute for Integrated Circuits, Johannes Kepler University Linz

# Define your arguments here

# Path to store the Virtual machine configuration
export STORE_PATH=${HOME}/Dropbox/IIC_Xubuntu_v2
# Name of the virtual machine OS
export NAME=IIC_Xubuntu_v2
# Path of the ISO file
export ISO=${HOME}/Downloads/xubuntu-20.04.3-desktop-amd64.iso
# Size of the RAM in GB
export RAM_SIZE=4
# Size of the HDD in GB
export HDD_SIZE=20
# Number of CPUs
export N_CPU=2
# Location of templates (first one for Linux, second one for MacOS)
#export VBOX_DIR=/usr/share/virtualbox
export VBOX_DIR=/Applications/VirtualBox.app/Contents/MacOS

# Templates for unattended install
export PRE=${VBOX_DIR}/UnattendedTemplates/ubuntu_preseed.cfg
export POST=${VBOX_DIR}/UnattendedTemplates/debian_postinstall.sh
export ADDITIONS_PATH=${VBOX_DIR}/VBoxGuestAdditions.iso

# Let's go to work

echo "[- Message -]: Creating a VM with name $NAME and path $STORE_PATH"
# --register will enable the VM in the VirtualBox GUI
# --default will create the machine with minimal config for
# the hardware.
# For the ostype, use the command VBoxManage list ostypes
VBoxManage createvm --name $NAME --ostype Ubuntu_64 --register --basefolder $STORE_PATH --default
# Increase a little bit the HW capabilities
echo "[- Message -] Modifying the hardware RAM with $RAM_SIZE GB and $N_CPU CPUs"
VBoxManage modifyvm $NAME --memory $((RAM_SIZE * 1024)) --cpus $N_CPU
# and the hdd
echo "[- Message -] Creating an HDD of size $HDD_SIZE GB stored in $STORE_PATH/$NAME.vdi"
VBoxManage createmedium disk --filename "$STORE_PATH/$NAME.vdi" --size $((HDD_SIZE*1024)) --format VDI --variant Fixed
# connect the HDD to the created VM
echo "[- Message -] Attaching the virtual HDD $NAME.vdi to the VM $NAME"
VBoxManage storageattach $NAME --storagectl SATA --port 0 --type hdd --medium $STORE_PATH/$NAME.vdi
# Prepare boot from ISO
echo "[- Message -] Attaching ISO DVD $ISO"
VBoxManage storageattach $NAME --storagectl IDE --device 0 --port 0 --type dvddrive --medium $ISO
# Creating a port forwarding for SSH connection
echo "[- Message -] Enabling ssh port forwarding"
VBoxManage modifyvm "$NAME" --natpf1 "SSH,tcp,127.0.0.1,2522,10.0.2.15,22"
# Launch
echo "[- Message -] Launching virtual machine $NAME"
VBoxManage unattended install $NAME --iso=$ISO --user=iic --password=iic!123 --install-additions --additions-iso=$ADDITIONS_PATH --script-template=$PRE --post-install-template=$POST --time-zone=CET --hostname=iic-vm.vm.com --start-vm=gui
