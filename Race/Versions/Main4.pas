program ball;

uses GraphABC;
var
  Car, Rud, Rest: Picture;

var
  H, Y, Ru, Turn, STurn, TapRight, TapLeft, BLeft, BRight, Step, Esc, CarRound: integer;

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
  if key = VK_Escape then
  begin
    Esc := 1;
  end;
  
  if key = VK_Enter then
  begin
    CarRound:=1;
  end;
  
  if key = VK_Right then
  begin
    TapRight := 1;
    if Turn > STurn + 20 then
    begin
      Turn := Turn;
    end
      else
    begin
      Turn := Turn + 1;
    end;
  end;
  
  if key = VK_Left then
  begin
    TapLeft := 1;
    if Turn < STurn - 20 then
    begin
      Turn := Turn;
    end
      else
    begin
      Turn := Turn - 1;
    end;
  end;
end;

begin
  OnKeyDown := KeyDown;
  Window.Title := 'Гонка';
  OnKeyUp := KeyUp;
  MaximizeWindow;
  H := 200;//высота и длина машины
  Car := Picture.Create('TeslaGreen3.bmp');//Машина
  Car.Load('TeslaGreen3.bmp');//Машина
  Car.Transparent := True;
  Rud := Picture.Create('road.png');//Дорога
  Rud.Load('road.png');//Дорога
  Rest := Picture.Create('Restarting.gif');//Машина
  Rest.Load('Restarting.gif');//Машина
  Rest.Transparent := True;
  LockDrawing;
  while True do
  begin
    Step := 5;
    STurn := 90;
    Turn := STurn;
    Y := 250;
    while Esc = 0 do
    begin
      if CarRound=1 then
      begin
        Print(round((Y+H-round(WindowHeight/20))/round(WindowHeight/5)));
        redraw();
        sleep(1000);
        CarRound:=0;
      end;
      
      if Turn > STurn then
      begin
        if Y > WindowHeight - H then
        begin
          Turn -= 1;
        end
        else
        begin
          Y := Y + round(Turn - STurn);
        end
      end;
      
      if Turn < STurn then
      begin
        if Y < 0 then
        begin
          Turn += 1;
        end
        else
        begin
          Y := Y - round(STurn - Turn);
        end;
      end;
      
      if BRight = 1 then//сигнал вернуться
      begin
        if Turn >= STurn + Step then//можем ли повернуть
        begin
          Turn := Turn - Step;//поворот
          if Turn = STurn then//проверяем повернулись ли мы уже
          begin
            Step := 5;//сброс
            BRight := 0;//сброс
          end
        end
        else
        begin
          Step := Turn - STurn;//доворот
        end;
      end;
      
      if BLeft = 1 then//сигнал вернуться
      begin
        if Turn <= STurn - Step then//можем ли повернуть
        begin
          Turn := Turn + Step;//поворот
          if Turn = STurn then//проверяем повернулись ли мы уже
          begin
            Step := 5;//сброс
            BLeft := 0;//сброс
          end
        end
        else
        begin
          Step := STurn - Turn;//доворот
        end;
      end;
      
      Ru := Ru + 20;
      Rud.Draw(0 - Ru, 0, WindowWidth * 2, WindowHeight);
      Car.Draw(50, y, Turn, H, H);
      redraw();
      if Ru > 968 then
      begin
        Ru := 0;
      end;
    end;
    Esc := 0;
    Rest.Draw(100, 0 - 10, WindowWidth - 200, WindowHeight);
    redraw();
    sleep(900);
  end
end.