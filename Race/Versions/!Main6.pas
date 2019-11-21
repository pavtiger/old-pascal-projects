program Project;

uses GraphABC, Utils;
var
  Pict, Car, Rud, Rest, Mark: Picture;

var
  P1, P2, P3, NMark, Ready, forr, Rand, MarkX, H, Question, Y, Ru, Turn, STurn, GoAway, TapRight, TapLeft, BLeft, BRight, Step, Esc, CarRound, S1, S2, S3, S4, S5, i: integer;

var marks: array [1..48] of string = (
'Acura'
,'Alfa Romeo'
,'Audi'
,'Bentley'
,'Bogdan'
,'Buick'
,'Cadillac'
,'Chery'
,'Chevrolet'
,'Citroёn'
,'Daewoo'
,'Daihatsu'
,'Dodge'
,'Faw'
,'Ferrari'
,'Gaz'
,'Hafei'
,'Haima'
,'Honda'
,'Hyundai'
,'Infiniti'
,'Iran Khodro'
,'Jaguar'
,'Kamaz'
,'Koenigsegg'
,'Lamborghini'
,'Lexus'
,'Lincoln'
,'Maserati'
,'Mazda'
,'Mercedes'
,'Mercury'
,'Mini'
,'Mitsubishi'
,'Moskvich'
,'Opel'
,'Peugeot'
,'Pontiac'
,'Porshe'
,'Renault'
,'SAAB'
,'Saturn'
,'Scoda'
,'Seat'
,'Subaru'
,'Toyota'
,'Volkswagen'
,'F1'
);

var way: array [1..48] of string = (
'Acura.jpg'
,'Alfa Romeo.jpg'
,'Audi.jpg'
,'Bentley.jpg'
,'Bogdan.jpg'
,'Buick.jpg'
,'Cadillac.jpg'
,'Chery.jpg'
,'Chevrolet.jpg'
,'Citroёn.jpg'
,'Daewoo.jpg'
,'Daihatsu.jpg'
,'Dodge.jpg'
,'Faw.jpg'
,'Ferrari.jpg'
,'Gaz.jpg'
,'Hafei.jpg'
,'Haima.jpg'
,'Honda.jpg'
,'Hyundai.jpg'
,'Infiniti.jpg'
,'Iran Khodro.jpg'
,'Jaguar.jpg'
,'Kamaz.jpg'
,'Koenigsegg.jpg'
,'Lamborghini.jpg'
,'Lexus.jpg'
,'Lincoln.jpg'
,'Maserati.jpg'
,'Mazda.jpg'
,'Mercedes.jpg'
,'Mercury.jpg'
,'Mini.jpg'
,'Mitsubishi.jpg'
,'Moskvich.jpg'
,'Opel.jpg'
,'Peugeot.jpg'
,'Pontiac.jpg'
,'Porshe.jpg'
,'Renault.jpg'
,'Saab.jpg'
,'Saturn.jpg'
,'Scoda.jpg'
,'Seat.jpg'
,'Subaru.jpg'
,'Toyota.jpg'
,'Volkswagen.jpg'
,'F1.jpg'
);

var Ys: array [1..5] of integer = (
45,
190,
0,
480,
625
);

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
    CarRound := 1;
    GoAway:=1;
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
  Window.Title := 'Определи Марку Машины';
  OnKeyUp := KeyUp;
  MaximizeWindow;
  S1:=-40;
  S2:=98;
  S3:=244;
  S4:=390;
  S5:=535;
  SetFontSize(30);
  H := 250;//высота и длина машины
  Car := Picture.Create('NewMainCar.bmp');//Машина
  Car.Load('NewMainCar.bmp');//Машина
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
      
      if BRight  =1 then//сигнал вернуться
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
      if Milliseconds>3000 then
      begin
        Question:=1;
      end;
      if (Question = 1) then
      begin
        if Ready=0 then
        begin
          NMark:=random(47)+1;
          Pict := Picture.Create('Marks\'+way[NMark]);
          Pict.Load('Marks\'+way[NMark]);
          Ready:=1;
          Rand:=Random(4)+1;
          if Rand>2 then Rand+=1;
          repeat 
            P1:=random(47)+1;
          until P1<>NMark;
          repeat 
            P2:=random(47)+1;
          until (P2<>P1)and(P2<>NMark);
          repeat 
            P3:=random(47)+1;
          until (P3<>P1)and(P3<>P2)and(P3<>NMark);
        end;
        if GoAway=1 then
        begin
          MarkX+=20;
          if MarkX>WindowWidth then
          begin
            Ready:=0;
            GoAway:=0;
          end;
        end
        else
        begin
          if MarkX<700 then
          begin
            MarkX:=MarkX;
            TextOut(WindowWidth-250, Ys[Rand], Marks[NMark]);
            for forr:=1 to 4 do
            begin
              if forr<>Rand then
              begin

              end;
            end
          end
          else
          begin
            MarkX-=20;
          end;
        end;
        Mark.Draw(MarkX, S3-60, H+100, H+100);
        Pict.Draw(MarkX+60, S3+70, H-160, H-160);
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