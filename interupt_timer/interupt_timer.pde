#include <LiquidCrystal.h>
#include "TimerOne.h"

LiquidCrystal lcd(12, 11, 5, 4, 3, 2);

unsigned int seconds = -1;

void setup() {
  lcd.begin(16, 2);
  lcd.clear();
  
  Timer1.initialize(1000000);         
  Timer1.attachInterrupt(second);
}
 
void second() {
  seconds++;
}

void loop() {
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print(seconds);
  
  lcd.setCursor(0, 1);
  lcd.print(millis());
  
  delay(100);
}
