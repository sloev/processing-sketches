PImage img;
int x=0;
int xDir=1;
int y=0;

int col=0;

String current="";
String current2="";

int cur=0;

boolean fin=false;

int speed=100;
int colorWheelAngle=0;

int thisWidth=100;

void setup() {
  size(thisWidth, (thisWidth*2)/3);
  frameRate(240);
  img = loadImage("test.jpg");
  img.resize(width, height);
  //size has to be in 35mm format
}

void draw() {
  if (fin!=true) {
    col++;
    if (col>2) {
      col=0;
    }
    switch (col) {
    case 0:
      cur=int(red(img.pixels[x+y*width]));
      current=cur+",";
      current2=current;

      break;
    case 1:
      cur=int(green(img.pixels[x+y*width]));
      current=cur+",";
      current2+=current;

      break;
    case 2:
      cur=int(blue(img.pixels[x+y*width]));
      current=cur+",";

      current2+=current;
      receiveRGB();

      break;
    }

    moveX();
    sendRGB();
  }
}

void moveX() {
  x+=xDir;
  if (x>width || x<0) {
    xDir*=-1;
    moveY();
  }
}

void moveY() {
  y++;
  if (y>height-2) {
    finnish();
    x=0;
    y=0;
  }
}

void finnish() {
  fin=!fin;
}


void sendRGB() {
  print(current);
}

void receiveRGB() {
  int r=0;
  int g=0;
  int b=0;
  int xDir2=0;

  int count=0;
  //read all serial bytes until , and \n 
  String a="";
  //following is a simulation
  for (int i=0; i<current2.length();i++) {
    if (current2.charAt(i)==',') {
      count++;
    }
    else {
      a=a+current2.charAt(i);

      switch(count) {
      case 0:
        r=Integer.parseInt(a);
        break;
      case 1:
        g=Integer.parseInt(a);
        break;
      case 2:
        b=Integer.parseInt(a);
        break;
      }
    }
  }

  stroke(b);
  point(x, y);
}

