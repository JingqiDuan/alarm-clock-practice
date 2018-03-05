import controlP5.*;
ControlP5 cp5;
import processing.sound.*;


//for the text fields
String textValue = "";
String getHour, getMinute, getSecond;
int setHour, setMinute, setSecond;
//PFont alarmFont;
SoundFile alarmSound;
//alarm
boolean callOnce= false;
boolean showText= false;
boolean snoozeText = false;
boolean offAlarm = false;
boolean playingAlarm = false;
float currentVolume = 0;

int timeStartPlayingAlarm;
int theCount = 0;

//String alarmSoundFile = "alarm-clock.wav";
String alarmSoundFile = "alarmPurpleRain.wav";
//second pointer

float secondsRadius;
float randR, randG, randB, randD;
float randR2, randG2, randB2, randD2;
float randR3, randG3, randB3, randD3;
float textX, textY;
//
int x, y, i, k;
PFont f;
//rain
Drop[] drops = new Drop[400];

//-----task1---------------
PImage arrow;
PImage heart;
int arrowX, arrowY;
int heartX = 365, heartY = 354;
int displacementX = 0, displacementY = 0;

//------task2---------------------
PImage umbrella;
PImage girl;
int umbrellaX, umbrellaY;
int currentumbrella = 0;
int girlX=400, girlY=450;
int displacement2X = 0, displacement2Y = 0;

void setup()
{
  //frameRate(35); 
  size(600, 800);
  x=width/2;
  y=height/4;
  smooth();
  f = createFont("HelveNueThin", 55);
  textFont(f);
  //sound
  //alarmFont = createFont("Helvetica", 30);
  //textFont(alarmFont);
  textAlign(CENTER, CENTER);

  secondsRadius = 150;
  //text field--
  PFont font = createFont("arial", 15);

  //alarm------------------------
  alarmSound = new SoundFile(this, alarmSoundFile);

  cp5 = new ControlP5(this);
  cp5.addTextfield("HUR")
    .setPosition(width/2-60, height/3+120)
    .setSize(35, 30)
    .setFont(font)
    .setAutoClear(false)
    //.setColor(color(255, 0, 0))
    ;

  cp5.addTextfield("MIN")
    .setPosition(width/2-20, height/3+120)
    .setSize(35, 30)
    .setFont(font)
    .setAutoClear(false)
    // .setColor(color(255, 0, 0))
    ;

  cp5.addTextfield("SEC")
    .setPosition(width/2+20, height/3+120)
    .setSize(35, 30)
    .setFont(font)
    .setAutoClear(false)
    // .setColor(color(255, 0, 0))
    ;

  cp5.addBang("set")
    .setPosition(width/2+60, height/3+120)
    .setSize(60, 30)
    .setFont(font)
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    ;

  cp5.addBang("clear")
    .setPosition(width/2-125, height/3+120)
    .setSize(60, 30)
    .setFont(font)
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    ;

cp5.addBang("snooze")
    .setPosition(width/2-130, height/3+120)
    .setSize(250, 60)
    .setFont(f)
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    ;
    

  //rain
  for (int i=0; i <drops.length; i++) {
    drops[i] = new Drop();
  }
  //----------task1------------
  imageMode(CENTER);  
  arrowX=int(random(width));
  arrowY=int(random(height));
  heart = loadImage("heart.png");
  arrow = loadImage("arrow.png");
  //----------task2------------
  umbrellaX=int(random(width));
  umbrellaY=int(random(height));
  umbrella = loadImage("theUmbrella.png");
  girl = loadImage("girl.png");
}

void set() {

  getHour = cp5.get(Textfield.class, "HUR").getText();
  getMinute = cp5.get(Textfield.class, "MIN").getText();
  getSecond = cp5.get(Textfield.class, "SEC").getText();
  setHour = int(getHour);
  setMinute = int(getMinute);
  setSecond = int(getSecond);
  showText= true;
  callOnce = true;
  //playingAlarm = true;
}

