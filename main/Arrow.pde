
class Arrow{
  PVector block_center;
  float block_width;
  float block_height;
  color fill_color;
  int arrow_direction;
  
  Arrow(color col, MRect r){
      block_width = r.width;
      block_height = r.height;
      block_center = r.center;
      fill_color = col;
  }
  
  void draw(){
    fill(fill_color);
    noStroke();
    // save context
    pushMatrix();
    
    // translate the axes
    translate(block_center.x-block_width/2,block_center.y);

    beginShape();
    vertex(0, 0);
    vertex(0, arrow_direction*20);
    vertex(-10, arrow_direction*20);
    vertex(block_width/2, arrow_direction*45);
    vertex(block_width+10,arrow_direction*20);
    vertex(block_width,arrow_direction*20);
    vertex(block_width,0);
    endShape(CLOSE);
    
    // revert context
    popMatrix();
    
  }  
  
}
