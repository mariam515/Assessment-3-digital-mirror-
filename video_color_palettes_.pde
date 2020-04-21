
import generativedesign.*;
import processing.pdf.*;
import java.util.Calendar;

import processing.video.*;
Capture video;


color[] colors;
String sortMode = null;

void setup (){

 size(600, 500);
  background(0); 
  
video = new Capture (this,640,480);
video.start();

}

void captureEvent(Capture video){
video.read();

} 



void draw(){
int tileCount = width / max(mouseX,4);
float rectSize = width / float(tileCount);

int i = 0 ;
colors = new color [tileCount*tileCount];
 for ( int gridY=0; gridY <tileCount; gridY ++){
   for ( int gridX=0; gridX <tileCount; gridX ++){
     
   int px= (int) (gridX*rectSize );
   int py = (int)(gridY*rectSize );
   colors [i] = video.get (px, py);
   i++;
   }
   
 }
 
 if (sortMode != null) colors = GenerativeDesign.sortColors(this , colors , sortMode);
 i=0 ;
 for ( int gridY=0; gridY <tileCount; gridY ++){
 for ( int gridX=0; gridX <tileCount; gridX ++){
   fill (colors[i]);
   
   rect(gridX*rectSize, gridY*rectSize, rectSize, rectSize);
   i++;
 }

 
 }
}


void keyReleased(){
  if (key=='c' || key=='C') GenerativeDesign.saveASE(this, colors, timestamp()+".ase");
  if (key=='s' || key=='S') saveFrame(timestamp()+"_##.png");
 

  if (key == '1') video = new Capture (this,640,480);
  if (key == '2') video = new Capture (this,640,480);
  if (key == '3') video = new Capture (this,640,480);

  if (key == '4') sortMode = null;
  // (key == '5') sortMode = GenerativeDesign.HUE;
  if (key == '6') sortMode = GenerativeDesign.SATURATION;
  if (key == '7') sortMode = GenerativeDesign.BRIGHTNESS;
 if (key == '8') sortMode = GenerativeDesign.GRAYSCALE;
}

String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
