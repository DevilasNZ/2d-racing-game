int ColourChangeTime = 9;
int RowWidth = 70;
int roadmove = 1;
int carX = 200;
int scoreAdd = 1;
int GameOver = 0;
int EndAlpha = 0;
PFont scores;
PImage car;
PImage spacebar;
PImage endCar;
PImage endBack;
int score;
int bestScore = 0;

int menuOn =0;
int menuAlpha = 0;

int backMaxC = 245;
int backMinC = 10;
int R = 120;
int G = 120;
int B = 120;
int RandomCounter = 0;
int RandomCounterAdd = 1;
int night = 0;

int minCarColour = 50;
int carR = 255;
int carG = 255;
int carB = 255;

int xyz = 0;

int[] road = new int[RowWidth];

void setup() {
  
    size(400, 700);
    frameRate(60);
    
    for(int i=1; i<RowWidth; i = i + 1){
        road[i] = 100;
        
    }
scores = createFont("Arial", 32, true);
car = loadImage ("Wcar.png");
spacebar = loadImage("spacebar.png");
endCar = loadImage("endCar.png");
endBack = loadImage("endBack.png");
  
  score = 1;
}
void draw() {

  String saveScore =str(bestScore);
  String[] hiScore = split(saveScore, "testString");
  
  if(keyPressed){
      if(key == 'l' && EndAlpha == 0||key =='L' && EndAlpha == 0){
        night();}
      if(key =='k' && EndAlpha == 0|| key =='K' && EndAlpha == 0){
        daytime();}
  }
     background(R,G,B);
  
  score = score +scoreAdd;
  
  float RoadPos = random(1, 10);

  RandomCounter = RandomCounter +RandomCounterAdd;
  
  if(RandomCounter > ColourChangeTime){
   changeColour();
   RandomCounter = 0; 
  }

  fill(255, 255);
  
 for(int i = 1; i <70; i = i+roadmove){
   //the race track
   ellipse(road[i] +75, i * 10, 5, 5);
   fill(0,0,0);
   stroke(0, 0, 0, 0);
   rect(road[i], i*10, 150, 10);
   stroke(0, 0, 0, 1);
   fill(255,255,255);
   
   if(road[40] > carX || road[40] +150 < carX +25){
      scoreAdd = 0;
      GameOver = 1;
   }
 }
    
 for(int i=RowWidth-1; i>1; i--){
  road[i] = road[i-1];
 }
 
   //the race car
   fill(255, 255, 255, 120);
   if(night == 1){
triangle(carX+9, 410, carX-20, 300, carX +30, 300);
triangle(carX+22, 410, carX+10, 300, carX +60, 300);
   }
   noFill();
  tint(carR,carG,carB);
image(car, carX, 400, 30, 60);
  noTint();
 //road[1] = road[1] +1;

if (RoadPos < 4){
     road[1] = road[1] +10; 
     
    if(road[1] >245){
       road[1] = road[1] - 10;
    }
     
  }
if(RoadPos > 7){
     road[1] = road[1] -10; 
    
  if(road[1] < 1){
     road[1] = road[1] + 10; 
  }

}

if(keyPressed) {
   if (key == 'a' || key == 'A') {
    carX = carX - 3; 
   }
   if (key == 'd' || key == 'D') {
     carX = carX +3; 
   }
   if (key == ' ' && EndAlpha == 255 && menuOn == 0){
    GameOver = 0;
    EndAlpha = 0;
    setup();
    carX =200;
    scoreAdd =1;
    RandomCounterAdd = 1;
   }
   if(key == '/'){
    print();
   }
   if(key == 'm' && EndAlpha == 255){
    menuOn = 1;
   }
   if(key == 'n'){
    menuOn = 0;
   }
   
} 
if(menuOn == 1){
 menuAlpha = 255;
}else{
  menuAlpha = 0;
}


if(carX < 0){
 carX = carX +3; 
 
} 

//car colour changer
  if(keyPressed && menuAlpha == 255){
    
    //Red Colour Changer
    if(key == '7' && carR < 255 ){
    carR = carR +2;}
    if(key == '1' && carR > minCarColour){
    carR = carR -2;}
    
    //Green Colour Changer
    if(key == '8'){
      carG = carG +2;}
    if(key == '2'){
      carG = carG -2;}
      
    //Blue Colour Changer
    if(key == '9'){
      carB =carB +2;}
    if(key == '3'){
      carB =carB -2;}
    
    //Light and Dark Presets
    if(key == '4'){
    carR = 50;
    carG = 50;
    carB = 50;}
    if(key =='6'){
    carR = 255;
    carG = 255;
    carB = 255; 
    }
    
  }


 //score
   fill(0,0,0);
   rect(0,0,width,50);
   textFont(scores);
   textSize(32);
  fill(255);
  text("Score: " + score, 20, 40);
  text("Best: " + bestScore, 230, 40);
  
  if(GameOver >= 1){
    EndAlpha = 255;
    RandomCounterAdd = 0;
    if(score > bestScore){
     bestScore = score; 
     saveStrings("bestScore.dat", hiScore);
    }
  }
  fill(255, EndAlpha);
      tint(R,G,B,EndAlpha);
        image(endBack, 0,0,width,height);
      tint(carR,carG,carB,EndAlpha);
        image(endCar, 0,0,width,height);
      noTint();
  fill(255, EndAlpha);
     textSize(50);
      text("Game Over", 100, 60);
     textSize(32);
      text("Score: " +score,width -200,112);
      text("Best: " +saveScore,width -200, 154);
     textSize(25);
      //text("Press", 1, 450);
     tint(255, EndAlpha);
      image(spacebar,width -200, 200, 150, 50);
     noTint();
      text("to Play Again", width -150, 282);
 fill(0,EndAlpha);
       text("[m] to customise car", 10, height -10);
   
   //car colour change menu
   fill(255, menuAlpha);
     rect(0,0,width, height);
   fill(0, menuAlpha);
   textSize(40);
     text("Car Colour Changer", 20, 50);
   textSize(35);
     text("Press:", 20, height - 180);
   textSize(18);
     text("[7] for +Red", 20, height -155);
     text("[1] for -Red", 20, height -130);
     text("[8] for +Green", 20, height -95);
     text("[2] for -Green", 20, height -70);
     text("[9] for +Blue", 20, height -35);
     text("[3] for -Blue", 20, height -10);
     text("[4] for Dark Preset", 0.5*width, height -155);
     text("[6] for Light Preset", 0.5*width, height -130);
     text("[n] to exit this menu", 0.5*width, height -10);
   tint(carR, carG, carB, menuAlpha);
     image(car, 100, 60, width - 200, height-260);
   noTint();
}

void changeColour(){
    float colourPickerR = random(1,10);
    float colourPickerG = random(1,10);
    float colourPickerB = random(1,10);
  
      //Random Colour Changer
    
    if(colourPickerR > 5.5){
      if(R < backMaxC){
       R = R+10;
      } 
      
       
    }else{
      if(R > backMinC){
         R =R -10; 
      }
    }
    if(colourPickerG > 5.5){
      if (G < backMaxC){
       G =G +10; 
      }
    }else{
      if(G > backMinC){
       G =G -10; 
      }
    }
    if(colourPickerB > 5.5){
      if(B < backMaxC){
       B =B +10; 
      }
    }else{
      if( B > backMinC){
     B=B-10; 
      }
    }
}

void night(){
        backMinC = 10;
      backMaxC = 120;
    R = 30;
    G = 30;
    B = 30;
    night = 1;
}

void daytime(){
          backMinC = 120;
      backMaxC = 245;
    R = 150;
    G = 150;
    B = 150;
    night = 0;
}
