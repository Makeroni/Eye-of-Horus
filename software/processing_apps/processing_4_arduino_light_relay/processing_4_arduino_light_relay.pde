import processing.video.*;
import processing.serial.*;

Movie movie;
Serial myPort;
int num = 30;
float mx[] = new float[num];
float my[] = new float[num];
PImage img;

void setup() {
  size(1200, 700);
  movie = new Movie(this, "led.mp4");
  movie.loop();

  // List all the available serial ports:
  println(Serial.list());

  // Open the port you are using at the rate you want:
  myPort = new Serial(this, Serial.list()[3], 57600);


  /*
  size(displayWidth, displayHeight);
   if (frame != null) {
   frame.setResizable(true);
   }
   */
  noStroke();
  fill(255, 153);
}

void movieEvent(Movie m) {
  m.read();
}

void draw() {
  if (movie.available() == true) {
    movie.read(); 
  }
  image(movie, 0, 0, width, height);


  // Cycle through the array, using a different entry on each frame. 
  // Using modulo (%) like this is faster than moving all the values over.
  int which = frameCount % num;
  mx[which] = mouseX;
  my[which] = mouseY;

  for (int i = 0; i < num; i++) {
    // which+1 is the smallest (the oldest in the array)
    int index = (which+1 + i) % num;
    stroke(255);
    ellipse(mx[index], my[index], i, i);
    stroke(0,255,0);
    line(mx[index]-10, my[index],mx[index]+10, my[index]);
    line(mx[index], my[index]-10,mx[index], my[index]+10);
  }
  
  //LED detection
  float distance_led_eye = 800;
  textSize(32);
  if(dist(mouseX, mouseY, 300, 460)<50)
  {
    fill(0, 255, 0);
    text("LED Detected. Ready to turn the light on!", mouseX+40, mouseY+40);
    text("Sending light_on command to Arduino", mouseX+40, mouseY+80);
    // Send a command out the serial port for arduino
    myPort.write("light_on");

  }
  else{
    fill(255);
    text("Select your target", mouseX+40, mouseY+80);    
  }
  
  
  
  //text(mouseX, mouseX+40, mouseY+40);
  //text(mouseY, mouseX+40, mouseY+80);
  text(dist(mouseX, mouseY, 300, 460),mouseX+40, mouseY+120);
  
}

