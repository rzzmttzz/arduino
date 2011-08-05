/*
  Blink
  Turns on an LED on for one second, then off for one second, repeatedly.
 
  This example code is in the public domain.
 */

#include <LiquidCrystal.h>

#define BUTTON_UP 6
#define BUTTON_DOWN 7
#define LED 9

int val = 128; 
int btn_up = LOW;
int old_btn_up = LOW;
int state_up = 0;

int btn_down = LOW;
int old_btn_down = LOW;
int state_down = 0;

LiquidCrystal lcd(12, 11, 5, 4, 3, 2);

void setup() {                
  pinMode(BUTTON_UP, INPUT);
  pinMode(BUTTON_DOWN, INPUT);
  pinMode(LED, OUTPUT);   

  lcd.begin(16, 2);  
}

void loop() {
  
  btn_up = digitalRead(BUTTON_UP); 
  // Check if there was a transition
  if ((btn_up == HIGH) && (old_btn_up == LOW) && val <= 255 && state_up == 0) {
    state_up = 1;
    val += 1;
    delay(500);
  }
  if ((btn_up == HIGH) && (old_btn_up == HIGH) && val <= 255) {
    val += 1;
    delay(100);
  }
  if ((btn_up == LOW) && (old_btn_up == HIGH) && state_up == 1) {
    state_up = 0;
  }
  old_btn_up = btn_up; 
  
  btn_down = digitalRead(BUTTON_DOWN); // read input value and store it
  // Check if there was a transition
  if ((btn_down == HIGH) && (old_btn_down == LOW) && val >= 0 && state_down == 0) {
    state_down = 1 - state_down;
    val -= 1;
    delay(500);
  }
  if ((btn_down == HIGH) && (old_btn_down == HIGH) && val >= 0) {
    val -= 1;
    delay(100);
  }
  if ((btn_down == LOW) && (old_btn_down == HIGH) && state_down == 1) {
    state_down = 0;
  }
  old_btn_down = btn_down; 

  val = constrain(val, 0, 255);

  //lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print("val = ");
  lcd.print(val);
  lcd.print("        ");
  
  analogWrite(LED, val);
} 
