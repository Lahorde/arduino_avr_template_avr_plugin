### Description
Template ATmega328p project to use in Eclipse. It is already configured to be debugged with AVR Dragon

### Debugging steps

Parameters given are for ATmega328p : 

 * Write Code in Eclipse, build without errors
 * Upload to Arduino over usb-serial in Eclipse
 * Enable DebugWIRE on Arduino with AVRDUDE
    avrdude -pm328p -cdragon_isp -Pusb -v -U hfuse:w:0x9E:m
    
 * Start AVARICE
    avarice --debugwire --dragon --ignore-intr :4242
    
 * Configure and start up debugging in Eclipse
 * Debug until your eyes cross
 * Disable DebugWIRE when done
    avrdude -pm328p -cdragon_isp -Pusb -v -U hfuse:w:0xDE:m

(from excellent http://awtfy.com/2012/03/29/hardware-debugging-the-arduino-using-eclipse-and-the-avr-dragon/ )

### Fuses for ATmega328p
* default config used in arduino uno (defined in boards.txt of arduino ide):
 * uno.bootloader.low_fuses=0xff
 * uno.bootloader.high_fuses=0xde
 * uno.bootloader.extended_fuses=0x05

* enable ATmega328p debugWire 
    avrdude -pm328p -cdragon_isp -Pusb -v -U hfuse:w:0x9E:m

* disable ATmega328p debugWire 
    avrdude -pm328p -cdragon_isp -Pusb -v -U hfuse:w:0xDE:m


### Issues
When launching gdb in Eclipse I had "no source available". All debug symbols where enabled (-g2 in build settings) and "debug info format" to "stabs". 
To get it working I had to change it to "stab+"

Do not forget to press reset button when flashing code from Serial!!!

### References
http://awtfy.com/2012/03/29/hardware-debugging-the-arduino-using-eclipse-and-the-avr-dragon/

http://playground.arduino.cc/code/eclipse 