#!/bin/bash
source `dirname $0`/debug_wire_check.sh

echo reading hfuse value from avrdude
avrDudeRes=$(avrdude -pm328p -cdragon_isp -Pusb -U hfuse:r:-:h 2>&1)

#debugWire bit at position 7
if isDebugWireEnabled enabled "$avrDudeRes" 7
then
  echo debugWire status read
else
  echo unable to get debugWire status
  exit 1
fi

if [ $enabled -eq 1 ]
then
  echo debugWire enabled
elif [ $enabled -eq 0 ]
then
echo debugWire not enabled - in order to debug debugWire fuse must be set	 	 	
if sleep 2 && avrdude -pm328p -cdragon_isp -Pusb -v -U hfuse:w:0x9E:m
  then
    echo changed fuse
  else
    echo unable to change fuse
    exit 2
  fi  	
else
  echo cannot check if debugWire has been enabled 
  exit 3
fi

echo power off debugger, power off board MCU, power on MCU, power on debugger -press enter when finished
read finished

#be sure no other avarice instance are running
pkill -x avarice
echo launch avarice...debug session can be started
if avarice --debugwire --dragon --ignore-intr :4242
then 
echo avarice session finished
else
	echo exited avarice
	exit 4
fi	 	
exit 0
