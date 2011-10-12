/**
 * A Program has a name and an array of events.
 * An Event 
 * The first step has no alarm as it is used as an introductory step.
 * To use for ingredients or preparation instructions
 * 
 * 
 */

#define TIMER 0
#define TEMPERATURE 1
#define L 1
#define G 2

#define PROGRAMS 3

struct Event {
  int type;
  int hours;
  int minutes;
  int seconds;
  int compare;
  int temperature;
  String data;
};

struct Program {
  String name;
  int length;
  Event* events;
};

Event feta[3] = {
  {TIMER,0,0,0,0,0,"prepare stuff"},
  {TIMER,0,0,5,0,0,"do some stuff"},
  {TIMER,0,0,5,0,0,"feta is finished"}
};

/*
Event camembert[2] = {
  {TIMER,0,0,0,0,0,
  "* Prepare the cheese starter * Prepare the styrofoam box * Heat milk"},
  {TEMPERATURE,0,0,0,G,32,
  "* Combine milk and starter * Add 1/10th tsp white mould * Mix well"}
};

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
Event brie[7] = {
  {TIMER,0,0,0,0,0,"brie 1"},
  {TIMER,0,0,5,0,0,"brie 2"},
  {TEMPERATURE,0,0,0,G,20,"heat until 20 C"},
  {TIMER,0,0,5,0,0,"brie 3"},
  {TIMER,0,0,5,0,0,"brie 4"},
  {TIMER,0,0,5,0,0,"brie 5"},
  {TIMER,0,0,5,0,0,"brie 6"}
};

Event yogurt[4] = {
  {TEMPERATURE,0,0,0,L,100,"Put milk in a saucepan, place the temperature probe in the milk and heat on a medium heat."},
  {TEMPERATURE,0,0,0,G,84, "Cool the milk in a water bath."},
  {TEMPERATURE,0,0,0,L,44, "Put milk in jar, add the yogurt culture, mix and place in a warm place for 4-10 hours."},
  {TIMER,4,0,0,0,0,"Yogurt should be set"}
};

Program programs[PROGRAMS] = {
//| name       | length | events
  { "Feta",      3,       feta},
  //{ "Camembert", 2,       camembert},
  { "Brie",      6,       brie},
  { "Yogurt",    3,       yogurt}
};

