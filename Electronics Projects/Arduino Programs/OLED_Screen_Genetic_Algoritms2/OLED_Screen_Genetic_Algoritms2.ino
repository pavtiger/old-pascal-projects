/*
Pavel Artiushkov
4.01.2018
Test For OLED Screen
*/

#define sclk 13
#define mosi 11
#define cs   10
#define rst  9
#define dc   8

// My Settings
#define NPopul    20
#define NGenotip 4

// Color definitions
#define BLACK           0x0000
#define BLUE            0x001F
#define RED             0xF800
#define GREEN           0x07E0
#define CYAN            0x07FF
#define MAGENTA         0xF81F
#define YELLOW          0xFFE0  
#define WHITE           0xFFFF

#include <Adafruit_GFX.h>
#include <Adafruit_SSD1331.h>
#include <SPI.h>

Adafruit_SSD1331 display = Adafruit_SSD1331(cs, dc, mosi, sclk, rst);  

float p = 3.1415926;
int posibilaty, Ready, NAnimals, i, N = 0;
int parents[NGenotip][NPopul];
int fitness[NPopul];

/*********************************************************************************************************************************************/
void setup(void) {
  Serial.begin(9600);
  Serial.print("Start");
  display.begin();
  
  Serial.println("init");
  uint16_t time = millis();
  display.fillScreen(BLACK);
  time = millis() - time;

  for(uint8_t y; y<=NPopul; y++) {
    for(uint8_t x; x<=NGenotip; x++) {
      parents[y][x] = random(-29, 29);
    }
  }
}

void ArrPrint(int arr[NPopul][NGenotip]) {
  int i = 0;
  for(uint8_t i; i<=NPopul; i++) {
    display.print(i);
    display.print(': ');
    display.println(arr[1]);
  }
}

void suma() {
  /*int y, sum: integer = 0;
  for(y:=1 to NPopul ) {
    sum+=290-_fitness[y];
  }*/
  
  //result:=sum;
}

void loop() {
}
