#!/sbin/sh
#
# Live ramdisk patching script
#
# This software is licensed under the terms of the GNU General Public
# License version 2, as published by the Free Software Foundation, and
# may be copied, distributed, and modified under those terms.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# Please maintain this if you use this script or any part of it

# Head to the build tools extracted folder
cd /tmp;

cmdline="androidboot.hardware=qcom user_debug=31 msm_rtb.filter=0x3b7 ehci-hcd.park=3 androidboot.bootdevice=msm_sdcc.1 vmalloc=300M dwc3.maximum_speed=high dwc3_msm.prop_chg_detect=Y buildvariant=userdebug";

# Pack our new boot.img
./mkbootimg --kernel /tmp/zImage --ramdisk /tmp/ramdisk.gz --cmdline "$cmdline" --base 0x00000000 --pagesize 2048 --ramdisk_offset 0x02000000 --tags_offset 0x01e00000 --dt /tmp/dt.img -o /tmp/newboot.img;

# It's flashing time!!
dd if=/tmp/newboot.img of=/dev/block/platform/msm_sdcc.1/by-name/boot;
