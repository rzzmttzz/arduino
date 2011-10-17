#include "program.h"
//"                  " 18 chars
String feta1[] = {"prepare stuff"};
String feta2[] = {"do some stuff"};
String feta3[] = {"feta is finished"};

Event feta[3] = {
  {TIMER,0,0,0,0,0,feta1,1},
  {TIMER,0,0,5,0,0,feta2,1},
  {TIMER,0,0,5,0,0,feta3,1}
};
