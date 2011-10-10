#include "WProgram.h"
#include "Thermistor.h"

Thermistor::Thermistor(int pin, int scale, double A, double B, double C) {
	_pin = pin;
	_scale = scale;
	_A=A;
	_B=B;
	_C=C;
}

double Thermistor::read() {
	double temp = analogRead(_pin);
 
	// Assuming a 10k Thermistor.  
	// Calculation is actually: Resistance = (1024 * BalanceResistor/ADC) - BalanceResistor
	temp = ((10240000/temp) - 10000);
	temp = log(temp); 
	temp = 1 / (_A + (_B * temp) + (_C * temp * temp * temp));   
	temp = temp - 273.15;  // Convert Kelvin to Celsius                       
  
	if(_scale == FAHRENHEIT) {
		// Convert to Fahrenheit
		temp = temp * 9.0/5.0 + 32.0;
	}
	return temp;
}
