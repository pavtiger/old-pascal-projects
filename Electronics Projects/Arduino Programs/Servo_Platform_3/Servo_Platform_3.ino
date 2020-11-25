#include <Servo.h>

#define RotSenter 300
#define HorSenter 10
#define VerSenter 23

Servo Vertical;
Servo Horizontal;
Servo Rotational;

void setup() {
  delay(1000);
  Serial.begin(9600);
  //Serial.print("Ready");
  
  pinMode(10, INPUT);
  Horizontal.attach(13);
  Vertical.attach(11);
  Rotational.attach(12);
  
  Rotational.write(RotSenter);
  Vertical.write(VerSenter);

  //while(digitalRead(10) == 0) {
  //}
  //Serial.print(digitalRead(10));
}

void loop() {
  uint8_t inf = Serial.read();
  if (inf != 'Н'){
    Serial.print(inf);
  }
  inf = 0;
  //Rotational.write(inf);
  //Horizontal.writeMicroseconds(1700);
  //Vertical.write(i);
}
