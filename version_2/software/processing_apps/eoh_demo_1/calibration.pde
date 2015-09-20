class Calibration
{ 
  int state;
  Transform tra;
  
  float px[] = new float[8];
  float py[] = new float[8];
  
  float posX;
  float posY;
  
  Calibration()
  {     
    tra = new Transform();
    state = 0;
  }
  
  void project(float x1, float y1)
  {
    if(state != 5)
    {
      return;
    }
    
    float p[] = new float[2];
    float q[] = new float[2];
    
    p[0] = x1;
    p[1] = y1;
   
    tra.perspective_project(p, q, tra.forward);
    
    posX = q[0];
    posY = q[1];
  }
  
  void info(FiducialDetector fid)
  {
    textAlign(CENTER);
    fill(64, 64, 64);
    
    if(state == 0)
    {
      text("System not calibrated\nPress Space to calibrate", width/2, height*90/100);
    }
    else if(state == 1)
    {
      text("Look at the center of the highlighted mark and press Space", width/2, height*90/100);
      strokeWeight(2);
      stroke(255, 255, 0);
      fid.draw(0);
    }
    else if(state == 2)
    {
      text("Look at the center of the highlighted mark and press Space", width/2, height*90/100);
      strokeWeight(2);
      stroke(255, 0, 0);
      fid.draw(1);
    }
    else if(state == 3)
    {
      text("Look at the center of the highlighted mark and press Space", width/2, height*90/100);
      strokeWeight(2);
      stroke(255, 255, 0);
      fid.draw(2);
    }
    else if(state == 4)
    {
      text("Look at the center of the highlighted mark and press Space", width/2, height*90/100);
      strokeWeight(2);
      stroke(255, 0, 0);
      fid.draw(3);
    }
    else if(state == 5)
    {
      text("System calibrated\nPress Space to calibrate again", width/2, height*90/100);
    }
  }
  
  void keyPressed(PupilDetector pup, FiducialDetector fid, char key)
  {
    if(key == ' ' && fid.on(0, 1, 2, 3))
    {
      if(state == 0)
      {
        state++;
      }
      else if(state < 5)
      {
        //1.- use mouse instead of pupil
        px[(state-1)*2] = pup.posX; // mouseX;
        py[(state-1)*2] = pup.posY; // mouseY;
        px[(state-1)*2+1] = fid.data[state-1].x;
        py[(state-1)*2+1] = fid.data[state-1].y;
        
        if(state == 4)
        {
           tra.perspective_coefs(px, py, tra.back);
           tra.perspective_invert(tra.forward, tra.back);
        }
        
        state++;
      }
      else
      {
        state = 1;
      }
    }
  }
}
