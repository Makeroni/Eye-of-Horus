import processing.video.*;
import jp.nyatla.nyar4psg.*;
import java.util.HashSet;
import java.util.Arrays;

PupilDetector pup;
FiducialDetector fid;
Capture frontalCam, eyeCam;
Transform tra;
Calibration cal;

PImage img;

void setup()
{
  size(640, 480);
  
  // Set sketch framerate
  frameRate(60);
  
  // Pupil detector
  pup = new PupilDetector(1.0, 0.001, 0.005);
  
  // Fiducial detector
  fid = new FiducialDetector(this);
  
  // Transformation operator
  tra = new Transform();
  
  // Calibration operator
  cal = new Calibration();
  
  // Get list of camera names
  String[] cams = getCameraNames();
  
  // Change camera order here
  String frontal = cams[0];
  String eye     = cams[1];
  
  // Start frontal camera
  frontalCam = new Capture(this, 640, 480, frontal, 30);
  frontalCam.start();
  
  // Start eye camera
  eyeCam = new Capture(this, 640, 480, eye, 30);
  eyeCam.start();
  
  // Test image
  img = loadImage("data"+File.separator+"mario.png");
  img.loadPixels();
  
  // Minim setup
  minim_setup();
}

void draw()
{
  // Read frontal camera
  if (frontalCam.available())
  {
    frontalCam.read();
    rotateCamera(frontalCam);
  }
    
  // Read eye camera
  if (eyeCam.available())
  {
    eyeCam.read();
    rotateCamera(eyeCam);
  }
  
  // Detect fiducials
  fid.detect(frontalCam);
  
  // Calibration frame
  if(fid.on(0, 1, 2, 3))
  {
      // Compute transformation
      tra.setFrame(fid, 0, 1, 2, 3);
      
      // Draw sample image on the frame
      //tra.drawImage(img, frontalCam);
  }

  // Draw frontal image
  set(0, 0, frontalCam);
  
  // Draw light on/off fiducial
  if(fid.on(4))
  {
      strokeWeight(2);
      stroke(255, 255, 0);
      fid.draw(4);
  }
  
  // Draw eye image
  image(eyeCam, 0, 0, eyeCam.width / 4.0, eyeCam.height / 4.0);
  
  // Draw pupil
  if(pup.detect(eyeCam))
  {
    noFill();
    strokeWeight(2);
    stroke(0, 255, 0);
    ellipse(pup.posX, pup.posY, pup.posR, pup.posR);
    
    // If calibrated
    if(cal.state == 5)
    {
      // Project pupil coordinates and draw spot
      cal.project(pup.posX, pup.posY); // mouseX, mouseY); //1.- use mouse instead of pupil
      ellipse(cal.posX, cal.posY, 10, 10);
      ellipse(cal.posX, cal.posY, 20, 20);
      
      // Activate light on/off fiducial
      if(fid.on(4))
      {
          float dx, dy, r;
          
          dx = cal.posX - fid.data[4].x;
          dy = cal.posY - fid.data[4].y;
          r = sqrt(dx*dx+dy*dy);
          
          if(r < fid.data[4].r)
          {
            strokeWeight(2);
            stroke(255, 0, 0);
            fid.draw(4);
            // TODO Send serial msg
          }
      }
      
    }
  }
  
  // Draw calibration info
  if(fid.on(0, 1, 2, 3))
  {
    cal.info(fid);
  }
  
   //Change frequency!
   //float new_frequency = pup.posX;
   //new_frequency = map(new_frequency, 50, 90, -20, 500);
   //change_frequency((int)new_frequency);
   //float amp = map( pup.posX, 0, 150, 1, 0 );
   float amp = map( pup.posY, 40, 70, 1, 0 );
   wave.setAmplitude( amp );
  
   //float freq = map( pup.posY, 80, 30, 20, 880 );
   float freq = map( pup.posX, 60, 110, 20, 600 );
   wave.setFrequency( freq );
   
   println("x:" + pup.posX + " y:" + pup.posY + " amp:" + amp + " freq:" + freq);
}

void keyPressed()
{
  cal.keyPressed(pup, fid, key);
}

String[] getCameraNames()
{
  String[] list = Capture.list();
  for (int i=0; i < list.length; i++)
  {
    String[] chunks = split(list[i], ',');
    chunks = split(chunks[0], '=');
    list[i] = chunks[1];
  }
  String[] unique = new HashSet<String>(Arrays.asList(list)).toArray(new String[0]);
  return unique;
}

void rotateCamera(Capture img)
{
    PImage out = img.get();
    int k=0;
    for (int y=0; y<img.height; y++ )
    {
      for (int x=0; x<img.width; x++ )
      {
        out.pixels[k++] = img.pixels[img.width-1-x+(img.height-1-y)*img.width];
      }
    }
    k=0;
    for (int y=0; y<img.height; y++ )
    {
      for (int x=0; x<img.width; x++ )
      {
        img.pixels[k] = out.pixels[k];
        k++;
      }
    }
}
