#ifndef Smooth_h
#define Smooth_h

#include "WProgram.h"

#define NUM_READINGS 10

class Smooth {
	public:
    		Smooth(int pin);
    		int smoothedAnalogRead();
	private:
		int _pin;
		int _numReadings;
    		int _readings[NUM_READINGS];
		int _index;
		int _total;
		int _average;		
};

#endif
