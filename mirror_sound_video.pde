import java.util.Calendar;
import processing.sound.*;
import processing.video.*;
Capture video; 


AudioIn input;   // sound 
Amplitude loudness;  // sound 

int cellsize = 3; 
int columns, rows; 


final float MAX_MIX = 1;
final float TRESH = 0.5;


void setup() {
  
//size(1280, 720,P3D);
size(640,480);
video = new Capture (this,640,480);
video.start();
background(0);

  columns = video.width / cellsize;
  rows = video.height / cellsize;
    background(0);
    input = new AudioIn(this, 1);
  input.start();
  loudness = new Amplitude(this);
  loudness.input(input);
  
  
}
 
 void captureEvent(Capture video){
video.read();

} 
 
 
void draw() {

  background(0);
  float volume = loudness.analyze();
   float size_ = map(volume, 0, 10, 32, width);
 println(size_);
 //volume, 0, 0.5, 1, width
 //0, 0.5, 1, 350
 //height*0.75
 // explode 
  for ( int i = 0; i < columns; i++) {
  
    for ( int j = 0; j < rows; j++) {
      int x = i*cellsize + cellsize/2;  
      int y = j*cellsize + cellsize/2;  
      int loc = x + y*video.width;  
      color c = video.pixels[loc];  
      // Calculate a z position as a function of mouseX and pixel brightness
 
      float z = (size_ / float(width)) * brightness(video.pixels[loc]) - 1;
      pushMatrix();
     translate(x + 0, y + 0, z);
      fill(c, 204);
      noStroke();
      rectMode(CENTER);
      rect(0, 0, cellsize, z);
      popMatrix();
    }
  }
 


  int transparency = int(map(volume, 0, 1, 255, 100));

  
 // noise
  loadPixels();
  for (int i = 0; i < pixels.length; i++) {
    color n = color(random(100), transparency);
    color c = pixels[i];
    color result = lerpColor(c, n, random(MAX_MIX));
    pixels[i] = transparency <= TRESH? result:c;
  }
 
 
  updatePixels();
 
} 
