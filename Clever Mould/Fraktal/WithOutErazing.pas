uses GraphABC;
var x1, y1, H: integer; str:string;

procedure lineDraw(x1, y1, x2, y2: integer);
begin
  MoveTo(x1, y1);
  LineTo(x1+8, y1);
  LineTo(x2+8, y2);
  LineTo(x2, y2);
  LineTo(x1, y1);
  
  SetPenColor(clWhite);
  SetPenWidth(5);
  //Line(x1+2, y1+4, x2+4, y2);
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
    {Right} lineDraw(x1+round(H/2), y1+round(H/2*Sqrt(3)/2), x1, y1-round(H/2*Sqrt(3)/2));
    {Left}  lineDraw(x1-round(H/2)-3, y1+round(H/2*Sqrt(3)/2), x1-3, y1-round(H/2*Sqrt(3)/2));
    
    SetPenColor(clWhite);
    SetPenWidth(5);
    //Line(x1-round(H/2), y1+round(H/2*Sqrt(3)/2)+4, x1+round(H/2)+5, y1+round(H/2*Sqrt(3)/2)+4);
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

////////////////////////////////////////////////////////////////////////////////
begin
  MaximizeWindow;
  SetBrushColor(clTransparent);
  print('Input H:');
  read(str);
  
  x1:=round(WindowWidth/2); //round(WindowWidth/2)-round(H/2);
  y1:=round(WindowHeight/2); //round((WindowHeight-round(H/2*Sqrt(3)))/2+H/2*Sqrt(3));
  
  H:= 700;
  //Rectangle(x1-round(H/2), y1+round(H/2*Sqrt(3)/2), x1+round(H/2), y1+round(H/2*Sqrt(3)/2)+8);
  //lineDraw(x1+round(H/2), y1-round(H/2*Sqrt(3)/2), x1, y1+round(H/2*Sqrt(3)/2));
  //lineDraw(x1-round(H/2)-4, y1-round(H/2*Sqrt(3)/2), x1, y1+round(H/2*Sqrt(3)/2));
  
  if str='' then
    H:=round(WindowWidth/1.4)
   else
    H:=StrToInt(str);
  println(H);
  
  TriangleDraw(H, x1, y1);
end.