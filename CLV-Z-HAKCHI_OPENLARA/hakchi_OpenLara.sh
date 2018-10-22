#!/bin/sh

#Load in the console's enviornment variables
source /etc/preinit
script_init

OpenLaraTrueDir="$(dirname `readlink -f "$0"`)"

uistop # Kill it! Kill it with fire!

#Clean down and overcommit memory
echo "1" > "/proc/sys/vm/overcommit_memory"
echo "3" > "/proc/sys/vm/drop_caches"

dd if=/dev/zero of=/dev/fb0 #Clear FB just in case...

chmod +x "$OpenLaraTrueDir/hakchi_OpenLara_child.sh"

if [ -f "/bin/remote-exec" ]; then
  echo $OpenLaraTrueDir/hakchi_OpenLara_child.sh ${1+"$@"} > /var/exec.flag
else
  exec $OpenLaraTrueDir/hakchi_OpenLara_child.sh ${1+"$@"}
fi