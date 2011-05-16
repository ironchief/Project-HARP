Rects rects = new Rects(); //wrapper class for rects
Balls balls = new Balls(); //wrapper class for balls

void setup()
{
  size(800, 600);
}

void draw()
{
  background(255);
  rects.draw(mouseX, mouseY);
  balls.draw();
}

void mousePressed()
{
  balls.add(mouseX, mouseY + 40);
  if (!rects.isClicked(mouseX, mouseY)) //if you're not clicking on a box
  {
    rects.add(mouseX, mouseY); //add one
  }
  else
  {
    if (mouseEvent.getClickCount() == 2) //if we double clicked a box
    {
      rects.removeAt(mouseX, mouseY); //delete it
    }
    else
    {
      rects.latch(mouseX, mouseY); //otherwise latch (or unlatch) the box for moving
    }
  }
}

class Balls {
  ArrayList data;
  Balls() {
    data = new ArrayList();
  }
  
  void add(PVector center)
  {
    data.add(new Ball(center));
  }
  
  void add(float x, float y)
  {
    add(new PVector(x,y));
  }
  
  void draw()
  {
    for(int i = 0; i < data.size(); ++i)
    {
      Ball temp = (Ball)data.get(i);
      if(rects.collide(temp))
      {
        data.remove(i);
      }
      else if(!temp.onScreen())
      {
        data.remove(i);
      }
      else
      {
        temp.draw();
      }
    }
  }
}

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
    ellipse(center.x,center.y,diameter,diameter);
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

class Rects {
  ArrayList data;
  boolean latched;
  MRect moving;

  Rects() {
    data = new ArrayList();
    latched = false;
  }

  void latch(float x, float y)
  {
    if (!latched)
    {
      moving = getCollider(x, y); //keep track of the box we're moving
      latched = true;
    }
    else
    {
      latched = false;
    }
  }

  void add(PVector center)
  {
    data.add(new MRect (center));
  }

  void add(float x, float y)
  {
    add(new PVector (x, y));
  }

  void draw(float x, float y)
  {
    if (latched)
    {
      moving.moveTo(x, y);
    }
    for (int i = 0; i < data.size(); ++i)
    {
      ((MRect)data.get(i)).draw();
    }
  }

  int getColliderIndex(float x, float y)
  {
    for (int i = 0; i < data.size(); ++i)
    {
      if (((MRect)data.get(i)).overlaps(x, y))
      {
        return i;
      }
    }
    return -1;
  }

  boolean isClicked(float x, float y)
  {
    return getColliderIndex(x, y) == -1 ? false : true;
  }

  void removeAt(float x, float y)
  {
    int i = getColliderIndex(x, y);
    if (i != -1) data.remove(i);
  }

  MRect getCollider(float x, float y)
  {
    return (MRect)data.get(getColliderIndex(x, y));
  }
  
  boolean collide(Ball ball)
  {
    return isClicked(ball.center.x,ball.center.y);
  }
}

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
