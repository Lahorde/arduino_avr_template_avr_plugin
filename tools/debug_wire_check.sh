#!/bin/bash

#call it with  (result, avrdude stdouput, debugWireBit pos in hfuse)
function isDebugWireEnabled { 
  local  _resultvar=$1   

  #find hfuse value 
  local _hfuse=`echo "$2" | grep -i '^0x[0-9a-f]\{1,2\}'`

  if [ -z "$_hfuse" ]
  then
    echo 'hfuse could not be read'
    return 1
  fi

  echo hfuse=$_hfuse 
 
  #convert hexa to dec
  _hfuse=$(printf "%d\n" $_hfuse)
 
  local _bitSet=$((_hfuse & 1<<($3-1))) 

  #bit set to 0 when debugWire enabled
  if [ $_bitSet -eq 0 ]
  then 
    eval $_resultvar=1
  else 
    eval $_resultvar=0
  fi
}
