### Description
Template ATmega328p project to use in Eclipse. It is already configured to be debugged with AVR Dragon

### Debugging wiring
On arduino Uno ICSP connector :

![alt text](http://www.gammon.com.au/images/Arduino/Fuse_issues5.JPG)

![alt text](http://www.gammon.com.au/images/Arduino/Fuse_issues6.JPG)

1-MISO
2-+5V
3-SCK
4-MOSI
5-/Reset
6-Gnd

On AVRDragon : 

![alt text](http://orbisvitae.com/ubbthreads/ubbthreads.php?ubb=download&Number=1817&filename=IO%20Pins,%20ISP%20Pinout.jpg)


AVR Dragon and UNO connected :  

![alt text](https://github.com/Lahorde/arduino_avr_template_avr_plugin/raw/master/img/avr_dragon_uno_wiring.jpg)

### Debugging steps

Following steps must be done to debug with ATmega328p : 

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

ATmega328p only supports debugWire (1 wire debugging on Reset pin). To enable it, debugWire fuse must be set.

* default config used in arduino uno (defined in boards.txt of arduino ide):
 * uno.bootloader.low_fuses=0xff
 * uno.bootloader.high_fuses=0xde
 * uno.bootloader.extended_fuses=0x05

* enable ATmega328p debugWire 
    avrdude -pm328p -cdragon_isp -Pusb -v -U hfuse:w:0x9E:m

* disable ATmega328p debugWire 
    avrdude -pm328p -cdragon_isp -Pusb -v -U hfuse:w:0xDE:m

### external tools 
Some external tools are in tools/eclipse_external_tools.
* flash_avr_template_328p.launch : read debugWire fuse, if set unset it, then flash code
* debug_avr_template_328p.launch : read debugWire fuse, if unset set it, then start avarice, after a debug session can be started

### Issues
* When launching gdb in Eclipse I had "no source available". All debug symbols where enabled (-g2 in build settings) and "debug info format" to "stabs". 
To get it working I had to change it to "stab+"

* Do not forget to press reset button when flashing code from Serial!!!
* Check wire pictures!!!

### References
http://awtfy.com/2012/03/29/hardware-debugging-the-arduino-using-eclipse-and-the-avr-dragon/

http://playground.arduino.cc/code/eclipse 

http://www.gammon.com.au/forum/?id=11643