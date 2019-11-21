program SpaceTrajectory;
{$reference 'PresentationCore.dll'}
uses GraphABC;

var Stars, Planet, EarthObject, SaturnV1, DeathStar, Tower: Picture;
var H, EarthX, EarthY, i, RingH, HeightObject, R, Count, Step, WhiteOrTranparent, 
  SaturnVHeight, StartButtonNumber, EndFlight, Gotcha, StarWars, S, W, ready, GoAway, ReadyToFall, TurnReady, Test: integer;
var X, Y, StartX, StartY, XTr, YTr, iTr, RTr, iTrD, RTrD, XSaturn1, YSaturn1, XSaturn2, YSaturn2, 
  dx, dy, Stepi, StepR, ask, HSaturn1, iSaturn1, HSaturn2, iSaturn2, H2, DI, XRocket, 
  YRocket, XSaturnHeight, YSaturnHeight, SaturnTriangle, TriangleX1, TriangleY1, 
  TriangleX2, TriangleY2, FlightH, Flighti, StepTriangle, Fi, H1, StepRocket, StartLine, 
  HDownUp, ChangeH, TowerTriangle, StartFall, fall, Gotchai, StepFall, a, ra, StartFallH, 
  StartFalli, Fr, StepRocketR, StepRocketI, FallCount, SaturnRocketTriangle, StepTriangleFall, Between, StartITr, AddH: real;
type RealArr = array [1..3] of real;
////////////////////////////////////////////////////////////////////////////////

const
  WayPlanets: array [1..48] of string = (
    'Planet.bmp'
  , '.bmp'
);

const
  WayRockets: array [1..48] of string = (
    '.bmp'
  , '.bmp'
);

