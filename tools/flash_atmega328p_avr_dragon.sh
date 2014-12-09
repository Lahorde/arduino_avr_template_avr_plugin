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
  echo debugWire enabled - debugWire fuse must be set to 0 before flashing
  if sleep 2 && avrdude -pm328p -cdragon_isp -Pusb -v -U hfuse:w:0xDE:m
  then
    echo changed fuse
  else
    echo unable to change fuse
    exit 2
  fi  
elif [ $enabled -eq 0 ]
then
  echo debugWire not enabled - code can be flashed
else
  echo cannot check if debugWire has been enabled 
  exit 3
fi

echo "flash firmware over Serial (bootloader won't be erased)"
avrdude	-pm328p -carduino -P/dev/ttyACM0 -b115200 -Uflash:w:$1:a

exit 0
