class MRect {
  int width = 60;
  int height = 20;
  PVector center;

  MRect(PVector _center)
  {
    center = _center;
  }
  void draw()
  {
    rectMode(CENTER);
    rect(center.x, center.y, width, height);
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
}