const
  WayObjects: array [1..48] of string = (
    '.bmp'
  , '.bmp'
);
////////////////////////////////////////////////////////////////////////////////

  {==}{procedure KeyUp(key: integer);
  begin
    if key = VK_S then
    begin
      S:=0;
    end;
  end;}
  
  
  {==}procedure KeyDown(key: integer);
  begin
    if key = VK_Enter then
    begin
      StartButtonNumber:=1;
    end;
    
    if key = VK_Back then
    begin
      Test:=1;
    end;
    
    if key = VK_Space then
    begin
      Gotcha:=1;
    end;
    
    {if key = VK_S then
    begin
      S:=1;
    end;
    
    if key = VK_W then
    begin
      if S=1 then
      begin
        StarWars:=1;
      end;
    end;}
  end;
  
  
  
  //XTr := StartX + RTr*cos((iTr+90)*Pi/180);
  //YTr := StartY + RTr*sin((iTr+90)*Pi/180);
      
  {==}function XGetter(StartX, R, Angle: real): integer;
  begin
    result := round(StartX + R*cos((-Angle+90) * Pi / 180));
  end;
  
  {==}function YGetter(StartY, R, Angle: real): integer;
  begin
    result := round(StartY + R*sin((-Angle+90) * Pi / 180));
  end;
  
  
  
  {==}procedure EarthObjectDraw(i: integer);
  begin
    X := StartX + R*cos(i*Pi/180);
    Y := StartY + R*sin(i*Pi/180);
    EarthObject.Draw(round(X)-round(HeightObject/2), round(Y)-round(HeightObject/2), HeightObject, HeightObject);
  end;
  
  
  
  {==}procedure SaturnRocketDraw(x, y, r: real);
  begin
    SaturnV1.Draw(round(x-SaturnVHeight/2), round(y-SaturnVHeight/2), r, SaturnVHeight, SaturnVHeight);
  end;
  
  
  
  {==}function Triangle(x1, y1, x2, y2: real):real;
  begin
    var dx, dy: real;
    dx:=x1-x2;
    dy:=y1-y2;
    
    result:=ArcTan(round(dy/dx))*(180/pi)-90;
  end;
  
  
  
  {==}function TrajectoryRunH1(sx, sy: real):real;
  begin
    HSaturn1:=H/2;
    iSaturn1:=H/2;
    
    HSaturn2:=H/2;
    iSaturn2:=H/2;
    ask:=0;
    While ask<SaturnVHeight do
    begin
      XSaturn2 := StartX + HSaturn2*cos(((iSaturn2*-1)+90)*Pi/180);
      YSaturn2 := StartY + HSaturn2*sin((iSaturn2+90)*Pi/180);
  
      dx:=sx-XSaturn2;
      dy:=sy-YSaturn2;
      
      ask:=sqrt(sqr(dx)+sqr(dy));
      
      HSaturn2+=1;
      iSaturn2+=1
    end;
    result:=HSaturn1;
  end;
  
  
  
  {==}function TrajectoryRunH2(sx, sy: real):real;
  begin
    HSaturn1:=H/2;
    iSaturn1:=H/2;
    
    HSaturn2:=H/2;
    iSaturn2:=H/2;
    ask:=0;
    While ask<SaturnVHeight do
    begin
      XSaturn2 := StartX + HSaturn2*cos(((iSaturn2*-1)+90)*Pi/180);
      YSaturn2 := StartY + HSaturn2*sin((iSaturn2+90)*Pi/180);
  
      dx:=sx-XSaturn2;
      dy:=sy-YSaturn2;
      
      ask:=sqrt(sqr(dx)+sqr(dy));
      
      HSaturn2+=1;
      iSaturn2+=1
    end;
    result:=HSaturn2;
  end;
  
  
  
  {==}function TrajectoryRunDI(sx, sy: real):real;
  begin
    HSaturn1:=H/2;
    iSaturn1:=H/2;
    
    HSaturn2:=H/2;
    iSaturn2:=H/2;
    ask:=0;
    While ask<SaturnVHeight do
    begin
      XSaturn2 := StartX + HSaturn2*cos(((iSaturn2*-1)+90)*Pi/180);
      YSaturn2 := StartY + HSaturn2*sin((iSaturn2+90)*Pi/180);
  
      dx:=sx-XSaturn2;
      dy:=sy-YSaturn2;
      
      ask:=sqrt(sqr(dx)+sqr(dy));
      
      HSaturn2+=1;
      iSaturn2+=1
    end;
    result:=iSaturn2-iSaturn1;
  end;
  
  
  
  {==}procedure SaturnBeforeLiftoffDraw();
  begin
    {-}TriangleX1:=StartX;
    {|}TriangleY1:=StartY;
    {-}TriangleX2:=StartX + (H/2)*cos(((H/2*-1)+90)*Pi/180);
    {|}TriangleY2:=StartY + (H/2)*sin((H/2+90)*Pi/180);
    SaturnTriangle:=Triangle(TriangleX1, TriangleY1, TriangleX2, TriangleY2);
    
    SaturnRocketDraw(XSaturnHeight+5, YSaturnHeight+5, SaturnTriangle-190);
  end;
  
   
  
  {==}procedure TowerDraw(flight: real);
  begin
    if (flight=0) then
    begin
      TowerTriangle:=round(SaturnTriangle-190);
      Tower.Draw(round(XSaturnHeight-SaturnVHeight/2), round(YSaturnHeight-SaturnVHeight/2), round(SaturnTriangle-190), round(SaturnVHeight), round(SaturnVHeight));
    end
    else
    begin
      Tower.Draw(round(XSaturnHeight-SaturnVHeight/2), round(YSaturnHeight-SaturnVHeight/2), round(TowerTriangle), round(SaturnVHeight), round(SaturnVHeight));
    end;
  end;
  
  
  
  {==}function SaturnLiftoffDraw(flighti1, flightr1: real):real;
  begin   
    if flighti1=0 then
    begin
      XSaturn1 := StartX + (FlightH)*cos(((Flighti*-1)+90)*Pi/180);
      YSaturn1 := StartY + (FlightH)*sin((Flighti+90)*Pi/180);
      H1:=TrajectoryRunH1(XSaturn1, YSaturn1);
      H2:=TrajectoryRunH2(XSaturn1, YSaturn1);
      DI:=TrajectoryRunDI(XSaturn1, YSaturn1);
      SaturnTriangle:=Triangle(TriangleX1, TriangleY1, TriangleX2, TriangleY2);
      SaturnRocketTriangle:=SaturnTriangle;
    end
    else
    begin
      SaturnTriangle-=StepTriangle;
      Between:=SaturnTriangle-SaturnRocketTriangle;
      if (Between<225) and (Gotcha=1) then
      begin
        FallCount+=StepTriangleFall;
        //SaturnRocketTriangle-=StepTriangle;
        SaturnRocketTriangle-=StepTriangleFall;
      end
      else
      begin
        SaturnRocketTriangle-=StepTriangle;
      end;
    end;
    
    if (XRocket<0) or (XRocket>WindowWidth) or (YRocket<0) or (YRocket>WindowHeight) then
    begin
      EndFlight:=1;
    end;
    
    if  round(flighti) mod 4 = 0 then
    begin
      ChangeH:=HDownUp;
    end
    else
    begin
      ChangeH:=-HDownUp;
    end;
    
    if (Gotcha=1) and (ready=0) then
    begin
      StartFallH:=(((H+(H2-H1))/2)+flightr1+ChangeH);
      StartFalli:=(H/2+flighti1+DI/2);
      ready:=1;
    end;

    XRocket:=StartX + (((H+(H2-H1))/2)+flightr1+ChangeH)*cos((((H/2+flighti1+DI/2)*-1)+90)*Pi/180);
    YRocket:=StartY + (((H+(H2-H1))/2)+flightr1+ChangeH)*sin(((H/2+flighti1+DI/2)+90)*Pi/180);
    
    {#}TriangleX1:=StartX + (H1+flightr1)*cos((((H/2+flighti1)*-1)+90)*Pi/180);
    {#}TriangleY1:=StartY + (H1+flightr1)*sin(((H/2+flighti1)+90)*Pi/180);
    {#}TriangleX2:=StartX + (H2+flightr1)*cos((((H/2+flighti1+DI)*-1)+90)*Pi/180);
    {#}TriangleY2:=StartY + (H2+flightr1)*sin(((H/2+flighti1+DI)+90)*Pi/180);
    
    //Circle(round(TriangleX1), round(TriangleY1), 3);
    //Circle(round(TriangleX2), round(TriangleY2), 3);
    //Line(round(TriangleX1), round(TriangleY1), round(TriangleX2), round(TriangleY2));
    
    SaturnRocketDraw(XRocket, YRocket, SaturnRocketTriangle+90);
    result:=H/2+flighti1+DI/2;
  end;
  
  
  
  {==}procedure LineDraw(start, fallReady: real);
  begin
    GoAway:=0;
    While true do
    begin
      Count+=1;
      XTr := StartX + RTr*cos(-(iTr-90)*Pi/180);
      YTr := StartY + RTr*sin(-(iTr-90)*Pi/180);
      if RTr>H/2 then
      begin
        GoAway:=1;
      end;
      if ((XTr<=0)or(XTr>=WindowWidth)or(YTr<=0)or(YTr>=WindowHeight)) or ((RTr<=H/2) and (GoAway=1)) then
      begin
        RTr:=0;
        iTr:=StartITr;
        break;
      end
      else
      begin
        if (iTr<=StartFallI) or (StartFallI=0) then
        begin
          RTr+=StepR;
          iTr+=Stepi;
        end
        else
        begin
          RTr-=StepR;
          iTr+=Stepi;
        end;
      end;
       
      if Count>Step then
      begin
        Count:=0;
        WhiteOrTranparent:=WhiteOrTranparent*-1
      end
      else
      begin
        if (WhiteOrTranparent=1) and (iTR>start) then
        begin
          LineTo(round(XTr), round(YTr), clWhite);
        end
        else
        begin
          MoveTo(round(XTr), round(YTr));
        end;
      end;
    end;
  end;
  
  
  
  {==}procedure EarthDraw();
  begin
    Planet.Draw(EarthX, EarthY, 80, H, H);
  end;
  
  
  
  {==}procedure StarWarsDraw();
  begin
    DeathStar.Draw(EarthX, EarthY, 0, H, H);
  end;
  
  
  
  {==}procedure StarsDraw();
  begin
    Stars.Draw(0, 0, WindowWidth, WindowHeight);
  end;
  
  
  
  {==}procedure RingDraw();
  begin
    Circle(round(StartX), round(StartY), RingH);
  end;
  
////////////////////////////////////////////////////////////////////////////////
begin
  MaximizeWindow;
  OnKeyDown := KeyDown;
  OnKeyUp := KeyUp;
  Window.Title:='Space Trajectory';
  SetPenColor(clYellow);
  SetPenWidth(2);
  SetBrushColor(clTransparent);
  
  H:=200;//round(WindowHeight/3.43333333333);
  EarthX:=round(WindowWidth/2)-round(H/2);
  EarthY:=round(WindowHeight/2)-round(H/2);
  RingH:=H+random(35, 100);
  StartX:=round(WindowWidth/2);
  StartY:=round(WindowHeight/2);
  HeightObject:=70;
  R:=RingH;//round(WindowHeight/2.4862);
  Step:=26;
  SaturnVHeight:=85;
  StepR:=0.1;
  Stepi:=0.1;
  Flighti:=H/2;
  FlightH:=H/2;
  Fi:=0;
  StartITr:=0;
  i:=random(0,360);
  StepRocketI:=2;
  StepRocketR:=2;
  StepTriangle:=2.14;
  HDownUp:=0;
  StepFall := 0.5;
  ra:=H;
  StepTriangleFall:=12;
  AddH:=10;
  
  WayPlanets
  Stars := Picture.Create('Photoes\Stars.bmp');
  Stars.Load('Photoes\Stars.bmp');
  Planet := Picture.Create('Photoes\Planet.bmp');
  Planet.Load('Photoes\Planet.bmp');
  {*}Planet.Transparent := True;
  EarthObject := Picture.Create('Photoes\Sputnik1.bmp');
  EarthObject.Load('Photoes\Sputnik1.bmp');
  {*}EarthObject.Transparent := True;
  SaturnV1 := Picture.Create('Photoes\SaturnV.bmp');
  SaturnV1.Load('Photoes\SaturnV.bmp');
  {*}SaturnV1.Transparent := True;
  DeathStar := Picture.Create('Photoes\DeathStar.bmp');
  DeathStar.Load('Photoes\DeathStar.bmp');
  {*}DeathStar.Transparent := True;
  Tower := Picture.Create('Photoes\Tower.bmp');
  Tower.Load('Photoes\Tower.bmp');
  {*}Tower.Transparent := True;
////////////////////////////////////////////////////////////////////////////////

  LockDrawing();
  XSaturnHeight := StartX + (H/2+SaturnVHeight/2-5)*cos(((H/2/StepR*Stepi*-1)+90)*Pi/180);
  YSaturnHeight := StartY + (H/2+SaturnVHeight/2-5)*sin((H/2+90)*Pi/180);
  
  While True do
  begin
    While ((((H+(H2-H1))/2)+Fr+ChangeH)>(H/2+AddH)) or (Gotcha=0) do
    begin
      Count:=0;
      WhiteOrTranparent:=1;
      MoveTo(round(StartX), round(StartY));
      StarsDraw();
      RingDraw();
      if Gotcha=1 then
      begin
        if a < StepFall then
        begin
          a+=0.01
        end;
      end;
      
      LineDraw(StartLine, fall);
      EarthObjectDraw(i);
      if Starwars<>1 then
      begin
        EarthDraw();
      end
      else
      begin
        StarWarsDraw();
      end;
      if StartButtonNumber=0 then
      begin
        SaturnBeforeLiftoffDraw();
      end
      else
      begin
        if EndFlight<>1 then
        begin
          StartLine:=SaturnLiftoffDraw(Fi, Fr);
          Fi+=StepRocketI;
          Fr+=StepRocketR;
        end;
      end;
      TowerDraw(Fi);
      if (Gotcha=1) and (ReadyToFall=0) then
      begin
        StepRocketR:=StepRocketR*-1;
        Fall:=1;
        ReadyToFall:=1;
      end;
      i-=2;
      
      redraw();
    end;
  end
end.