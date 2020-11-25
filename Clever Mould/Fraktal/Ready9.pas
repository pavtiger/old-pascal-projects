uses GraphABC;
var x1, y1, H, I, step, new_step: integer; str: string;
const NVl = 600;
var arrTriangles: array [1..NVl] of array [1..4] of array [1..2] of integer;

procedure lineDraw(side: boolean; x1, y1, x2, y2: integer);
begin
  MoveTo(x1, y1);
  LineTo(x1+8, y1);
  LineTo(x2+8, y2);
  LineTo(x2, y2);
  LineTo(x1, y1);
  
  SetPenColor(ARGB(255, 0, 0, 0));
  SetPenWidth(5);
  if side = True then
  begin
    Line(x1+6, y1+4, x2+2, y2-4);
  end
  else
  begin
    Line(x1+2, y1+4, x2+6, y2-4);
  end;
  SetPenColor(ARGB(255, 100, 100, 100));
  SetPenWidth(1);
end;


procedure TriangleDraw(H: real; x1, y1:integer);
begin
  step:= 15;
  new_step:= step*2;
  SetPenColor(ARGB(255, 100, 100, 100));
  
  if H<=40 then
  else
  begin
    {Left}  TriangleDraw(H/2-H/step, x1-round(H/4+H/new_step-1), round(y1+H/2*Sqrt(3)/4+H/new_step-2));
    {Right} TriangleDraw(H/2-H/step, x1+round(H/4+H/new_step-1), round(y1+H/2*Sqrt(3)/4+H/new_step-2));
    {Up}    TriangleDraw(H/2-H/step, x1, round(y1-H/2*Sqrt(3)/4-H/new_step+2));
  
    {Down}  Rectangle(x1-round(H/2), y1+round(H/2*Sqrt(3)/2), x1+round(H/2)+5, y1+round(H/2*Sqrt(3)/2)+8);
    {Right} lineDraw(True, x1+round(H/2), y1+round(H/2*Sqrt(3)/2), x1, y1-round(H/2*Sqrt(3)/2));
    {Left}  lineDraw(False, x1-round(H/2)-3, y1+round(H/2*Sqrt(3)/2), x1-3, y1-round(H/2*Sqrt(3)/2));
    
    SetPenColor(ARGB(255, 0, 0, 0));
    SetPenWidth(5);
    {=}Line(x1-round(H/2)-3, y1+round(H/2*Sqrt(3)/2)+4, x1+round(H/2)+5, y1+round(H/2*Sqrt(3)/2)+4);
    if H>90 then
    begin
      {0, H} arrTriangles[I, 4, 1]:= round(H);
      {1, x} arrTriangles[I, 1, 1]:= x1-round(H/4);
      {1, y} arrTriangles[I, 1, 2]:= y1+3;
      {2, x} arrTriangles[I, 2, 1]:= x1+round(H/4)+5;
      {2, y} arrTriangles[I, 2, 2]:= y1+3;
      {3, x} arrTriangles[I, 3, 1]:= x1;
      {3, y} arrTriangles[I, 3, 2]:= y1+round(H/2*Sqrt(3)/2);
      
      I+=1;
    end;
    SetPenColor(ARGB(255, 100, 100, 100));
    SetPenWidth(1);
  end;
end;

procedure Errase();
begin
  var r: integer;
  for r:=1 to NVl do
  begin
    SetPenColor(clWhite);//ARGB(255, 0, 0, 0));
    SetPenWidth(5);
    
    {Up}    Line(arrTriangles[r, 1, 1]+1 + round(arrTriangles[r, 4, 1]/30), arrTriangles[r, 1, 2] - round(arrTriangles[r, 4, 1]/17), arrTriangles[r, 2, 1] - round(arrTriangles[r, 4, 1]/30), arrTriangles[r, 2, 2] - round(arrTriangles[r, 4, 1]/17));
    //{Right} Line(arrTriangles[r, 2, 1]-5, arrTriangles[r, 2, 2], arrTriangles[r, 3, 1]+1, arrTriangles[r, 3, 2]);
    //{Left}  Line(arrTriangles[r, 3, 1]+5, arrTriangles[r, 3, 2]+3, arrTriangles[r, 1, 1]+7, arrTriangles[r, 2, 2]);
  end;
end;

////////////////////////////////////////////////////////////////////////////////
begin
  MaximizeWindow;
  FloodFill(1, 1, ARGB(255, 0, 0, 0));
  SetBrushColor(clTransparent);
  print('Input H:');
  read(str);
  
  x1:=round(WindowWidth/2);
  y1:=round(WindowHeight/2);
  I:= 1;  
  H:= 700;
  
  if str='' then
    H:=round(WindowWidth/1.4)
   else
    H:=StrToInt(str);
  println(H);
  
  TriangleDraw(H, x1, y1);
  Errase();
  FloodFill(x1, y1-round(H/2*Sqrt(3)/2), ARGB(255, 0, 0, 0));
end.