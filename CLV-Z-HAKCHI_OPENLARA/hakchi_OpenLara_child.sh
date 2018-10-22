#!/bin/sh

source /etc/preinit
script_init

OpenLaraTrueDir="$(dirname `readlink -f "$0"`)"
OPENLARAPortableFiles="$OPENLARATrueDir/OpenLara_files"
ok=1 #Legacy... For now.
filedetect=0

HOME="/var/saves/CLV-Z-HAKCHI_OPENLARA"
export HOME

#Commandline support for future use
#while [ $# -gt 0 ]; do
#  [ "$1" == "--reset-config" ] && cmd_reset=1 #Resets saved config
#  shift
#done

#check for gamefiles...
[ -f "$OPENLARAPortableFiles/DATA/GYM.PHD" ] && filedetect=1
[ -f "$OPENLARAPortableFiles/data/gym.phd" ] && filedetect=1
[ -f "$OPENLARAPortableFiles/GYM.PHD" ] && filedetect=1
[ -f "$OPENLARAPortableFiles/gym.phd" ] && filedetect=1
[ -f "$OPENLARAPortableFiles/PSXDATA/GYM.PSX" ] && filedetect=1
[ -f "$OPENLARAPortableFiles/psxdata/gym.psx" ] && filedetect=1
#[ -f "$OPENLARAPortableFiles/DATA/GYM.SAT" ] && filedetect=1 #SATURN (Not support yet)
[ -f "$OPENLARAPortableFiles/data/ASSAULT.TR2" ] && filedetect=1
[ -f "$OPENLARAPortableFiles/data/assault.tr2" ] && filedetect=1
[ -f "$OPENLARAPortableFiles/assault.TR2" ] && filedetect=1
[ -f "$OPENLARAPortableFiles/ASSAULT.TR2" ] && filedetect=1
[ -f "$OPENLARAPortableFiles/DATA/ASSAULT.PSX" ] && filedetect=1
[ -f "$OPENLARAPortableFiles/data/JUNGLE.TR2" ] && filedetect=1
[ -f "$OPENLARAPortableFiles/DATA/JUNGLE.PSX" ] && filedetect=1
[ -f "$OPENLARAPortableFiles/level/1/GYM.PHD" ] && filedetect=1
[ -f "$OPENLARAPortableFiles/level/1/GYM.PSX" ] && filedetect=1

if [ "$ok" == 1 ] && [ "$filedetect" == 1 ]; then
  decodepng "$OPENLARATrueDir/Hakchi_OpenLara_assets/openlarasplash-min.png" > /dev/fb0;
  mkdir -p "$HOME/.openlara"
  [ -f "$HOME/save.sram" ] || touch "$HOME/save.sram" #To prevent save state manager to wipe the saves/configs
  sleep 1 #Engine is so well built the splash needs to display for at least a second for looks...
  cd "$OPENLARAPortableFiles"
  chmod 755 "$OPENLARAPortableFiles/OpenLara"
  $OPENLARAPortableFiles/OpenLara #Execute engine.
else
  decodepng "$OPENLARATrueDir/Hakchi_OpenLara_assets/openlaraerror_files-min.png" > /dev/fb0;
  sleep 5
fi
