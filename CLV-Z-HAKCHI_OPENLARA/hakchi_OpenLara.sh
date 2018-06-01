#!/bin/sh

source /etc/preinit
script_init

WorkingDir=$(pwd)
GameName=$(echo $WorkingDir | awk -F/ '{print $NF}')
ok=0
filedetect=0

if [ -f "/usr/share/games/$GameName/$GameName.desktop" ]; then
        OPENLARATrueDir=$(grep /usr/share/games/$GameName/$GameName.desktop -e 'Exec=' | awk '{print $2}' | sed 's/\([/\t]\+[^/\t]*\)\{1\}$//')
        OPENLARAPortableFiles="$OPENLARATrueDir/OpenLara_files"
        ok=1
fi

#check for gamefiles...
[ -f "$OPENLARAPortableFiles/DATA/GYM.PHD"] && filedetect=1
[ -f "$OPENLARAPortableFiles/GYM.PHD"] && filedetect=1
[ -f "$OPENLARAPortableFiles/PSXDATA/GYM.PSX"] && filedetect=1
#[ -f "$OPENLARAPortableFiles/DATA/GYM.SAT"] && filedetect=1 #SATURN (Not support yet)
[ -f "$OPENLARAPortableFiles/data/ASSAULT.TR2"] && filedetect=1
[ -f "$OPENLARAPortableFiles/assault.TR2"] && filedetect=1
[ -f "$OPENLARAPortableFiles/DATA/ASSAULT.PSX"] && filedetect=1
[ -f "$OPENLARAPortableFiles/data/JUNGLE.TR2"] && filedetect=1
[ -f "$OPENLARAPortableFiles/DATA/JUNGLE.PSX"] && filedetect=1
[ -f "$OPENLARAPortableFiles/level/1/GYM.PHD"] && filedetect=1
[ -f "$OPENLARAPortableFiles/level/1/GYM.PSX"] && filedetect=1

if [ "$ok" == 1 ] && [ "$filedetect" == 1 ]; then
   decodepng "$OPENLARATrueDir/Hakchi_OpenLara_assets/openlarasplash-min.png" > /dev/fb0;
   echo "1" > "/proc/sys/vm/overcommit_memory" #Unlock RAM limit. No reason not to...
   sleep 1 #Engine is so well built the splash needs to display for at least a second for looks...
   cd $OPENLARAPortableFiles
   chmod 755 $OPENLARAPortableFiles/OpenLara
   $OPENLARAPortableFiles/OpenLara #Execute engine.
   # After runtime
   sync
   echo 3 > /proc/sys/vm/drop_caches
   sleep 1
else
        decodepng "$OPENLARATrueDir/Hakchi_OpenLara_assets/openlaraerror_files-min.png" > /dev/fb0;
        sleep 5
fi