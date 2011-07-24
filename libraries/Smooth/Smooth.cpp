#include "WProgram.h"
#include "Smooth.h"

Smooth::Smooth(int pin) {
	_numReadings = 10;
	_pin = pin;
	for (int i = 0; i < _numReadings; i++) {
		_readings[i] = 0;       
	}
	_index = 0; 
	_total = 0; 
	_average = 0;
}

int Smooth::smoothedAnalogRead() {
	// subtract the last reading
	_total= _total - _readings[_index];
	// read from the sensor    
	_readings[_index] = analogRead(_pin);
	// add the reading to the total
	_total = _total + _readings[_index];
	// advance to the next position in the array
	_index = _index + 1;
	// if we're at the end of the array, wrap to start
	if (_index >= _numReadings)              
		_index = 0;

	// calculate the average  
	_average = _total / _numReadings;
	
	// return the average
	return _average;
}

