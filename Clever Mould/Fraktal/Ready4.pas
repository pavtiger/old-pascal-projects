uses GraphABC;
var x1, y1, H, I, r: integer; str: string;
const NVl = 100;
var arrTriangles: array [1..NVl] of array [1..3] of array [1..2] of integer;

procedure lineDraw(side: boolean; x1, y1, x2, y2: integer);
begin
  MoveTo(x1, y1);
  LineTo(x1+8, y1);
  LineTo(x2+8, y2);
  LineTo(x2, y2);
  LineTo(x1, y1);
  
  SetPenColor(clWhite);
  SetPenWidth(5);
  if side = True then
  begin
    Line(x1+6, y1+4, x2+2, y2-4);
  end
  else
  begin
    Line(x1+2, y1+4, x2+6, y2-4);
  end;
  SetPenColor(clBlack);
  SetPenWidth(1);
end;


procedure TriangleDraw(H: real; x1, y1:integer);
begin
  SetPenColor(clBlack);
  if H<=30 then
  else
  begin
    {Left}  TriangleDraw(H/2, x1-round(H/4), round(y1+H/2*Sqrt(3)/4));
    {Right} TriangleDraw(H/2, x1+round(H/4), round(y1+H/2*Sqrt(3)/4));
    {Up}    TriangleDraw(H/2, x1, round(y1-H/2*Sqrt(3)/4));
  
    {Down}  Rectangle(x1-round(H/2), y1+round(H/2*Sqrt(3)/2), x1+round(H/2)+5, y1+round(H/2*Sqrt(3)/2)+8);
    {Right} lineDraw(True, x1+round(H/2), y1+round(H/2*Sqrt(3)/2), x1, y1-round(H/2*Sqrt(3)/2));
    {Left}  lineDraw(False, x1-round(H/2)-3, y1+round(H/2*Sqrt(3)/2), x1-3, y1-round(H/2*Sqrt(3)/2));
    
    SetPenColor(clWhite);
    SetPenWidth(5);
    {=}Line(x1-round(H/2)-7, y1+round(H/2*Sqrt(3)/2)+4, x1+round(H/2)+5, y1+round(H/2*Sqrt(3)/2)+4);
    if H>50 then
    begin
      {1, x}arrTriangles[I, 1, 1]:= x1-round(H/4);
      {1, y}arrTriangles[I, 1, 2]:= y1+3;
      {2, x}arrTriangles[I, 2, 1]:= x1+round(H/4)+5;
      {2, y}arrTriangles[I, 2, 2]:= y1+3;
      {3, x}arrTriangles[I, 3, 1]:= x1;
      {3, y}arrTriangles[I, 3, 2]:= y1+round(H/2*Sqrt(3)/2);
      I+=1;
      //{Up}    Line(x1-round(H/4), y1+3, x1+round(H/4)+5, y1+3);
      //{Right} Line(x1+round(H/4)+1, y1, x1, y1+round(H/2*Sqrt(3)/2));
      //{Left}  Line(x1+4, y1+round(H/2*Sqrt(3)/2), x1-round(H/4)+4, y1);
    end;
    SetPenColor(clBlack);
    SetPenWidth(1);
  end;
  
  //SetPenColor(clWhite);
  //SetPenWidth(5);
  //Line(x1, y1+4, x1+round(H), y1+4);
  //SetPenWidth(7);
  //SetPenColor(clBlack);
  //SetPenWidth(1);
end;

procedure Errase(H: real; x1, y1:integer);
begin
  //if H>50 then
  //begin
  //  {Up}    Line(x1-round(H/4), y1+3, x1+round(H/4)+5, y1+3);
  //  {Right} Line(x1+round(H/4)+1, y1, x1, y1+round(H/2*Sqrt(3)/2));
  //  {Left}  Line(x1+4, y1+round(H/2*Sqrt(3)/2), x1-round(H/4)+4, y1);
  //end;
end;

////////////////////////////////////////////////////////////////////////////////
begin
  MaximizeWindow;
  SetBrushColor(clTransparent);
  print('Input H:');
  read(str);
  
  x1:=round(WindowWidth/2); //round(WindowWidth/2)-round(H/2);
  y1:=round(WindowHeight/2); //round((WindowHeight-round(H/2*Sqrt(3)))/2+H/2*Sqrt(3));
  I:= 1;  
  H:= 700;
  
  if str='' then
    H:=round(WindowWidth/1.4)
   else
    H:=StrToInt(str);
  println(H);
  
  TriangleDraw(H, x1, y1);
  
  for r:=1 to NVl do
  begin
    {1, x}//arrTriangles[I, 1, 1]:= x1-round(H/4);
    {1, y}//arrTriangles[I, 1, 2]:= y1+3;
    {2, x}//arrTriangles[I, 2, 1]:= x1+round(H/4);
    {2, y}//arrTriangles[I, 2, 2]:= y1;
    {3, x}//arrTriangles[I, 3, 1]:= x1;
    {3, y}//arrTriangles[I, 3, 2]:= y1+round(H/2*Sqrt(3)/2);
    
    SetPenColor(clRed);
    SetPenWidth(5);
    
    {Up}    Line(arrTriangles[r, 1, 1], arrTriangles[r, 1, 2], arrTriangles[r, 2, 1]+5, arrTriangles[r, 2, 2]);
    {Right} //Line(arrTriangles[r, 2, 1]+1, arrTriangles[r, 2, 2], arrTriangles[r, 3, 1], arrTriangles[r, 3, 2]);
    {Left}  //Line(arrTriangles[r, 3, 1], arrTriangles[r, 3, 2], arrTriangles[r, 1, 1]+4, arrTriangles[r, 2, 2]);
  end;
end.