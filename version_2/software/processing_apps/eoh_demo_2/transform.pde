class Transform
{ 
  float forward[] = new float[8];
  float back[]    = new float[8];
  
  Transform()
  {
  }
  
  void setFrame(FiducialDetector f, int i1, int i2, int i3, int i4)
  {
    Fiducial f1 = f.data[i1];
    Fiducial f2 = f.data[i2];
    Fiducial f3 = f.data[i3];
    Fiducial f4 = f.data[i4];
    
    float px[] = { f1.c1x-1, 0, f2.c2x+1, width,  f4.c3x+1, width,  f3.c4x-1,      0};
    float py[] = { f1.c1y-1, 0, f2.c2y-1,      0, f4.c3y+1, height, f3.c4y+1, height};
    
    perspective_coefs(px, py, back);
    perspective_invert(forward, back);
  }
  
  void drawImage(PImage img, PImage out)
  {
    float p1[] = new float[2];
    float q1[] = new float[2];

    int k=0;
    for (int y=0; y<img.height; y++ )
    {
      for (int x=0; x<img.width; x++ )
      {          
        p1[0] = x; p1[1] = y;
        perspective_project(p1, q1, back);
        if(q1[0]>=0 && q1[0]<out.width && q1[1]>=0 && q1[1]<out.height)
        {
          out.pixels[(int)q1[0]+(int)q1[1]*out.width] = img.pixels[k];
        }
        k++;
      }
    }
  }
  
  void drawLine(float x1, float y1, float x2, float y2)
  {
    float p1[] = new float[2];
    float p2[] = new float[2];
    float q2[] = new float[2];
    float q1[] = new float[2];
    
    p1[0] = x1;
    p1[1] = y1;
    
    p2[0] = x2;
    p2[1] = y2;

    perspective_project(p1, q1, back);
    perspective_project(p2, q2, back);
    
    line(q1[0], q1[1], q2[0], q2[1]);
  }
  
  void perspective_project(float p1[], float q1[], float u[])
  {
    float x1, y1, x2, y2, rr;
    
    x1 = p1[0];
    y1 = p1[1];
    
    rr = u[6] * x1 + u[7] * y1 + 1.0;
    
    x2 = (u[0] * x1 + u[1] * y1 + u[2]) / rr;
    y2 = (u[3] * x1 + u[4] * y1 + u[5]) / rr;
    
    q1[0] = x2;
    q1[1] = y2;
  }
  
  void perspective_invert(float i[], float v[])
  {
    float det = perceptible_reciprocal(v[0]*v[4]-v[3]*v[1]);
    i[0] = det*(v[4]-v[7]*v[5]);
    i[1] = det*(v[7]*v[2]-v[1]);
    i[2] = det*(v[1]*v[5]-v[4]*v[2]);
    i[3] = det*(v[6]*v[5]-v[3]);
    i[4] = det*(v[0]-v[6]*v[2]);
    i[5] = det*(v[3]*v[2]-v[0]*v[5]);
    i[6] = det*(v[3]*v[7]-v[6]*v[4]);
    i[7] = det*(v[6]*v[1]-v[0]*v[7]);
  }
  
  void perspective_coefs(float px[], float py[], float u[])
  {
    int i, j;
    float m[][] = new float[8][8];
    float v[] = new float[8];
    
    for(j=0; j<8; j++)
    {
      for(i=0; i<8; i++)
      { 
        m[i][j] = 0.0;
      }
      u[j] = 0.0;
    }  
    
    for(i=0; i<4; i++)
    {
      v[0] = px[i*2+1];
      v[1] = py[i*2+1];
      v[2] = 1.0;
      v[3] = 0.0;
      v[4] = 0.0;
      v[5] = 0.0;
      v[6] = -px[i*2]*px[i*2+1];
      v[7] = -px[i*2]*py[i*2+1];
      
      add_gauss(m, u, v, px[i*2]);
      
      v[0] = 0.0;
      v[1] = 0.0;
      v[2] = 0.0;
      v[3] = px[i*2+1];
      v[4] = py[i*2+1];
      v[5] = 1.0;
      v[6] = -py[i*2]*px[i*2+1];
      v[7] = -py[i*2]*py[i*2+1];
      
      add_gauss(m, u, v, py[i*2]);
    }
    
    solve_gauss(m, u);
  }
  
  void add_gauss(float m[][], float u[], float v[], float x)
  {
    int i, j;
    
    for(j=0; j<8; j++)
    {
      for(i=0; i<8; i++)
      { 
        m[i][j] = m[i][j] + v[i] * v[j];
      }
      u[j] = u[j] + v[j] * x;
    }
  }
  
  float perceptible_reciprocal(float x)
  {
    float sign;
  
    sign = x < 0.0 ? -1.0 : 1.0;
    if ((sign*x) >= 1.E-7)
      return(1.0/x);
  
    return(sign/1.E-7);
  }
  
  void solve_gauss(float m[][], float u[])
  {
    float max, scale;
    int i, j, k;
    int column, row;
    int columns[] = {0,0,0,0,0,0,0,0};
    int rows[]    = {0,0,0,0,0,0,0,0};
    int pivots[]  = {0,0,0,0,0,0,0,0};
    
    column = 0;
    row = 0;
    for(i=0; i<8; i++)
    {
      max = 0.0;
      for(j=0; j<8; j++)
      {
        if (pivots[j] != 1)
        {
          for(k=0; k<8; k++)
          {
            if (pivots[k] != 0)
            {
              if (pivots[k] > 1)
              {
                return;
              }
            }
            else if (abs(m[j][k]) >= max)
            {
              max = abs(m[j][k]);
              row = j;
              column = k;
            }
          }
        }
      }
      
      pivots[column]++;
      if (row != column)
      {
        for(k=0; k<8; k++)
        {
          if(m[row][k] != m[column][k])
          {
            m[row][k]    = m[row][k] + m[column][k];
            m[column][k] = m[row][k] - m[column][k];
            m[row][k]    = m[row][k] - m[column][k];
          }
        }
        if(u[row] != u[column])
        {
          u[row]    = u[row] + u[column];
          u[column] = u[row] - u[column];
          u[row]    = u[row] - u[column];
        }
      }
  
      rows[i]=row;
      columns[i]=column;
      
      if (m[column][column] == 0.0)
      {
        return;
      }
      
      scale = perceptible_reciprocal(m[column][column]);
      m[column][column] = 1.0;
      
      for (j=0; j<8; j++)
      {
        m[column][j] *= scale;
      }
      u[column] *= scale;
      for (j=0; j<8; j++)
      {
        if (j != column)
        {
          scale = m[j][column];
          m[j][column] = 0.0;
          for (k=0; k<8; k++)
          {
            m[j][k] -= scale * m[column][k];
          }
          u[j] -= scale * u[column];
        }
      }
    }
      
    for (j=7; j>=0; j--)
    {
      if (columns[j] != rows[j])
      {
        for (i=0; i<8; i++)
        {
          if(m[i][rows[j]] != m[i][columns[j]])
          {
            m[i][rows[j]]    = m[i][rows[j]] + m[i][columns[j]];
            m[i][columns[j]] = m[i][rows[j]] - m[i][columns[j]];
            m[i][rows[j]]    = m[i][rows[j]] - m[i][columns[j]];
          }
        }
      }
    }
  }
}
