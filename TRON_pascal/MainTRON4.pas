uses Graph3D;
var i: real;
var Bike:=FileModel3D(0, i, 0, 'TRON_Light_Cycle1982_v2.3ds');

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
    //var b := Box(p,Sz3D(2,1,1),Colors.PaleGreen);
    //b.Rotate(V3D(0,1,0),-30);
    //p := P3D(5,1,0);
    
    //Bike.Rotate(v3d(0,1,0),10);//Поворот в разные стороны(для поворота)
    Bike.MoveTo(0, i, 0);//Движение Светоцикла
    var Rect:=Rectangle3D(0, i-1, 0.5, 1, 0.1, Colors.Blue);
    Rect.Rotate(v3d(0,1,0),90);
    
    sleep(100);
  end;
end.