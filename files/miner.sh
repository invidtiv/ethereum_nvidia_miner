#!/usr/bin/env bash

#
# miner.sh
# Author: Nils Knieling - https://github.com/Cyclenerd/ethereum_nvidia_miner
#
# Start etherminer and set power limit
#

# Load global settings settings.conf
# shellcheck source=settings.conf
# shellcheck disable=SC1091
if ! source ~/settings.conf; then
	echo "FAILURE: Can not load global settings 'settings.conf'"
	exit 9
fi

# Set power limit
~/nvidia-overclock.sh powerlimit

export GPU_FORCE_64BIT_PTR=0
export GPU_MAX_HEAP_SIZE=100
export GPU_USE_SYNC_OBJECTS=1
export GPU_MAX_ALLOC_PERCENT=100
export GPU_SINGLE_ALLOC_PERCENT=100
export CUDA_DEVICE_ORDER=PCI_BUS_ID

#
# Ethereum Mining
#

# The following setting is available in ethminer since ver 0.13x
# Set it to any value to prevent colored output (useful for log collecting)
# Uncomment the following line if you want to disable colors.
#export NO_COLOR=true

# ethminer
# https://github.com/ethereum-mining/ethminer
# Use -G (opencl) or -U (cuda) flag to select GPU platform.
~/ethereum-mining/ethminer/build/ethminer/ethminer -U -P stratum+tcp://"$MY_ADDRESS.$MY_RIG"@eu1.ethermine.org:4444 

# Claymore's Dual Ethereum+Decred AMD+NVIDIA GPU Miner
# https://github.com/nanopool/Claymore-Dual-Miner
#~/claymore-dual-miner/ethdcrminer64 -epool "eu1.ethermine.org:4444" -ewal "$MY_ADDRESS.$MY_RIG" -epsw x -mode 1 -ftime 10 -mport 0


#
# Monero Mining
#

# XMR-Stak - Monero/Aeon All-in-One Mining Software
# https://github.com/fireice-uk/xmr-stak
#cd ~/monero-mining
# CUDA (GPU) only mining. Disable the CPU miner backend.
#~/monero-mining/xmr-stak/build/bin/xmr-stak --noCPU
# CPU only mining. Disable the NVIDIA miner backend.
#~/monero-mining/xmr-stak/build/bin/xmr-stak --noNVIDIA


#
# Zcash Mining
#

# EWBF's CUDA Zcash Miner
# https://bitcointalk.org/index.php?topic=1707546.0
#cd ~/zcash-mining
#~/zcash-mining/ewbf/miner --fee 0 --server eu1-zcash.flypool.org --user YOUR-ZCASH-T-ADDRESS --pass x --port 3333
