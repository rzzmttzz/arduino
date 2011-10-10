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

Event brie[7] = {
  {TIMER,0,0,0,0,0,"brie 1"},
  {TIMER,0,0,5,0,0,"brie 2"},
  {TEMPERATURE,0,0,0,G,20,"heat until 20 C"},
  {TIMER,0,0,5,0,0,"brie 3"},
  {TIMER,0,0,5,0,0,"brie 4"},
  {TIMER,0,0,5,0,0,"brie 5"},
  {TIMER,0,0,5,0,0,"brie 6"}
};

Event yogurt[3] = {
  {TEMPERATURE,0,0,0,L,100,"Put milk in a saucepan, place the temperature probe in the milk and heat on a medium heat."},
  {TEMPERATURE,0,0,0,G,84, "Cool the milk in a water bath."},
  {TEMPERATURE,0,0,0,L,44, "Put milk in jar, add the yogurt culture, mix and place in a warm place for 4-10 hours."}
};

Program programs[3] = {
//| name      | length | events
  { "Feta",     3,       feta},
  { "Brie",     6,       brie},
  { "Yogurt",   3,       yogurt}
};

