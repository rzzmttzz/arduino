/*
*** Core13 ***
Arduino core designed for Attiny13 and similar devices.
NO WARRANTEE OR GUARANTEES!
Written by John "smeezekitty" 
You are free to use, redistribute and modify at will EXCEPT IF MARKED OTHERWISE IN A PARTICULAR SOURCE FILE!
Version 0.14
*/

#include "wiring_private.h"
#include <avr/interrupt.h>
volatile unsigned long ovrf=0;
ISR(TIM0_OVF_vect){
	ovrf++; //Increment counter every 256 clock cycles
//	PORTB = 0x18;
}
unsigned long millis(){
	unsigned long x;
	asm("cli"); 
	/*Scale number of timer overflows to milliseconds*/
	#if F_CPU == 128000
	x = ovrf * 2;
    #elif F_CPU == 600000
	x = ovrf / 2;
	#elif F_CPU == 1000000
	x = ovrf / 4;
	#elif F_CPU == 1200000
	x = ovrf / 5;
	#elif F_CPU == 4000000
	x = ovrf / 16;
	#elif F_CPU == 4800000
	x = ovrf / 19;
	#elif F_CPU == 8000000
	x = ovrf / 31;
	#elif F_CPU == 9600000
	x = ovrf / 37;
    #elif F_CPU == 10000000
	x = ovrf / 39;
	#elif F_CPU == 12000000
	x = ovrf / 47;
	#elif F_CPU == 16000000
	x = ovrf / 63;
	#else
	#error This CPU frequency is not defined
	#endif
	asm("sei");
	return x;
}
unsigned long micros(){
	return millis() * 1000; //To keep it simple and small :) //I will correctly implement this one of these days.......
}
void delay(unsigned ms){
	while(ms--){
		_delay_ms(1); //Using the libc routine over and over is non-optimal but it works and is close enough
	}
	//Note, I may have to reimplement this because the avr-libc delay is too slow *todo*
}
void delayMicroseconds(unsigned us){
	//*todo* measure actual speed at different clock speeds and try to adjust for closer delays
	if(us == 0){return;}
	#if F_CPU == 16000000 || F_CPU == 12000000
	if(--us == 0){return;}
	us <<= 2;
	us -= 2; //Underflow possible?
	#elif F_CPU == 8000000 || F_CPU == 9600000 || F_CPU == 10000000
	if(--us == 0){return;}
	if(--us == 0){return;}
	us <<= 1;
	us--; //underflow possible?
	#elif F_CPU == 4000000 || F_CPU == 4800000
	if(--us == 0){return;}
	if(--us == 0){return;}
	//For 4MHz, 4 cycles take a uS. This is good for minimal overhead
	#elif F_CPU == 1000000 || F_CPU == 1200000//For slow clocks, us delay is marginal.
	if(--us == 0){return;}
	if(--us == 0){return;}
	us >>= 2; 
	us--; //Underflow?
	#elif F_CPU == 600000
	if(--us == 0){return;}
	if(--us == 0){return;}
	us >>= 3;
	#elif F_CPU == 128000
	if(--us == 0){return;}
	if(--us == 0){return;}
	us >>= 5;
	#else 
	#error Invalid F_CPU value
	#endif
	asm __volatile__("1: sbiw %0,1\n\t"
			 "brne 1b" : "=w" (us) : "0" (us));
}
void init(){
	//Setup timer interrupt and PWM pins
	TCCR0B |= _BV(CS00);
	TCCR0A |= _BV(WGM00)|_BV(WGM01);
	TIMSK0 |= 2;
	TCNT0=0; //Causes malfunction?
	sei();
	//Set up ADC clock depending on F_CPU
	#if F_CPU == 128000
	ADCSRA |= _BV(ADEN);
	#elif F_CPU == 1000000 || F_CPU == 1200000 || F_CPU == 600000
	ADCSRA |= _BV(ADEN) | _BV(ADPS1);
	#else
	ADCSRA |= _BV(ADEN) | _BV(ADPS1) | _BV(ADPS0) | _BV(ADPS2);
	#endif
}
	