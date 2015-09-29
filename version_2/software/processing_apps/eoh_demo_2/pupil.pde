class PupilDetector
{ 
  float posX;
  float posY;
  float posR;

  //Config params
  float threshold; 
  float minSize;   
  float maxSize;   

  PupilDetector(float tempThreshold, float tempMinSize, float tempMaxSize)
  { 
    threshold = tempThreshold;
    minSize = tempMinSize;
    maxSize = tempMaxSize;
  }

  void setThreshold(float tempThreshold)
  {
    threshold = tempThreshold;
  }

  void setMinSize(float tempMinSize)
  {
    minSize = tempMinSize;
  }

  void setMaxSize(float tempMaxSize)
  {
    maxSize = tempMaxSize;
  }

  boolean detect(Capture img)
  {
    int i, j, k;
    int w, h, wh;
    
    color col;
    float lum;
    
    w = img.width;
    h = img.height;
    wh = w * h;
    
    char mat[] = new char[wh];
    
    float avg, des, level;
    
    // Compute threshold
    avg = 0.0;
    for (i=0; i<wh; i++ )
    {
      avg = avg + brightness(img.pixels[i]);
    }
    avg = avg / wh;
    des = 0.0;
    for (i=0; i<wh; i++ )
    {
      des = des + (avg - brightness(img.pixels[i])) * (avg - brightness(img.pixels[i]));
    }
    des = sqrt(des / wh);
    level = avg - threshold * des; // Threshold factor
      
    // Apply threshold
    for (i=0; i<wh; i++ )
    {
      if(brightness(img.pixels[i]) < level)
      {
        mat[i] = 1;
        //img.pixels[i] = color(0);
      }
      else
      {
        mat[i] = 0;
        //img.pixels[i] = color(255);
      }
    }
  
    // Clean borders
    for(i=0; i<w; i++)
    {
      mat[i] = 0;
      mat[wh-1-i] = 0;
    }
    for(i=0; i<h; i++)
    {
      mat[i*w] = 0;
      mat[i*w+w-1] = 0;
    }
    
    // Reduce noise
    if(w == 320)
    {
      dilate(mat, w, h);
      dilate(mat, w, h);
      erode(mat, w, h);
      erode(mat, w, h);
    }
    else if(w == 640)
    {
      dilate(mat, w, h);
      dilate(mat, w, h);
      dilate(mat, w, h);
      dilate(mat, w, h);
      erode(mat, w, h);
      erode(mat, w, h);
      erode(mat, w, h);
      erode(mat, w, h);
    }
  
    int id;
    int id_size[] = new int[10024];
    float id_x[] = new float[10024];
    float id_y[] = new float[10024];
    
    // Detect groups
    id_size[0] = 0;
    id_size[1] = 0;
    id = 2;
    k = 0;
    for(j=0; j<h; j++)
    {
      for(i=0; i<w; i++)
      {
        if(mat[k++] == 1)
        {
          grow(mat, w, h, i, j, (char)id, id_size, id_x, id_y);
          id++;
        }
      }
    }
    
    // Locate the closest to the center
    int minId = 0;
    float minDis = 1.E15;
    for(i=2; i<id; i++)
    {
      float dis = (id_x[i]-w/2)*(id_x[i]-w/2)+(id_y[i]-h/2)*(id_y[i]-h/2);
      if(dis < minDis && id_size[i] > wh * minSize && id_size[i] < wh * maxSize) // Min/max pupil size factor
      {
        minId = i;
        minDis = dis;
      }
    }
  
    if(minId > 0)
    {
      posX = id_x[minId];
      posY = id_y[minId];
      posR = sqrt(id_size[minId]*4.0/3.14);
      //println(eyeX + " " + eyeY);
      
      // Transform to fit eye camera thumbnail
      posX = posX / 4.0;
      posY = posY / 4.0; //(float) img.height / 4.0 - posY / 4.0;
      posR = posR / 4.0;

      return true;
    }

    return false;
  }
  
  
  void erode(char map[], int w, int h)
  {
    int wh = w * h;
    char map2 [] = new char[wh];
  
    // Clean borders
    for(int i=0; i<w; i++)
    {
      map[i] = 0;
      map[wh-1-i] = 0;
    }
    for(int i=0; i<h; i++)
    {
      map[i*w] = 0;
      map[i*w+w-1] = 0;
    }
    
    // Erode
    int k = 0;
    for(int j=0; j<h; j++)
    {
      for(int i=0; i<w; i++)
      {
        if(map[k]==1 && map[k+1]==1 && map[k-1]==1 && map[k+w]==1 && map[k-w]==1)
        {
          map2[k] = 1;
        }
        else
        {
          map2[k] = 0;
        }
        k++;
      }
    }
    
    for(int i=0; i<wh; i++)
    {
      map[i] = map2[i];
    }
  }
  
  void dilate(char map[], int w, int h)
  {
    int wh = w * h;
    char map2 [] = new char[wh];
    
    // Clean border
    for(int i=0; i<w; i++)
    {
      map[i] = 1;
      map[wh-1-i] = 1;
    }
    for(int i=0; i<h; i++)
    {
      map[i*w] = 1;
      map[i*w+w-1] = 1;
    }
    
    int k = 0;
    for(int j=0; j<h; j++)
    {
      for(int i=0; i<w; i++)
      {
        if(map[k]==1 || map[k+1]==1 || map[k-1]==1 || map[k+w]==1 || map[k-w]==1)
        {
          map2[k] = 1;
        }
        else
        {
          map2[k] = 0;
        }
        k++;
      }
    }
    
    // Clean border
    for(int i=0; i<w; i++)
    {
      map2[i] = 0;
      map2[i+w] = 0;
      map2[wh-1-i] = 0;
      map2[wh-1-i-w] = 0;
    }
    for(int i=0; i<h; i++)
    {
      map2[i*w] = 0;
      map2[i*w+1] = 0;
      map2[i*w+w-1] = 0;
      map2[i*w+w-2] = 0;
    }
    
    for(int i=0; i<wh; i++)
    {
      map[i] = map2[i];
    }
  }
  
  int grow_list[] = new int[1024*1024];
  
  void grow(char map[], int w, int h, int i, int j,
            char id, int id_size[], float id_x[], float id_y[])
  {
    int x, y, p1, p2, cx=0, cy=0;
  
    // Add the fist item to the list
    p1 = i + j * w;
    int size = 1;
    int next = 0;
    grow_list[next] = p1;
  
    // Mark as done
    map[p1] = id; 
  
    while( size > next )
    {
      // Process the first item
      p1 = grow_list[next];
      y = p1 / w;
      x = p1 - y * w;
  
      cx = cx + x;
      cy = cy + y;
  
      // Add not explored neighbors to the list
      p2 = p1 - w;
      if( map[p2] == 1 )
      {
        grow_list[size++] = p2;
        map[p2] = id;
      }
      p2 = p1 + w;
      if( map[p2] == 1 )
      {
        grow_list[size++] = p2;
        map[p2] = id;
      }
      p2 = p1 - 1;
      if( map[p2] == 1 )
      {
        grow_list[size++] = p2;
        map[p2] = id;
      }
      p2 = p1 + 1;
      if( map[p2] == 1 )
      {
        grow_list[size++] = p2;
        map[p2] = id;
      }
  
      // Parse next element
      next++;
    }
  
    id_size[id] = size;
    id_x[id] = (float) cx / (float) size;
    id_y[id] = (float) cy / (float) size;
    
    return;
  }
}
