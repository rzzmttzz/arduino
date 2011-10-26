#include <LiquidCrystal.h>
#include <TimerOne.h>
#include <Button.h>
#include <Thermistor.h>
#include "programs.h"

#define UP_BUTTON 8
#define DOWN_BUTTON 7
#define OK_BUTTON 9
#define CANCEL_BUTTON 10
#define LED 13
#define ALARM 6
#define THERMISTER 0
#define LCD_WIDTH 20
#define LCD_HEIGHT 4
#define NOTE_C7 2093
#define NOTE_FS7 2960

LiquidCrystal lcd(12, 11, 5, 4, 3, 2);

// Timer variables
unsigned int seconds = 0;
unsigned int minutes = 0;
unsigned int hours = 0;

// Temperature variables
float temperature = 0.0;
// temperature mode
int temperatureScale = CELCIUS;
//Thermistor thermistor(THERMISTER, temperatureScale,-0.033593997,0.0032009496,-8.627067e-7);

// Navigation and statuses
int program = -1;
int selected = 0;
int event = 0;
boolean started = false;
boolean showevent = false;
boolean alarmed = false;
boolean cancel = false;

int menu[LCD_HEIGHT];
int menuSelected = 0;
int eventScroll = 0;

// Alarm
// Alarm theory: http://www.anaes.med.usyd.edu.au/alarms/
const int num_notes = 5;
int notes[num_notes] = {NOTE_C7,NOTE_C7,NOTE_C7,0,0};
//int notes[num_notes] = {NOTE_C7,NOTE_FS7,0};
//int notes[num_notes] = {NOTE_C7,NOTE_FS7,NOTE_C7,0,NOTE_FS7,NOTE_C7,0,0};
//int notes[num_notes] = {NOTE_C7,NOTE_C7,NOTE_C7,0,0};
int current_note = 0;

// Buttons
Button upButton(UP_BUTTON);
Button downButton(DOWN_BUTTON);
Button okButton(OK_BUTTON);
Button cancelButton(CANCEL_BUTTON);

void setup() {
  pinMode(LED, OUTPUT); 
  pinMode(ALARM, OUTPUT); 
  
  // initialise the LCD
  lcd.begin(LCD_WIDTH, LCD_HEIGHT);
  lcd.clear();
  
  // setup the timer and its interupt function
  Timer1.initialize(1000000);         
  Timer1.attachInterrupt(second);
  
  // init the menu buffer
  for(int i = 0; i < LCD_HEIGHT; i++) {
    menu[i]=i;
  } 
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
  lcd.clear();
  //temperature = thermistor.read();
  int val = analogRead(THERMISTER);// * 0.004882812 * 100;   
  temperature =  (((5000 * val) / 1024) / 10) - 273.15;
  print(10,3,val);
  buttons();
  alarm();
  display();
  delay(200);
}

void buttons() {
  // up button
  if (upButton.read() == HIGH) {
    // if on menu
    if(program == -1) {
      if(selected > 0) {
        selected--;
        if(menuSelected == 0) {
          for(int i = 0; i < LCD_HEIGHT; i++) {
            menu[i]--;
          } 
        } else {
          menuSelected--;
        }
      }
    } else if(showevent) {
      if(eventScroll>0) {
        eventScroll--;
      }
    } 
  }
  
  // down button
  if (downButton.read() == HIGH) {
    // if on menu
    if(program == -1) {
      if(selected < PROGRAMS-1) {
        selected++;
        if(menuSelected == LCD_HEIGHT-1) {
          for(int i = 0; i < LCD_HEIGHT; i++) {
            menu[i]++;
          } 
        } else {
          menuSelected++;
        }
      }  
    } else if(showevent) {
      if(programs[program].events[event].length > LCD_HEIGHT && eventScroll < (programs[program].events[event].length-LCD_HEIGHT)) {
        eventScroll++;
      }
    }
  }
  
  // ok button
  if (okButton.read() == HIGH) {
    if(program == -1) {
      // ok button pressed while in menu mode
      // if no program is selected, then select the selected program
      program = selected;
    } else if(program != -1 && !started) {
      // button pressed while confirming program
      // if the program is selected but not started, then start it
      started = true;
    } else if(alarmed) {
      // ok button pressed while in alarm mode
      // if the alarm is triggered stop the alarm enable show event mode
      alarmed = false;
      showevent = true;
    } else if(showevent) {
      // ok button pressed while in showevent mode
      showevent=false;
      // reset the timer
      hours = 0;
      minutes = 0;
      seconds = 0;
      
      // if not at the end of the program
      if(event < programs[program].length-1) {
        event++;  
      } else {
        // otherwise reset all of the variables to display the menu again
        reset();
      }  
    } else if(cancel) {
      // ok button pressed to confirm a cancel
      // if the alarm is triggered stop the alarm enable show event mode
      reset();
    }
  }
  
  // cancel button
  if (cancelButton.read() == HIGH) {
    // if the selected program has not been started, then deselect the selected program
    if(program != -1 && !started) {
      program = -1;
    } else if(cancel) {
      cancel = false;
    } else if(started) {
      cancel = true;
    }
  }
}

