PImage bg1, bg2, enemy, fighter, hp, treasure, start1, start2, end1, end2;
int bg, enX, enY, hps, trX, trY, ftX, ftY, timer;
float speed;
boolean upPressed=false, downPressed=false, leftPressed=false, rightPressed=false;
boolean straight=true, tilt=false, square=false;
final int START=0, PLAYING=1, END=2;
int gameState;

void setup () {
  size(640, 480) ;
  start1=loadImage("img/start1.png");
  start2=loadImage("img/start2.png");
  bg1=loadImage("img/bg1.png");
  bg2=loadImage("img/bg2.png");
  hp=loadImage("img/hp.png");
  enemy=loadImage("img/enemy.png");
  fighter=loadImage("img/fighter.png");
  treasure=loadImage("img/treasure.png");
  end1=loadImage("img/end1.png");
  end2=loadImage("img/end2.png");
  
  bg=0;
  speed=0;
  gameState=START;
}

void draw() {
 switch(gameState){
  case START:
  image(start2,0,0);
  if(mouseX<=450 && mouseX>=200 && mouseY<=430 && mouseY>=380){
   if(mousePressed){gameState=PLAYING;}
   else{image(start1,0,0);}}
  //restart
   ftX=580;
   ftY=260;
   trX=floor(random(0,600));
   trY=floor(random(45,430));
   enY=floor(random(45,430));
   enX=0;
   hps=199*2/10;
  break;
 
  case PLAYING:
  //background
   bg++;
   bg%=1282;
   image(bg1,bg,0);
   image(bg2,bg-641,0);
   image(bg1,bg-1282,0);

  //treasure
   image(treasure, trX, trY);
   if(trY+50>=ftY && ftY>=trY-50){
    if(trX-50<=ftX && ftX<=trX+50){
     image(treasure, trX, trY);
     trY=floor(random(45,430));
     trX=floor(random(0,600));
     hps+=199/10;
     if(hps>=199){
     hps=199;}}}
     
  //enemy
   //move 
   enX+=3;
   enX%=2120;
   /*if(upPressed){
    if(enY+30>ftY+25){enY-=(speed-2);}
    if(enY+30<ftY+25){enY+=(speed-2);}
    else if(enY+30==ftY+25){enY=ftY;}}
   else if(downPressed){
    if(enY+30<ftY+25){enY+=(speed-2);}
    if(enY+30>ftY+25){enY-=(speed-2);}
    else if(enY+30==ftY+25){enY=ftY;}}
   else if(enY+30==ftY+25){enY=ftY;}
   else{
    if(enY+30>ftY+25){enY-=(speed-2);}
    if(enY+30<ftY+25){enY+=(speed-2);}
    else if(enY+30==ftY+25){enY=ftY;}} */
   if(enX==0){enY=floor(random(45,420));}
   if(enX==1060){enY=floor(random(185,280));}
    
   //enemies
   
 /*  //straight
     for(int X=-340; X<=0; X+=70){
     pushMatrix();
     translate(X,0);
      image(enemy, enX, enY);
     popMatrix();}
   
   //tilt
    for(int X=-340; X<=0; X+=70){
     pushMatrix();
     translate(X-1060,X+140);
      image(enemy, enX, enY);
     popMatrix();}*/
     
   //square
    for(int X=-240; X<0; X+=80){
     pushMatrix();
     translate(X,X);
     if(X%120==0){
      image(enemy, enX, enY);
     }else{
       image(enemy, enX-30, enY);}
     popMatrix();}}
     
   //boundary
    if(enY>height-60){enY=height-60;}
    if(enY<0){enY=0;}
    
   /*//crash
   image(enemy, enX, enY);
   if(enY+60>=ftY && ftY>=enY-60){
    if(enX-60<=ftX && ftX<=enX+60){
     image(enemy, enX, enY);
     enY=floor(random(45,420));
     enX=0;
     hps-=2*199/10;}}*/
  
  //fighter
   //move
    speed++;
    if(speed>=4){speed=4;}
    if(upPressed){ftY-=speed;}
    if(downPressed){ftY+=speed;} 
    if(leftPressed){ftX-=speed;}
    if(rightPressed){ftX+=speed;}
    
  //boundary
    if(ftX>width-50){ftX=width-50;}
    if(ftX<0){ftX=0;}
    if(ftY>height-50){ftY=height-50;}
    if(ftY<0){ftY=0;}
  image(fighter, ftX, ftY);
  
  //hp
   fill(255,0,0);
   noStroke();
   rect(22, 15, hps, 30);
   image(hp, 15, 15);
   if(hps<=0){
    hps=0;
    gameState=END;}
 break;
 
 case END:
  image(end2,0,0);
  if(mouseX<=450 && mouseX>=200 && mouseY<=350 && mouseY>=320){
   if(mousePressed){gameState=START;}
   else{image(end1,0,0);}
 break;
 }
}
}

void keyPressed(){
  if(key==CODED){
    switch(keyCode){
    case UP:
    upPressed = true;
    break;
    case DOWN:
    downPressed = true;
    break;  
    case LEFT:
    leftPressed = true;
    break;
    case RIGHT:
    rightPressed = true;
    break;
  }
  }
}

void keyReleased(){
  if(key==CODED){
    switch(keyCode){
    case UP:
    upPressed = false;
    break;
    case DOWN:
    downPressed = false;
    break;  
    case LEFT:
    leftPressed = false;
    break;
    case RIGHT:
    rightPressed = false;
    break; 
  }
  }
}
