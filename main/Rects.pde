class Rects {
  ArrayList<MRect> data;
  boolean latched;
  MRect moving;

  Rects() {
    data = new ArrayList<MRect>();
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
      data.get(i).draw();
    }
  }

  int getColliderIndex(float x, float y)
  {
    for (int i = 0; i < data.size(); ++i)
    {
      if ((data.get(i)).overlaps(x, y))
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
    return data.get(getColliderIndex(x, y));
  }

  MRect getCollider(Ball ball)
  {
    return data.get(getColliderIndex(ball.center.x, ball.center.y));
  }
  
  boolean collide(Ball ball)
  {
    return isClicked(ball.center.x,ball.center.y);
  }
}
