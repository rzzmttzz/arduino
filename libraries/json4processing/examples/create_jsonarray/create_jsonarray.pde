/*
 * JSON 4 Processing
 * Basic example 2: Creating a JSON Array
 *
 * Good for sending a large set of primitive values, like sensor readings.
 */

import org.json.*;

void setup(){
  
  // 1. Initialize the Array
  JSONArray myJsonArray = new JSONArray();
  
  // 2. Add some content to the array
  myJsonArray.put( 4 );
  myJsonArray.put( 2 );
  
  println( myJsonArray ); 
}

void draw(){
}
