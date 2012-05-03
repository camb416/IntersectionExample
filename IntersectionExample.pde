// intersection implementation
// ported from Ruby
// http://stackoverflow.com/questions/3120357/get-closest-point-to-a-line
// 
// by Cameron Browning

class pt{
  float x;
  float y; 
  
  pt(float x_in, float y_in){
   x = x_in;
  y = y_in; 
  }
}

pt a,b,c;
float prevT;

void setup(){
  size(640,480);
  smooth();
  noStroke();
  a = new pt(320,240);
  b = new pt(320,0);
  c = new pt(0,0);
  frameRate(30);
}

void draw(){
  background(128,136,120);
  
  b.x = cos((float)frameCount/100.0f)*120+320;
  b.y = sin((float)frameCount/100.0f)*120+240;
  a.x = cos((float)frameCount/100.0f+PI)*120+320;
  a.y = sin((float)frameCount/100.0f+PI)*120+240;
  
  c.x += (mouseX-c.x)/2.0f;
  c.y += (mouseY-c.y)/2.0f;
  // line(a.x,a.y,b.x,b.y);
  noFill();
  stroke(255);
  //ellipse(c.x,c.y,10,10);
  
  pt intersect = getClosest(a,b,c);
  fill(192,255,212);
  stroke(212);
  line(c.x,c.y,intersect.x,intersect.y);
  beginShape();
  vertex(c.x,c.y);
  bezierVertex(intersect.x,intersect.y,intersect.x,intersect.y,a.x,a.y);
  vertex(b.x,b.y);
  bezierVertex(intersect.x,intersect.y,intersect.x,intersect.y,c.x,c.y);
  
  endShape();
  noFill();
  stroke(255);
 // ellipse(intersect.x,intersect.y,10,10);
  
}

pt getClosest(pt start,pt end,pt elsewhere){
  
  pt start_to_elsewhere = new pt(elsewhere.x-start.x,elsewhere.y-start.y);
  pt start_to_end = new pt(end.x-start.x,end.y-start.y);
  
  float startend2 = start_to_end.x*start_to_end.x + start_to_end.y*start_to_end.y;
  
  float start_dot_elsewhere = start_to_elsewhere.x*start_to_end.x + start_to_elsewhere.y*start_to_end.y;
  
  float t = start_dot_elsewhere / startend2;
  t = constrain(t,0,1);
  
  t = prevT + (t-prevT)/16.0f;
  prevT = t;
  
  return new pt(start.x+start_to_end.x*t,
                 start.y+start_to_end.y*t);
  
}
