uses Graph3D;
var i: real;
var rr := Rectangle3D(-3.5,-2,0,3,2,Colors.MediumPurple);
rr.Rotate(v3d(0,1,0),30);
//var стрелки := CoordinateSystem(5);
begin
  i:=-1;
  
  While True do
  begin
    i+=0.1;
    //стрелки.Rotate(V3D(0,0,1),1);
    FileModel3D(1, i, 0, 'TRON_Light_Cycle1982_v2.3ds');
    sleep(100);
    //ClearWindow
  end;
end.