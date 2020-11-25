#include <Servo.h>
#define Senter 75

Servo Vertical;
Servo Horizontal;

void setup() {
  Horizontal.attach(7);
  Vertical.attach(6);
  
  //Horizontal.write(Senter);
  //Vertical.write(5);
  //delay(500);
  //Horizontal.write(0);
}

void loop() {
  //for(uint8_t r = -90; r <= 180; r++) {
  //  Horizontal.write(r);
  //  delay(10);
  //}

  //delay(2101);
  //for(uint8_t r = 270; r >= 0; r--) {
  //  Horizontal.write(r);
  //  delay(10);
  //}
}
