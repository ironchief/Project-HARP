Rects rects = new Rects(); //wrapper class for rects
Balls balls = new Balls(); //wrapper class for balls

void setup()
{
  size(800, 600);
}

void draw()
{
  background(255);
  rects.draw(mouseX, mouseY);
  balls.draw();
  balls.removeCollisions(rects);
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
