uses GraphABC, Utils;
var SIZEY: integer;
var SIZEX: integer;
var Map: array [1..501] of array [1..601] of integer;
var SecondArr: array [1..501] of array [1..601] of integer;
var StartPoint: array [1..2] of integer;
var y, x, rand, rezim, Cheat, CheatRezim, mx, my: integer;
var a: string;

{==}procedure MouseDown(mousex, mousey, mb: integer);
begin
  mx:= mousex;
  my:= mousey;
end;
  
{==}procedure KeyDown(key: integer);
begin
  if key = VK_Escape then
  begin
    CloseWindow;
  end;


  if key = VK_Up then
  begin
    if Map[my-1, mx] = 0 then
    begin
      my-=1;
    end;
  end;
  
  if key = VK_Down then
  begin
    if Map[my+1, mx] = 0 then
    begin
      my+=1;
    end;
  end;
  
  if key = VK_Left then
  begin
    if Map[my, mx-1] = 0 then
    begin
      mx-=1;
    end;
  end;
  
  if key = VK_Right then
  begin
    if Map[my, mx+1] = 0 then
    begin
      mx+=1;
    end;
  end;
  
  
  if key = VK_Space then
  begin
    if rezim=0 then
    begin
      rand:=0;
      rezim:=1;
    end
    else
    begin
      rand:=2;
      rezim:=0;
    end;
  end;
end;

procedure Gribock();
begin
  var i, g: integer;
  SetWindowHeight(501);
  SetWindowWidth(601);
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
        if random(0, rand)=0 then
        begin
          {}SecondArr[y, x]:=2;
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
  rand:=2;
  mx:= 2;
  my:= 2;
  OnMouseDown := MouseDown;
  OnKeyDown := KeyDown;
  SIZEY:=501;
  SIZEX:=601;
  StartPoint[2]:=7;//round(SIZEX/2);//X
  StartPoint[1]:=490;//round(SIZEX/2);//Y
  Gribock();
  
  SecondArr[StartPoint[1], StartPoint[2]]:=1;//Ставим 1 для процеса
  {Если стаит 1 значит эта клетка будет разростаться}
  {Если цифры больше то значит клетка там уже какое-то время}
  
  SetBrushColor(clRed);
  While True do
  begin
    Points();
    Circle(mx, my, 3);
    for y:=1 to SIZEY do
    begin
      for x:=1 to SIZEX do
      begin
        case Map[y, x] of
          1: SetPixel(x, y, clYellow);
          //2: SetPixel(x, y, clRed);
        end
      end;
    end;
  end;
end.