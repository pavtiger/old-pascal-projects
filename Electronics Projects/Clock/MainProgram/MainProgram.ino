/*
Pavel Artiushkov
10.11.2018
Test For OLED Screen
*/

#define sclk 13
#define mosi 11
#define cs   10
#define rst  9
#define dc   8

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

/*********************************************************************************************************************************************/
void setup(void) {
  Serial.begin(9600);
  Serial.print("Start");
  display.begin();

  Serial.println("init");
  uint16_t time = millis();
  display.fillScreen(BLACK);
  time = millis() - time;
  
  uint16_t a, b, c, d;
  a=0;
  b=0;
  c=0;
  d=0;
  
  while(1) {
    delay(1000);

    if (d<9) {
      d++;
      display.fillRect(78, 13, 16, 31, BLACK);//Минуты Единицы
    }
    else {
      if (c<5) {
        c++;
        d=0;
        display.fillRect(78, 13, 16, 31, BLACK);//Минуты Единицы
        display.fillRect(58, 13, 16, 31, BLACK);//Минуты Десятки
      }
      else {
        //if (b<) {
        b++;
        c=0;
        d=0;
        display.fillRect(78, 13, 16, 31, BLACK);//Минуты Единицы
        display.fillRect(58, 13, 16, 31, BLACK);//Минуты Десятки
        display.fillRect(21, 13, 16, 31, BLACK);//Часы Единицы
      }
    }

    numberOutput(a, 30, 1, 13, MAGENTA);
    numberOutput(b, 30, 21, 13, MAGENTA);
  
    upDot(8, 4, 45, 16, RED);
    downDot(8, 4, 45, 31, RED);
    
    numberOutput(c, 30, 58, 13, MAGENTA);
    numberOutput(d, 30, 78, 13, MAGENTA);
  }
}



void loop() {
}


void upDot(uint16_t H, uint16_t W, uint16_t X, uint16_t Y, uint16_t Color) {
  display.drawLine(X, Y+H, X, Y, Color);
  display.drawLine(X, Y, X+W, Y, Color);
  display.drawLine(X+W, Y, X+W, Y+H, Color);
}


void downDot(uint16_t H, uint16_t W, uint16_t X, uint16_t Y, uint16_t Color) {
  display.drawLine(X, Y, X, Y+H, Color);
  display.drawLine(X, Y+H, X+W, Y+H, Color);
  display.drawLine(X+W, Y+H, X+W, Y, Color);
}


void numberOutput(uint16_t N, uint16_t H, uint16_t X, uint16_t Y, uint16_t Color) {
  //display.drawRect(X, Y, 15, H, RED);
  switch(N) {
    case 0:
      display.drawRect(X, Y, H/2, H+1, Color);
      break;
    
    case 1:
      display.drawLine(X+3, Y, X+6, Y, Color);
      display.drawLine(X+6, Y, X+6, Y+H, Color);
      display.drawLine(X, Y+H, X+11, Y+H, Color);
      break;

    case 2:
      display.drawLine(X, Y+3, X, Y, Color);
      display.drawLine(X, Y, X+H/2, Y, Color);
      display.drawLine(X+H/2, Y, X+H/2, Y+H/2, Color);
      display.drawLine(X+H/2, Y+H/2, X, Y+H/2, Color);
      display.drawLine(X, Y+H/2, X, Y+H, Color);
      display.drawLine(X, Y+H, X+H/2, Y+H, Color);
      break;

    case 3:
      display.drawLine(X, Y+3, X, Y, Color);
      display.drawLine(X, Y, X+H/2, Y, Color);
      display.drawLine(X+H/2, Y, X+H/2, Y+H/2, Color);
      display.drawLine(X+H/2, Y+H/2, X, Y+H/2, Color);
      display.drawLine(X+H/2, Y+H/2, X+H/2, Y+H, Color);
      display.drawLine(X, Y+H, X+H/2, Y+H, Color);
      display.drawLine(X, Y+H-3, X, Y+H, Color);
      break;

    case 4:
      display.drawLine(X, Y, X, Y+H/2, Color);
      display.drawLine(X, Y+H/2, X+H/2, Y+H/2, Color);
      display.drawLine(X+H/2, Y, X+H/2, Y+H, Color);
      break;

    case 5:
      display.drawLine(X, Y, X+H/2, Y, Color);
      display.drawLine(X, Y, X, Y+H/2, Color);
      display.drawLine(X+H/2, Y+H/2, X, Y+H/2, Color);
      display.drawLine(X+H/2, Y+H/2, X+H/2, Y+H, Color);
      display.drawLine(X, Y+H, X+H/2, Y+H, Color);
      display.drawLine(X, Y+H, X, Y+H-3, Color);
      break;

    case 6:
      display.drawLine(X, Y, X+H/2, Y, Color);
      //display.drawLine(X+H/2, Y, X+H/2, Y+H/2, Color);
      display.drawLine(X+H/2, Y+H/2, X+H/2, Y+H, Color);
      display.drawLine(X+H/2, Y+H, X, Y+H, Color);
      display.drawLine(X, Y+H, X, Y+H/2, Color);
      display.drawLine(X, Y+H/2, X, Y, Color);
      
      display.drawLine(X, Y+H/2, X+H/2, Y+H/2, Color);
      display.drawLine(X+H/2, Y, X+H/2, Y+3, Color);
      break;

    case 7:
      display.drawLine(X, Y+3, X, Y, Color);
      display.drawLine(X, Y, X+H/2, Y, Color);
      display.drawLine(X+H/2, Y, X+H/2, Y+H, Color);
      break;

    case 8:
      display.drawLine(X, Y, X+H/2, Y, Color);
      display.drawLine(X+H/2, Y, X+H/2, Y+H/2, Color);
      display.drawLine(X+H/2, Y+H/2, X+H/2, Y+H, Color);
      display.drawLine(X+H/2, Y+H, X, Y+H, Color);
      display.drawLine(X, Y+H, X, Y+H/2, Color);
      display.drawLine(X, Y+H/2, X, Y, Color);
      
      display.drawLine(X, Y+H/2, X+H/2, Y+H/2, Color);
      break;

    case 9:
      display.drawLine(X, Y, X+H/2, Y, Color);
      display.drawLine(X+H/2, Y, X+H/2, Y+H/2, Color);
      display.drawLine(X+H/2, Y+H/2, X+H/2, Y+H, Color);
      display.drawLine(X+H/2, Y+H, X, Y+H, Color);
      //display.drawLine(X, Y+H, X, Y+H/2, Color);
      display.drawLine(X, Y+H/2, X, Y, Color);
      
      display.drawLine(X, Y+H/2, X+H/2, Y+H/2, Color);
      display.drawLine(X, Y+H, X, Y+H-3, Color);
      break;
  }
}
