#include <LiquidCrystal.h>
#include "TimerOne.h"

#define UP_BUTTON 8
#define DOWN_BUTTON 7
#define OK_BUTTON 9
#define CANCEL_BUTTON 10
#define LED 13
#define LCD_WIDTH 16
#define LCD_HEIGHT 2

LiquidCrystal lcd(12, 11, 5, 4, 3, 2);

// timer variables
unsigned int seconds = -1; // -1 since the interupt get called imediately 
unsigned int minutes = 0;
unsigned int hours = 0;

// Navigation
String menu[3] = {"Feta","Brie","Yogurt"};
int selected = -1;
int highlighted = 0;


void setup() {
  pinMode(UP_BUTTON, INPUT); 
  pinMode(DOWN_BUTTON, INPUT); 
  pinMode(OK_BUTTON, INPUT); 
  pinMode(CANCEL_BUTTON, INPUT); 
  pinMode(LED, OUTPUT); 
  
  // initialise the LCD
  lcd.begin(LCD_WIDTH, LCD_HEIGHT);
  lcd.clear();
  
  // setup the timer and its interupt function
  Timer1.initialize(1000000);         
  Timer1.attachInterrupt(second);
}
 
/**
 * This function is called every second by the timer1 interupt
 */
void second() {
  seconds++;
  if(seconds == 60) {
    minutes++;
    seconds = 0;  
  }
  if(minutes == 60) {
     hours++;
    minutes = 0; 
  }
}

void loop() {
  buttons();
  display();
  delay(100);
}

void buttons() {
  int reading;
  
  // up button
  reading = digitalRead(UP_BUTTON);
  if (reading == HIGH) {
    if(highlighted > 0) {
      highlighted--;
    }
  } 
  
  // down button
  reading = digitalRead(DOWN_BUTTON);
  if (reading == HIGH) {
    if(highlighted < sizeof(menu)) {
      highlighted++;
    }
  }
  
  // ok button
  reading = digitalRead(OK_BUTTON);
  if (reading == HIGH) {
    digitalWrite(LED, HIGH);
  } else {
    digitalWrite(LED, LOW);
  }
  
  // cancel button
  reading = digitalRead(CANCEL_BUTTON);
  if (reading == HIGH) {
    digitalWrite(LED, HIGH);
  } else {
    digitalWrite(LED, LOW);
  }
}

/**
 * Thid funtion displays the screen
 */
void display() {
  lcd.clear();
  
  // display the up, down, ok and cancel navigation
  lcd.setCursor(0, 0);
  lcd.print("^");
  lcd.setCursor(0, LCD_HEIGHT-1);
  lcd.print("v");
  lcd.setCursor(LCD_WIDTH-1, 0);
  lcd.print("y");
  lcd.setCursor(LCD_WIDTH-1, LCD_HEIGHT-1);
  lcd.print("n");
  
  
  if(selected == -1) {
    // if no program is selected display the menu
    for(int i = 0; i < LCD_HEIGHT ;i++) {
      // highlight the highlighted program
      if(i == highlighted) {
        lcd.setCursor(1, i);
        lcd.print(">");
        lcd.print(menu[i]);
        lcd.setCursor(LCD_WIDTH-2, i);
        lcd.print("<");
      } else {
        lcd.setCursor(2, i);
        lcd.print(menu[i]);
      }
    }
  } else {
    lcd.setCursor(2, 0);
    lcd.print(hours);
    lcd.print(":");
    lcd.print(minutes);
    lcd.print(":");
    lcd.print(seconds);
  }
  
  //lcd.setCursor(2, 1);
  //lcd.print(highlighted);
}
