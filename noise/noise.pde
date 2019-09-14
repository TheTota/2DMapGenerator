
float increment = 0.008;

void setup() { 
  size(800,800);  
}

void draw() {  
  
  loadPixels();

  float xoff = 0.0; // Start xoff at 0
  float detail = map(0, 0, width, 0.1, 0.6);
  noiseDetail(8, detail);
  
  // For every x,y coordinate in a 2D space, calculate a noise value and produce a brightness value
  for (int x = 0; x < width; x++) {
    xoff += increment;   // Increment xoff 
    float yoff = 0.0;   // For every xoff, start yoff at 0
    
    for (int y = 0; y < height; y++) {
      yoff += increment; // Increment yoff      
      
      float noiseVal = noise(xoff, yoff) * 255;
      
      if(noiseVal < 12) { // mountainTop (white/grey)
        pixels[x+y*width] = color(200,200,200);
      } 
      else if (noiseVal < 17) { // mountain higher ground (dark brown) 
        pixels[x+y*width] = color(79, 49, 19);
      }
      else if (noiseVal < 22) { // mountain lower ground (brown) 
        pixels[x+y*width] = color(143, 89, 34);
      }
      else if (noiseVal < 28) { // deep lands (dark green)
        pixels[x+y*width] = color(0,75,0);
      }
      else if (noiseVal < 35) { // land (green)
        pixels[x+y*width] = color(0,100,0); 
      }
      else if(noiseVal < 50) { // coastal land (bright green)
        pixels[x+y*width] = color(0,150,0);
      } 
      else if (noiseVal < 52) { // beaches/borders (white/grey)
        pixels[x+y*width] = color(200,200,200);      
      }
      else if (noiseVal < 58) { // coastal sea (cyan)      
        pixels[x+y*width] = color(0,150,150);     
      }      
      else if (noiseVal < 80) { // deeper sea (darker blue)
        pixels[x+y*width] = color(0,0,220);    
      }      
      else if (noiseVal < 100) { // deeeep sea (darker darker blue)
        pixels[x+y*width] = color(0,0,180);  
      }
      else { // rly deep sea (dark dark blue)
        pixels[x+y*width] = color(0,0,150);     
      }
    }
  } 
  
  updatePixels();
}

void mousePressed(){
  noiseSeed((int)random(999999));
}
