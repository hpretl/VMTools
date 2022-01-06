# Now copy the script
export NAME=ztoa_mpw2_30g
echo "[- Message -] Copying the script to $NAME"
scp -P 2522 ./install_tools.sh ./fix_sudo.sh ./openlane.sh openlane_wrapper.sh zerotoasic@127.0.0.1:/home/zerotoasic
# Give permissions to the script
VBoxManage --nologo guestcontrol $NAME run --exe "/usr/bin/chmod" --username zerotoasic --password 12345  --wait-stdout -- chmod/arg0 a+x /home/zerotoasic/install_tools.sh /home/zerotoasic/fix_sudo.sh
# Run script
echo "[- Message -] Installing tools"
VBoxManage --nologo guestcontrol $NAME run --exe "/home/zerotoasic/fix_sudo.sh" --username root --password 12345 --wait-stdout
VBoxManage --nologo guestcontrol $NAME run --exe "/usr/bin/bash" --username zerotoasic --password 12345 --wait-stdout -- source/arg0 -c "source /home/zerotoasic/install_tools.sh"
# Rebooting to apply new group
echo "[- Message -] Rebooting machine to reflect docker group"
VBoxManage controlvm $NAME acpipowerbutton
