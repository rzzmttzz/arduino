// Example 06A: Blink LED at a rate specified by the
// value of the analogue input
#define LED 9 // the pin for the LED

int val0 = 0;
int val1 = 0;


void setup() {
  pinMode(LED, OUTPUT); // LED is as an OUTPUT
  // Note: Analogue pins are
  // automatically set as inputs
}
void loop() {
  val0 = analogRead(A0); 
  val1 = analogRead(A1); 
  
  if(val0 < val1) {
    digitalWrite(LED, high); 
  }
  
  delay(10); 
}