//----------------------snooz=======================================
void snooze() {
  getHour = cp5.get(Textfield.class, "HUR").getText();
  getMinute = cp5.get(Textfield.class, "MIN").getText();
  getSecond = cp5.get(Textfield.class, "SEC").getText();
  setHour = int(getHour);
  setMinute = int(getMinute);
  setSecond = int(getSecond);
  playingAlarm = false;
  currentVolume = 0;
  alarmSound.amp(currentVolume);
  snoozeText = true;
  theCount=0;
  if(theCount == 3&&currentVolume<0.1)
  {
    callOnce = true;
    setSecond = int(getSecond+30);
    
  }

}

void clear() {
  cp5.get(Textfield.class, "HUR").clear();
  cp5.get(Textfield.class, "MIN").clear();
  cp5.get(Textfield.class, "SEC").clear();
  //also decline the alarm setting

  offAlarm = true;
  
  callOnce = true;
  showText= false;
}

void alarming() {

  if (playingAlarm) 
  {
    timeStartPlayingAlarm = millis();
    alarmSound.cue(0);
    alarmSound.amp(min(currentVolume, 1));
    alarmSound.loop();
    theCount+=1;
  }
}

//---------task1-------------
void arrowOverTarget()
{

  if (abs(arrowX-heartX)<40&& abs(arrowY-heartY)<40)
  {
    theCount+=1;
    println("Got her!");
  }
}

void moveArrow()
{
  if (abs(mouseX-arrowX)<=30&&abs(mouseY-arrowY)<=30)
  {
    arrowX = mouseX;
    arrowY = mouseY;
  }
}

//-----------task2------------------
void umbrellaOverTarget()
{
  if (abs(umbrellaX-girlX)<60&& abs(umbrellaY-girlY)<60)
  {
    theCount+=1;
    println("got it again");
  }
}



void keyPressed()
{
  if (key==CODED)
  {
    switch(keyCode)
    {
    case UP:
      displacement2X = 0;
      displacement2Y = -10;
      break;
    case DOWN:
      displacement2X = 0;
      displacement2Y = 10;
      break;
    case LEFT:
      displacement2X = -10;
      displacement2Y = 0;
      break;
    case RIGHT:
      displacement2X = 10;
      displacement2Y = 0;
      break;
    }
  }

  moveUmbrella();
}

void moveUmbrella()
{
  umbrellaX += displacement2X;
  umbrellaY += displacement2Y;
  displacement2X = 0;
  displacement2Y = 0;
}

