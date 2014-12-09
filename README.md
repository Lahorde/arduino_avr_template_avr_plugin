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

### debugWire
DebugWire uses reset line in order to flash/debug small MCUs like ATmega328
To enable debugWire with ATmega328p :
    avrdude -pm328p -cdragon_isp -Pusb -v -U hfuse:w:0x9E:m

To disable debugWire with ATmega328p :
avrdude -pm328p -cdragon_isp -Pusb -v -U hfuse:w:0xDE:m

### flashing using avrdragon

#### flashing over UART - keeps bootloader
    avrdude	-pm328p -carduino -P/dev/ttyACM0 -b115200 -Uflash:w:your_image.hex:a

#### flashing over ISP
    avrdude -pm328p -c dragon_isp -Pusb -v -U flash:w:arduino_avr_template_avr_plugin.hex:i
When flashing using ISP with debugWire enabled, it will temporarily activate ISP and then debugwire is only possible after power-cycle.
Consequently, in order to use avarice, MCU must be powered off/on

#### flashing using debugWire
debugWire must be enabled
    avrdude -pm328p -c dragon_isp -Pusb -v -U flash:w:arduino_avr_template_avr_plugin.hex:i
Flashing using debugWire isn't reliable => lot of mismatch error

### debugging using avrdragon
debugWire must be enabled

Avarice must be first started : 
    avarice --debugwire --dragon --ignore-intr :4242

Then launch avr-gdb :
    avr-gdb your_image.elf
then in gdb
    target remote localhost:4242

### Debugging using Eclipse

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

 * then in gdb :
    target remote localhost:4242

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

* debugging very slow : get avarice trunk version and compile it
  * on Arch https://aur.archlinux.org/packages/avarice-svn/
  * or directly from svn repo : http://sourceforge.net/p/avarice/code/HEAD/tree/trunk/
* Check wire pictures!!!

### References

http://www.avrfreaks.net/forum/avrdragon-debugwire-atmega328p-nice-unusable

http://sourceforge.net/p/avarice/mailman/message/33130047/

http://awtfy.com/2012/03/29/hardware-debugging-the-arduino-using-eclipse-and-the-avr-dragon/

http://playground.arduino.cc/code/eclipse 

http://www.gammon.com.au/forum/?id=11643