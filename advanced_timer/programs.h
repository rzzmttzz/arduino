#define TIMER 0
#define TEMPERATURE 1
#define LESS 0
#define GREATER 1

struct Event {
  int hours;
  int minutes;
  int seconds;
  int temperature;
  int compare;
  String data;
};

struct Program {
  String name;
  int type;
  Event* events;
};

Event feta[2] = {
  {0,0,0,0,LESS,"Step 1"},
  {0,0,30,0,LESS,"Step 2"}
};

Event brie[2] = {
  {0,0,0,0,LESS,"Step 1"},
  {0,0,30,0,LESS,"Step 2"}
};

Event yogurt[2] = {
  {0,0,0,84,GREATER,"Step 1"},
  {0,0,0,44,LESS,"Step 2"}
};

Program programs[3] = {
  {"Feta",TIMER, feta},
  {"Brie",TIMER, brie},
  {"Yogurt", TEMPERATURE, yogurt}
};

