# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=Phoenixkernel by Harikumar @ xda-developers
do.devicecheck=1
do.modules=0
do.systemless=0
do.cleanup=1
do.cleanuponabort=0
device.name1=laurel_sprout
device.name2=laurus
supported.versions=10 - 11
'; } # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=auto;
ramdisk_compression=auto;

## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;

## AnyKernel install
dump_boot;

mount -o rw,remount /vendor;
mount -o rw,remount /system;

# memcg is disabled
patch_cmdline androidboot.memcg androidboot.memcg=0;

# LMKD
#patch_prop /system/build.prop "ro.config.low_ram" "false"
#patch_prop /system/build.prop "ro.lmk.kill_heaviest_task" "true"
#patch_prop /system/build.prop "ro.lmk.kill_timeout_ms" "100"
#patch_prop /system/build.prop "ro.lmk.log_stats" "false"
#patch_prop /system/build.prop "ro.lmk.use_minfree_levels" "true"
#patch_prop /system/build.prop "ro.lmk.use_psi" "true"

patch_prop /system/build.prop "ro.lmk.enable_userspace_lmk" "false";

remove_line /system/build.prop "ro.config.low_ram=false";
remove_line /system/build.prop "ro.lmk.kill_heaviest_task=true";
remove_line /system/build.prop "ro.lmk.kill_timeout_ms=100";
remove_line /system/build.prop "ro.lmk.log_stats=false";
remove_line /system/build.prop "ro.lmk.use_minfree_levels=true";
remove_line /system/build.prop "ro.lmk.use_psi=true";

backup_file /vendor/bin/init.qcom.post_boot.sh;
replace_file /vendor/bin/init.qcom.post_boot.sh 755 init.qcom.post_boot.sh;

backup_file /vendor/etc/msm_irqbalance.conf;
replace_file /vendor/etc/msm_irqbalance.conf 644 msm_irqbalance.conf;

backup_file /vendor/etc/wifi/WCNSS_qcom_cfg.ini;
replace_file /vendor/etc/wifi/WCNSS_qcom_cfg.ini 644 WCNSS_qcom_cfg.ini;

backup_file /vendor/etc/perf/perfboostsconfig.xml;
replace_file /vendor/etc/perf/perfboostsconfig.xml 644 perfboostsconfig.xml;

write_boot;
## end install

