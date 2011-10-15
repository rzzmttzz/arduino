#include "program.h"
//"                  " 18 chars
String yogurt1[] = {
  "Heat the milk"};
String yogurt2[] = {
  "Cool the milk"};
String yogurt3[] = {
  "Add the yogurt",
  "culture and", 
  "incubate."};
String yogurt4[] = {
  "Yogurt should be",
  "set"};

Event yogurt[4] = {
  {TIMER,0,0,0,0,0,yogurt1},
  {TEMPERATURE,0,0,0,G,84, yogurt2},
  {TEMPERATURE,0,0,0,L,44, yogurt3},
  {TIMER,4,0,0,0,0,yogurt4}
};
