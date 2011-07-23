// Example 04: Fade an LED in and out like on
// a sleeping Apple computer
#define LED 9 // the pin for the LED
#define BUTTON 7 // input pin of the pushbutton


int brightness = 128;
// Stores the brightness value
unsigned long startTime = 0; // when did we begin pressing?

int val = 0; // stores the state of the input pin
int old_val = 0; // stores the previous value of "val"
int state = 0;
// 0 = LED off while 1 = LED on


void setup() {
  pinMode(LED, OUTPUT); // tell Arduino LED is an output
  pinMode(BUTTON, INPUT); // and BUTTON is an input

}
void loop(){
  val = digitalRead(BUTTON); // read input value and store it
  // yum, fresh
  // check if there was a transition
  if ((val == HIGH) && (old_val == LOW)) {
    state = 1 - state; // change the state from off to on
    // or vice-versa
    startTime = millis(); // millis() is the Arduino clock
    // it returns how many milliseconds
    // have passed since the board has
    // been reset.
    // (this line remembers when the button
    // was last pressed)
    delay(10);
  }
  
  // check whether the button is being held down
  if ((val == HIGH) && (old_val == HIGH)) {
    // If the button is held for more than 500ms.
    if (state == 1 && (millis() - startTime) > 500) {
      brightness++; // increment brightness by 1
      delay(10);
      // delay to avoid brightness going
      // up too fast
      if (brightness > 255) { // 255 is the max brightness
        brightness = 0; // if we go over 255
        // let’s go back to 0
      }
    }
  }
  old_val = val; // val is now old, let’s store it
  
  if (state == 1) {
    analogWrite(LED, brightness); // turn LED ON at the
    // current brightness level
  } else {
    analogWrite(LED, 0); // turn LED OFF
  }
}


