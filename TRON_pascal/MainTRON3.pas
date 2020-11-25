uses Graph3D;
var i: real;
var Bike:=FileModel3D(0, i, 0, 'TRON_Light_Cycle1982_v2.3ds');
begin
  i:=-5;
  
  While True do
  begin
    i+=0.1;
    //Bike.Rotate(v3d(0,1,0),10);//Поворот в разные стороны(для поворота)
    Bike.MoveTo(0, i, 0);//Движение Светоцикла
    var Rect:=Rectangle3D(0, i-1, 0.5, 0.88, 0.1, Colors.Blue);
    Rect.Rotate(v3d(0,1,0),90);
    
    sleep(100);
  end;
end.