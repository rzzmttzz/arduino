#ifndef Accelerometer_h
#define Accelerometer_h

#include "WProgram.h"
#include "../Smooth/Smooth.h"


typedef struct vector {
	double x;
	double y;
	double z;
	double ax;
	double ay;
	double az;
	double d;
	int zerog;
} vector;

class Accelerometer {
	public:
    	Accelerometer(int xpin, int ypin, int zpin, int zerogpin, double aref);
    	Accelerometer(Smooth& xpin, Smooth& ypin, Smooth& zpin, int zerogpin, double aref);
    	vector* getVector();
	private:
		int _xpin;
		int _ypin;
		int _zpin;
		int _zerogpin;
		double _aref;
		double _vzerogxy;
		double _vzerogz;
		double _sensitivity;
		double _adcrange;
		vector* _vector;
		Smooth* _smoothX;		
		Smooth* _smoothY;		
		Smooth* _smoothZ;		
};

#endif
