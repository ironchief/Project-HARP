import ddf.minim.*;
import ddf.minim.signals.*;
import java.util.Vector;
import java.util.Collections;
import java.lang.Math.*;

Rects rects = new Rects(); //wrapper class for rects
Balls balls = new Balls(); //wrapper class for balls

Minim minim = new Minim(this);
Tones tones = new Tones(minim.getLineOut(Minim.STEREO));
AudioPlayer music;

int iter = 1000; //ball drop time

float song_key = 2;
Vector<Double> allowable = allowedStepsForBlues(song_key);
int octaves = 1;
int baseFreq = 600;
int currentLevel = 0;
int score = 0;
boolean latched = false;

ArrayList<Level> levels = new ArrayList<Level>();

Timer timer = new Timer(iter);

AudioRenderer radar;

void setup()
{
  frameRate(60);
  levels.add(new Level(minim, "Assets/Chameleon - Bass,Snare.wav"));
  levels.add(new Level(minim, "Assets/Chameleon - Sax.wav"));
  levels.add(new Level(minim, "Assets/Chameleon Key Solo 1.wav"));
  levels.add(new Level(minim, "Assets/HBFS Clips/HBFS-1-Start-0-04.wav"));
  levels.add(new Level(minim, "Assets/HBFS Clips/HBFS-2-Start-0-20.wav"));
  levels.add(new Level(minim, "Assets/HBFS Clips/HBFS-3-Vocal-0-51.wav"));
  levels.add(new Level(minim, "Assets/HBFS Clips/HBFS-4-Vocal21-07.wav"));
  levels.add(new Level(minim, "Assets/HBFS Clips/HBFS-5-Interlude1-34.wav"));
  levels.add(new Level(minim, "Assets/HBFS Clips/HBFS-6-Reprise-1-53.wav"));
  levels.add(new Level(minim, "Assets/HBFS Clips/HBFS-7-Reprise-2-17.wav"));
  levels.add(new Level(minim, "Assets/HBFS Clips/HBFS-8-Drums-2-40.wav"));
  levels.add(new Level(minim, "Assets/HBFS Clips/HBFS-9-Chorus-3-03.wav"));
  levels.add(new Level(minim, "Assets/HBFS Clips/HBFS-10-Chorus-3-11.wav"));
  levels.add(new Level(minim, "Assets/HBFS Clips/HBFS-11-Spasm-3-19.wav"));
  levels.add(new Level(minim, "Assets/HBFS Clips/HBFS-12-End-3-34.wav"));
  size(1024, 768, P3D);
  colorMode(HSB,360);
  noStroke();
  music = levels.get(currentLevel).snippet;
  timer.start();
  radar = new RadarRenderer(music);
  music.addListener(radar);
  radar.setup();
}

void draw()
{
  background(50);
  radar.draw();
  colorMode(HSB,360);
  if(!music.isPlaying())
  {
    if(score > levels.get(currentLevel).reqScore())
    {
      currentLevel++;
      rects.clear();
    }
    score = 0;
    levels.get(currentLevel).resetBalls();
    music = levels.get(currentLevel).snippet;
    music.play(0);
    music.addListener(radar);
  }
  if(timer.isFinished())
  {
    balls.add(levels.get(currentLevel).nextBall());
    timer.start();
  }
  fill(360);
  text("Level: " + currentLevel,10,20);
  text("Score: " + score,10,40);
  rects.draw(mouseX, mouseY);
  balls.draw();
  balls.removeCollisions(rects,tones);
  tones.removeDeadTones();
  if(mousePressed)
  {
    if(!latched && mouseEvent.getClickCount() != 2) //if we double clicked a box
    {
      if(rects.isClicked(mouseX,mouseY))
      {
        rects.latch(mouseX, mouseY);
        latched = true;
      }
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
