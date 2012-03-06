#include "WProgram.h"
#include "Accelerometer.h"

/**
 * xpin: 		analog pin for x acceleration
 * ypin: 		analog pin for y acceleration
 * zpin: 		analog pin for z acceleration
 * zerogpin: 	digital pin to read the zero g event
 */
Accelerometer::Accelerometer(int xpin, int ypin, int zpin, int zerogpin, double aref) {
	_xpin = xpin;
	_ypin = ypin;
	_zpin = zpin;
	_zerogpin = zerogpin;
	_aref = aref;
	
	_vzerogxy = 1.65;
	_vzerogz = 1.5;
	_sensitivity = 0.44;
	_adcrange = 1023;
	_vector = (vector*) malloc(sizeof(vector));
}

vector* Accelerometer::getVector() {

	_vector->x = (analogRead(_xpin) * _aref / _adcrange - _vzerogxy) / _sensitivity;
	_vector->y = (analogRead(_ypin) * _aref / _adcrange - _vzerogxy) / _sensitivity;
	_vector->z = (analogRead(_zpin) * _aref / _adcrange - _vzerogz) / _sensitivity;
	
	_vector->d = sqrt(square(_vector->x) + square(_vector->y) + square(_vector->z));
	_vector->ax = acos(_vector->x/_vector->d);
	_vector->ay = acos(_vector->y/_vector->d);
	_vector->az = acos(_vector->z/_vector->d);

	_vector->zerog = digitalRead(_zerogpin);

	return _vector;
}
