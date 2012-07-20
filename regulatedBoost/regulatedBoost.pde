void setup() {
  pinMode(9,OUTPUT);
  //TCCR1B = TCCR1B & 0b11111000 | 0x04;
}

void loop() {
 
  analogWrite(9,1);
  /*digitalWrite(9,HIGH);
    digitalWrite(13,HIGH);
  delay(1000);
  digitalWrite(9,LOW);
    digitalWrite(13,LOW);
  delay(1000);
  */
}
