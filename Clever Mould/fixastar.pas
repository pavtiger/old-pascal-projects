uses GraphABC, Utils;
var SIZEY: integer;
var SIZEX: integer;
var Map: array [1..501] of array [1..601] of integer;
var SecondArr: array [1..501] of array [1..601] of integer;
var StartPoint: array [1..2] of integer;
var AStar: array [1..501] of array [1..601] of integer; //1 - x + |2 - x - |3 - y + |4 - y - |5 - xy + | 6 - xy - |7 - x +, y - |8 - y +, x -|||
var AStarHelper: array [1..501] of array [1..601] of integer;
var Good: array [1..501] of array [1..601] of real;
var Tr2: array [1..501] of array [1..601] of boolean;
var y, x: integer;
var a: string;
var tr, k, ch, ch2: integer;
var b: boolean;
var rand, rezim, Cheat, CheatRezim, rand2: integer;

procedure Asstar(l, x3, y3, startx, starty: integer);
begin
    if((l = 1)and(x3 > 1)and(y3 > 1)and(x3 < 600)and(y3 < 500)and(AStar[y3][x3] > 0)and(Map[y3][x3] <> -1))then
    begin
        if((Map[y3][x3 + 1] <> -1)and(Astar[y3][x3 + 1] = 0)or(Map[y3][x3 + 1] <> -1)and(Astar[y3][x3 + 1] > Astar[y3][x3] + 1))then
        begin
            Astar[y3][x3 + 1] := Astar[y3][x3] + 1;
            AstarHelper[y3][x3 + 1] := 2;
        end;
        if((Map[y3][x3 - 1] <> -1)and(Astar[y3][x3 - 1] = 0)or(Map[y3][x3 - 1] <> -1)and(Astar[y3][x3 - 1] > Astar[y3][x3] + 1))then
        begin
            Astar[y3][x3 - 1] := Astar[y3][x3] + 1;
            AstarHelper[y3][x3 - 1] := 1;
        end;
        if((Map[y3 + 1][x3] <> -1)and(Astar[y3 + 1][x3] = 0)or(Map[y3 + 1][x3] <> -1)and(Astar[y3 + 1][x3] > Astar[y3][x3] + 1))then
        begin
            Astar[y3 + 1][x3] := Astar[y3][x3] + 1;
            AstarHelper[y3 + 1][x3] := 4;
        end;
        if((Map[y3 - 1][x3] <> -1)and(Astar[y3 - 1][x3] = 0)or(Map[y3 - 1][x3] <> -1)and(Astar[y3 - 1][x3] > Astar[y3][x3] + 1))then
        begin
            Astar[y3 - 1][x3] := Astar[y3][x3] + 1;   //1 - x + |2 - x - |3 - y + |4 - y - |5 - xy + | 6 - xy - |7 - x +, y - |8 - y +, x -|||
            AstarHelper[y3 - 1][x3] := 3;
        end;
        if((Map[y3 + 1][x3 + 1] <> -1)and(Astar[y3 + 1][x3 + 1] = 0)or(Map[y3 + 1][x3 + 1] <> -1)and(Astar[y3 + 1][x3 + 1] > Astar[y3][x3]))then
        begin
            Astar[y3 + 1][x3 + 1] := Astar[y3][x3] + 1;
            AstarHelper[y3 + 1][x3 + 1] := 6;
        end;
        if((Map[y3 - 1][x3 - 1] <> -1)and(Astar[y3 - 1][x3 - 1] = 0)or(Map[y3 - 1][x3 - 1] <> -1)and(Astar[y3 - 1][x3 - 1] > Astar[y3][x3]))then
        begin
            Astar[y3 - 1][x3 - 1] := Astar[y3][x3] + 1;
            AstarHelper[y3 - 1][x3 - 1] := 5;
        end;
        if((Map[y3 - 1][x3 + 1] <> -1)and(Astar[y3 - 1][x3 + 1] = 0)or(Map[y3 - 1][x3 + 1] <> -1)and(Astar[y3 - 1][x3 + 1] > Astar[y3][x3]))then
        begin
            Astar[y3 - 1][x3 + 1] := Astar[y3][x3] + 1;
            AstarHelper[y3 - 1][x3 + 1] := 8;
        end;
        if((Map[y3 + 1][x3 - 1] <> -1)and(Astar[y3 + 1][x3 - 1] = 0)or(Map[y3 + 1][x3 - 1] <> -1)and(Astar[y3 + 1][x3 - 1] > Astar[y3][x3]))then
        begin
            Astar[y3 + 1][x3 - 1] := Astar[y3][x3] + 1;
            AstarHelper[y3 + 1][x3 - 1] := 7;
        end;
    end
    else if(l = 2)then
    begin
        var x2, y2: integer;
        x2 := x3;
        y2 := y3;
        while((x2 <> startx)and(y2 <> starty))do
        begin
             //1 - x + |2 - x - |3 - y + |4 - y - |5 - xy + | 6 - xy - |7 - x +, y - |8 - yё +, x -|||
            SetPenWidth(5);
            if(AStarHelper[y2][x2] = 1)then // поменять потом на белый цвет
            begin
                SetPixel(x2, y2, ClRed);
                x2 += 1;
                SetPixel(x2, y2, ClRed);
            end
            else if(AStarHelper[y2][x2] = 2)then
            begin
                SetPixel(x2, y2, ClRed);
                x2 -= 1;
                SetPixel(x2, y2, ClRed);
            end
            else if(AStarHelper[y2][x2] = 3)then
            begin
                SetPixel(x2, y2, ClRed);
                y2 += 1;
                SetPixel(x2, y2, ClRed);
            end
            else if(AStarHelper[y2][x2] = 4)then
            begin
                SetPixel(x2, y2, ClRed);
                y2 -= 1;
                SetPixel(x2, y2, ClRed);
            end
            else if(AStarHelper[y2][x2] = 5)then
            begin
                SetPixel(x2, y2, ClRed);
                y2 += 1;
                x2 += 1;
                SetPixel(x2, y2, ClRed);
            end
            else if(AStarHelper[y2][x2] = 6)then //1 - x + |2 - x - |3 - y + |4 - y - |5 - xy + | 6 - xy - |7 - x +, y - |8 - y +, x -|||
            begin
                SetPixel(x2, y2, ClRed);
                y2 -= 1;
                x2 -= 1;
                SetPixel(x2, y2, ClRed);
            end
            else if(AStarHelper[y2][x2] = 7)then
            begin
                SetPixel(x2, y2, ClRed);
                x2 += 1;
                y2 -= 1;
                SetPixel(x2, y2, ClRed);
            end
            else if(AStarHelper[y2][x2] = 8)then
            begin
                SetPixel(x2, y2, ClRed);
                x2 -= 1;
                y2 += 1;
                SetPixel(x2, y2, ClRed);
            end;
        end;
        SetPenWidth(1);
    end
    else if((x3 > 1)and(x3 < SIZEX - 1)and(y3 > 1)and(x3 < SIZEY - 1)and(l = 3)and(Map[y3][x3] <> -1))then
    begin
        if((AStar[y3 + 1][x3] > 0)and(AStar[y3][x3] = 0)or((AStar[y3 + 1][x3] > 0)and(AStar[y3 + 1][x3] < AStar[y3][x3])))then
        begin
            AStar[y3][x3] := AStar[y3 + 1][x3] + 1;
            AstarHelper[y3][x3] := 3;
        end;
        if(((AStar[y3 - 1][x3] > 0)and(AStar[y3][x3] = 0))or((AStar[y3 - 1][x3] > 0)and(AStar[y3 - 1][x3] < AStar[y3][x3])))then
        begin
            AStar[y3][x3] := AStar[y3 - 1][x3] + 1;
            AstarHelper[y3][x3] := 4;
        end;
        if(((AStar[y3][x3 + 1] > 0)and(AStar[y3][x3] = 0))or((AStar[y3][x3 + 1] > 0)and(AStar[y3][x3 + 1] < AStar[y3][x3])))then
        begin
            AStar[y3][x3] := AStar[y3][x3 + 1] + 1;
            AstarHelper[y3][x3] := 1;
        end;
        if(((AStar[y3][x3 - 1] > 0)and(AStar[y3][x3] = 0))or((AStar[y3][x3 - 1] > 0)and(AStar[y3][x3 - 1] < AStar[y3][x3])))then
        begin
            AStar[y3][x3] := AStar[y3][x3 - 1] + 1;  //1 - x + |2 - x - |3 - y + |4 - y - |5 - xy + | 6 - xy - |7 - x +, y - |8 - y +, x -|||
            AstarHelper[y3][x3] := 2;
        end;
        if(((AStar[y3 + 1][x3 + 1] > 0)and(AStar[y3][x3] = 0))or((AStar[y3 + 1][x3 + 1] > 0)and(AStar[y3 + 1][x3 + 1] < AStar[y3][x3])))then
        begin
            AStar[y3][x3] := AStar[y3 + 1][x3 + 1] + 1;
            AstarHelper[y3][x3] := 5;
        end;
        if(((AStar[y3 - 1][x3 - 1] > 0)and(AStar[y3][x3] = 0))or((AStar[y3 - 1][x3 - 1] > 0)and(AStar[y3 - 1][x3 - 1] < AStar[y3][x3])))then
        begin
            AStar[y3][x3] := AStar[y3 - 1][x3 - 1] + 1;
            AstarHelper[y3][x3] := 6;
        end;
        if(((AStar[y3 - 1][x3 + 1] > 0)and(AStar[y3][x3] = 0))or((AStar[y3 - 1][x3 + 1] > 0)and(AStar[y3 - 1][x3 + 1] < AStar[y3][x3])))then
        begin
            AStar[y3][x3] := AStar[y3 - 1][x3 + 1] + 1;
            AstarHelper[y3][x3] := 7;
        end;
        if(((AStar[y3 + 1][x3 - 1] > 0)and(AStar[y3][x3] = 0))or((AStar[y3 + 1][x3 - 1] > 0)and(AStar[y3 + 1][x3 - 1] < AStar[y3][x3])))then
        begin
            AStar[y3][x3] := AStar[y3 + 1][x3 - 1] + 1;
            AstarHelper[y3][x3] := 8;
        end;
    end;
