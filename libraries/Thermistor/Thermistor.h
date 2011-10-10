#ifndef Thermistor_h
#define Thermistor_h

#include "WProgram.h"

#define CELCIUS 1
#define FAHRENHEIT 2

// Utilizes the Steinhart-Hart Thermistor Equation:
//    Temperature in Kelvin = 1 / {A + B[ln(R)] + C[ln(R)]^3}

class Thermistor {
	public:
		Thermistor(int pin, int scale, double A, double B, double C);
    	double read();
	private:
		int _pin;	
		int _scale;
		double _A;
		double _B;
		double _C;
};

#endif
