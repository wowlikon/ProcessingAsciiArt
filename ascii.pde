PImage source;
int s = 10, w, h;
char chr[] = (" .`':;°-~=+^*●</|(ap%#$%0ß@¶").toCharArray(); //char chr[] = (" °.-~=+*^>a#$%0ß@").toCharArray();
boolean invert = false;
boolean wait = true;

void setup() {
  size(250, 250, P2D);
  selectInput("Select a file to process:", "fileSelected");
  while(wait){ delay(50); }
  windowResize(source.width, source.height);
  w = width/s;
  h = height/s;
  textSize(s);
}

void draw() {
  background(255);
  image(source, 0, 0);
  noStroke();
  for (int j = 0; j < h; j++) {
    for (int i = 0; i < w; i++) {
      float val = getAvg(get(i*s, j*s, s, s));
      fill(val);
      rect(i*s, j*s, s, s);
      char replace = (( (invert)? (chr[floor(map(val, 255, 0, 0, chr.length-0.01))]) : (chr[floor(map(val, 0, 255, 0, chr.length-0.01))])));
      print(replace+" ");
    }
    println();
  }
  noLoop();
}

float getValue(char input) {
  PGraphics temp = createGraphics(s, s);
  temp.beginDraw();
  temp.background(0);
  temp.textSize(s);
  temp.textAlign(3, 3);
  temp.fill(0);
  temp.text(input, s*0.5, s*0.5);
  temp.endDraw();
  return getAvg(temp);
}

float getAvg(PImage input) {
  input.filter(GRAY);
  float sum = 0, imgW = input.width, imgH = input.height;
  for (int i = 0; i < imgW; i++) for (int j = 0; j < imgH; j++) sum += red(input.get(i, j));
  float avg = sum/(imgW*imgH);
  return (avg);
}

void fileSelected(File load) {
  if (load == null) {
    exit();
  } else {
    source = loadImage(load.getAbsolutePath());
    source.resize(source.width/2, source.height/2);
    wait = false;
  }
}
