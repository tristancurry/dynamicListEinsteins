//all of the below is to control and create balloons

class NumberedBalloon {
  /////////////////////
  ///CLASS VARIABLES (declare all variables that need to work across the object)
  /////////////////////
  
  int serialNumber;
  int diceRoll;
  
  
  float posiX;
  float posiY;
  float veloX;
  float veloY;
  
  int balloonAlpha;
  
  float rotationSpeed;
  float angle;
  
  int balloonTimer;
 
  //////////////////////
  //the CONSTRUCTOR (a function that runs once, when a new instance of the object is created)
  //////////////////////
 
  NumberedBalloon(float _posiX, float _posiY, float _veloX, float _veloY){
    
    serialNumber = balloonNumber;
    balloonNumber ++;   //increase the global balloon number, so that the next one has a higher number
    
    posiX = _posiX;     //start the balloon with the values specified when it was created
    posiY = _posiY;
    veloX = _veloX;
    veloY = _veloY;
    
    balloonAlpha = 255;
    
    rotationSpeed = random(-5,5);  //extra stuff for setting the balloons spinning at a random rate
    angle = 0;                     //between -5 and 5 degree per frame (approx 60 fps)
    
    balloonTimer = 0;

    diceRoll = floor(random(1,11));
  }
  
  ///////////////////////////////
  //METHODS (functions specific to this type of object)
  ///////////////////////////////
 
   void update(){    //this METHOD is for updating the position of the balloon on the screen.
   
     posiX = posiX + veloX;
     posiY = posiY + veloY;
     
     //you could also have some code here to change the veloX and veloY each time update() is called.
     //This would be useful if you were simulating gravity.
     //For example, uncomment the following for some weak gravity:  
    
     veloY = veloY + 0.03;
     
     //or give them some attraction to the mouse:
     
     
     posiX = posiX + random(-0.1,0.1);                             //give the balloon a tiny amount of jitter, so it knows whether to turn left or right
     float dist = sqrt(sq(mouseX - posiX)+ sq(mouseY - posiY));    //calculate distace between balloon centre and mouse (remember distance formula or Pythagoras?)
     float veloOld = sqrt(sq(veloX) + sq(veloY));                  //calculate original velocity
     veloX =  veloX + 0.1*(mouseX - posiX)/dist;                   //add some velocity based on distance to mouse
     veloY = veloY + 0.1*(mouseY - posiY)/dist;
     float veloNew = sqrt(sq(veloX) + sq(veloY));                  //calculate new velocity
     veloX = veloX*(veloOld/veloNew);                              //these steps are there to keep the speed the same so that only their direction is affected 
     veloY = veloY*(veloOld/veloNew);                              //omit these if you want the balloons to also speed up towards the mouse 
    
     //If you wanted the balloon to bounce off the walls, this would be the place to
     //put the code for handling this (as it involves changing the veloX and veloY)
     
   
     angle = angle + radians(rotationSpeed); 
   
     balloonTimer = balloonTimer + 1;
   }
   
   
   
   void display(){  //this METHOD is for displaying the balloon at the correct location.
     
  
    imageMode(CENTER);  //images will now be drawn according to the coords of their center (instead of a corner)
     
     pushMatrix();          //the following code is for temporarily setting the (0,0) position to wherever this balloon is.
       translate(posiX, posiY); 
       rotate(angle);
       tint(255, balloonAlpha);
       if(diceRoll > 9){
         image(jbFace,0,0);
       } else {
         image(aeFace,0,0);
       }
       textAlign(CENTER, CENTER);
       textSize(24);
       translate(2,-3);
       fill(0,0,0,balloonAlpha);       //slight adjustment to centre the text a bit better!
       text(serialNumber,0,0);
       translate(-2,-2);            //slight adjustment to centre the text a bit better!
        fill(255,255,255,balloonAlpha);
       text(serialNumber,0,0);
     popMatrix();          //return the coordinate system to usual angle and origin
       
       
   }
   
   void fade(){     //this METHOD gradually makes the balloon more and more transparent
     if(balloonAlpha > 0){
       balloonAlpha = balloonAlpha - 2;
       
     //alternatively, maybe you want the transparency to increase and decrease periodically - use a periodic function like sine.
     //you might have to declare some of the variables as floats instead of ints though.
     //For example...
     // balloonAlpha = sq((sin(balloonTimer/10)))*255;
       
     }
   }
  
}
