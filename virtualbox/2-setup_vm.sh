# Name of the virtual machine OS
export NAME=IIC_Xubuntu_20.04LTS-v2
# Copy the tools script to the VM, first install SSH
echo "[- Message -] Making iic sudoer in $NAME"
VBoxManage --nologo guestcontrol $NAME run --exe "/usr/bin/apt-get" --username root --password 12345  --wait-stdout -- apt/arg0 install -y ssh

as root:

usermod -aG sudo iic

sudo apt install git docker.io

sudo usermod -aG docker iic

<<reboot>>

git clone https://github.com/hpretl/iic-osic.git

cd iic-osic

./iic-osic-setup.sh





echo "[- Message -] Installing VirtualBox tools in $NAME"
VBoxManage --nologo guestcontrol $NAME run --exe "/usr/bin/apt-get" --username root --password 12345  --wait-stdout -- apt/arg install -y dkms build-essential linux-headers-5.8.0-48-generic autoconf make bison flex gperf libreadline-dev libncurses5-dev docker.io -o Dpkg::Options::=--force-confnew
VBoxManage --nologo guestcontrol $NAME run --exe "/usr/bin/apt-get" --username root --password 12345  --wait-stdout -- apt/arg0 install -y virtualbox-guest-utils virtualbox-guest-x11 virtualbox-guest-dkms -o Dpkg::Options::=--force-confnew
echo "[- Message -] Installing EDA dependencies [GTKWave/ngspice/klayout] in $NAME"
VBoxManage --nologo guestcontrol $NAME run --exe "/usr/bin/apt-get" --username root --password 12345  --wait-stdout -- apt/arg install -y m4 tcsh csh libx11-dev tcl-dev tk-dev libcairo2-dev libncurses-dev git ngspice klayout python3-pip gtkwave -o Dpkg::Options::=--force-confnew

