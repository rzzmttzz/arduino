/*

 */

// include the library code:
#include <LiquidCrystal.h>

#define MAX_MILLIS_VALUE 34359738

// initialize the library with the numbers of the interface pins
LiquidCrystal lcd(12, 11, 5, 4, 3, 2);

// time keeping variables
unsigned long current_millis_value = 0;
unsigned long previous_millis_value = 0;
unsigned long m = 0;
unsigned int seconds = 0;
unsigned int minutes = 0;
unsigned int hours = 0;

//reset button
const int buttonPin = 1;     // the number of the pushbutton pin
const int ledPin =  13;      // the number of the LED pin

void setup() {
  // set up the LCD's number of columns and rows: 
  lcd.begin(16, 2);
  lcd.clear();
  
  pinMode(ledPin, OUTPUT);      
  pinMode(buttonPin, INPUT); 
}

void loop() {
  current_millis_value = millis();
  if (current_millis_value < previous_millis_value)
    m += MAX_MILLIS_VALUE - previous_millis_value + current_millis_value;
  else 
    m += current_millis_value - previous_millis_value; 
  seconds += m / 1000;
  m = m % 1000;
  minutes += seconds / 60;
  seconds = seconds % 60;
  hours += minutes / 60;
  minutes = minutes % 60;
  hours = hours % 24;
  previous_millis_value = current_millis_value;
  
  //reset button
  int reading = digitalRead(buttonPin);
  if (reading == LOW) {
    digitalWrite(ledPin, HIGH);
    hours = 0;
    minutes = 0;
    seconds = 0;
  } else {
    digitalWrite(ledPin, LOW); 
  }
  
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print(hours);
  lcd.print(":");
  lcd.print(minutes);
  lcd.print(":");
  lcd.print(seconds);
  
  lcd.setCursor(0, 1);
  lcd.print(m);
  delay(150);
}

