#!/system/bin/sh -
#===============================================================================
#
#          FILE: leapp_init.sh
# 
#         USAGE: ./leapp_init.sh 
# 
#   DESCRIPTION: this script for installing lenovo apps, don't try to modify.
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: linkscue(scue),
#  ORGANIZATION: 
#       CREATED: 2013年08月17日 16时20分42秒 HKT
#      REVISION:  ---
#===============================================================================

#-------------------------------------------------------------------------------
#  variable
#-------------------------------------------------------------------------------
LOG="log -p i -t preload"
log_file="/data/system/.preload_app_done"
if [[ -f $log_file ]]; then
    $LOG "preload had done."
    exit 0
fi

#-------------------------------------------------------------------------------
#  alias
#-------------------------------------------------------------------------------
alias sysrw='mount -o remount,rw /system'
alias sysro='mount -o remount,ro /system'

#-------------------------------------------------------------------------------
#  install apps
#-------------------------------------------------------------------------------
$LOG "preload install lenovo apps start"
LeApps_Dir="/preload/LeApps"
find $LeApps_Dir -type f -name "*.apk" -exec cp {} /data/app/ \;
busybox chown system:system /data/app/*.apk # 
busybox chmod 664 /data/app/*.apk
$LOG "preload install lenovo apps done"

#-------------------------------------------------------------------------------
#  SuperCam & others, don't try to modify the code list below.
#-------------------------------------------------------------------------------
if [[ ! -f $LeApps_Dir/SCG_arm_hd.apk ]]; then
    echo "Preload error at $(date +%F_%X)" > $log_file
    $LOG "Preload error at $(date +%F_%X)!"
    exit 9
fi
$LOG "Preload install SuperCam libs & others start"
SuperCAM_Package="com.lenovo.scg"
LeStore_Package="com.lenovo.leos.appstore"
Home_Package="com.cyanogenmod.trebuchet"
while [[ "$(pm list package | grep com.lenovo.scg)" == "" ]]; do
    sleep 1
done
SuperCAM_Base=$(pm path $SuperCAM_Package |\
    sed 's/package://g;s/\/data\/app\///g;s/\.apk//g')
if [[ "$(echo $SuperCAM_Base | grep [0-9])" == ""  ]]; then
    SuperCAM_Base="$SuperCAM_Base"-1
fi
SuperCAM_Libs="/data/app-lib/$SuperCAM_Base"
sysrw
for n in $(find $SuperCAM_Libs -type f);
do 
    ln -s $n /system/lib/$(basename $n)
done
sysro
echo "Preload done at $(date +%F_%X)" > $log_file
$LOG "Preload done at $(date +%F_%X)!"