end;

procedure MouseDown(x, y, mb: integer);
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
        Good[y][x] := -1;
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
                end;
                if(127 + Good[iy][ix] * 127 > 255)then
                begin
                    p := 255;
                end;
                if(128 - Good[iy][ix] * 127 > 255)then
                begin
                    p2 := 255;
                end;
                if(128 - Good[iy][ix] * 127 < 0)then
                begin
                    p2 := 0;
                end;
                if((SecondArr[iy][ix] <> -1)and(getpixel(ix, iy) <> ARGB(255, 255, 255, 0)))then
                begin
                    SetPixel(ix, iy, RGB(p, p2, 0));
                end;
            end;
        end;
    end;
    ch2 += 1;
end;

procedure KeyDown(key: integer);
begin
  if key = VK_Escape then
  begin
    CloseWindow;
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
  setwindowheight(SIZEY);
  setwindowwidth(SIZEX);
  var pic: Picture;
  pic := Picture.Create('no.png');
  pic.Load('no.png');
  pic.Draw(0, 0);
  for i := 1 to SIZEX do
  begin
    for g := 1 to SIZEY do
    begin
      if((getpixel(i, g) = ARGB(255, 100, 100, 100)))then
        SecondArr[g, i] := -1;
    end;
  end;
end;

procedure Points();
begin
  var x, y, Ex: integer;
  for y:=2 to SIZEY - 1 do
  begin
    rand := 3;
    rand2 := 1;
    for x:=2 to SIZEX - 1 do
    begin
      rand := 3;
      rand2 := 1;
      Asstar(3, x, y, StartPoint[1], StartPoint[2]);
      Asstar(1, x, y, StartPoint[1], StartPoint[2]);
      if Map[y, x]=1 then//Нашли единицы
      begin
