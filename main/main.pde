import ddf.minim.*;
import ddf.minim.signals.*;

Rects rects = new Rects(); //wrapper class for rects
Balls balls = new Balls(); //wrapper class for balls
Tones tones;

Minim minim;

void setup()
{
  size(800, 600);
  minim = new Minim(this);
  tones = new Tones(minim.getLineOut(Minim.STEREO));
}

void draw()
{
  background(255);
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
