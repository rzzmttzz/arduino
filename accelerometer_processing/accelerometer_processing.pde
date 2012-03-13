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
  size(600, 600, OPENGL); 
  noStroke(); 
  //colorMode(RGB, 1);
  //frameRate(30);

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
  lights();
  ambientLight(102, 102, 102);
  lightSpecular(100, 100, 100); 
  directionalLight(102, 102, 102, -1, -1, 0);
  
  float depth = -500;
  float graphDepth = 0;
  // draw walls
  fill(150);
  stroke(20);
  beginShape(QUADS);
    vertex(0, 0, 0);
    vertex(0, 0, depth);
    vertex(0, height,depth);
    vertex(0, height,0);
  endShape(CLOSE);
  beginShape(QUADS);
    vertex(0, 0, 0);
    vertex(width, 0, 0);
    vertex(width, 0,depth);
    vertex(0, 0,-500);
  endShape(CLOSE);
  beginShape(QUADS);
    vertex(width, 0, 0);
    vertex(width, height, 0);
    vertex(width, height,depth);
    vertex(width, 0,depth);
  endShape(CLOSE);
  beginShape(QUADS);
    vertex(0, height, 0);
    vertex(0, height, depth);
    vertex(width, height,depth);
    vertex(width, height,0);
  endShape(CLOSE);
  beginShape(QUADS);
    vertex(0, 0, depth);
    vertex(width,0 , depth);
    vertex(width, height,depth);
    vertex(0, height,depth);
  endShape(CLOSE);
  
  //draw latest reading
  if(vectors.size()>1) {
    Vector latest = (Vector)vectors.get(vectors.size()-1);
    fill(0,0,255);
    text("x:"+latest.x,width/2+10,30);
    fill(0,255,0);
    text("y:"+latest.y,width/2+10,50);
    fill(255,0,0);
    text("z:"+latest.z,width/2+10,70);
  
    fill(255,255,0);
    text("ax:"+latest.ax,width/2+10,90);
    fill(255,0,255);
    text("ay:"+latest.ay,width/2+10,110);
    fill(0,255,255);
    text("az:"+latest.az,width/2+10,130);
  
    // draw ball
    pushMatrix(); 
      fill(34,100,255);
      //line(0,0,0,latest.x*200,latest.y*200,latest.z*200);
      noStroke();
      
      specular(200, 200, 200); 
      //translate(width/2+latest.x*50,height/2+latest.z*50,depth/2+latest.y*50); 
      translate(map(latest.x, -3, 3, 0, width),map(latest.z, -3, 3, 0, height),map(latest.y, -3, 3, 0, depth)); 
      // line(0,0,0,latest.x*100,latest.y*100,latest.z*100);
      shininess(5.0);
      sphere(28);
    popMatrix();
  }
  
  // draw ball axis
  stroke(0);
  line(0, height/2, graphDepth/2, width,  height/2, graphDepth/2);
  line(width/2, 0, graphDepth/2, width/2, height,graphDepth/2);
  line(width/2, height/2, 0, width/2, height/2,graphDepth);

  // draw graph axis
  stroke(255,255,255);
  fill(255);
  line(20, height/2, graphDepth, width,  height/2, graphDepth);
  line(20, 0, graphDepth, 20, height,graphDepth);
  text("0",5,height/2,graphDepth);
  
  // scroll graph horizontally when it reaches the right of the window
  int xmin = 1;
  int xmax = vectors.size();
  if(xmax > width/2 - 20) {
    xmin = xmax - width/2 + 20;  
  }
  
  // draw graph
  for(int i = xmin; i < xmax; i++) {
    try {
      Vector v = (Vector)vectors.get(i);
      Vector prev = (Vector)vectors.get(i-1);
      //offset the start of the graph to be within the axis
      int x = i+20-xmin+1;
      
      fill(0,0,255,20);
      noStroke();
      beginShape(QUADS);
        vertex(x, height - map(prev.x, -3, 3, 0, height), graphDepth);
        vertex(x, height - map(v.x, -3, 3, 0, height), graphDepth);
        vertex(x, height - map(v.x, -3, 3, 0, height), depth);
        vertex(x, height - map(prev.x, -3, 3, 0, height), depth);  
      endShape(CLOSE);
      stroke(0,0,255,100);
      line(x, height-map(prev.x, -3, 3, 0, height), graphDepth, x, height - map(v.x, -3, 3, 0, height), graphDepth);
     
      fill(0,255,0,20);
      noStroke();
      beginShape(QUADS);
        vertex(x, height - map(prev.y, -3, 3, 0, height), graphDepth);
        vertex(x, height - map(v.y, -3, 3, 0, height), graphDepth);
        vertex(x, height - map(v.y, -3, 3, 0, height), depth);
        vertex(x, height - map(prev.y, -3, 3, 0, height), depth);  
      endShape(CLOSE);
      stroke(0,255,0,100);
      line(x, height-map(prev.y, -3, 3, 0, height), graphDepth, x, height - map(v.y, -3, 3, 0, height), graphDepth);
     
      fill(255,0,0,20);
      noStroke();
      beginShape(QUADS);
        vertex(x, height - map(prev.z, -3, 3, 0, height), graphDepth);
        vertex(x, height - map(v.z, -3, 3, 0, height), graphDepth);
        vertex(x, height - map(v.z, -3, 3, 0, height), depth);
        vertex(x, height - map(prev.z, -3, 3, 0, height), depth);  
      endShape(CLOSE);
      stroke(255,0,0,100);
      line(x, height-map(prev.z, -3, 3, 0, height), graphDepth, x, height - map(v.z, -3, 3, 0, height), graphDepth); 
    } catch(IndexOutOfBoundsException e) {}
  }
  
  //draw latest reading
  if(vectors.size()>1) {
    Vector latest = (Vector)vectors.get(vectors.size()-1);
    
    
    float ax=0,ay=0,az=0;
    float arcx = acos(latest.x/latest.d);
    float arcy = acos(latest.y/latest.d);
    float arcz = acos(latest.z/latest.d);
    
    fill(255,255,0);
    //text("arcx:"+arcx,width/2+10,150);
    fill(255,0,255);
    //text("arcy:"+arcy,width/2+10,170);
    fill(0,255,255);
    //text("arcz:"+arcz,width/2+10,190);
    float arcsinx = acos(latest.x/latest.d);
    float arcsiny = acos(latest.y/latest.d);
    float arcsinz = acos(latest.z/latest.d);
 
    float x = latest.x, y = latest.y, z = latest.z;
    if (y > 0 && z > 0) { 
      ax = arcsinx;
    } else if (y < 0 && z > 0) { 
      ax = 2*PI + arcsinx; 
    } else if (y > 0 && z < 0) {
      ax = PI - arcsinx;
    } else if (y < 0 && z < 0) {
      ax = PI - arcsinx; 
    }
    
    if (x > 0 && z > 0) { 
      ay = arcsiny;
    } else if (x < 0 && z > 0) { // x neg, y pos: lower-right
      ay = 2*PI + arcsiny; // arcsin is negative here, actuall 360 - ang
    } else if (x > 0 && z < 0) { // x pos, y neg: upper-left
      ay = PI - arcsiny;
    } else if (x < 0 && z < 0) { // both neg: upper-right
      ay = PI - arcsiny; // arcsin is negative here, actually 180 + ang
    }
    
    if (x > 0 && y > 0) { 
      az = arcsinz;
    } else if (x < 0 && y > 0) { // x neg, y pos: lower-right
      az = 2*PI + arcsinz; // arcsin is negative here, actuall 360 - ang
    } else if (x > 0 && y < 0) { // x pos, y neg: upper-left
      az = PI - arcsinz;
    } else if (x < 0 && y < 0) { // both neg: upper-right
      az = PI - arcsinz; // arcsin is negative here, actually 180 + ang
    }
    //latest.ax = ax;
    //latest.ay = ay;
    //latest.az = az;

    fill(0,255,255);
    //text("ax:"+ax,width/2+10,210);
    //text("ay:"+ay,width/2+10,230);
    //text("az:"+az,width/2+10,250);
  
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
    if(vectors.size() > 500) {
       vectors.remove(0);
    }
  }
}

