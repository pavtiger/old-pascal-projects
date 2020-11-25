uses GraphABC, Utils;
var SIZEY: integer;
var SIZEX: integer;
var Map: array [1..501] of array [1..601] of integer;
var SecondArr: array [1..501] of array [1..601] of integer;
var StartPoint: array [1..2] of integer;
var Good: array [1..501] of array [1..601] of real;
var AStar: array [1..501] of array [1..601] of integer; //1 - x + |2 - x - |3 - y + |4 - y - |5 - xy + | 6 - xy - |7 - x +, y - |8 - y +, x -|||
var AStarHelper: array [1..501] of array [1..601] of integer;
var y, x, rand, rezim, Cheat, CheatRezim, FoodRand: integer;
var a: string;
var tr, k, ch, ch2, Ready: integer;
var b: boolean;

procedure KeyDown(key: integer);//Паша
begin
  if key = VK_Enter then
  begin
    Ready:=1;
  end;

  if key = VK_Escape then
  begin
    CloseWindow;
  end;

  if key = VK_Space then
  begin
    if rezim=0 then
    begin
      rand:=2;
      rezim:=1;
    end
    else
    begin
      rand:=10;
      rezim:=0;
    end;
  end;
end;

procedure MouseDown(x, y, mb: integer);//Лёша
begin
    var ix, iy: integer;
    for ix:= 1 to SIZEX do
    begin
        for iy:= 1 to SIZEY do
        begin
            if(tr >= k)then
            begin
                Good[iy][ix] += 200 / ((ix - x) * (ix - x) + (iy - y) * (iy - y) + 200);
            end
            else
            begin
                Good[iy][ix] += -200 / ((ix - x) * (ix - x)  + (iy - y) * (iy - y) + 200);
            end;
        end;
    end;
    if(tr >= k)then
    begin
        SetBrushColor(ARGB(200, 250, 250, 0));
        Circle(x, y, 10);
    end
    else
    begin
        SetPixel(x, y, clBlack);
        SetPixel(x + 1, y, clBlack);
        SetPixel(x, y + 1, clBlack);
        SetPixel(x + 1, y + 1, clBlack);
        tr += 1;
    end;
    if(ch2 > ch + tr - 2) then
    begin
        for ix:= 1 to SIZEX do
        begin
            for iy:= 1 to SIZEY do
            begin
                var p, p2: integer;
                p := 127 + round(Good[iy][ix] * 127);
                p2 := 128 - round(Good[iy][ix] * 127);
                if(127 + Good[iy][ix] * 127 < 0)then
                begin
                    p := 0;
                end
                else if(127 + Good[iy][ix] * 127 > 255)then
                begin
                    p := 255;
                end
                else if(128 - Good[iy][ix] * 127 > 255)then
                begin
                    p2 := 255;
                end
                else if(128 - Good[iy][ix] * 127 < 0)then
                begin
                    p2 := 0;
                end;
                if SecondArr[iy, ix]<>-1 then
                begin
                  SetPixel(ix, iy, RGB(p, p2, 0));
                end;
            end;
        end;
    end;
    ch2 += 1;
end;

procedure Gribock();//Дима
begin
  var i, g: integer;
  var pic: Picture;
  pic := Picture.Create('no.png');
  pic.Load('no.png');
  pic.Draw(0, 0);
  for i := 1 to SIZEX do
  begin
    for g := 1 to SIZEY do
    begin
      if(getpixel(i, g) = ARGB(255, 100, 100, 100)) then
        SecondArr[g, i] := -1;
    end;
  end;
end;

procedure Points();//Паша
begin
  var x, y: integer;
  for y:=1 to SIZEY do
  begin
    for x:=1 to SIZEX do
    begin
      if Map[y, x]=1 then//Нашли единицы
      begin
        FoodRand:=random(0, 10000000{round(49*Good[y, x]+50)});
        //TextOut(1, 1, FoodRand);
        if FoodRand=0 then
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
  SIZEY:=201;
  SIZEX:=201;
  SetWindowHeight(SIZEY);
  SetWindowWidth(SIZEX);
  rand:=2;
  StartPoint[1]:=round(SIZEX/2);//X
  StartPoint[2]:=round(SIZEX/2);//Y
  //Gribock();
  SecondArr[StartPoint[1], StartPoint[2]]:=1;//Ставим 1 для процеса
  OnKeyDown := KeyDown;
  //print('Введите кол-во еды.');
  read(k);
  //print('Введите кол-во вредных для плесени условий.');
  read(ch);
  //print('Нажмите на точки где поставить еду, а потом на точки где будут плохие условия.');
  tr := 0;
  while ready=0 do
  begin
    OnMouseDown:=MouseDown;
  end;
  
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
          //2: SetPixel(x, y, clRed);
        end
      end;
    end;
  end;
end.