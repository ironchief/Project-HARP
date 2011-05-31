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
      temp.draw();
    }
  }
  
  void removeCollisions(Rects rects,Tones tones)
  {
    for(int i = 0; i < data.size(); ++i)
    {
      Ball temp = (Ball)data.get(i);
      if(rects.collide(temp))
      {
        MRect tempR = rects.getCollider(temp);
        tones.addTone(tempR);
        data.remove(i);
      }
      else if(!temp.onScreen())
      {
        data.remove(i);
      }
    }
  }
}
