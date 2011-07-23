// the pin for the LED
#define LED 13

// the input pin where the pushbutton is connected
#define BUTTON 7 

// val will be used to store the state of the input pin
int val = 0;

// this variable stores the previous value of "val"
int old_val = 0;

// 0 = LED off while 1 = LED on
int state = 0;


            
void setup() {
  pinMode(LED, OUTPUT);
  // tell Arduino LED is an output
  pinMode(BUTTON, INPUT); // and BUTTON is an input
}
void loop(){
  // read input value and store it
  val = digitalRead(BUTTON);
  
  // check if there was a transition
  if ((val == HIGH) && (old_val == LOW)) {
    state = 1 - state;
    delay(20);
  }
  
  // val is now old, let's store it
  old_val = val;

  if (state == 1) {
    digitalWrite(LED, HIGH); // turn LED ON
  } else {
    digitalWrite(LED, LOW);
  }

}

