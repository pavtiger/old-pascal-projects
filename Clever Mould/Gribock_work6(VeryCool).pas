uses GraphABC, Utils;
var SIZEY: integer;
var SIZEX: integer;
var Map: array [1..501] of array [1..601] of integer;
var SecondArr: array [1..501] of array [1..601] of integer;
var StartPoint: array [1..2] of integer;
var y, x: integer;
var a: string;

{==}procedure KeyDown(key: integer);
begin
  if key = VK_Escape then
  begin
    CloseWindow;
  end;
end;

procedure Gribock();
begin
  var i, g: integer;
  setwindowheight(501);
  setwindowwidth(601);
  var pic: Picture;
  pic := Picture.Create('no.png');
  pic.Load('no.png');
  pic.Draw(0, 0);
  for i := 1 to 601 do
  begin
    for g := 1 to 501 do
    begin
      if(getpixel(i, g) = ARGB(255, 100, 100, 100)) then
        SecondArr[g, i] := -1;
    end;
  end;
end;

procedure Points();
begin
  var x, y: integer;
  for y:=1 to SIZEY do
  begin
    for x:=1 to SIZEX do
    begin
      if Map[y, x]=1 then//Нашли единицы
      begin
        if random(0, 2)=0 then
        begin
          SecondArr[y, x]:=2;
          if SecondArr[y+1, x]=0 then SecondArr[y+1, x]+=1;
          if SecondArr[y-1, x]=0 then SecondArr[y-1, x]+=1;
          if SecondArr[y, x+1]=0 then SecondArr[y, x+1]+=1;
          if SecondArr[y, x-1]=0 then SecondArr[y, x-1]+=1;
        end;
      end;
    end;
  end;
  for y:=1 to SIZEY do
  begin
    for x:=1 to SIZEX do
    begin
      Map[y, x]:=SecondArr[y, x];
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
begin
  //read(a);
  OnKeyDown:=KeyDown;
  SIZEY:=501;
  SIZEX:=601;
  StartPoint[1]:=400;//round(SIZEX/2);//X
  StartPoint[2]:=300;//round(SIZEX/2);//Y
  Gribock();
  
  SecondArr[StartPoint[1], StartPoint[2]]:=1;//Ставим 1 для процеса
  {Если стаит 1 значит эта клетка будет разростаться}
  {Если цифры больше то значит клетка там уже какое-то время}
  
  While True do
  begin
    Points();
    for y:=1 to SIZEY do
    begin
      for x:=1 to SIZEX do
      begin
        case Map[y, x] of
          1: SetPixel(x, y, clYellow);
        end
      end;
    end;
  end;
end.