# !/bin/sh

RTE_IGB_UIO="/root/kmods-dpdk/linux/igb_uio"
RTE_DEV_TOOL="$RTE_SDK/usertools/dpdk-devbind.py "

# this is dpdk setup in vmware

# first : config hugepages (already config on boot)

# second : insmod dpdk uio
cd $RTE_IGB_UIO
rmmod igb_uio.ko
make > /dev/null 2>&1
sudo modprobe uio
sudo insmod igb_uio.ko
cd -

# eth down
ifconfig ens37 down > /dev/null 2>&1
ifconfig ens38 down > /dev/null 2>&1

# sleep 3 seconds
sleep 3

# bind network device

# second bind
eval  python3 $RTE_DEV_TOOL "-b igb_uio 0000:02:05.0 0000:02:06.0"

echo "\n======== after dev bind========\n"
eval python3 $RTE_DEV_TOOL "--status"
