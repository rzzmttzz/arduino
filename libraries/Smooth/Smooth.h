#ifndef Smooth_h
#define Smooth_h

#include "WProgram.h"

class Smooth {
	public:
    		Smooth(int pin);
    		int smoothedAnalogRead();
	private:
		int _pin;
		int _numReadings;
    		int _readings[10];
		int _index;
		int _total;
		int _average;		
};

#endif
