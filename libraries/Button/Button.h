#ifndef Button_h
#define Button_h

#include "WProgram.h"

class Button {
	public:
		Button(int pin);
    	int read();
	private:
		int _pin;	
		int _previous_button;
		int _state;
};

#endif
