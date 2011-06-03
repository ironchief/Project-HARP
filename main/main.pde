import ddf.minim.*;
import ddf.minim.signals.*;
import java.util.Vector;
import java.util.Collections;
import java.lang.Math.*;

Rects rects = new Rects(); //wrapper class for rects
Balls balls = new Balls(); //wrapper class for balls

Minim minim = new Minim(this);
Tones tones = new Tones(minim.getLineOut(Minim.STEREO));
AudioSnippet music;

int iter = 500; //ball drop time

float song_key = 1;
Vector<Double> allowable = allowedStepsForBlues(song_key);
int octaves = 2;
int baseFreq = 220;
int currentLevel = 0;
float score = 0;
boolean latched = false;

ArrayList<Level> levels = new ArrayList<Level>();

Timer timer = new Timer(iter);

void setup()
{
  levels.add(new Level(minim, "Assets/Chameleon - Sax.wav"));
  size(800, 600);
  colorMode(HSB,360);
  noStroke();
  music = levels.get(currentLevel).snippet;
  timer.start();
}

void draw()
{
  if(!music.isPlaying())
  {
    score = 0;
    levels.get(currentLevel).resetBalls();
    music.play(0);
  }
  if(timer.isFinished())
  {
    balls.add(levels.get(currentLevel).nextBall());
    timer.start();
  }
  background(50);
  fill(360);
  text("Score: " + score,10,20);
  rects.draw(mouseX, mouseY);
  balls.draw();
  balls.removeCollisions(rects,tones);
  tones.removeDeadTones();
  if(mousePressed)
  {
    if(!latched && mouseEvent.getClickCount() != 2) //if we double clicked a box)
    {
      rects.latch(mouseX, mouseY);
      latched = true;
    }
  }
  else if(latched)
  {
    rects.latch(mouseX, mouseY);
    latched = false;
  }
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
//      rects.latch(mouseX, mouseY); //otherwise latch (or unlatch) the box for moving
    }
  }
}


class Timer {
 
  int savedTime; // When Timer started
  int totalTime; // How long Timer should last
  
  Timer(int tempTotalTime) {
    totalTime = tempTotalTime;
  }
  
  // Starting the timer
  void start() {
    // When the timer starts it stores the current time in milliseconds.
    savedTime = millis(); 
  }
  
  // The function isFinished() returns true if 5,000 ms have passed. 
  // The work of the timer is farmed out to this method.
  boolean isFinished() { 
    // Check how much time has passed
    int passedTime = millis()- savedTime;
    if (passedTime > totalTime) {
      return true;
    } else {
      return false;
    }
  }
}
