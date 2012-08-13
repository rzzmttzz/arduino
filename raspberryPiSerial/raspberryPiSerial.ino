#include <SoftwareSerial.h>

SoftwareSerial raspberryPi(12,13); // rx, tx

void setup() {
  Serial.begin(9600);
  raspberryPi.begin(9600);
}

void loop() {
  //while (raspberryPi.available() <= 0) {
    Serial.write("pi: ");
    Serial.write(raspberryPi.read());
    Serial.write("\n");
  //}
  
  raspberryPi.write("hello pi\n");
  
  delay(100);
}
