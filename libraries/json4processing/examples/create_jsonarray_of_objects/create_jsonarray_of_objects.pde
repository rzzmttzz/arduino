/*
 * JSON 4 Processing
 * Basic example 3: Creating a JSON Array of JSON Objects.
 *
 * Good for sending multiple complex values, such as database tables.
 */

import org.json.*;

void setup(){
  
  // 1. Initialize the Array
  JSONArray myJsonUsers = new JSONArray();
  
  // 2. Create the first object & add to array
  JSONObject firstUser = new JSONObject();
  firstUser.put( "name", "Andreas" );
  firstUser.put( "age", 32 );
  myJsonUsers.put( firstUser );
  
  // 3. Create the second object
  JSONObject secondUser = new JSONObject();
  secondUser.put( "name", "Maria" );
  secondUser.put( "age", 28 );
  myJsonUsers.put( secondUser );
  
  println( myJsonUsers ); 
}

void draw(){
}
