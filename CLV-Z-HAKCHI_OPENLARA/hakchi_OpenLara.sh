#!/bin/sh

source /etc/preinit
script_init

WorkingDir=$(pwd)
GameName=$(echo $WorkingDir | awk -F/ '{print $NF}')
ok=0

if [ -f "/usr/share/games/$GameName/$GameName.desktop" ]; then
	OPENLARATrueDir=$(grep /usr/share/games/$GameName/$GameName.desktop -e 'Exec=' | awk '{print $2}' | sed 's/\([/\t]\+[^/\t]*\)\{1\}$//')
	OPENLARAPortableFiles="$OPENLARATrueDir/OpenLara_files"
	ok=1
fi

if [ "$ok" == 1 ]; then
   decodepng "$OPENLARATrueDir/Hakchi_OpenLara_assets/openlarasplash-min.png" > /dev/fb0;
   cd $OPENLARAPortableFiles
   chmod 755 $OPENLARAPortableFiles/OpenLara
   exec $OPENLARAPortableFiles/OpenLara
else
	decodepng "$OPENLARATrueDir/Hakchi_OpenLara_assets/openlaraerror_files-min.png" > /dev/fb0;
	sleep 5
fi
