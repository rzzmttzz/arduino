#include <LiquidCrystal.h>
#include <TimerOne.h>
#include <pitches.h>
#include "programs.h"

#define UP_BUTTON 8
#define DOWN_BUTTON 7
#define OK_BUTTON 9
#define CANCEL_BUTTON 10
#define LED 13
#define ALARM 6
#define LCD_WIDTH 16
#define LCD_HEIGHT 2

LiquidCrystal lcd(12, 11, 5, 4, 3, 2);

// timer variables
unsigned int seconds = 0;
unsigned int minutes = 0;
unsigned int hours = 0;

// Navigation
int selected = -1;
int highlighted = 0;
boolean started = false;

// Alarm
// Alarm theory: http://www.anaes.med.usyd.edu.au/alarms/
const int num_notes = 3;
int notes[num_notes] = {NOTE_C7,NOTE_FS7,0};
//int notes[num_notes] = {NOTE_C7,NOTE_FS7,NOTE_C7,0,NOTE_FS7,NOTE_C7,0,0};
//int notes[num_notes] = {NOTE_C7,NOTE_C7,NOTE_C7,0,0};
int current_note = 0;

void setup() {
  pinMode(UP_BUTTON, INPUT); 
  pinMode(DOWN_BUTTON, INPUT); 
  pinMode(OK_BUTTON, INPUT); 
  pinMode(CANCEL_BUTTON, INPUT); 
  pinMode(LED, OUTPUT); 
  pinMode(ALARM, OUTPUT); 
  
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
  if(started) {
    seconds++;
    if(seconds == 60) {
      minutes++;
      seconds = 0;  
    }
    if(minutes == 60) {
       hours++;
      minutes = 0; 
    }
  } else {
    hours = 0;
    minutes = 0;
    seconds = 0;
  }
}

void loop() {
  buttons();
  display();
  if(seconds+60*minutes > 1) {
    alarm();
  }
  delay(200);
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
    if(highlighted < sizeof(programs)) {
      highlighted++;
    }
  }
  
  // ok button
  reading = digitalRead(OK_BUTTON);
  if (reading == HIGH) {
    // if the program is selected but not started, then start it
    if(selected != -1 && !started) {
      started = true;
    }
    // if no program is selected, then select the highlighted program
    if(selected == -1) {
      selected = highlighted;
    }
  }
  
  // cancel button
  reading = digitalRead(CANCEL_BUTTON);
  if (reading == HIGH) {
    // if the selected program has not been started, then deselect the selected program
    if(selected != -1 && !started) {
      selected = -1;
    }
  }
}

/**
 * This function displays to the screen
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
      
      // TODO keep selected program on screen byscrolling the list 
      if(highlighted > LCD_HEIGHT-1) {
        
      }
      
      // highlight the highlighted program
      if(i == highlighted) {
        lcd.setCursor(1, i);
        lcd.print(">");
        lcd.print(programs[i].name);
        lcd.setCursor(LCD_WIDTH-2, i);
        lcd.print("<");
      } else {
        lcd.setCursor(2, i);
        lcd.print(programs[i].name);
      }
    }
  } else {
    if(!started) {
      lcd.setCursor(2, 0);
      lcd.print("Make "+programs[selected].name+"?");
    } else {
      lcd.setCursor(2, 0);
      lcd.print(hours);
      lcd.print(":");
      lcd.print(minutes);
      lcd.print(":");
      lcd.print(seconds);
    }
  }
  
  //lcd.setCursor(2, 1);
  //lcd.print(highlighted);
}

void alarm() {
  tone(ALARM, notes[current_note],200); 
  current_note++;
  if(current_note >= num_notes) {
    current_note = 0;
  }
}