/**
 * This function displays to the screen
 */
void display() {
  // delay lcd clear to reduce screen flicker
  //lcd.clear();

  if(program == -1) {
    for(int i = 0; i < LCD_HEIGHT ;i++) {
      // highlight the selected program
      if(menu[i] == selected) {
        print(1, i, ">");
        print(2, i, programs[menu[i]].name);
        print(LCD_WIDTH-2, i, "<");
      } else {
        print(2, i, programs[menu[i]].name);
      }
    }
    navigation("^", "v", "y", "");
  } else {
    if(!started) {
      print(0, 0, "Make "+programs[program].name+"?");
      navigation("", "", "y", "n");
    } else if(cancel) {
      print(0, 0, "Cancel "+programs[program].name+"?");
      navigation("", "", "y", "n");
    } else if(alarmed) {
      print(0, 0, "Next step!");
      navigation("", "", ">", "x");
    } else if(showevent) {
      int r = 0;
      for(int i = eventScroll; i < eventScroll+LCD_HEIGHT; i++) {
        print(1, r, programs[program].events[event].data[i]);
        r++;
      }
      navigation("^", "v", ">", "x");
    } else {
      if(programs[program].events[event].type == TIMER) {
        lcd.setCursor(0, 0);
        lcd.print(hours);
        lcd.print(":");
        lcd.print(minutes);
        lcd.print(":");
        lcd.print(seconds);
        navigation("", "", "", "x");
      } else if(programs[program].events[event].type == TEMPERATURE) {
        lcd.setCursor(0, 0);
        lcd.print(temperature);
        if(temperatureScale == CELCIUS) {
          lcd.print(" C");
        } else if(temperatureScale == FAHRENHEIT) {
          lcd.print(" F");
        }
        navigation("", "", "", "x");
      }
    }
  }
  
  //print(8, 1, sizeof(programs[program].events[event].data));
}

void alarm() {
  // test if the alarm should sound
  if(started && !showevent) {
    if(programs[program].events[event].type==TIMER) {
      if(programs[program].events[event].hours <= hours && programs[program].events[event].minutes <= minutes && programs[program].events[event].seconds <= seconds) {
        alarmed = true;
      }
    } else if(programs[program].events[event].type==TEMPERATURE) {
      if(programs[program].events[event].temperature > temperature && programs[program].events[event].compare == L) {
        alarmed = true;
      } else if(programs[program].events[event].temperature < temperature && programs[program].events[event].compare == G) {
        alarmed = true;
      }  
    }
  }
  
  // do not sound alarm on the first step
  if(event == 0 && alarmed) {
    alarmed = false;
    showevent = true;
  }
  
  // if alarmed play the alarm
  if(alarmed) {
    tone(ALARM, notes[current_note],200); 
    current_note++;
    if(current_note >= num_notes) {
      current_note = 0;
    }
  }
}

// display naivigation
void navigation(String tl, String bl, String tr, String br) {
  print(0, 0, tl);
  print(0, LCD_HEIGHT-1, bl);
  print(LCD_WIDTH-1, 0, tr);
  print(LCD_WIDTH-1, LCD_HEIGHT-1, br);
}

void print(int x, int y, String text) {
  lcd.setCursor(x, y);
  lcd.print(text);
}

void reset() {
  program = -1;
  started = false;
  event = 0;
  showevent = false;
  alarmed = false;
  cancel = false;
}
