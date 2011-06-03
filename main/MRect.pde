class MRect {
  int width = 60;
  int height = 20;
  int fillTime = 50;
  int arrow_direction;
  PVector center;
  float hue;
  int saturation;
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
    if(filled && saturation > 0)
    {
      Arrow arrow = new Arrow(color(hue,saturation,360,100),this);
      arrow.arrow_direction = this.arrow_direction;
      arrow.draw();
      fill(hue,saturation,360);
      saturation = saturation - (360 / fillTime);
    }
    else
    {
      fill(360);
      filled = false;
    }
    rect(center.x, center.y, width, height);
  }
  
  //returns true if the rectangle overlaps point x,y
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
  
  void fillRect(float _hue)
  {
    filled = true;
    hue = _hue;
    saturation = 360;
  }
}
