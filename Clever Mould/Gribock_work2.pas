uses GraphABC, Utils;
var SIZEY: integer;
var SIZEX: integer;
var Map: array [1..501] of array [1..601] of integer;
var SecondArr: array [1..501] of array [1..601] of integer;
var EndMould: array [1..100000] of array [1..2] of integer;
var StartPoint: array [1..2] of integer;
var i, a, y, x: integer;

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
  var x, y, EndCount: integer;
  //for y := 1 to SIZEY do
  //begin
    //for x := 1 to SIZEX do
    //begin
      //if (Map[y, x] = 1) and ((x > 1) or (x < SIZEX) or (y > 1) or (y < SIZEY)) then//����� �������
      //begin
      EndCount:=1;
      While EndMould[1, 1]<>0 do
      begin
        x:=EndMould[EndCount, 1];
        y:=EndMould[EndCount, 2];
        EndCount+=1;
        
        if random(0, 2) = 0 then
        begin
          a:=1;
          
          {}if SecondArr[y + 1, x] = 0 then
          begin
            SecondArr[y + 1, x] += 1;
            EndMould[a, 1]:=y + 1;
            EndMould[a, 2]:=x;
            a+=1;
          end;
          
          {}if SecondArr[y - 1, x] = 0 then
          begin
            SecondArr[y - 1, x] += 1;
            EndMould[a, 1]:=y - 1;
            EndMould[a, 2]:=x;
            a+=1;
          end;
          
          {}if SecondArr[y, x + 1] = 0 then
          begin
            SecondArr[y, x + 1] += 1;
            EndMould[a, 1]:=y;
            EndMould[a, 2]:=x + 1;
            a+=1;
          end;
          
          {}if SecondArr[y, x - 1] = 0 then
          begin
            SecondArr[y, x - 1] += 1;
            EndMould[a, 1]:=y;
            EndMould[a, 2]:=x - 1;
            a+=1;
          end;
        //end;
      //end;
    //end
    end
    else
    begin
      EndCount-=1;
    end;
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
  FloodFill(1, 1, clBlack);
  SIZEY := 501;
  SIZEX := 601;
  StartPoint[1] := 300; //round(SIZEX/2);//X
  StartPoint[2] := 300;  //round(SIZEX/2);//Y
  EndMould[1, 1]:=StartPoint[1];
  EndMould[1, 2]:=StartPoint[2];
  Gribock();
  SecondArr[StartPoint[1], StartPoint[2]] := 1;
  {���� ����� 1 ������ ��� ������ ����� ������������}
  {���� ����� ������ �� ������ ������ ��� ��� �����-�� �����}
  
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