import processing.serial.*;
import org.json.*;

// serial port
Serial port;

PFont font;
color backgroundColour = color(0, 0, 0);

ArrayList vectors = new ArrayList();

// creat a class to store the collected data
class Vector {
  float x;
  float y;
  float z;
  float ax;
  float ay;
  float az;
  float d;
  int zerog;
}

void setup() {
  size(640, 480);
  frameRate(30);

  font = loadFont("Garuda-32.vlw");
  fill(255);
  textFont(font, 20);

  //println(Serial.list());
  String arduinoPort = Serial.list()[0];
  // connect to Arduino
  port = new Serial(this, arduinoPort, 9600); 
  port.bufferUntil('\n');
  
  background(backgroundColour);
}

// the drawing thread draws the graph
void draw() {
  // clear the screen
  background(backgroundColour);

  // draw axis
  stroke(255,255,255);
  fill(255);
  line(20, height/2, width,  height/2);
  line(20, 0, 20, height);
  text("0",5,height/2);
  
  // scroll graph horizontally when it reaches the right of the window
  int xmin = 1;
  int xmax = vectors.size();
  if(xmax > width - 30) {
    xmin = xmax - width + 30;  
  }
  
  for(int i = xmin; i < xmax; i++) {
    Vector v = (Vector)vectors.get(i);
    Vector prev = (Vector)vectors.get(i-1);
    //offset the start of the graph to be within the axis
    int x = i+20-xmin+1;
    stroke(0,0,255);
    line(x, height-map(prev.x, -3, 3, 0, height), x, height - map(v.x, -3, 3, 0, height));
    stroke(0,255,0);
    line(x, height-map(prev.y, -3, 3, 0, height), x, height - map(v.y, -3, 3, 0, height));
    stroke(255,0,0);
    line(x, height-map(prev.z, -3, 3, 0, height), x, height - map(v.z, -3, 3, 0, height)); 
  }
  
  //draw latest reading
  if(vectors.size()>1) {
    Vector latest = (Vector)vectors.get(vectors.size()-1);
    fill(0,0,255);
    text("x:"+latest.x,30,30);
    fill(0,255,0);
    text("y:"+latest.y,30,50);
    fill(255,0,0);
    text("z:"+latest.z,30,70);
  }
}

// the serial event thread collects the data
void serialEvent (Serial port) {
  // get the json string:
  String inString = port.readString();
  // if there is not data, skip
  if (inString != null) {
    // trim off any whitespace:
    inString = trim(inString);
    
    // parse into a json object
    JSONObject data = new JSONObject(inString);
    
    // build a local object from the json object  
    Vector v = new Vector();
    v.x = (float)data.getDouble("x");
    v.y = (float)data.getDouble("y");
    v.z = (float)data.getDouble("z");
    v.ax = (float)data.getDouble("ax");
    v.ay = (float)data.getDouble("ay");
    v.az = (float)data.getDouble("az");
    v.d = (float)data.getDouble("d");
    v.zerog = data.getInt("zerog");
    
    //store it in an arraylist
    vectors.add(v);
  }
}
