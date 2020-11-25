uses GraphABC, Utils;
var SIZEY: integer;
var SIZEX: integer;
var Map: array [1..501] of array [1..601] of integer;
var SecondArr: array [1..501] of array [1..601] of integer;
var EndMould: array [1..4000] of array [1..2] of integer;
var StartPoint: array [1..2] of integer;
var i, a, y, x, NumberOfPixels: integer;

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
  for i := 1 to 601 do
  begin
    for g := 1 to 501 do
    begin
      if(SecondArr[g, i] = -1) then
        setpixel(i, g, clBlack);
    end;
  end;
end;

procedure Points();
begin
  var x, y, r, EndCount: integer;
  //for y := 1 to SIZEY do
  //begin
    //for x := 1 to SIZEX do
    //begin
      //if (Map[y, x] = 1) and ((x > 1) or (x < SIZEX) or (y > 1) or (y < SIZEY)) then//Нашли единицы
      //begin
      EndCount:=1;
      a:=2;
      i:=1;
      
      While EndMould[i, 1]<>0 do
      begin
        i+=1;
        NumberOfPixels+=1;
      end;
      i:=0;
      While i<NumberOfPixels do
      begin
        i+=1;
        //if EndMould[EndCount+1, 1]=0 then
        //begin
        //  EndCount:=1;
        //end;
        if(a < 1)then
        begin
            a := 1;
        end;
        if(x < 1)then
        begin
            x := 280;
        end;
        if(y < 1)then
        begin
            y := 300;
        end;
        y:=EndMould[EndCount, 1];
        x:=EndMould[EndCount, 2];
        EndCount+=1;
        
        if EndMould[EndCount+1, 1]=0 then
        begin
          EndCount:=1;
        end;
        
        //if random(0, 2) = 0 then
        //begin
        var i, i2: integer;
          {}if SecondArr[y + 1, x] = 0 then
          begin
            {Ставим пиксель}SecondArr[y + 1, x] += 1;
            {Ставим Пиксель в границу(x)}EndMould[a, 1]:=y + 1;
            {Ставим Пиксель в границу(y)}EndMould[a, 2]:=x;
            a+=1;
          end;
          
          {}if SecondArr[y - 1, x] = 0 then
          begin
            {Ставим пиксель}SecondArr[y - 1, x] += 1;
            {Ставим Пиксель в границу(x)}EndMould[a, 1]:=y - 1;
            {Ставим Пиксель в границу(y)}EndMould[a, 2]:=x;
            a+=1;
          end;
          
          {}if SecondArr[y, x + 1] = 0 then
          begin
            {Ставим пиксель}SecondArr[y, x + 1] += 1;
            {Ставим Пиксель в границу(x)}EndMould[a, 1]:=y;
            {Ставим Пиксель в границу(y)}EndMould[a, 2]:=x + 1;
            a+=1;
          end;
          
          {}if SecondArr[y, x - 1] = 0 then
          begin
            {Ставим пиксель}SecondArr[y, x - 1] += 1;
            {Ставим Пиксель в границу(x)}EndMould[a, 1]:=y;
            {Ставим Пиксель в границу(y)}EndMould[a, 2]:=x - 1;
            a+=1;
          end;
          
          r:=1;
          While EndMould[r, 1]<>0 do
          begin
            EndMould[r, 1]:=EndMould[r+1, 1];
            EndMould[r, 2]:=EndMould[r+1, 2];
            r+=1;
          end;{
          for i:= 1 to 40 do
          begin
            if EndMould[i, 1]<>0 then
            begin
              i2+=1;
            end;
        end;
        a -= i2 - 1;}
        a -= 1;
          //a-=1;
   //end;
   //end;
   //end
   //end
   //else
   //begin
   //EndCount-=1;
   //end;
  end;
  
  for y := 1 to SIZEY do
  begin
    for x := 1 to SIZEX do
    begin
      Map[y, x] := SecondArr[y, x];
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
begin
  //FloodFill(1, 1, clBlack);
  SIZEY := 501;
  SIZEX := 601;
  StartPoint[1] := 300; //round(SIZEX/2);//X
  StartPoint[2] := 300;  //round(SIZEX/2);//Y
  EndMould[1, 1]:=StartPoint[1];
  EndMould[1, 2]:=StartPoint[2];
  Gribock();
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
    sleep(2000);
  end;
end.