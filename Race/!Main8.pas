﻿program Project;
{$reference 'PresentationCore.dll'}
uses GraphABC, Utils;
var
  Flag, Pict, Car, Rud, Rest, Mark: Picture;

const
  MarkSpeed: integer = 50;

var
  EnableTurn, LastRand, Text, UnPushEntr, Enable, MarkCount, NumberReady, 
  Number, Points, P1, P2, P3, PY1, PY2, PY3, NMark, Ready, Rand, MarkX, H,
  Question, Y, Ru, Turn, STurn, GoAway, GoAwayStarted, TapRight, TapLeft, BLeft, BRight, 
  Step, Esc, CarRound, S1, S2, S3, S4, S5, i: integer;

const
  QustionCount: integer = 10;

const
  marks: array [1..48] of string = (
  'Acura'
  , 'Alfa Romeo'
  , 'Audi'
  , 'Bentley'
  , 'Bogdan'
  , 'Buick'
  , 'Cadillac'
  , 'Chery'
  , 'Chevrolet'
  , 'Citroёn'
  , 'Daewoo'
  , 'Daihatsu'
  , 'Dodge'
  , 'Faw'
  , 'Ferrari'
  , 'Gaz'
  , 'Hafei'
  , 'Haima'
  , 'Honda'
  , 'Hyundai'
  , 'Infiniti'
  , 'Iran Khodro'
  , 'Jaguar'
  , 'Kamaz'
  , 'Koenigsegg'
  , 'Lamborghini'
  , 'Lexus'
  , 'Lincoln'
  , 'Maserati'
  , 'Mazda'
  , 'Mercedes'
  , 'Mercury'
  , 'Mini'
  , 'Mitsubishi'
  , 'Moskvich'
  , 'Opel'
  , 'Peugeot'
  , 'Pontiac'
  , 'Porshe'
  , 'Renault'
  , 'SAAB'
  , 'Saturn'
  , 'Scoda'
  , 'Seat'
  , 'Subaru'
  , 'Toyota'
  , 'Volkswagen'
  , 'F1'
  );
{
const L1: array [1..14] of integer = (
3
,9
,16
,24
,27
,28
,31
,32
,35
,40
,41
,44
,46
,47
);

const L2: array [1..13] of integer = (
2
,4
,7
,10
,14
,20
,21
,25
,30
,34
,37
,38
,48
);
const L3: array [1..14] of integer = (
3
,9
,16
,24
,27
,28
,31
,32
,35
,40
,41
,44
,46
,47
);

const L4: array [1..10] of integer = (
6
,11
,12
,15
,18
,26
,33
,36
,39
,43
);
}
const
  way: array [1..48] of string = (
  'Acura.jpg'
  , 'Alfa Romeo.jpg'
  , 'Audi.jpg'
  , 'Bentley.jpg'
  , 'Bogdan.jpg'
  , 'Buick.jpg'
  , 'Cadillac.jpg'
  , 'Chery.jpg'
  , 'Chevrolet.jpg'
  , 'Citroёn.jpg'
  , 'Daewoo.jpg'
  , 'Daihatsu.jpg'
  , 'Dodge.jpg'
  , 'Faw.jpg'
  , 'Ferrari.jpg'
  , 'Gaz.jpg'
  , 'Hafei.jpg'
  , 'Haima.jpg'
  , 'Honda.jpg'
  , 'Hyundai.jpg'
  , 'Infiniti.jpg'
  , 'Iran Khodro.jpg'
  , 'Jaguar.jpg'
  , 'Kamaz.jpg'
  , 'Koenigsegg.jpg'
  , 'Lamborghini.jpg'
  , 'Lexus.jpg'
  , 'Lincoln.jpg'
  , 'Maserati.jpg'
  , 'Mazda.jpg'
  , 'Mercedes.jpg'
  , 'Mercury.jpg'
  , 'Mini.jpg'
  , 'Mitsubishi.jpg'
  , 'Moskvich.jpg'
  , 'Opel.jpg'
  , 'Peugeot.jpg'
  , 'Pontiac.jpg'
  , 'Porshe.jpg'
  , 'Renault.jpg'
  , 'Saab.jpg'
  , 'Saturn.jpg'
  , 'Scoda.jpg'
  , 'Seat.jpg'
  , 'Subaru.jpg'
  , 'Toyota.jpg'
  , 'Volkswagen.jpg'
  , 'F1.jpg'
  );

var
  Markready: array [1..48] of integer = (
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0
  );

const
  Ys: array [1..4] of integer = (
  45,
  190,
  480,
  627
  );

procedure KeyUp(key: integer);
begin
  if TapRight = 1 then
  begin
    TapRight := 0;
    BRight := 1;
    BLeft := 0;
  end;
  ////////////////////////////////////////////////////////////////////////////////
  if TapLeft = 1 then
  begin
    TapLeft := 0;
    BLeft := 1;
    BRight := 0;
  end;
