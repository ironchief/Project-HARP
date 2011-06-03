class Level {
  String path;
  AudioSnippet snippet;
  ArrayList<Integer> balls;
  int currentBall;
  
  Level(Minim minim, String _path)
  {
    path = _path;
    snippet = minim.loadSnippet(path);
//    snippet.setVolume(1000);
    balls = new ArrayList<Integer>();
    for(int i = 0; i < snippet.length()/iter+1; ++i)
    {
      balls.add((int)random(0,800));
    }
    resetBalls();
  }
  
  PVector nextBall()
  {
    currentBall++;
    return new PVector(balls.get(currentBall - 1),0);
  }
  
  void resetBalls()
  {
    currentBall = 0;
  }
}
