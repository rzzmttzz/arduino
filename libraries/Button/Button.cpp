#include "WProgram.h"
#include "Button.h"

/**
 * pin: is the digital pin to read from
 */
Button::Button(int pin) {
	_pin = pin;
	_previous_button = LOW;
	_state = LOW;
	pinMode(_pin, INPUT);
}

int Button::read() {
	// read the digital pin
	int button = digitalRead(_pin);
	// check if the button has transitioned from LOW to HIGH
	if (button == HIGH && _previous_button == LOW) {
		_state = HIGH;
		// debounce
		delay(100);
	}
	
	// if the button is being held down
	if (button == HIGH && _previous_button == HIGH) {
		_state = LOW;
	}
	
	// check if the button has transitioned from HIGH to LOW
	if (button == LOW && _previous_button == HIGH && _state == HIGH) {
		_state = LOW;
	}
  
	// record the button state
	_previous_button = button;
	return _state;
}
