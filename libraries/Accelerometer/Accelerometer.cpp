#include "WProgram.h"
#include "Accelerometer.h"

/**
 * xpin: 		analog pin for x acceleration
 * ypin: 		analog pin for y acceleration
 * zpin: 		analog pin for z acceleration
 * zerogpin: 	digital pin to read the zero g event
 */
Accelerometer::Accelerometer(int xpin, int ypin, int zpin, int zerogpin) {
	_xpin = xpin;
	_ypin = ypin;
	_zpin = zpin;
	_zerogpin = zerogpin;
	_vector = (vector*) malloc(sizeof(vector));
}

vector* Accelerometer::getVector() {
	_vector->x = analogRead(_xpin)-512;
	_vector->y = analogRead(_ypin)-512;
	_vector->z = analogRead(_zpin)-512;
	return _vector;
}
