/*
* Simple Transmitter Code
* This code simply counts up to 255
* over and over
* (TX out of Arduino is Digital Pin 1)
*/
#include <SoftwareSerial.h>

SoftwareSerial mySerial(2, 3); // RX, TX

byte counter = 0;

void setup(){
  Serial.begin(2400);
  mySerial.begin(4800);
  pinMode(2, INPUT);
   pinMode(3, OUTPUT);
}

void loop(){
  digitalWrite(13,HIGH);
  //send out to transmitter
  //mySerial.println(1,BYTE);
  mySerial.println(counter,BYTE);
  Serial.println(counter,DEC);
  counter++;
  digitalWrite(13,LOW);
  delay(10);
}

