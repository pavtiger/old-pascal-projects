#include <Servo.h>

#define RotSenter 57
#define HorSenter 10
#define VerSenter 23
#define HandEnd   120

Servo Vertical;
Servo Horizontal;
Servo Rotational;
Servo Hand;
int x, y, r;

void setup() {
  delay(1000);
  Serial.begin(9600);
  Serial.println("BEGIN");
  Serial.println("Print 'Help' for all commands");
  Serial.println("");

  pinMode(10, INPUT);
  Horizontal.attach(13);
  Vertical.attach(11);
  Rotational.attach(12);
  Hand.attach(9);
  
  Rotational.write(RotSenter);
  Vertical.write(VerSenter);
  Hand.write(0);

  x = VerSenter;
  r = RotSenter;
}

void loop() {
  String str = Serial.readString();

  if (str != "") {
    Serial.println(str);
  }
///////////////////////////////////////////////////////////////////
  if (str == "help") {
    Serial.println("  up..");
    Serial.println("  down..");
    Serial.println("  rot right..");
    Serial.println("  rot left..");
    Serial.println("  right");
    Serial.println("  left");
    Serial.println("  stop");
    Serial.println("  reset");
    Serial.println("  capture");
    Serial.println("  release");
  }
///////////////////////////////////////////////////////////////////
  if (str == "up") {
    int N = 0;
    while (N == 0) {
      N = Serial.readString().toInt();
    }
    x += N;
    Vertical.write(x);
  }
///////////////////////////////////////////////////////////////////
  if (str == "down") {
    int N = 0;
    while (N == 0) {
      N = Serial.readString().toInt();
    }
    x -= N;
    Vertical.write(x);
  }
///////////////////////////////////////////////////////////////////
  if (str == "rot left") {
    int N = 0;
    while (N == 0) {
      N = Serial.readString().toInt();
    }
    r -= N;
    Rotational.write(r);
  }
////////////////////////////////////////////////////////////////////
    if (str == "rot right") {
    int N = 0;
    while (N == 0) {
      N = Serial.readString().toInt();
    }
    r += N;
    Rotational.write(r);
  }
///////////////////////////////////////////////////////////////////
  if (str == "right") {
    Horizontal.writeMicroseconds(1420);
  }
///////////////////////////////////////////////////////////////////
  if (str == "left") {
    Horizontal.writeMicroseconds(1620);
  }
///////////////////////////////////////////////////////////////////
  if (str == "stop") {
    Horizontal.writeMicroseconds(1500);
  }
///////////////////////////////////////////////////////////////////
  if (str == "reset") {
    //Horizontal.writeMicroseconds(1700);
    Vertical.write(VerSenter);
    Rotational.write(RotSenter);
  }
///////////////////////////////////////////////////////////////////
  if (str == "capture") {
    Hand.write(HandEnd);
  }
///////////////////////////////////////////////////////////////////
  if (str == "release") {
    Hand.write(0);
  }
}
