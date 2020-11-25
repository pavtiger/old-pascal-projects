uses GraphABC, Utils;
var SIZEY: integer;
var SIZEX: integer;
var Map: array [1..501] of array [1..601] of integer;
var SecondArr: array [1..501] of array [1..601] of integer;
var StartPoint: array [1..2] of integer;
var i, a, y, x: integer;


procedure Points();
begin
  var x, y: integer;
  for y:=1 to SIZEY do
  begin
    for x:=1 to SIZEX do
    begin
      if (Map[y, x]=1)and((x>1)or(x<SIZEX)or(y>1)or(y<SIZEY)) then//Нашли единицы
      begin
        if random(0, 5)=0 then
        begin
          if SecondArr[x+1, y]=0 then SecondArr[x+1, y]+=1;
          if SecondArr[x-1, y]=0 then SecondArr[x-1, y]+=1;
          if SecondArr[x, y+1]=0 then SecondArr[x, y+1]+=1;
          if SecondArr[x, y-1]=0 then SecondArr[x, y-1]+=1;
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
  FloodFill(1, 1, clBlack);
  SIZEY:=501;
  SIZEX:=601;
  StartPoint[1]:=round(SIZEX/2);//X
  StartPoint[2]:=round(SIZEX/2);//Y
  
  Map[StartPoint[1], StartPoint[2]]:=1;//Ставим 1 для процеса
  SecondArr[StartPoint[1], StartPoint[2]]:=1;
  {Если стаит 1 значит эта клетка будет разростаться}
  {Если цифры больше то значит клетка там уже какое-то время}
  
  While True do
  begin
    Points();
    for y:=1 to SIZEY do
    begin
      for x:=1 to SIZEY do
      begin
        case Map[y, x] of
          //0: SetPixel(x, y, clBlack);
          1: SetPixel(x, y, clYellow);
        end
      end;
    end;
  end;
end.