////////////////////////////////////////////////////////////////////////////////
            var tr10, tr11: integer;
            rand:=1;
            Ex:=0;
            if Good[y, x]>-0.5 then
            begin
              rand:=4;
              if Good[y, x]>0.1 then
              begin
                rand:=11;
                if Good[y, x]>0.5 then
                begin
                  rand:=21;
                  if Good[y, x]>0.7 then
                  begin
                    Ex:=1;
                  end;
                end;
              end;
            end;
            {rand := 3;
              if(Good[y][x] > 0.1)then
              begin
                  rand += 15;
                  if(Good[y][x] > 0.4)then
                  begin
                      rand += 15;
                  end;
                  if(Good[y][x] > 0.6)then
                  begin
                      rand := 99999999999;
                  end;
              end
              else if(Good[y][x] < -0.2)then
              begin
                  rand -= 1;
                  if(Good[y][x] < -0.5)then
                  begin
                      rand -= 2;
                  end;
              end;}
              
              if (random(0, rand)=0)and(Ex=0) then
              begin
                  SecondArr[y, x]:=2;
                  if SecondArr[y+1, x]=0 then 
                  begin
                      SecondArr[y+1, x]+=1;
                  end;
                  if (SecondArr[y+1, x]=0) {and (random(0, rand2) = 0))} then SecondArr[y+1, x]+=1;
                  if (SecondArr[y-1, x]=0) {and (random(0, rand2) = 0))} then SecondArr[y-1, x]+=1;
                  if (SecondArr[y, x+1]=0) {and (random(0, rand2) = 0))} then SecondArr[y, x+1]+=1;
                  if (SecondArr[y, x-1]=0) {and (random(0, rand2) = 0))} then SecondArr[y, x-1]+=1;
              tr11 := 0;
            end;
            rand := 3;
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

