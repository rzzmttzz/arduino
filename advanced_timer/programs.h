/**
 * A Program has a name and an array of events.
 * An Event 
 * The first step has no alarm as it is used as an introductory step.
 * To use for ingredients or preparation instructions
 * 
 * 
 */

#include "program.h"

#include "feta.h"
#include "camembert.h"
#include "yogurt.h"

#define PROGRAMS 3

Program programs[PROGRAMS] = {
//| name       | length | events
  { "Feta",      3,       feta},
  { "Camembert", 3,       camembert},
  { "Yogurt",    3,       yogurt}
};

