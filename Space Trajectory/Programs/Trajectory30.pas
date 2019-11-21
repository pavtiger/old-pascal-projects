program SpaceTrajectory;
{$reference 'PresentationCore.dll'}
uses GraphABC, VCL;

var Stars, Planet, EarthObject, SaturnV1, DeathStar, Tower: Picture;
var H, EarthX, EarthY, RingH, HeightObject, R, Count, Step, WhiteOrTranparent, 
  SaturnVHeight, StartButtonNumber, EndFlight, Gotcha, StarWars, ready, GoAway, 
  ReadyToFall, Test, NLevels, CaptureReady, StartPlay, SaturnVHeightNoFire, BadCapture: integer;
var X, Y, StartX, StartY, XTr, YTr, iTr, RTr, XSaturn1, YSaturn1, XSaturn2, 
  YSaturn2, dx, dy, Stepi, StepR, ask, HSaturn1, iSaturn1, HSaturn2, iSaturn2, H2, DI, XRocket, 
  YRocket, XSaturnHeight, YSaturnHeight, SaturnTriangle, TriangleX1, TriangleY1, 
  TriangleX2, TriangleY2, FlightH, Flighti, StepTriangle, Fi, H1, StartLine, 
  HDownUp, ChangeH, TowerTriangle, fall, StartFalli, Fr, StepRocketR, StepRocketI, 
  FallCount, SaturnRocketTriangle, StepTriangleFall, Between, StartITr, AddH, StepObject, i, 
  RocketR, RocketI, Minus, DXCapture, DYCapture, CaptureH, GoBackStep, GoBack, TriangleR1, 
  TriangleR2, ExplodeH, DCapture, XSaturnHeightStart, YSaturnHeightStart, XSaturnHeightTower, YSaturnHeightTower, TowerMinus, SaturnVHeightTower: real;
type RealArr = array [1..3] of real;

var mp3_LiftOff := new System.Windows.Media.MediaPlayer;
var mp3_BackGraund := new System.Windows.Media.MediaPlayer;  
////////////////////////////////////////////////////////////////////////////////
const
  TurnPlanet: array [1..2] of integer = (
    80
  , 0
);

const
  MinusTower: array [1..2] of integer = (
    64
  , 0
);

const
  NeedTower: array [1..2] of integer = (
    1
  , 0
);

const
  WayPlanets: array [1..2] of string = (
    'Earth.bmp'
  , 'DeathStar.bmp'
);

const
  WayRockets: array [1..2] of string = (
    'SaturnV3.bmp'
  , 'X-Wing.bmp'
);

