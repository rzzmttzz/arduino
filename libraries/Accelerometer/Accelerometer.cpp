#include "WProgram.h"
#include "Accelerometer.h"

/**
 * xpin: is the analog pin for x acceleration
 * ypin: is the analog pin for y acceleration
 * zpin: is the analog pin for z acceleration
 * zerogpin: is the digital pin to read the zero g event
 */
Accelerometer::Accelerometer(int xpin, int ypin, int zpin, int zerogpin) {
	_xpin = xpin;
	_ypin = ypin;
	_zpin = ypin;
	_zerogpin = zerogpin;
	_vector = (vector*) malloc(sizeof(vector));
}

vector* Accelerometer::getVector() {
	_vector->x = analogRead(_xpin)-512;
	_vector->y = analogRead(_ypin)-512;
	_vector->z = analogRead(_zpin)-512;
	return _vector;
}
