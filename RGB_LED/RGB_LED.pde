#define RED 9
#define GREEN 10
#define BLUE 11

void setup() {
  pinMode(RED, OUTPUT); 
  pinMode(GREEN, OUTPUT); 
  pinMode(BLUE, OUTPUT); 
  Serial.begin(9600);
}

void loop() {
  float val;
  float h;
  int h_int;
  int r=0, g=0, b=0;
  
  //val=analogRead(potpin);    // Read the pin and display the value
  for(int i=0;i<1024; i++) {
    val = i;
    //Serial.println(val);
    h = ((float)val)/1024;
    h_int = (int) 360*h;
    h2rgb(h,r,g,b);
    
    Serial.print("Potentiometer value: ");
    Serial.print(val);
    Serial.print(" = Hue of ");
    Serial.print(h_int);
    Serial.print("degrees. In RGB this is: ");
    Serial.print(r);
    Serial.print(" ");
    Serial.print(g);
    Serial.print(" ");
    Serial.println(b);
  
    analogWrite(RED, r); 
    analogWrite(GREEN, g); 
    analogWrite(BLUE, b);
   delay(30);  
  }
  /*
  for(int fadeValue = 0 ; fadeValue <= 255; fadeValue +=5) { 
    // sets the value (range from 0 to 255):
    analogWrite(RED, fadeValue);         
    // wait for 30 milliseconds to see the dimming effect    
    delay(30);                            
  }
  
  for(int fadeValue = 0 ; fadeValue <= 255; fadeValue +=5) { 
    // sets the value (range from 0 to 255):
    analogWrite(GREEN, fadeValue);         
    // wait for 30 milliseconds to see the dimming effect    
    delay(30);                            
  }
  
  for(int fadeValue = 0 ; fadeValue <= 255; fadeValue +=5) { 
    // sets the value (range from 0 to 255):
    analogWrite(BLUE, fadeValue);         
    // wait for 30 milliseconds to see the dimming effect    
    delay(30);                            
  }
  */
  delay(30);  
}

void h2rgb(float H, int& R, int& G, int& B) {

  int var_i;
  float S=1, V=1, var_1, var_2, var_3, var_h, var_r, var_g, var_b;

  if ( S == 0 )                       //HSV values = 0 ÷ 1
  {
    R = V * 255;
    G = V * 255;
    B = V * 255;
  }
  else
  {
    var_h = H * 6;
    if ( var_h == 6 ) var_h = 0;      //H must be < 1
    var_i = int( var_h ) ;            //Or ... var_i = floor( var_h )
    var_1 = V * ( 1 - S );
    var_2 = V * ( 1 - S * ( var_h - var_i ) );
    var_3 = V * ( 1 - S * ( 1 - ( var_h - var_i ) ) );

    if      ( var_i == 0 ) {
      var_r = V     ;
      var_g = var_3 ;
      var_b = var_1 ;
    }
    else if ( var_i == 1 ) {
      var_r = var_2 ;
      var_g = V     ;
      var_b = var_1 ;
    }
    else if ( var_i == 2 ) {
      var_r = var_1 ;
      var_g = V     ;
      var_b = var_3 ;
    }
    else if ( var_i == 3 ) {
      var_r = var_1 ;
      var_g = var_2 ;
      var_b = V     ;
    }
    else if ( var_i == 4 ) {
      var_r = var_3 ;
      var_g = var_1 ;
      var_b = V     ;
    }
    else                   {
      var_r = V     ;
      var_g = var_1 ;
      var_b = var_2 ;
    }

    R = (1-var_r) * 255;                  //RGB results = 0 ÷ 255
    G = (1-var_g) * 255;
    B = (1-var_b) * 255;
  }
}

