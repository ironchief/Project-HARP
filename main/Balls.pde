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
      Ball ball = data.get(i);
      ball.draw();
    }
  }
  
  void removeCollisions(Rects rects,Tones tones)
  {
    for(int i = 0; i < data.size(); ++i)
    {
      Ball ball = data.get(i);
      if(rects.collide(ball))
      {
        //retrieve the rectangle it collided with
        MRect rect = rects.getCollider(ball);
        //retrieve the score for the rectangle
        float newScore = tones.addTone(rect);
        if(newScore<(float)0){      
          rect.arrow_direction = 1; 
        }else{ 
          rect.arrow_direction = -1; 
        }
        print("\n");
        newScore = 6 - min(1/pow(newScore,1.5),6);
        score += (int)(Math.abs(newScore) * 100/6);
        //color the rectangle based on its score
        rect.fillRect(Math.abs(120*newScore/6));

        //remove the ball
        data.remove(i);
      }
      else if(!ball.onScreen())
      {
        data.remove(i);
      }
    }
  }
}
