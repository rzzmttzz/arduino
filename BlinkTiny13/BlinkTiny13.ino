/*
  Blink
  Turns on an LED on for one second, then off for one second, repeatedly.
 
  This example code is in the public domain.
 */

void setup() {                
  // initialize the digital pin as an output.
  // Pin 13 has an LED connected on most Arduino boards:
  pinMode(4, OUTPUT); 
  pinMode(0, INPUT);   
}

void loop() {
  //int i = analogRead(0);
  digitalWrite(4, HIGH);   // set the LED on
  delay(200);              // wait for a second
  digitalWrite(4, LOW);    // set the LED off
  delay(200);              // wait for a second
}
