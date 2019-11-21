program ball;

uses GraphABC;
var
  Car, Rud, Rest, Mark: Picture;

var
  MarkX, H, Question, Y, Ru, Turn, STurn, TapRight, TapLeft, BLeft, BRight, Step, Esc, CarRound, S1, S2, S3, S4, S5, i: integer;

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
  if key = VK_Space then
  begin
    Question:=1;
  end;
  if key = VK_Escape then
  begin
    Esc := 1;
  end;
  
  if key = VK_Enter then
  begin
    CarRound := 1;
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
  S1:=-40;
  S2:=98;
  S3:=244;
  S4:=390;
  S5:=535;
  H := 250;//высота и длина машины
  Car := Picture.Create('NewMainCar2.bmp');//Машина
  Car.Load('NewMainCar2.bmp');//Машина
  Car.Transparent := True;
  Rud := Picture.Create('road.png');//Дорога
  Rud.Load('road.png');//Дорога
  Rest := Picture.Create('Restarting.gif');//Машина
  Rest.Load('Restarting.gif');//Машина
  Rest.Transparent := True;
  Mark := Picture.Create('Big.bmp');//Машина
  Mark.Load('Big.bmp');//Машина
  Mark.Transparent := True;
  LockDrawing;
  while True do
  begin
    Step := 5;
    Turn := STurn;
    Y := S3;
    i:=0;
    Question:=0;
    MarkX:=WindowWidth;
    while Esc = 0 do
    begin
      if CarRound = 1 then
      begin
        if round((Y + H - round(WindowHeight / 20)) / round(WindowHeight / 5)) = 1 then
        begin
          if Y > S1 then
          begin
            if Y >= S1-Step then
            begin
              Y-=Step;
            end
            else
            begin
              Step:=S1-Y;
            end
          end;
          if Y > S1 then
          begin
            Y-=Step;
          end;
          if Y = S1 then
          begin
            CarRound := 0;
          end;
        end;
        
        if round((Y + H - round(WindowHeight / 20)) / round(WindowHeight / 5)) = 2 then
        begin
          if Y < S2 then
          begin
            if Y <=S2-Step then
            begin
              Y+=Step;
            end
            else
            begin
              Step:=S2-Y;
            end
          end;
          if Y > S2 then
          begin
            Y-=Step;
          end;
          if Y = S2 then
          begin
            CarRound := 0;
          end;
        end;
        
        if round((Y + H - round(WindowHeight / 20)) / round(WindowHeight / 5)) = 4 then
        begin
          if Y < S4 then
          begin
            if Y <= S4-Step then
            begin
              Y+=Step;
            end
            else
            begin
              Step:=S4-Y;
            end
          end;
          if Y > S4 then
          begin
            Y-=Step;
          end;
          if Y = S4 then
          begin
            CarRound := 0;
          end;
        end;
        
        if round((Y + H - round(WindowHeight / 20)) / round(WindowHeight / 5)) = 5 then
        begin
          if Y < S5 then
          begin
            if Y <= S5-Step then
            begin
              Y+=Step;
            end
            else
            begin
              Step:=S5-Y;
            end
          end;
          if Y > S5 then
          begin
            Y-=Step;
          end;
          if Y = S5 then
          begin
            CarRound := 0;
          end;
        end;
      end;
      
      if Turn > STurn then
      begin
        if Y > 525 then
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
        if Y < -22 then
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
      
      Ru := Ru + i;
      if i<17 then
      begin
        i+=2;
      end
      else
      begin
        i:=i;
      end;
      Rud.Draw(0 - Ru, 0, WindowWidth * 2, WindowHeight);
      Car.Draw(50, y, Turn, H, H);
      if Question = 1 then
      begin
        if MarkX<670 then
        begin
          MarkX:=MarkX;
        end
        else
        begin
          MarkX-=9;
        end;
        Mark.Draw(MarkX, S3-60, H+100, H+100);
        redraw();
      end;
      redraw();
      if Ru > 968 then
      begin
        Ru := 33;
      end;
    end;
    Esc := 0;
    Rest.Draw(100, 0 - 10, WindowWidth - 200, WindowHeight);
    redraw();
    sleep(900);
  end
end.