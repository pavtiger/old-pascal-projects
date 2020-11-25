#include <Servo.h>

#define LeftSenter 0
#define RightSenter 180
#define HandEnd 80

Servo Hand;
Servo Left;
Servo Right;
String State; //move, stuck, grab, need help

void setup() {
  delay(1000);
  Serial.begin(9600);
  Serial.println("BEGIN");
  Serial.println("Print 'Help' for all commands");
  
  Hand.attach(4);
  Left.attach(3);
  Right.attach(2);
  
  Left.write(LeftSenter);
  Right.write(RightSenter);
  Hand.write(HandEnd);
}

void loop() {
  String str = Serial.readString();

  if (str != "") {
    Serial.println(str);
  }
  if (str == "help") {
    Serial.println("  capture");
    Serial.println("  release");
  }
  if (str == "capture") {
    Hand.write(0);
  }
  if (str == "release") {
    Hand.write(HandEnd);
  }
}
