#!/system/bin/sh
#===============================================================================
#
#          FILE: gms_install.sh
# 
#         USAGE: ./gms_install.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: linkscue (scue), linkscue@gmail.com
#       CREATED: Friday, July 12, 2013 06:46:11 HKT HKT
#     COPYRIGHT: Copyright (c) 2013, linkscue
#      REVISION: 0.1
#  ORGANIZATION: ATX风雅组
#===============================================================================

gms_dir=/preload/gms
cd $gms_dir

#make directory
find system/* -type d -exec mkdir -p /{} 2>/dev/null \;

#remount system
mount -o remount,rw /system

# link file
find system/ -type d -exec mkdir -p /{} \;
find system/ -type f -exec ln -s $(readlink -f {}) /{} \;

#remount system
mount -o remount,ro /system

cd -
