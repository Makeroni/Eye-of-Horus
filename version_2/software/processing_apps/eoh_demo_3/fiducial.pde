class Fiducial
{
  boolean on;
  float x, y, a, r;
  float c1x, c1y;
  float c2x, c2y;
  float c3x, c3y;
  float c4x, c4y;
}

class FiducialDetector
{
  MultiMarker nya;
  
  Fiducial[] data;;
  
  FiducialDetector(PApplet parent)
  {
    nya = new MultiMarker(parent, 640, 480, "camera_para.dat", NyAR4PsgConfig.CONFIG_PSG);
    nya.setLostDelay(1); // Change DEFAULT_LOST_DELAY
    nya.addARMarker("data"+File.separator+"fid_4x4_8.patt",  80); //id=0
    nya.addARMarker("data"+File.separator+"fid_4x4_48.patt", 80); //id=1
    nya.addARMarker("data"+File.separator+"fid_4x4_89.patt", 80); //id=2
    nya.addARMarker("data"+File.separator+"fid_4x4_95.patt", 80); //id=3
    nya.addARMarker("data"+File.separator+"fid_4x4_43.patt", 80); //id=4
    
    data = new Fiducial[5]; // number of fiducials;
    for(int i=0; i<data.length; i++)
    {
      data[i] = new Fiducial();
    }
  }
  
  void detect(Capture img)
  {
    nya.detect(img);
    
    for(int i=0; i<data.length; i++)
    {
      Fiducial f = data[i];
      
      if((!nya.isExistMarker(i)))
      {
        f.on = false;
        continue;
      }
      
      PVector[] cor = nya.getMarkerVertex2D(i);
      f.on = true;
      f.x = (cor[0].x + cor[1].x + cor[2].x + cor[3].x) * 0.25;
      f.y = (cor[0].y + cor[1].y + cor[2].y + cor[3].y) * 0.25;
      f.a = atan2(cor[1].y-cor[0].y, cor[1].x-cor[0].x);
      f.r = sqrt((cor[1].x-cor[0].x)*(cor[1].x-cor[0].x)+(cor[1].y-cor[0].y)*(cor[1].y-cor[0].y));
      f.c1x = cor[0].x;
      f.c1y = cor[0].y;
      f.c2x = cor[1].x;
      f.c2y = cor[1].y;
      f.c3x = cor[2].x;
      f.c3y = cor[2].y;
      f.c4x = cor[3].x;
      f.c4y = cor[3].y;
    } 
  }
  
  boolean on(int i1)
  {
    return data[i1].on;
  }
  
  boolean on(int i1, int i2)
  {
    return data[i1].on && data[i2].on;
  }
  
  boolean on(int i1, int i2, int i3)
  {
    return data[i1].on && data[i2].on && data[i3].on;
  }
  
  boolean on(int i1, int i2, int i3, int i4)
  {
    return data[i1].on && data[i2].on && data[i3].on && data[i4].on;
  }
  
  void drawFrame(int i1, int i2, int i3, int i4)
  {
      if(on(i1, i2, i3, i4))
      {
        Fiducial c1 = data[i1];
        Fiducial c2 = data[i2];
        Fiducial c3 = data[i3];
        Fiducial c4 = data[i4];
        strokeWeight(2);
        stroke(0, 255, 0);
        line(c1.x, c1.y, c2.x, c2.y);
        line(c2.x, c2.y, c4.x, c4.y);
        stroke(255, 0, 0);
        line(c4.x, c4.y, c3.x, c3.y);
        stroke(0, 0, 255);
        line(c3.x, c3.y, c1.x, c1.y);
      }
  }

  void draw(int i)
  {
      Fiducial f = data[i];
      line(f.c1x, f.c1y, f.c2x, f.c2y);
      line(f.c2x, f.c2y, f.c3x, f.c3y);
      line(f.c3x, f.c3y, f.c4x, f.c4y);
      line(f.c4x, f.c4y, f.c1x, f.c1y);
  }
}
