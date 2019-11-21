program ball;

uses GraphABC;
var
  Car, Rud: Picture;

var
  H, CR, Y, Ru, T, ST, KeyID, KeyIsDown: integer;

procedure KeyDown(key: integer);
begin
  KeyIsDown:=1;
  KeyID:=key;
end;
procedure KeyUp(key: integer);
begin
  KeyIsDown:=2;
  KeyID:=key;
end;

procedure doKeyboard();
begin
  if KeyIsDown=2 then
  begin
    KeyIsDown:=0;
  end;
  if KeyIsDown = 1 then
  begin
    if KeyID = VK_Right then
    begin
      TapR:=1;
      if T > ST + 20 then
      begin
        T := T;
      end
      else
      begin
        T := T + 1;
      end;
    end;
    
    
    if KeyID = VK_Left then
    begin
      if T < ST - 20 then
      begin
        T := T;
      end
      else
      begin
        T := T - 1;
      end;
    end;  
    KeyIsDown := 0;
  end;
end;

begin
  OnKeyDown := KeyDown;
  OnKeyUp := KeyUp;
  ST := 90;
  T := ST;
  Y := 250;
  MaximizeWindow;
  H := 200;//высота и длина машины
  CR := 3;//кол-во дорог
  Car := Picture.Create('TeslaGreen3_.bmp');//Машина
  Car.Load('TeslaGreen3_.bmp');//Машина
  Car.Transparent := True;
  Rud := Picture.Create('road.png');//Дорога
  Rud.Load('road.png');//Дорога
  LockDrawing;
  while True do
  begin
    doKeyboard();
    doSensors();
    doWork();
    doExportData();
    if T > ST then
    begin
      Y := Y + round(T - ST);
    end;
    if T < ST then
    begin
      Y := Y - round(ST - T);
    end;
    
    If TapR = 1 then
    begin
      TapR:=2;//нажата кнопка
    end;
    If TapR = 2 then
    begin
      TapR:=0;//отпущена
    end;
    Ru := Ru + 20;
    Rud.Draw(0 - Ru, 0, WindowWidth * 2, WindowHeight);
    Car.Draw(50, y, T, H, H);
    redraw();
    if Ru > 968 then
    begin
      Ru := 0;
    end;
  end;
end.