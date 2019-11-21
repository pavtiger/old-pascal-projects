program SpaceTrajectory;
uses GraphABC;
var Stars, Earth, Sputnik {ISS, Moon}: Picture;
var H, EarthX, EarthY, i, RingX, RingY, RingH, ISSHeight, R: integer;
var X, Y, StartX, StartY: real;

  procedure SputnikDraw(i: integer);
  begin
    X := StartX + R*cos(i*Pi/180);
    Y := StartY + R*sin(i*Pi/180);
    Sputnik.Draw(round(X)-round(ISSHeight/2), round(Y)-round(ISSHeight/2), ISSHeight, ISSHeight);
  end;
  
  procedure EarthDraw();
  begin
    Earth.Draw(EarthX, EarthY, H, H);
  end;
  
  procedure StarsDraw();
  begin
    Stars.Draw(0, 0, WindowWidth, WindowHeight);
  end;
  
  procedure RingDraw();
  begin
    Circle(RingX, RingY, RingH);
  end;
  
begin
  MaximizeWindow;
  Window.Title:='Space Trajectory';
  SetPenColor(clYellow);
  SetPenWidth(2);
  SetBrushColor(clTransparent);
  
  H:=round(WindowHeight/3.43333333333);
  EarthX:=round(WindowWidth/2)-round(H/2);
  EarthY:=round(WindowHeight/2)-round(H/2);
  RingX:=EarthX+100;
  RingY:=EarthY+100;
  RingH:=H+90;
  StartX:=round(WindowWidth/2);
  StartY:=round(WindowHeight/2);
  ISSHeight:=round(WindowHeight/4.8066);
  R:=round(WindowHeight/2.4862);
  
  Stars := Picture.Create('Stars.bmp');
  Stars.Load('Stars.bmp');
  Earth := Picture.Create('Earth.bmp');
  Earth.Load('Earth.bmp');
  Earth.Transparent := True;
  Sputnik := Picture.Create('Sputnik.bmp');
  Sputnik.Load('Sputnik.bmp');
  Sputnik.Transparent := True;
  //ISS := Picture.Create('ISS.bmp');
  //ISS.Load('ISS.bmp');
  //ISS.Transparent := True;
  //Moon := Picture.Create('Moon.bmp');
  //Moon.Load('Moon.bmp');
  //Moon.Transparent := True;
  LockDrawing();
  i:=0;
  
  While True do
  begin
    StarsDraw();
    RingDraw();
    EarthDraw();
    SputnikDraw(i);
    i-=2;
    
    redraw();
  end
end.