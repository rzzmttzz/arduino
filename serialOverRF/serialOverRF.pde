
int incomingByte = 0;

void setup()
{
  Serial.begin(2000);    
}

void loop() {


  //send out to transmitter
  Serial.print(1);
  

  
  // read in values, debug to computer
  if (Serial.available() > 0) {
    incomingByte = Serial.read();
    //Serial.println(incomingByte, DEC);
    if(incomingByte == 1) {
      digitalWrite(13, HIGH);
    }
  }
  
  incomingByte = 0;
  delay(500);
  digitalWrite(13, LOW);
  delay(500);
}
