int num = 60;
float mx[] = new float[num];
float my[] = new float[num];
PImage img;
  
void setup() {
  size(1200, 700);

  img = loadImage("back.jpg");  
  
  /*
  size(displayWidth, displayHeight);
  if (frame != null) {
    frame.setResizable(true);
  }
  */
  noStroke();
  fill(255, 153); 
}

void draw() {
  background(img);
  
  // Cycle through the array, using a different entry on each frame. 
  // Using modulo (%) like this is faster than moving all the values over.
  int which = frameCount % num;
  mx[which] = mouseX;
  my[which] = mouseY;
  
  for (int i = 0; i < num; i++) {
    // which+1 is the smallest (the oldest in the array)
    int index = (which+1 + i) % num;
    ellipse(mx[index], my[index], i, i);
    //stroke(255);
    //line(width/2, height/2, mx[index], my[index]);
  }
}
