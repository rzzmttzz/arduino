
#include <aJSON.h>
#include <Wire.h>

#define TURN_PWM 6
#define TURN_IN1 7
#define TURN_IN2 8
#define MOVE_PWM 3
#define MOVE_IN1 2
#define MOVE_IN2 4

class Car {
  private:
   int turn_pwm_pin;
   int turn_in1_pin;
   int turn_in2_pin;
   int move_pwm_pin;
   int move_in1_pin;
   int move_in2_pin;
   
   int move;
   int turn;
   
   aJsonObject* rootJson;
   aJsonObject* carJson;
   aJsonObject* turnJson;
   aJsonObject* moveJson;
   
  public:
   /**
   * turn_pwm: pwm steering motor pin
   * turn_in1: input 1 steering motor pin
   * turn_in2: input 2 steering motor pin
   * move_pwm: pwm movement motor pin
   * move_in1: input 1 movement motor pin
   * move_in2: input 2 movement motor pin
   */
   Car(int turn_pwm,int turn_in1,int turn_in2,int move_pwm,int move_in1,int move_in2) {
     turn_pwm_pin = turn_pwm; 
     turn_in1_pin = turn_in1;
     turn_in2_pin = turn_in2;
     move_pwm_pin = move_pwm;
     move_in1_pin = move_in1;
     move_in2_pin = move_in2;
     move = 0;
     turn = 0;
   }
   
   /**
   * amount: (-255, 255) 
   *         -255 for full left, 
   *         255 for full right 
   *         and 0 for stop
   */
   void setTurn(int amount) {
     //turn = amount;
     if(amount == 0) {
       digitalWrite(turn_in1_pin, HIGH);
       digitalWrite(turn_in2_pin, HIGH); 
       analogWrite(turn_pwm_pin, amount);
     } else if(amount < 0) {
       digitalWrite(turn_in1_pin, LOW);
       digitalWrite(turn_in2_pin, HIGH);
       analogWrite(turn_pwm_pin, -amount);
     } else if(amount > 0) {
       digitalWrite(turn_in1_pin, HIGH);
       digitalWrite(turn_in2_pin, LOW);
       analogWrite(turn_pwm_pin, amount);
     }
   }
   
   /*
   * amount: (-255, 255) 
   *         -255 for full reverse, 
   *         255 for full forward
   *         and 0 for stop
   */
   void setMove(int amount) {
     //move = amount;
     if(amount == 0) {
       digitalWrite(move_in1_pin, HIGH);
       digitalWrite(move_in2_pin, HIGH);
       analogWrite(move_pwm_pin, amount); 
     } else if(amount < 0) {
       digitalWrite(move_in1_pin, HIGH);
       digitalWrite(move_in2_pin, LOW);
       analogWrite(move_pwm_pin, -amount);
     } else if(amount > 0) {
       digitalWrite(move_in1_pin, LOW);
       digitalWrite(move_in2_pin, HIGH);
       analogWrite(move_pwm_pin, amount);
     }
   }
   
  void setJson(char* json) {
    // parse json string into an object
    rootJson = aJson.parse(json);
    
    //char* string = aJson.print(json);
    //Serial.println(string);
    
    carJson = aJson.getObjectItem(rootJson, "car");
    moveJson = aJson.getObjectItem(carJson, "move");
    turnJson = aJson.getObjectItem(carJson, "turn");
    Serial.print("move: ");
    Serial.println(moveJson->valuestring);
    Serial.print("turn: ");
    Serial.println(turnJson->valuestring);
    Serial.println("");
    
    // set cars inputs
    setMove(atoi(moveJson->valuestring));
    setTurn(atoi(turnJson->valuestring)); 
   }
   
   int getMove() {
     return move;
   }
   
   int getTurn() {
     return turn;
   }
};

// setup car object
Car car(TURN_PWM,TURN_IN1,TURN_IN2,MOVE_PWM,MOVE_IN1,MOVE_IN2);

void setup() {
  
  pinMode(TURN_PWM, OUTPUT);
  pinMode(TURN_IN1, OUTPUT);
  pinMode(TURN_IN2, OUTPUT);
  pinMode(MOVE_PWM, OUTPUT);
  pinMode(MOVE_IN1, OUTPUT);
  pinMode(MOVE_IN2, OUTPUT);
  
  // setup car as i2c slave
  // Start I2C Bus as a Slave (Device Number 9)
  Wire.begin(9);
  
  // register events  
  Wire.onReceive(i2cReceive);
  Wire.onRequest(i2cRequest); 
  
  // run tests once
  //tests();
  
}

