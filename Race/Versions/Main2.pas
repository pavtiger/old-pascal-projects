program ball;

uses GraphABC;
var
  Car, Rud: Picture;

var
  H, CR, Y, Ru, T, ST, TapRight, TapLeft, BLeft, BRight, Step: integer;

procedure KeyUp(key: integer);
begin
  if TapRight = 1 then
  begin
    TapRight := 0;
    BRight := 1;
  end;
  
  if TapLeft = 1 then
  begin
    TapLeft := 0;
    BLeft := 1;
  end;
end;


procedure KeyDown(key: integer);
begin
  if key = VK_Right then
  begin
    TapRight := 1;
    if T > ST + 20 then
    begin
      T := T;
    end
      else
    begin
      T := T + 1;
    end;
  end;
  
  if key = VK_Left then
  begin
    TapLeft := 1;
    if T < ST - 20 then
    begin
      T := T;
    end
      else
    begin
      T := T - 1;
    end;
  end;
end;

begin
  OnKeyDown := KeyDown;//Window.Title
  OnKeyUp := KeyUp;
  Step := 2;
  ST := 90;
  T := ST;
  Y := 250;
  MaximizeWindow;
  H := 200;//высота и длина машины
  CR := 3;//кол-во дорог
  Car := Picture.Create('TeslaGreen3_.bmp');//ћашина
  Car.Load('TeslaGreen3_.bmp');//ћашина
  Car.Transparent := True;
  Rud := Picture.Create('road.png');//ƒорога
  Rud.Load('road.png');//ƒорога
  LockDrawing;
  while True do
  begin
    if T > ST then
    begin
      {if Y > WindowHeight - H then
      begin
        TapRight:=0;
        Bright := 1;
      end
      else}
      begin
        Y := Y + round(T - ST);
      end;
      if T < ST then
      begin
        Y := Y - round(ST - T);
      end;
    end;
    
    if BRight = 1 then//сигнал вернутьс€
    begin
      if T >= ST + Step then//можем ли повернуть
      begin
        T := T - Step;//поворачиваем
        if T <> ST then//провер€ем повернулись ли мы уже
        begin
          Step := T - ST;//доворачиваемс€
        end
      end
      else
      begin
        Step := 2;
        BRight := 0;
      end
    end;
    
    if BLeft = 1 then
    begin
      if T < ST - Step then
      begin
        T := T + Step;
        
      end
      else
      begin
        BLeft := 0;
      end
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