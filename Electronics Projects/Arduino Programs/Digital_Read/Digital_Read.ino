void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  Serial.print("Start");
  
  pinMode(10, INPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  Serial.println(digitalRead(10));
}
