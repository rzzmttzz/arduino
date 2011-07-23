#define LED 9 // the pin for the LED

const int numSensors = 2;
const int numReadings = 20;

int readings[numSensors][numReadings];
int index[numSensors];                  // the index of the current reading
int total[numSensors];                  // the running total
int average[numSensors];                // the average

void setup() {
  pinMode(LED, OUTPUT); 
  //Serial.begin(9600);
  // initialize all the readings to 0
  for (int i = 0; i < numSensors; i++) {
    for (int j = 0; j < numReadings; j++) {
      readings[i][j] = 0;       
    }
    index[i] = 0; 
    total[i] = 0; 
    average[i] = 0;
  }
}

void loop() {
  // for each sensor
  for (int i = 0; i < numSensors; i++) {
    // subtract the last reading
    total[i]= total[i] - readings[i][index[i]];
    // read from the sensor    
    readings[i][index[i]] = analogRead(i);
    // add the reading to the total
    total[i]= total[i] + readings[i][index[i]];
    // advance to the next position in the array
    index[i] = index[i] + 1;
    // if we're at the end of the array, wrap to start
    if (index[i] >= numReadings)              
      index[i] = 0;
      
    // calculate the average  
    average[i] = total[i] / numReadings;
    //Serial.print("A");
    //Serial.print(i, DEC);
    //Serial.print(": ");
    //Serial.println(average[i], DEC);
  }
  
  if(average[0] < average[1]) {
    digitalWrite(LED, HIGH); 
  } else {
    digitalWrite(LED, LOW);
  }
  
  delay(50); 
}

