#include "program.h"
//"                  " 18 chars
String camembert1[] = {
  "*Prepare the",
  " cheese starter",
  "*Prepare the",
  " styrofoam box", 
  "*Heat milk"
};
String camembert2[] = {
  "*do some stuff", 
  "*do some stuff", 
  "*do some stuff", 
  "*do some stuff"
};
String camembert3[] = {
  "camembert is",
  "finished"
};

Event camembert[3] = {
  {TIMER,0,0,0,0,0,camembert1,5},
  {TEMPERATURE,0,0,0,G,25,camembert2,4},
  {TIMER,0,0,5,0,0,camembert3,2}
};

/*
Event camembert[15] = {
  {TIMER,0,0,0,0,0,
  "* Prepare the cheese starter * Prepare the styrofoam box * Heat milk"},
  {TEMPERATURE,0,0,0,G,32,
  "* Combine milk and starter * Add 1/10th tsp white mould * Mix well"},
  {TIMER,1,30,0,0,0,
  "* Mix 2.5ml rennet with 25ml pasteurized water * Add to milk"},
  {TIMER,0,30,0,0,0,
  "* When set, cut curd into 2cm cubes"},
  {TIMER,0,5,0,0,0,
  "* Turn curd"},
  {TIMER,0,10,0,0,0,
  "* Turn curd"},
  {TIMER,0,10,0,0,0,
  "* Turn curd"},
  {TIMER,0,10,0,0,0,
  "* Prepare 60C pasteurized water"},
  {TEMPERATURE,0,0,0,G,60,
  "* Drain 2.5L and replace with the water * Close lid"},
  {TIMER,0,10,0,0,0,
  "* Drain half the whey * Place curd into hoops"},
  {TIMER,0,15,0,0,0,
  "* Invert hoops"},
  {TIMER,0,30,0,0,0,
  "* Invert hoops"},
  {TIMER,1,0,0,0,0,
  "* Invert hoops"},
  {TIMER,3,0,0,0,0,
  "* Invert hoops"},
  {TIMER,5,0,0,0,0,
  "* Invert hoops * Leave overnight"}
};
*/
