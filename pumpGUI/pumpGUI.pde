import controlP5.*; //import ControlP5 library
import processing.serial.*;

Serial port;

ControlP5 cp5; //create ControlP5 object
PFont font;
PImage bg;
PImage bg1;
PImage bg2;

int timeSinceStart=-1000;
int cSpeed=0;
int m;

void setup(){ //same as arduino program

  size(300, 485);    //window size, (width, height)
 
 // SERIAL COMMUNICATION STUFF
  printArray(Serial.list());   //prints all available serial ports
  port = new Serial(this, "COM7", 9600);  //i have connected arduino to com3, it would be different in linux and mac os
  
  //lets add buton to empty window
  cp5 = new ControlP5(this);
  font = createFont("calibri light bold", 20);    // custom fonts for buttons and title
  
  cp5.addButton("AUS")     //"red" is the name of button
      .setPosition(90, 105)  //x and y coordinates of upper left corner of button
      .setSize(120, 70)      //(width, height)
      .setFont(font)
    ;   
    
  cp5.addButton("FASTER")     //"red" is the name of button
    .setPosition(170, 180)  //x and y coordinates of upper left corner of button
    .setSize(120, 70)      //(width, height)
    .setFont(font)
  ;   

  cp5.addButton("CHILL")     //"yellow" is the name of button
    .setPosition(10, 180)  //x and y coordinates of upper left corner of button
    .setSize(120, 70)      //(width, height)
    .setFont(font)
  ;
  
  cp5.addButton("STAPH")     //"red" is the name of button
    .setPosition(90, 255)  //x and y coordinates of upper left corner of button
    .setSize(120, 70)      //(width, height)
    .setFont(font)
  ;   
  
  bg1 = loadImage("bg1.png");
  bg2= loadImage("bg2.png");
  bg=bg1;
}

void draw(){  //same as loop in arduino

  background(bg);
  m = millis(); 
  
  if(timeSinceStart + 1000 > m){
    bg=bg2; // or whatever is outside while loop
    //timeSinceStart = millis();
  }
  else{
    bg=bg1;
  }
  
  font = createFont("calibri light bold", 40);    // custom fonts for buttons and title
  //lets give title to our window
  fill(0, 25, 0);               //text color (r, g, b)
  textFont(font);
  textAlign(CENTER, CENTER);
  text("PUMP", 150, 45);  // ("text", x coordinate, y coordinat)
  String speedMon="Speed "+cSpeed;
  text(speedMon, 150, 355);  // ("text", x coordinate, y coordinat)
}

// BUTTON FUNCTIONS
void AUS(){
    port.write('d');
    timeSinceStart = millis(); 
}

void STAPH(){
  port.write('a');
}

void FASTER(){
  port.write('w');
  cSpeed+=100;
}

void CHILL(){
  port.write('s');
  cSpeed-=100;

}
