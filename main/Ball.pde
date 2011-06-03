class Ball {
  PVector center;
  PVector velocity;
  PVector gravity;
  int diameter = 5;
  
  Ball(PVector _center)
  {
    center = _center;
    velocity = new PVector(0,0);
    gravity = new PVector(0,.49);
  }
  
  void draw()
  {
    fall();
    fill(360);
    ellipse(center.x,center.y,diameter,diameter);
    noFill();
  }
  
  void fall()
  {
    velocity.add(gravity);
    center.add(velocity);
  }
  
  boolean onScreen()
  {
    return !(center.x < 0 || center.x > width || center.y < 0 || center.y > height);
  }
  
}