function Tr2Helper(x, y: integer): boolean;
begin
    var chet: integer;
    if(Tr2[y][x + 1] = false)then chet += 1;
    if(Tr2[y][x - 1] = false)then chet += 1;
    if(Tr2[y + 1][x] = false)then chet += 1;
    if(Tr2[y - 1][x] = false)then chet += 1;
    if(Tr2[y + 1][x + 1] = false)then chet += 1;
    if(Tr2[y - 1][x - 1] = false)then chet += 1;
    if(Tr2[y + 1][x - 1] = false)then chet += 1;
    if(Tr2[y - 1][x + 1] = false)then chet += 1;
    if(Tr2[y][x + 2] = false)then chet += 1;
    if(Tr2[y][x - 2] = false)then chet += 1;
    if(Tr2[y + 2][x] = false)then chet += 1;
    if(Tr2[y - 2][x] = false)then chet += 1;
    if(Tr2[y + 2][x + 2] = false)then chet += 1;
    if(Tr2[y - 2][x - 2] = false)then chet += 1;
    if(Tr2[y + 2][x - 2] = false)then chet += 1;
    if(Tr2[y - 2][x + 2] = false)then chet += 1;
    if(Tr2[y][x + 3] = false)then chet += 1;
    if(Tr2[y][x - 3] = false)then chet += 1;
    if(Tr2[y + 3][x] = false)then chet += 1;
    if(Tr2[y - 3][x] = false)then chet += 1;
    if(Tr2[y + 3][x + 3] = false)then chet += 1;
    if(Tr2[y - 3][x - 3] = false)then chet += 1;
    if(Tr2[y + 3][x - 3] = false)then chet += 1;
    if(Tr2[y - 3][x + 3] = false)then chet += 1;
    if(Tr2[y][x + 4] = false)then chet += 1;
    if(Tr2[y][x - 4] = false)then chet += 1;
    if(Tr2[y + 4][x] = false)then chet += 1;
    if(Tr2[y - 4][x] = false)then chet += 1;
    if(Tr2[y + 4][x + 4] = false)then chet += 1;
    if(Tr2[y - 4][x - 4] = false)then chet += 1;
    if(Tr2[y + 4][x - 4] = false)then chet += 1;
    if(Tr2[y - 4][x + 4] = false)then chet += 1;
    if(Tr2[y][x + 5] = false)then chet += 1;
    if(Tr2[y][x - 5] = false)then chet += 1;
    if(Tr2[y + 5][x] = false)then chet += 1;
    if(Tr2[y - 5][x] = false)then chet += 1;
    if(Tr2[y + 5][x + 5] = false)then chet += 1;
    if(Tr2[y - 5][x - 5] = false)then chet += 1;
    if(Tr2[y + 5][x - 5] = false)then chet += 1;
    if(Tr2[y - 5][x + 5] = false)then chet += 1;
    if(chet = 40)then
    begin
        result := true;
    end
    else
    begin
        result := false;
    end;
