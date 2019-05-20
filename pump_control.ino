// Run a A4998 Stepstick from an Arduino UNO.
// Paul Hurley Aug 2015
#include "AccelStepper.h"
#define stepsPerRevolution 200
#define stepPin 3
#define dirPin 2
AccelStepper stepper(1,stepPin,dirPin);

int cSpeed=0; // current Speed
int mStatus=0; // motor status (ON/OFF)
  
void setup() 
{
  stepper.setMaxSpeed(1000); 
  Serial.begin(9600);    //start serial communication @9600 bps
}

void loop() 
{
  // RECEIVE SERIAL COMMANDS
  if(Serial.available()){  //id data is available to read
    char val = Serial.read();
    
    // INCREASE SPEED
    if(val == 'w'){
      if (cSpeed<1000)
      {
        cSpeed+=100;
        stepper.setSpeed(cSpeed);
      }
    }

    // REDUCE SPEED
    if(val == 's'){       //if f received
      if (cSpeed>-1000){
        cSpeed-=100;
        stepper.setSpeed(cSpeed);
      }
    } 

    //STOP
    if(val == 'a'){       //if f received
     stepper.stop();  
     mStatus=0;
    }

    //START
    if(val == 'd'){       //if f received
     mStatus=1; //step the motor with constant speed as set by setSpeed()
     stepper.setSpeed(cSpeed);
    }
    
  }
// END RECIVING COMMANDS
  if (mStatus>0)
  {
    stepper.runSpeed();
  }
}
