# !/bin/sh

RTE_DEV_TOOL="$RTE_SDK/usertools/dpdk-devbind.py "

# this is dpdk setup in vmware

# first : config hugepages (already config on boot)

# second : insmod dpdk uio
sudo modprobe uio
sudo insmod $RTE_SDK/$RTE_TARGET/kmod/igb_uio.ko

# eth down
ifconfig eth37 down
ifconfig eth38 down

# bind network device
# first show
eval $RTE_DEV_TOOL "--status"

# second bind
eval $RTE_DEV_TOOL "-b igb_uio 0000:02:05.0 0000:02:06.0"