void draw()
{

  background(0);
  float s = map(second(), 0, 60, 0, TWO_PI) - HALF_PI;
  int m = minute();
  int h = hour();

  //alarm
  if (setHour == hour()&&setMinute == minute()&&setSecond== second())
  {
    playingAlarm = true; //got command here. 
    // call one time
    if (callOnce)
    {
      alarming();

      callOnce = false;
    }
    //if (callOnceMore)
      //{
      //  alarming();
      //  callOnce = false;
     // }
  }


  // volume of alarm
  if(theCount<=1)
  {
    if (playingAlarm && (currentVolume<10)) 
    {
      alarmSound.amp(currentVolume);
      currentVolume += 0.04;
      println("Current volume: "+currentVolume);
    } 
  }
  //rain
  for (int i=0; i <drops.length; i++) {
    drops[i].fall();
    drops[i].show();
  }


  randR = random(255);
  randG = random(255);
  randB = random(255);
  randR2 = random(255);
  randG2 = random(255);
  randB2 = random(255);
  randR3 = random(255);
  randG3 = random(255);
  randB3 = random(255);

  randD = random(290, 320);
  randD2 = random(250, 290);
  randD3 = random(190, 240);

  textX = random(width/2-5, width/2+5);
  textY = random(y-85, y-75);

  if(snoozeText==false)
  {
  if (showText==true) 
  {
   
    if (m<10)
    {
      textSize(45);
      text("Alarm clock at: "+setHour+":0"+setMinute+":"+setSecond, width / 2, height / 2+150);
    } else {
      textSize(45);
      text("Alarm clock at: "+setHour+":"+setMinute+":"+setSecond, width / 2, height / 2+150);
    }
  } else {
    textSize(45);
    text("Set your wake-up time", width / 2, height / 2+150);
    }
  }

  if(snoozeText==true)
  {
    textSize(35);
    fill(#737176);
    text("Snoozed!\nYou will be re-alarmed\nin 8 minutes!",width/2, height/2+200);
  }



  //---------draw out circle---------------
  noStroke();
  fill(randR, randG, randB);
  ellipse(x, y, randD, randD);
  //---------draw out circle---------------
  noStroke();
  fill(randR2, randG2, randB2);
  ellipse(x, y, randD2, randD2);
  //---------draw out circle---------------
  noStroke();
  fill(randR3, randG3, randB3);
  ellipse(x, y, randD3, randD3);
  //----------second--------------

  stroke(24, 24, 100);
  strokeWeight(10);
  line(x, y, x + cos(s) * secondsRadius, y + sin(s) * secondsRadius);
  //////////////////
  //-----------inner circle-------------
  fill(24, 24, 100);
  noStroke();
  ellipse(x, y, 150, 150);
  //------------------------
  fill(255);
  textAlign(CENTER);
  textSize(55);
  if (m<10)
  {
    textSize(55);
    text(h+":0"+m, x, y+20);
  } else {
    textSize(55);
    text(h+":"+m, x, y+20);
  }
  
      // volume of alarm for snoozes
    if (theCount>1&&theCount<3)
    {
      if (playingAlarm && (currentVolume>2))
      {
        alarmSound.amp(min(currentVolume, 1));
        currentVolume -= 0.04;
        if (currentVolume<2)
        {
          currentVolume = 0.4;
        }
        println("Current volume: "+currentVolume);
      }
    }
    
  if (theCount<=2)
  {
   cp5.get("snooze").hide(); 
  }else
    {
      cp5.get("snooze").show();
    }
  //-----------------------first task-------------------
  if (playingAlarm==true&&theCount==1)
  {
    background(0);
    //rain
    for (int i=0; i <drops.length; i++) 
    {
      drops[i].fall();
      drops[i].show();
    }
    //hide textfields
    cp5.get("HUR").hide();
    cp5.get("MIN").hide();
    cp5.get("SEC").hide();
    cp5.get("clear").hide();
    cp5.get("set").hide();
    cp5.get("snooze").hide();
    textSize(85);
    fill(randR, randG, randB);
    text("WAKE UP\n&\nGET LOVE", textX, textY);
    textSize(35);
    fill(#737176);
    text("My love is like a arrow\nto your heart\n(use mouse)", width/2, height/2+200);

    // draw targets
    heart.resize(35, 35);
    image(heart, heartX, heartY);
    //draw arrow
    arrow.resize(80, 80);
    image(arrow, arrowX, arrowY);
    arrowOverTarget();
    if (mousePressed)
    {
      moveArrow();
    }



  } 

  //--------task2------------------
  if (playingAlarm==true&&theCount==2)
  {
    background(#3A0676);
    //rain
    for (int i=0; i <drops.length; i++) 
    {
      drops[i].fall();
      drops[i].show();
    }

    //hide textfields
    cp5.get("HUR").hide();
    cp5.get("MIN").hide();
    cp5.get("SEC").hide();
    cp5.get("clear").hide();
    cp5.get("set").hide();
    cp5.get("snooze").hide();
    
    textSize(85);
    fill(randR, randG, randB);
    text("Congrats!\nAlmost awake!", textX, textY);

    textSize(35);
    fill(#737176);
    text("You know how\nto be a gentleman\n(use keyboard)", width/2, height/2+200);

    // draw the girl
    girl.resize(70, 70);
    image(girl, girlX, girlY);
    //draw umbrella
    umbrella.resize(100, 100);
    image(umbrella, umbrellaX, umbrellaY);
    umbrellaOverTarget();
  }
  
  if (playingAlarm==true&&theCount==3)
  {
    background(#FF7D03);
    //rain
    for (int i=0; i <drops.length; i++) 
    {
      drops[i].fall();
      drops[i].show();
    }
    setSecond = int(getSecond+30);
    
  }

  println("theCount: "+theCount);
  println("Current volume: "+currentVolume);
}