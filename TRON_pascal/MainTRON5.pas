uses Graph3D;
var i, Rotation: real;
var Bike:= FileModel3D(0, i, 0, 'TRON_Light_Cycle1982_v2.3ds');

procedure BikeRotation(R: real);
begin
  Bike.Rotate(v3d(0,1,0),R);//Поворот в разные стороны(для поворота)
end;

{==}{procedure KeyDown(key: integer);
begin
  if key = VKEscape then
  begin
    CloseWindow;
  end;
end;}
////////////////////////////////////////////////////////////////////////////////
begin
  {OnKeyDown := KeyDown;}
  Window.Title:='TRON';
  Bike.Scale(1);
  
  i:=-5;
  While True do
  begin
    i+=0.1;
    
    //Bike.Rotate(v3d(0,1,0),10);//Поворот в разные стороны(для поворота)
    Bike.MoveTo(0, i, 0);//Движение Светоцикла
    var Line:=Box(0, i-1, 0.5, 1, 0.1, 0.03, Colors.Blue);
    Line.Rotate(v3d(0, 1, 0), 90);
    
    sleep(10);
  end;
end.