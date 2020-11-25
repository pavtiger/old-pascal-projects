#define Test_PIN 2
#define TimeOut1 200
#define TimeOut2 400


void setup() {
  pinMode(Test_PIN, OUTPUT);
}

void loop() {
  migay(TimeOut1);
  migay(TimeOut2);
}

void migay(int pause){
  digitalWrite(Test_PIN, HIGH);
  delay(pause);
  digitalWrite(Test_PIN, LOW);
  delay(pause);
}







