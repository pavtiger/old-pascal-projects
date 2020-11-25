uses GraphABC, Utils;

const SIZEX = 767;
const SIZEY = 669;
var Map: array [1..SIZEY] of array [1..SIZEX] of integer;
var SecondArr: array [1..SIZEY] of array [1..SIZEX] of integer;
var StartPoint: array [1..2] of integer;
var y, x, rand, rezim, Cheat, CheatRezim, mx, my, radious, Rb, i: integer;
var Boom: boolean;
var pic: Picture;

{==}procedure MouseDown(mousex, mousey, mb: integer);
begin
  if mb = 1 then
  begin
    mx:= mousex;
    my:= mousey;
  end
  else
  begin
    StartPoint[2]:=mousex; //round(SIZEX/2);//X
    StartPoint[1]:=mousey; //round(SIZEX/2);//Y
    SecondArr[StartPoint[1], StartPoint[2]]:=1;//Ставим 1 для процеса
      {Если стаит 1 значит эта клетка будет разростаться}
      {Если цифры больше то значит клетка там уже какое-то время}
  end;
end;
  
{==}procedure KeyDown(key: integer);
begin
  if key = VK_Escape then
  begin
    CloseWindow;
  end;
  
  if key = VK_Enter then
  begin
    Boom:= True;
  end;

  if key = VK_Up then
  begin
    if Map[my-radious, mx] = 0 then
    begin
      my-=1;
    end;
  end;
  
  if key = VK_Down then
  begin
    if Map[my+radious, mx] = 0 then
    begin
      my+=1;
    end;
  end;
  
  if key = VK_Left then
  begin
    if Map[my, mx-radious] = 0 then
    begin
      mx-=1;
    end;
  end;
  
  if key = VK_Right then
  begin
    if Map[my, mx+radious] = 0 then
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
  SetWindowHeight(SIZEY);
  SetWindowWidth(SIZEX);
  CenterWindow;
  pic := Picture.Create('Lab.PNG');
  pic.Load('Lab.PNG');
  pic.Draw(0, 0);
  for i := 1 to SIZEX do
  begin
    for g := 1 to SIZEY do
    begin
      //SetPixel(i, g, clRed);
      if(getpixel(i, g) <> ARGB(255, 0, 0, 0)) then
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
        if random(0, rand) = 0 then
        begin
          {=}SecondArr[y, x]:=2;
          if (y>1) and (y<SIZEY-1) and (x>1) and (x<SIZEX-1) then
          begin
            if SecondArr[y+1, x]=0 then SecondArr[y+1, x]:=1;
            if SecondArr[y-1, x]=0 then SecondArr[y-1, x]:=1;
            if SecondArr[y, x+1]=0 then SecondArr[y, x+1]:=1;
            if SecondArr[y, x-1]=0 then SecondArr[y, x-1]:=1;
          end;
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
  rand:= 2;
  Rb:= 8;
  radious:=3;
  mx:= 2;
  my:= 2;
  OnMouseDown := MouseDown;
  OnKeyDown := KeyDown;
  Gribock();
  
  
  While True do
  begin
    Points();
    if Boom then
    begin
      SetPenColor(clBlack);
      for i:=1 to Rb do
      begin
        SetBrushColor(clBlack);
        FillRect(mx-i, my-i, mx+i, my+i);
        SetBrushColor(clRed);
        Circle(mx, my, radious-1);
        sleep(20);
      end;
      
      for x:=-Rb to Rb do
      begin
        for y:=-Rb to Rb do
        begin
          if (my+y>0) and (my+y<SIZEY) and (mx+x>0) and (mx+x<SIZEX) then
            SecondArr[my+y, mx+x]:= 0;
          //SetPixel(mx+x, my+y, clRed);
        end;
      end;
      
      Boom:= False;
    end;
    SetBrushColor(clRed);
    SetPenWidth(1);
    Circle(mx, my, radious-1);
    for y:=1 to SIZEY do
    begin
      for x:=1 to SIZEX do
      begin
        case Map[y, x] of
          1: SetPixel(x, y, clYellow);
          //2: SetPixel(x, y, clRed);
          3: SetPixel(x, y, clOrange);
        end
      end;
    end;
    SetBrushColor(clBlack);
    //Circle(mx, my, 4);
  end;
end.