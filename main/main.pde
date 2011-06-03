import ddf.minim.*;
import ddf.minim.signals.*;
import java.util.Vector;
import java.util.Collections;
import java.lang.Math.*;

Rects rects = new Rects(); //wrapper class for rects
Balls balls = new Balls(); //wrapper class for balls
Tones tones;

Minim minim;
AudioSnippet level1;

double song_key = 1;
Vector<Double> allowable = allowedStepsForBlues(song_key);
int octaves = 2;
int baseFreq = 220;
int level = 1;
float score = 0;

void setup()
{
  size(800, 600);
  colorMode(HSB,360);
  noStroke();
  minim = new Minim(this);
  tones = new Tones(minim.getLineOut(Minim.STEREO));
  level1 = minim.loadSnippet("Assets/Chameleon - Sax.wav");
  level1.play();
}

void draw()
{
  background(50);
  fill(360);
  rects.draw(mouseX, mouseY);
  balls.draw();
  balls.removeCollisions(rects,tones);
  tones.removeDeadTones();
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
