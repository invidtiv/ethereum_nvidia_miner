#!/usr/bin/env bash

#
# nvidia-overclock.sh
# Author: Nils Knieling - https://github.com/Cyclenerd/ethereum_nvidia_miner
#
# Overclocking with nvidia-settings
#

# Load global settings settings.conf
if ! source ~/settings.conf; then
	echo "FAILURE: Can not load global settings 'settings.conf'"
	exit 9
fi

export DISPLAY=:0

# Graphics card 1 to 6
for MY_DEVICE in {0..5}
do
	# Check if card exists
	if nvidia-smi -i $MY_DEVICE >> /dev/null 2>&1; then
		nvidia-settings -a "[gpu:$MY_DEVICE]/GPUPowerMizerMode=1"
		# Fan speed
		nvidia-settings -a "[gpu:$MY_DEVICE]/GPUFanControlState=1"
		nvidia-settings -a "[fan:$MY_DEVICE]/GPUTargetFanSpeed=$MY_FAN"
		# Graphics clock
		nvidia-settings -a "[gpu:$MY_DEVICE]/GPUGraphicsClockOffset[3]=$MY_CLOCK"
		# Memory clock
		nvidia-settings -a "[gpu:$MY_DEVICE]/GPUMemoryTransferRateOffset[3]=$MY_MEM"
               
               
	fi
done
# Set watt/powerlimit for all GPU.
sudo nvidia-smi -pl "$MY_WATT"

echo
echo "Done"
echo
