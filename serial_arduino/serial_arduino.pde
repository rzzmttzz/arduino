#define BUTTON 2
#define SENSOR 0
#define LED 9

int sensorValue = 0;
int ledBrightness = 0;

void setup() {
  delay(50);
  Serial.begin(9600);
  // open the serial port
  pinMode(BUTTON, INPUT);
  pinMode(LED, OUTPUT);
}

void loop() {
  // read the value from the sensor
  sensorValue = analogRead(SENSOR); 
  
  // write sensor value to serial
  Serial.println(sensorValue,DEC);
  
  // check if there is data waiting
  if (Serial.available()) {
    // read a byte of serial data (0-255)
    ledBrightness = Serial.read();
  }
  
  // set led brightness
  analogWrite(LED, ledBrightness);
  
  // wait 1 second
  delay(1000);
}
