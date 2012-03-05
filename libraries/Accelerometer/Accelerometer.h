#ifndef Accelerometer_h
#define Accelerometer_h

#include "WProgram.h"


typedef struct vector {
	int x;
	int y;
	int z;
} vector;

class Accelerometer {
	public:
    	Accelerometer(int xpin, int ypin, int zpin, int zerogpin);
    	vector* getVector();
	private:
		int _xpin;
		int _ypin;
		int _zpin;
		int _zerogpin;
		vector* _vector;		
};

#endif
