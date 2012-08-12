/*
**** Core13 ***
Arduino core designed for Attiny13 and similar devices.
NO WARRANTEE OR GUARANTEES!
Written by John "smeezekitty" 
You are free to use, redistribute and modify at will EXCEPT IF MARKED OTHERWISE IN A PARTICULAR SOURCE FILE!
Version 0.14
*/
#include "wiring_private.h"
//#include "pins_arduino.h"
void analogReference(char bla){}//Not supported
int analogRead(uint8_t pin){
	uint8_t l,h;
	ADMUX = (1<<REFS0) | pin & 7; //Setup ADC
	ADCSRA |= _BV(ADSC);	
	while(ADCSRA & ADSC); //Wait for conversion
	l = ADCL;  //Read and return 10 bit result
	h = ADCH;
	return (h << 8)|l; 
}
void analogWrite(uint8_t pin, uint8_t val){
	pinMode(pin, OUTPUT); //For compatibility - STUPID! 
	if(val==0){ //Handle Off condition
		digitalWrite(pin,0);
	} else if(val == 255){ //Handle On condition
		digitalWrite(pin, HIGH);
	} else { //Otherwise setup the appropriate timer compare
		if(pin == 1){
			TCCR0A |= (1 << COM0B1);
			OCR0B = (val / 16) * 16;
		}
		if(pin == 0){
			TCCR0A |= (1 << COM0A1);
			OCR0A = (val / 16) * 16;
		}
	}
}
		
