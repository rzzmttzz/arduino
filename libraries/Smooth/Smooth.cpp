#include "WProgram.h"
#include "Smooth.h"

/**
 * pin: is the analog pin to read from
 */
Smooth::Smooth(int pin) {
	_numReadings = NUM_READINGS;
	_pin = pin;
	// initialise the readings array 
	// and other variables to zero
	for (int i = 0; i < _numReadings; i++) {
		_readings[i] = 0;       
	}  
	_index = 0; 
	_total = 0; 
	_average = 0;
}
/**
 * Reads the analog input and smooths its value 
 * returns: the average of the last 10 reads
 */
int Smooth::smoothedAnalogRead() {
	// subtract the last reading
	_total -= _readings[_index];
	// read from the sensor    
	_readings[_index] = analogRead(_pin);
	// add the reading to the total
	_total += _readings[_index];
	// advance to the next position in the array
	_index++;
	// if we're at the end of the array, wrap to start
	if (_index >= _numReadings)              
		_index = 0;

	// calculate the average  
	_average = _total / _numReadings;
	
	// return the average
	return _average;
}