end;

////////////////////////////////////////////////////////////////////////////////
begin
  rand := 5;
  rand2 := 1;
  OnKeyDown := KeyDown;
  SIZEY:=301;
  SIZEX:=301;
  StartPoint[2]:=7;//round(SIZEX/2);//X 
  StartPoint[1]:=100;//round(SIZEX/2);//Y
  Gribock();
  var ix, iy, per: integer;
  ix := StartPoint[1];
  iy := StartPoint[2];
  Points();
  if(Map[iy][ix] <> -1)then
  begin
      AStar[iy][ix] := 1;
  end
  else
  begin
      print('error');
  end;
  per := 1;
  Asstar(per, ix, iy, 0, 0);
  for y:= iy downto 2 do
  begin
      for x:= ix to SIZEX - 1 do
      begin
          Asstar(per + 2, x, y, 0, 0);
          Asstar(per, x, y, 0, 0);
      end;
  end;
  for x := ix to SIZEX - 1 do
  begin
      for y:= iy downto 2 do
      begin
          Asstar(per + 2, x, y, 0, 0);
          Asstar(per, x, y, 0, 0);
      end;
  end;
  for x := ix downto 2 do
  begin
      for y:= iy downto 2 do
      begin
          Asstar(per + 2, x, y, 0, 0);
          Asstar(per, x, y, 0, 0);
      end;
  end;
  for y := iy downto 2 do
  begin
      for x:= ix downto 2 do
      begin
          Asstar(per + 2, x, y, 0, 0);
          Asstar(per, x, y, 0, 0);
      end;
  end;
  {
  for x:=ix to SIZEX - 2 do
  begin
      for y:=iy to SIZEY - 2 do
      begin
          Asstar(per + 2, x, y, 0, 0);
          Asstar(per, x, y, 0, 0);
      end;
  end;
  for y:=iy to SIZEY - 2 do
  begin
      for x:=ix to SIZEX - 2 do
      begin
          Asstar(per + 2, x, y, 0, 0);
          Asstar(per, x, y, 0, 0);
      end;
  end;
  for x:=ix to SIZEX - 2 do
  begin
      for y:=iy to SIZEY - 2 do
      begin
          Asstar(per + 2, x, y, 0, 0);
          Asstar(per, x, y, 0, 0);
      end;
  end;
  for y:=iy to SIZEY - 2 do
  begin
      for x:=ix downto 2 do
      begin
          Asstar(per + 2, x, y, 0, 0);
          Asstar(per, x, y, 0, 0);
      end;
  end;
  for x:= SIZEX to 2 do
  begin
      for y:= 2 to SIZEY - 2 do
      begin
          Asstar(per + 2, x, y, 0, 0);
          Asstar(per, x, y, 0, 0);
      end;
  end;
  for x:= SIZEX to 2 do
  begin
      for y:= SIZEY to 2 do
      begin
          Asstar(per + 2, x, y, 0, 0);
          Asstar(per, x, y, 0, 0);
      end;
  end;
  for y:=iy downto 2 do
  begin
      for x:=ix downto 2 do
      begin
          Asstar(per + 2, x, y, 0, 0);
          Asstar(per, x, y, 0, 0);
      end;
  end;
  for x:=ix downto 2 do
  begin
      for y:=iy downto 2 do
      begin
          Asstar(per + 2, x, y, 0, 0);
          Asstar(per, x, y, 0, 0);
      end;
  end;
  for y:=iy downto 2 do
  begin
      for x:=ix to SIZEX - 2 do
      begin
          Asstar(per + 2, x, y, 0, 0);
          Asstar(per, x, y, 0, 0);
      end;
  end;
  for x:=ix to SIZEX - 2 do
  begin
      for y:=iy downto 2 do
      begin
          Asstar(per + 2, x, y, 0, 0);
          Asstar(per, x, y, 0, 0);
      end;
  end;
  for y:=iy to SIZEY - 2 do
  begin
      for x:=ix downto 2 do
      begin
          Asstar(per + 2, x, y, 0, 0);
          Asstar(per, x, y, 0, 0);
      end;
  end;
  for x:=ix downto 2 do
  begin
      for y:=iy to SIZEY - 2 do
      begin
          Asstar(per + 2, x, y, 0, 0);
          Asstar(per, x, y, 0, 0);
      end;
  end;
  }
  //print('Введите кол-во еды, а потом введите кол-во вредных для плесени условий');
  read(k);
  read(ch);
  //print('Нажмите на точки где поставить n еды, а потом на точки где будут плохие условия');
  tr := 0;
  SecondArr[StartPoint[1], StartPoint[2]]:=1;//Ставим 1 для процеса
  {Если стаит 1 значит эта клетка будет разростаться}
  {Если цифры больше то значит клетка там уже какое-то время}
        
  var Mil, x5, y5: integer;
  var tr3: boolean;
  While True do
  begin
    SetPixel(301, 301, clYellow);
    Points();
    OnMouseDown := MouseDown;
    for y:=1 to SIZEY do
    begin
        for x:=1 to SIZEX do
        begin
          case Map[y, x] of
          1:SetPixel(x, y, clYellow);
          end;
          if((x > 1)and(y > 1)and(x < SIZEX - 1)and(y < SIZEY - 1))then
          begin
              Asstar(per, x, y, StartPoint[1], StartPoint[2]);
              Asstar(per + 2, x, y, StartPoint[1], StartPoint[2]);
          end;
          if(Tr2[y][x] = true){and(Tr2Helper(x, y) = true and Tr2Helper(x + 1, y + 1) = true and Tr2Helper(x - 1, y - 1) = true and Tr2Helper(x - 1, y + 1) = true and Tr2Helper(x + 1, y - 1) = true))}then
          begin
              Asstar(per + 1, x, y, StartPoint[2], StartPoint[1]);
              {Tr2[y - 2][x - 2] := true;
              Tr2[y + 2][x + 2] := true;
              Tr2[y + 2][x - 2] := true;
              Tr2[y - 2][x + 2] := true;}
          end;{
          if(Map[y][x] <> -1)then
          begin 
              if((Good[y][x] <= -1)and(Map[y][x] = 1)and(AStar[y][x] <> 0))then
              begin
                  Tr2[y][x] := true;
              end;
          end};
        end;
    end;
  end;
end.