// get i2c event and set car's values

void i2cReceive(int numBytes) {
  //x = Wire.receive();    // receive byte as an integer
  
  // Read json data as a string
  //Serial.println("Read json data as a string");
  static char incomingString[32];
  static int i;
  for(i=0; i<numBytes; i++) {
    incomingString[i] = Wire.read();
  }
  incomingString[i] = '\0';
  Serial.println(incomingString);
  
  //incomingString = "{\"car\":{\"move\":\"0\",\"turn\":\"0\"}}";
  car.setJson(incomingString);
  
  /*
  while(Wire.available()) {   // slave may send less than requested
    char c = Wire.read();    // receive a byte as character
    incomingString += c;
    //Serial.print(c);         // print the character
  }
  */
}

void i2cRequest() {
    int inData = 0;
    char writeString[32]; // for formating a string to send over I2C
    sprintf(writeString, "{\"data\":\"%d\"}\n", inData);
    Wire.write(writeString);
}

void loop() {}

void tests() {

  
  
  
  // Tests 
  /*
  // move forward [pass]
  car.setMove(255);
  delay(1000);
  // move backward [pass]
  car.setMove(-255);
  delay(1000);
  // stop [pass]
  car.setMove(0);
  delay(1000);
  // turn right [pass]
  car.setTurn(255);
  delay(1000);
  // turn left [pass]
  car.setTurn(-255);
  delay(1000);
  // center steering [pass]
  car.setTurn(0);
  delay(1000);
  
  // start at zero speed and increase forward speed until maximum
  // [pass]
  for (int i=0; i < 255; i++) {
    car.setMove(i);
    delay(20);
  }
  // from maximum forward speed, decrease forward speed until zero
  // [pass]
  for (int i=255; i > 0; i--) {
    car.setMove(i);
    delay(20);
  }
  // stop completely
  // [pass]
  car.setMove(0);
  delay(20);
  
  // start at zero speed and increase reverse speed until maximum
  // [pass]
  for (int i=0; i > -255; i--) {
    car.setMove(i);
    delay(20);
  }
  // from maximum forward speed, decrease forward speed until zero
  // [pass]
  for (int i=-255; i < 0; i++) {
    car.setMove(i);
    delay(20);
  }
  // stop completely
  // [pass]
  car.setMove(0);
  delay(20);
  
  
  
  // start at center and turn right until maximum
  // [pass]
  for (int i=0; i < 255; i++) {
    car.setTurn(i);
    delay(20);
  }
  // from full right, reduce turn until zero
  // [pass]
  for (int i=255; i > 0; i--) {
    car.setTurn(i);
    delay(20);
  }
  // center steering
  car.setTurn(0);
  delay(20);
  
  // start at center and turn left until maximum
  // [pass]
  for (int i=0; i > -255; i--) {
    car.setTurn(i);
    delay(20);
  }
  // from full left, reduce turn until zero
  // [pass]
  for (int i=-255; i < 0; i++) {
    car.setTurn(i);
    delay(20);
  }
  // center steering
  // [pass]
  car.setTurn(0);
  delay(20);
  
  
  // brake test
  // full then stop full then stop etc
  // [pass]
  car.setMove(0);
  delay(1000);
  car.setMove(255);
  delay(1000);
  car.setMove(0);
  delay(1000);
  car.setMove(255);
  delay(1000);
  car.setMove(0);
  car.setMove(255);
  delay(1000);
  car.setMove(0);
  car.setTurn(0);
  */
  
  car.setJson("{\"car\":{\"move\":\"0\",\"turn\":\"0\"}}");
  delay(1000);
  car.setJson("{\"car\":{\"move\":\"255\",\"turn\":\"0\"}}");
  delay(1000);
  car.setJson("{\"car\":{\"move\":\"-255\",\"turn\":\"0\"}}");
  delay(1000);
  car.setJson("{\"car\":{\"move\":\"0\",\"turn\":\"200\"}}");
  delay(1000);
  car.setJson("{\"car\":{\"move\":\"0\",\"turn\":\"-200\"}}");
  delay(1000);
  car.setJson("{\"car\":{\"move\":\"200\",\"turn\":\"200\"}}");
  delay(1000);
  car.setJson("{\"car\":{\"move\":\"200\",\"turn\":\"-200\"}}");
  delay(500);
  car.setJson("{\"car\":{\"move\":\"200\",\"turn\":\"200\"}}");
  delay(500);
  car.setJson("{\"car\":{\"move\":\"-200\",\"turn\":\"-200\"}}");
  delay(1000);  
}