const
  WayObjects: array [1..2] of string = (
    'Sputnik1.bmp'
  , 'DartVader.bmp'
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
      if StartButtonNumber=0 then
      begin
        StartPlay:=1;
      end;
      StartButtonNumber:=1;
    end;
    
    if key = VK_Back then
    begin
      Test:=1;
    end;
    
    if key = VK_Space then
    begin
      if StartButtonNumber=1 then
      begin
        Gotcha:=1;
      end;
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
  
  
  
  {==}procedure EarthObjectDraw(i: real);
  begin
    if CaptureReady=0 then
    begin
      X := StartX + R*cos(i*Pi/180);
      Y := StartY + R*sin(i*Pi/180);
      EarthObject.Draw(round(X)-round(HeightObject/2), round(Y)-round(HeightObject/2), HeightObject, HeightObject);
    end
    else
    begin
      //EarthObject.Draw(round(TriangleX1), round(TriangleY1), HeightObject, HeightObject);
    end;
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
    {-}TriangleX2:=StartX + (H/2-MinusTower[NLevels])*cos(((H/2*-1)+90)*Pi/180);
    {|}TriangleY2:=StartY + (H/2-MinusTower[NLevels])*sin((H/2+90)*Pi/180);
    SaturnTriangle:=Triangle(TriangleX1, TriangleY1, TriangleX2, TriangleY2);
    
    SaturnRocketDraw(XSaturnHeight+5, YSaturnHeight+5, SaturnTriangle-190);
  end;
  
   
  
  {==}procedure TowerDraw(flight: real);
  begin
    if (flight=0) then
    begin
      TowerTriangle:=round(SaturnTriangle-190);
      Tower.Draw(round(XSaturnHeightTower-SaturnVHeightNoFire/2), round(YSaturnHeightTower-SaturnVHeightNoFire/2), round(SaturnTriangle-190), round(SaturnVHeightTower-MinusTower[NLevels]), round(SaturnVHeightTower-MinusTower[NLevels]));
    end
    else
    begin
      Tower.Draw(round(XSaturnHeightTower-SaturnVHeightNoFire/2), round(YSaturnHeightTower-SaturnVHeightNoFire/2), round(TowerTriangle), round(SaturnVHeightTower-MinusTower[NLevels]), round(SaturnVHeightTower-MinusTower[NLevels]));
    end;
  end;
  
  
  
  {==}function SaturnLiftoffDraw(flighti1, flightr1: real):real;
  begin   
    if flighti1=0 then
    begin
      XSaturn1 := StartX + (FlightH)*cos(((Flighti*-1)+90)*Pi/180);
      YSaturn1 := StartY + (FlightH)*sin((Flighti+90)*Pi/180);
      H1:=TrajectoryRunH1(XSaturn1, YSaturn1);
      H2:=TrajectoryRunH2(XSaturn1, YSaturn1)-10;
      DI:=TrajectoryRunDI(XSaturn1, YSaturn1)-10;
      SaturnTriangle:=Triangle(TriangleX1, TriangleY1, TriangleX2, TriangleY2)-30;
      SaturnRocketTriangle:=SaturnTriangle;
    end
    else
    begin
      SaturnTriangle-=StepTriangle;
      Between:=SaturnTriangle-SaturnRocketTriangle;
      if (Between<210) and (Gotcha=1) then
      begin
        FallCount+=StepTriangleFall;
        SaturnRocketTriangle-=StepTriangleFall;
      end
      else
      begin
        SaturnRocketTriangle-=StepTriangle;
      end;
    end;
    
    if (XRocket<0) or (XRocket>1024) or (YRocket<0) or (YRocket>721) then
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
      StartFalli:=RocketI;
      Minus:=9;
      ready:=1;
    end;

    RocketR:=(((H+(H2-H1))/2)+flightr1+ChangeH)-Minus;
    RocketI:=(H/2+flighti1+DI/2);
    
    XRocket:=StartX + RocketR*cos(((RocketI*-1)+90)*Pi/180);
    YRocket:=StartY + RocketR*sin((RocketI+90)*Pi/180);
    TriangleR1:=H1+flightr1+GoBack;
    TriangleR2:=H2+flightr1-GoBack;
    
    GoBack+=GoBackStep;
    {#}TriangleX1:=StartX + (TriangleR1)*cos{}((((H/2+flighti1+GoBack){}*-1)+90)*Pi/180);
    {#}TriangleY1:=StartY + (TriangleR1)*sin{}(((H/2+flighti1+GoBack){}+90)*Pi/180);
    {#}TriangleX2:=StartX + (TriangleR2)*cos{}((((H/2+flighti1+DI-GoBack){}*-1)+90)*Pi/180);
    {#}TriangleY2:=StartY + (TriangleR2)*sin{}(((H/2+flighti1+DI-GoBack){}+90)*Pi/180);
    
    //Circle(round(TriangleX1), round(TriangleY1), 3);
    //Circle(round(TriangleX2), round(TriangleY2), 3);
    //Line(round(TriangleX1), round(TriangleY1), round(TriangleX2), round(TriangleY2));
    
    SaturnRocketDraw(XRocket, YRocket, SaturnRocketTriangle+90);
    result:=RocketI;
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
      if ((XTr<=0)or(XTr>=1024)or(YTr<=0)or(YTr>=721)) or ((RTr<=H/2) and (GoAway=1)) then
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
    Planet.Draw(EarthX, EarthY, TurnPlanet[NLevels], H, H);
  end;
  
  
  
  {==}procedure StarWarsDraw();
  begin
    DeathStar.Draw(EarthX, EarthY, 0, H, H);
  end;
  
  
  
  {==}procedure StarsDraw();
  begin
    Stars.Draw(0, 0, 1024, 721);
  end;
  
  
  
  {==}procedure RingDraw();
  begin
    Circle(round(StartX), round(StartY), RingH);
  end;
  
////////////////////////////////////////////////////////////////////////////////
begin
  mp3_LiftOff.Open(new System.Uri('LiftOff.mp3', System.UriKind.Relative));
  mp3_BackGraund.Open(new System.Uri('MakingWater.mp3', System.UriKind.Relative));
  //MaximizeWindow;
  //OnKeyUp := KeyUp;
  SetWindowSize(1024, 721);
  CenterWindow;
  OnKeyDown := KeyDown;
  Window.Title:='Space Trajectory';
  SetPenColor(clYellow);
  SetPenWidth(2);
  SetBrushColor(clTransparent);
  
  //WayPlanets[NLevels]
  //WayRockets[NLevels]
  //WayObjects[NLevels]
  //TurnPlanet[NLevels]
////////////////////////////////////////////////////////////////////////////////

  LockDrawing();
  NLevels:=1;
  mp3_BackGraund.Stop();
  mp3_BackGraund.Play();
  
  While True do
  begin
    H:=200;//round(721/3.43333333333);
    EarthX:=round(1024/2)-round(H/2);
    EarthY:=round(721/2)-round(H/2);
    RingH:=H+random(39, 100);
    StartX:=round(1024/2);
    StartY:=round(721/2);
    HeightObject:=70;
    R:=RingH;//round(721/2.4862);
    Step:=26;
    SaturnVHeightNoFire:=75;
    SaturnVHeight:=150;
    SaturnVHeightTower:=SaturnVHeight;
    StartButtonNumber:=0;
    StepR:=0.1;
    Stepi:=0.1;
    Flighti:=H/2;
    FlightH:=H/2;
    Fi:=0;
    StartITr:=0;
    i:=random(0,360);
    StepRocketI:=2.5;
    StepRocketR:=StepRocketI;
    StepTriangle:=2.6;
    HDownUp:=0;
    StepTriangleFall:=12;
    AddH:=30;
    StepObject:=random(20, 30)/10;
    CaptureH:=50;
    Gotcha:=0;
    GoBack:=0;
    GoBackStep:=0.2;
    ExplodeH:=10;
    TowerMinus:=35;
    XSaturnHeight := round(StartX + (H/2+SaturnVHeight/2-5-MinusTower[NLevels])*cos(((H/2/StepR*Stepi*-1)+90)*Pi/180));
    YSaturnHeight := round(StartY + (H/2+SaturnVHeight/2-5-MinusTower[NLevels])*sin((H/2+90)*Pi/180));
    
    XSaturnHeightStart := round(StartX + (H/2+SaturnVHeight/2-5)*cos(((H/2/StepR*Stepi*-1)+90)*Pi/180));
    YSaturnHeightStart := round(StartY + (H/2+SaturnVHeight/2-5)*sin((H/2+90)*Pi/180));
    
    XSaturnHeightTower := round(StartX + (H/2+SaturnVHeight/2-5-TowerMinus)*cos(((H/2/StepR*Stepi*-1)+90)*Pi/180));
    YSaturnHeightTower := round(StartY + (H/2+SaturnVHeight/2-5-TowerMinus)*sin((H/2+90)*Pi/180));
////////////////////////////////////////////////////////////////////////////////
    Stars := Picture.Create('Photoes\Everything Else\Stars.bmp');
    Stars.Load('Photoes\Everything Else\Stars.bmp');
    
    Planet := Picture.Create('Photoes\!Planets\'+ WayPlanets[NLevels]);
    Planet.Load('Photoes\!Planets\'+ WayPlanets[NLevels]);
    {*}Planet.Transparent := True;
    
    EarthObject := Picture.Create('Photoes\!Objects\'+ WayObjects[NLevels]);
    EarthObject.Load('Photoes\!Objects\'+ WayObjects[NLevels]);
    {*}EarthObject.Transparent := True;
    
    SaturnV1 := Picture.Create('Photoes\!Rockets\'+ WayRockets[NLevels]);
    SaturnV1.Load('Photoes\!Rockets\'+ WayRockets[NLevels]);
    {*}SaturnV1.Transparent := True;
    
    Tower := Picture.Create('Photoes\Everything Else\Tower.bmp');
    Tower.Load('Photoes\Everything Else\Tower.bmp');
    {*}Tower.Transparent := True;
////////////////////////////////////////////////////////////////////////////////
    While ((((H+(H2-H1))/2)+Fr+ChangeH)>(H/2+AddH)) or (Gotcha=0) or (StartButtonNumber=0) do
    begin
      if StartPlay=1 then
      begin
        //mp3_LiftOff.Stop();
        //mp3_LiftOff.Play();
        StartPlay:=0;
      end;
      Count:=0;
      WhiteOrTranparent:=1;
      MoveTo(round(StartX), round(StartY));
      StarsDraw();
      RingDraw();
      LineDraw(StartLine, fall);
      EarthObjectDraw(i);
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
        end
        else
        begin
          break;
        end;
      end;
      if NeedTower[NLevels]=1 then
      begin
        TowerDraw(Fi);
      end;
      {if DXCapture>DYCapture then
      begin
        DCapture:=DXCapture;
      end
      else
      begin
        DCapture:=DYCapture;
      end;}
      if (Gotcha=1) and (ReadyToFall=0) then
      begin
        DXCapture:=abs(TriangleX2-X);
        DYCapture:=abs(TriangleY2-Y);
        StepRocketR:=StepRocketR*-1;
        Fall:=1;
        ReadyToFall:=1;
        SaturnV1 := Picture.Create('Photoes\!Rockets\SaturnV.bmp');
        SaturnV1.Load('Photoes\!Rockets\SaturnV.bmp');
        SaturnVHeight:=100;
        {*}SaturnV1.Transparent := True;
        if (DXCapture+DYCapture)/2<CaptureH then
        begin
          CaptureReady:=1;
        end;
      end;
      if Starwars<>1 then
      begin
        EarthDraw();
      end
      else
      begin
        StarWarsDraw();
      end;
      {if (StartButtonNumber=1) and (Gotcha=0) and (DCapture<ExplodeH) then
      begin
        sleep(0);
      end;}
      i-=StepObject;
      {}redraw();
    end;
    StartButtonNumber:=0;
    ClearWindow(clBlack);
    SetFontSize(150);
    SetFontColor(clYellow);
    DCapture:=abs(DXCapture+DYCapture);
    if DCapture>=CaptureH*2 then
    begin
      DCapture:=CaptureH*2;
    end;
    BadCapture:=round((100/(CaptureH*2))*DCapture);
    TextOut(100, 200, 100-BadCapture+'%');
    redraw();
    
    While StartButtonNumber=0 do
    begin
      sleep(0);
    end;
    //NLevels+=1;
  end
end.