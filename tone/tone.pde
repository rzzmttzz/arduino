#include <pitches.h>

#define ALARM 6

int notes[3] = {NOTE_C6,NOTE_E6,NOTE_G6};
int durations[3] = {500,500,500};
int current_note = 0;

void setup() {
  Serial.begin(9600);
  pinMode(ALARM, OUTPUT); 
}

void loop() {
  tone(ALARM, notes[current_note],durations[current_note]);
  
  current_note++;
  if(current_note >= 3) {
    current_note = 0;
  }
  Serial.print("current_note: ");
  Serial.println(current_note);
  delay(500);
}
