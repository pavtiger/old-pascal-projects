uses GraphABC, Utils;
var
  SIZEY: integer;

var
  SIZEX: integer;

var Map: array [1..501] of array [1..601] of integer;
var SecondArr: array [1..501] of array [1..601] of integer;
var EndMould: array [1..100000] of array [1..2] of integer;
var StartPoint: array [1..2] of integer;
var i, a, y, x, count: integer;

procedure PlusMould(EndX, EndY, c: integer);
begin
  var ix, iy: integer;
  
  EndMould[c, 1]:=EndX;
  EndMould[c, 2]:=EndY;
end;

procedure Gribock();
begin
  var i, g: integer;
  setwindowheight(501);
  setwindowwidth(601);
  var pic: Picture;
  pic := Picture.Create('no.png');
  pic.Load('no.png');
  pic.Draw(0, -5);
  for i := 1 to 601 do
  begin
    for g := 1 to 501 do
    begin
      if(getpixel(i, g) = ARGB(255, 0, 0, 0)) then
        SecondArr[g, i] := -1;
    end;
  end;
end;

procedure Points();
begin
  var x, iy, ix, y, i, Start: integer;
     //if (Map[y, x]=1) and ((x>1) or (x<SIZEX) or (y>1) or (y<SIZEY)) then//Нашли единицы
     //begin
        //TextOut(1, 1, map[Startpoint[1], Startpoint[2]]);
        for i:=1 to 100000 do
        begin
          //if random(0, 3) = 0 then
          //begin
            count:=1;
            a:=1;
            //if EndMould[a, 1]<>0 then
            //begin
            //  x:=EndMould[a, 1];
            //  y:=EndMould[a, 2];
            //end;
            
            if Start=0 then
            begin
              EndMould[1, 1]:=StartPoint[1];
              EndMould[1, 2]:=StartPoint[2];
              Start:=1;
            end;
            
            PlusMould(y + 1, x, count);
            if EndMould[a, 1]<>0 then
            begin
              x:=EndMould[a, 1];
              y:=EndMould[a, 2];
            end;
            {}if SecondArr[y + 1, x]=0 then SecondArr[y + 1, x]+=1;
            count+=1;
            
            
            if EndMould[a, 1]<>0 then
            begin
              x:=EndMould[a, 1];
              y:=EndMould[a, 2];
            end;
            {}if SecondArr[y - 1, x]=0 then SecondArr[y - 1, x]+=1;
            PlusMould(y - 1, x, count);
            count+=1;
            
            
            if EndMould[a, 1]<>0 then
            begin
              x:=EndMould[a, 1];
              y:=EndMould[a, 2];
            end;
            {}if SecondArr[y, x + 1]=0 then SecondArr[y, x + 1]+=1;
            PlusMould(y, x + 1, count);
            count+=1;
            
            
            if EndMould[a, 1]<>0 then
            begin
              x:=EndMould[a, 1];
              y:=EndMould[a, 2];
            end;
            {}if SecondArr[y, x - 1]=0 then SecondArr[y, x - 1]+=1;
            PlusMould(y, x - 1, count);
            count+=1;
            
            for iy:=1 to 2 do
            begin
              for ix:=1 to 100000 do
              begin
                EndMould[ix, iy]:=0;
              end;
            end;
            
            a+=1;
        end;
      //end;
    //end;
    
  for y := 1 to SIZEY do
  begin
    for x := 1 to SIZEX do
    begin
      Map[y, x]:=SecondArr[y, x];
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
begin
  //FloodFill(1, 1, clBlack);
  SIZEY := 501;
  SIZEX := 601;
  StartPoint[2] := 300; //round(SIZEX/2);//X
  StartPoint[1] := 300;  //round(SIZEX/2);//Y
  Gribock();
  Map[StartPoint[1], StartPoint[2]] := 1;//Ставим 1 для процеса
  SecondArr[StartPoint[1], StartPoint[2]] := 1;
  {Если стаит 1 значит эта клетка будет разростаться}
  {Если цифры больше то значит клетка там уже какое-то время}
  
  while True do
  begin
    Points();
    for y := 1 to SIZEY do
    begin
      for x := 1 to SIZEX do
      begin
        case Map[y, x] of
          //0: SetPixel(x, y, clBlack);
          1: SetPixel(x, y, clYellow);
        end
      end;
    end;
  end;
end.