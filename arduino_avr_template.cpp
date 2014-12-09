
#include "Arduino.h"
#include <assert.h>

extern void __assert(const char *__func, const char *__file,
		     int __lineno, const char *__sexp);

void setup();
void loop();

void setup() {
	Serial.begin(115200);
	Serial.println(F("arduino_avr_template"));
}

void loop() {
	Serial.println("in loop.");
	delay(100);
}

void __assert (const char *func, const char *file, int lineno, const char *failedexpr)
{
	 // transmit diagnostic informations through serial link.
	Serial.println(F("ASSERTION FAILED"));
	Serial.println(func);
	Serial.println(file);
	Serial.println(lineno, DEC);
	Serial.println(failedexpr);
	Serial.flush();
	// abort program execution.
	abort();
}
