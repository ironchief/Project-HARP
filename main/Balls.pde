class Balls {
  ArrayList<Ball> data;
  Balls() {
    data = new ArrayList<Ball>();
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
      Ball temp = data.get(i);
      temp.draw();
    }
  }
  
  void removeCollisions(Rects rects,Tones tones)
  {
    for(int i = 0; i < data.size(); ++i)
    {
      Ball temp = data.get(i);
      if(rects.collide(temp))
      {
        MRect tempR = rects.getCollider(temp);
        int score = 3;
        tempR.fillRect(90*(6-score)/6);
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