end;
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
procedure KeyDown(key: integer);
begin
  if key = VK_Escape then
  begin
    if Esc=1 then CloseWindow;
    Esc := 1;
  end;
  
  if key = VK_Enter then
  begin
    if (Enable = 1) and (Number <> 3) then
    begin
      CarRound := 1;
      GoAway := 1;
      GoAwayStarted := 0;
    end;
  end;
  ////////////////////////////////////////////////////////////////////////////////
  if key = VK_Right then
  begin
    TapRight := 1;
    BRight := 0;
    BLeft := 0;
    if Turn > STurn + 20 then
    begin
      Turn := Turn;
    end
        else
    begin
      Turn := Turn + 2;
    end;
  end;
  ////////////////////////////////////////////////////////////////////////////////
  if key = VK_Left then
  begin
    TapLeft := 1;
    BLeft := 0;
    BRight := 0;
    if Turn < STurn - 20 then
    begin
      Turn := Turn;
    end
        else
    begin
      Turn := Turn - 2;
    end;
  end;
end;
////////////////////////////////////////////////////////////////////////////////
begin
  OnKeyDown := KeyDown;
  Window.Title := 'Определи Марку Машины';
  EnableTurn := 1;
  OnKeyUp := KeyUp;
  SetWindowWidth(1024);
  SetWindowHeight(721);
  SetWindowPos(0, 0);
  SetFontName('Lucida Console');
  Window.SetPos(20, 30);
  S1 := -40;
  S2 := 98;
  S3 := 244;
  S4 := 390;
  S5 := 535;
  SetFontSize(30);
  H := 250;//высота и длина машины
  Car := Picture.Create('NewMainCar.bmp');//Машина
  Car.Load('NewMainCar.bmp');//Машина
  Car.Transparent := True;
  Flag := Picture.Create('backfinish.jpg');//Машина
  Flag.Load('backfinish.jpg');//Машина
  Rud := Picture.Create('road.png');//Дорога
  Rud.Load('road.png');//Дорога
  Mark := Picture.Create('Big.bmp');//Машина
  Mark.Load('Big.bmp');//Машина
  Mark.Transparent := True;
  
  var mp3p1 := new System.Windows.Media.MediaPlayer;  
  mp3p1.Open(new System.Uri('CarSound.mp3', System.UriKind.Relative));
  
  var mp3end := new System.Windows.Media.MediaPlayer;  
  mp3end.Open(new System.Uri('end.mp3', System.UriKind.Relative));
  
  var mp3endSuper := new System.Windows.Media.MediaPlayer;  
  mp3endSuper.Open(new System.Uri('endSuper.mp3', System.UriKind.Relative));
  
  var mp3start := new System.Windows.Media.MediaPlayer;  
  mp3start.Open(new System.Uri('start.mp3', System.UriKind.Relative));
  
  mp3start.Play();
  ////////////////////////////////////////////////////////////////////////////////
  LockDrawing;
  Step := 6;
  Turn := STurn;
  Y := S3;
  i := 0;
  Question := 0;
  MarkX := WindowWidth;
  while Esc = 0 do
  begin
    if CarRound = 1 then
    begin
      if round((Y + H - round(WindowHeight / 20)) / round(WindowHeight / 5)) = 1 then
      begin
        if Y > S1 then
        begin
          if Y >= S1 - Step then
          begin
            Y -= Step;
          end
            else
          begin
            Step := S1 - Y;
          end
        end;
        if Y > S1 then
        begin
          Y -= Step;
        end;
        if Y = S1 then
        begin
          CarRound := 0;
        end;
      end;
      ////////////////////////////////////////////////////////////////////////////////
      if round((Y + H - round(WindowHeight / 20)) / round(WindowHeight / 5)) = 2 then
      begin
        if Y < S2 then
        begin
          if Y <= S2 - Step then
          begin
            Y += Step;
          end
            else
          begin
            Step := S2 - Y;
          end
        end;
        if Y > S2 then
        begin
          Y -= Step;
        end;
        if Y = S2 then
        begin
          CarRound := 0;
        end;
      end;
      ////////////////////////////////////////////////////////////////////////////////
      if round((Y + H - round(WindowHeight / 20)) / round(WindowHeight / 5)) = 4 then
      begin
        if Y < S4 then
        begin
          if Y <= S4 - Step then
          begin
            Y += Step;
          end
            else
          begin
            Step := S4 - Y;
          end
        end;
        if Y > S4 then
        begin
          Y -= Step;
        end;
        if Y = S4 then
        begin
          CarRound := 0;
        end;
      end;
      ////////////////////////////////////////////////////////////////////////////////
      if round((Y + H - round(WindowHeight / 20)) / round(WindowHeight / 5)) = 5 then
      begin
        if Y < S5 then
        begin
          if Y <= S5 - Step then
          begin
            Y += Step;
          end
            else
          begin
            Step := S5 - Y;
          end
        end;
        if Y > S5 then
        begin
          Y -= Step;
        end;
        if Y = S5 then
        begin
          CarRound := 0;
        end;
      end;
    end;
    ////////////////////////////////////////////////////////////////////////////////
    if Turn > STurn then
    begin
      if Y > 525 then
      begin
        Turn -= 1;
      end
        else
      begin
        Y := Y + round(1.5 * (Turn - STurn));
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
        if Turn <= STurn then//проверяем повернулись ли мы уже
        begin
          Step := 6;//сброс
          BRight := 0;//сброс
        end
      end
        else
      begin
        Step := Turn - STurn;//доворот
      end;
    end;
    ////////////////////////////////////////////////////////////////////////////////
    if BLeft = 1 then//сигнал вернуться
    begin
      if Turn <= STurn - Step then//можем ли повернуть
      begin
        Turn := Turn + Step;//поворот
        if Turn >= STurn then//проверяем повернулись ли мы уже
        begin
          Step := 6;//сброс
          BLeft := 0;//сброс
        end
      end
        else
      begin
        Step := STurn - Turn;//доворот
      end;
    end;
    
    Ru := Ru + i;
    if i < 17 then
    begin
      i += 2;
    end
      else
    begin
      i := i;
    end;
    Rud.Draw(0 - Ru, 0, WindowWidth * 2, WindowHeight);
    Car.Draw(130, y, Turn, H, H);
    if Milliseconds > 1200 then
    begin
      Question := 1;
    end;
    if (Question = 1) then
    begin
      if Ready = 0 then
      begin
        repeat
          NMark := random(1, 48);
        until Markready[NMark] = 0;
        Markready[NMark] := 1;
        MarkCount += 1;
        Ready := 1;
        NumberReady := 0;
        Pict := Picture.Create('Marks\' + way[NMark]);
        Pict.Load('Marks\' + way[NMark]);
        LastRand := Rand;
        repeat
          Rand := Random(1, 4);
        until Rand <> LastRand;
        ////////////////////////////////////////////////////////////////////////////////
        repeat
          P1 := random(1, 48);
        until P1 <> NMark;
        repeat
          P2 := random(1, 48);
        until (P2 <> P1) and (P2 <> NMark);
        repeat
          P3 := random(1, 48);
        until (P3 <> P1) and (P3 <> P2) and (P3 <> NMark);
        ////////////////////////////////////////////////////////////////////////////////
        repeat
          PY1 := random(1, 4);
        until PY1 <> Rand;
        repeat
          PY2 := random(1, 4);
        until (PY2 <> PY1) and (PY2 <> Rand);
        repeat
          PY3 := random(1, 4);
        until (PY3 <> PY1) and (PY3 <> PY2) and (PY3 <> Rand);
        ////////////////////////////////////////////////////////////////////////////////
      end;
      if GoAway = 1 then
      begin
        MarkX += MarkSpeed;
        if MarkX > WindowWidth then
        begin
          Ready := 0;
          Text := 0;
          GoAway := 0;
        end;
      end
        else
      begin
        if MarkX < 700 then
        begin
          TextOut(MarkX + 23, Ys[PY1], String.Format('{0,-13}', ' ' + Marks[P1]));
          TextOut(MarkX + 23, Ys[PY2], String.Format('{0,-13}', ' ' + Marks[P2]));
          TextOut(MarkX + 23, Ys[PY3], String.Format('{0,-13}', ' ' + Marks[P3]));
          Enable := 1;
          Text := 1;
          MarkX := MarkX;
        end
          else
        begin
          MarkX -= MarkSpeed;
        end;
      end;
      if CarRound = 1 then
      begin
        Enable := 0;
        if GoAwayStarted = 0 then
        begin
          mp3p1.Stop();
          mp3p1.Play();
          GoAwayStarted := 1;
        end;
        ////////////////////////////////////////////////////////////////////////////////
        if ((Rand = 1) and (Number = 1)) or ((Rand = 2) and (Number = 2)) or ((Rand = 3) and (Number = 4))
        or ((Rand = 4) and (Number = 5)) then
        begin
          if NumberReady = 0 then
          begin
            NumberReady := 1;
            Points += 1;
            
          end;
          
        end
      end;
      Mark.Draw(MarkX, S3 - 60, H + 100, H + 100);
      if Text = 1 then
      begin
        TextOut(674 + 23, Ys[Rand], String.Format('{0,-13}', ' ' + Marks[NMark]));
      end;
      TextOut(0, 0, String.Format('{0,-10}', 'Question:' + MarkCount + '/' + QustionCount));//{Points}
      TextOut(0, 40, String.Format('{0,-8}', 'Score:' + Points));//{Points}
      Pict.Draw(MarkX + 60, S3 + 70, H - 160, H - 160);
      {N}Number := round((Y + H - round(WindowHeight / 20)) / round(WindowHeight / 5));
      //TextOut(0,100,Number);
      redraw();
    end;
    redraw();
    if MarkCount > QustionCount then break;
    if Ru > 968 then
    begin
      Ru := 33;
    end;
  end;
  ClearWindow();
  if Points = QustionCount then 
  begin
    mp3endSuper.Play();
  end;
  if Points > 0 then
  begin
    mp3end.Play();
  end;
  Flag.Draw(0, 0, WindowWidth, WindowHeight);
  SetFontSize(100);
  SetFontStyle(fsBold);
  TextOut(10, 50, 'Final Score');
  
  SetFontSize(250);
  TextOut(150, 290, round(Points / QustionCount * 100) + '%');
  redraw();
end.