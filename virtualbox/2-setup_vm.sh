# Name of the virtual machine OS
export NAME=ztoa_mpw2_30g
# Copy the tools script to the VM, first install SSH
echo "[- Message -] Installing ssh in $NAME"
VBoxManage --nologo guestcontrol $NAME run --exe "/usr/bin/apt-get" --username root --password 12345  --wait-stdout -- apt/arg0 install -y ssh
echo "[- Message -] Installing VirtualBox tools in $NAME"
VBoxManage --nologo guestcontrol $NAME run --exe "/usr/bin/apt-get" --username root --password 12345  --wait-stdout -- apt/arg install -y dkms build-essential linux-headers-5.8.0-48-generic autoconf make bison flex gperf libreadline-dev libncurses5-dev docker.io -o Dpkg::Options::=--force-confnew
VBoxManage --nologo guestcontrol $NAME run --exe "/usr/bin/apt-get" --username root --password 12345  --wait-stdout -- apt/arg0 install -y virtualbox-guest-utils virtualbox-guest-x11 virtualbox-guest-dkms -o Dpkg::Options::=--force-confnew
echo "[- Message -] Installing EDA dependencies [GTKWave/ngspice/klayout] in $NAME"
VBoxManage --nologo guestcontrol $NAME run --exe "/usr/bin/apt-get" --username root --password 12345  --wait-stdout -- apt/arg install -y m4 tcsh csh libx11-dev tcl-dev tk-dev libcairo2-dev libncurses-dev git ngspice klayout python3-pip gtkwave -o Dpkg::Options::=--force-confnew

