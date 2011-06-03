import ddf.minim.*;
import ddf.minim.signals.*;
import java.util.Vector;
import java.util.Collections;
import java.lang.Math.*;

Rects rects = new Rects(); //wrapper class for rects
Balls balls = new Balls(); //wrapper class for balls
Tones tones;

Minim minim;
Vector<AudioSnippet> music;
AudioSnippet currentLevel;

float song_key = 1;
Vector<Double> allowable = allowedStepsForBlues(song_key);
int octaves = 2;
int baseFreq = 220;
int level = 0;
float score = 0;
boolean latched = false;

ArrayList<String> levels;

void setup()
{
  levels = new ArrayList<String>();
  levels.add("Assets/Chameleon - Sax.wav");
  size(800, 600);
  colorMode(HSB,360);
  noStroke();
  minim = new Minim(this);
  tones = new Tones(minim.getLineOut(Minim.STEREO));
  currentLevel = minim.loadSnippet(levels.get(level));
}

void draw()
{
  if(!currentLevel.isPlaying())
  {
    score = 0;
    currentLevel.play(0);
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
