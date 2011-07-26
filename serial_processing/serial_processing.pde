import processing.serial.*;

// serial port
Serial port;

PFont font;
color backgroundColour = color(0, 0, 0);

int sensorValue = 0;
int ledBrightness = 0;

void setup() {
  size(640, 480);
  frameRate(1);
  // we don't need fast updates
  font = loadFont("Garuda-32.vlw");
  fill(255);
  textFont(font, 32);

  // IMPORTANT NOTE:
  // The first serial port retrieved by Serial.list()
  // should be your Arduino. If not, uncomment the next
  // line by deleting the // before it, and re-run the
  // sketch to see a list of serial ports. Then, change
  // the 0 in between [ and ] to the number of the port
  // that your Arduino is connected to.
  //println(Serial.list());
  String arduinoPort = Serial.list()[0];
  // connect to Arduino
  port = new Serial(this, arduinoPort, 9600); 
  port.bufferUntil('\n');
}

void draw() {
  // set the background colour
  background(backgroundColour);
  
  text("Reads a value from serial and sends",10,40);
  text("back a valid LED brightness",10,80);
  
  // check if there is data waiting
  if (port.available() > 0) { 
    // read sensor value from serial port until newline
    String s = port.readStringUntil('\n');
    if(s != null) {
      // trim any extra bytes
      s = trim(s);
      // convert string to int
      sensorValue = int(s);
    }
  }
  
  // display sensor value
  text("Sensor Value: " + sensorValue, 10, 160);
  
  // calculate LED brightness
  ledBrightness = sensorValue/4;
  
  // display LED brightness
  text("LED brightness: " + ledBrightness, 10, 200);
  
  // send LED brightness over serial to arduino
  port.write(ledBrightness);
}
