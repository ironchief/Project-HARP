
class Arrow{
  PVector block_center;
  float block_width;
  color fill_color;
  
  Arrow(color col, PVector cent, float b_width){
      block_width = b_width;
      block_center = cent;
      fill_color = col;
  }
  
  void draw(){
    fill(fill_color);
    
    // save context
    pushMatrix();
    
    // translate the axes
    translate(block_center.x-block_width/2,block_center.y);

    beginShape();
    vertex(0, 0);
    vertex(0, -20);
    vertex(-10, -20);
    vertex(block_width/2, -45);
    vertex(block_width+10,-20);
    vertex(block_width,-20);
    vertex(block_width,0);
    endShape(CLOSE);
    
    // revert context
    popMatrix();
    
  }  
  
}
