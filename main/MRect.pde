class MRect {
  int width = 60;
  int height = 20;
  int fillLong = 50;
  PVector center;
  int hue;
  int saturation;
  int fillTime;
  boolean filled;

  MRect(PVector _center)
  {
    center = _center;
    filled = false;
  }
  
  void draw()
  {
    rectMode(CENTER);
    colorMode(HSB);
    if(filled && fillTime > 0)
    {
      fill(hue,saturation,360);
      fillTime--;
      saturation = saturation - (360 / fillLong);
    }
    else
    {
      filled = false;
    }
    rect(center.x, center.y, width, height);
    noFill();
  }

  boolean overlaps(float x, float y)
  {
    return !((x < center.x - width/2) || (x > center.x + width/2) || (y < center.y - width/2) || (y > center.y + width/2));
  }

  void moveTo(PVector newCenter)
  {
    center = newCenter;
  }

  void moveTo(float x, float y)
  {
    moveTo(new PVector(x, y));
  }
  
  void fillRect(int _hue)
  {
    filled = true;
    hue = _hue;
    saturation = 360;
    fillTime = fillLong;
  }
}
