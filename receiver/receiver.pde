/*
* Simple Receiver Code
* (TX out of Arduino is Digital Pin 1)
* (RX into Arduino is Digital Pin 0)
*/

#include <SoftwareSerial.h>

SoftwareSerial mySerial(2, 3); // RX, TX

int incomingByte = 0;

void setup(){
  Serial.begin(2400);
  mySerial.begin(4800);
  pinMode(2,INPUT);
  pinMode(3,OUTPUT);
}

void loop() {
  incomingByte = mySerial.read();
  if(incomingByte != 0) {
    Serial.println(incomingByte, DEC);
  }
  incomingByte = 0;

}


