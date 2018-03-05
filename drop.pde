class Drop{
  float x = random(width);
  float y = random(-500,200);
  float z = random(0,20);
  float yspeed =map(z,0,20,4,10);
  float len = map(z,0,20,10,20);
  
  void fall(){
    y = y + yspeed;
    yspeed = yspeed + 0.2;
    if (y>height){
      y = random(-200,-100);
      yspeed = map(z,0,20,4,10);
    }
  }
  
  void show (){
    float thick = map(z,0,20,1,2);
    strokeWeight(thick);
    stroke(138,43,226);
    line(x,y,x,y+len);
  }
  
}