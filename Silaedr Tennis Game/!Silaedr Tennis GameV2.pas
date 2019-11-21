program ball;
{$reference 'PresentationCore.dll'}

uses GraphABC;

var x, y, wwidth, wheight, dx, dy, H, p1, p2, wbd, F, D, count, D2, Wait: integer;

procedure KeyDown(key: integer);
begin
  if key = VK_Escape then
  begin
    CloseWindow;
  end;
////////////////////////////////////////////////////////////////////////////////
  if key = VK_Space then
  begin
    Wait+=1
  end;
////////////////////////////////////////////////////////////////////////////////
  if key = VK_Down then
  begin
    if p2 >= wheight - D - 1 then
    begin
      p2 := p2;
    end
    else
    begin
      p2 += 70;
    end
  end;
  
  if key = VK_Up then
  begin
    if p2 <= D then
    begin
      p2 := p2;
    end
    else
    begin
      p2 -= 70;
    end;
  end;
////////////////////////////////////////////////////////////////////////////////
  if key = VK_S then
  begin
    if p1 >= wheight - D - 1 then
    begin
      p1:=p1;
    end
    else
    begin
      p1+=70;
    end
  end;
  
  if key=VK_W then
  begin
    if p1 <= D then
    begin
      p1 := p1;
    end
    else
    begin
      p1 -= 70;
    end;
  end
end;

begin
  OnKeyDown := KeyDown;
  var Sil: Picture;
  Sil := Picture.Create('Silaedr.png');//силаэдр
  Sil.Load('Silaedr.png');//силаэдр
  
  var GameOver: Picture;
  GameOver := Picture.Create('gameovertank.png');
  GameOver.Load('gameovertank.png');
  
  var mp3p1:= new System.Windows.Media.MediaPlayer;
  mp3p1.Open( new System.Uri('s1.mp3', System.UriKind.Relative));
  
  var mp3p2 := new System.Windows.Media.MediaPlayer;
  mp3p2.Open( new System.Uri('s2.mp3', System.UriKind.Relative));
  
  var mp3gameover := new System.Windows.Media.MediaPlayer;
  mp3gameover.Open( new System.Uri('o-o3.mp3', System.UriKind.Relative));
  
  MaximizeWindow;  
  SetPenWidth(2);
  wwidth := WindowWidth;
  wheight := WindowHeight;
  x := round(wwidth / 4) + random(round(wwidth / 2));
  y := round(wheight / 4) + random(round(wheight / 2));;
  dx := 20 + random(7);
  dy := 10 + random(7);
  H := 70;
  F := 0;
  wbd := 20;
  D := 120;//длина ракеток
  D2:= 20;//длина 2
  p1 := round(wheight / 2);
  p2 := round(wheight / 2);
  SetPenWidth(2);
  if random(1) = 1 then
  begin
    dx := dx * -1;
  end;
  
  if random(1) = 1 then
  begin
    dy := dy * -1;
  end;
  
  LockDrawing();
  SetFontSize(10);
  
  sleep(1000);
  While 2 + 2 = 4 do
  begin
    ClearWindow();

    Sil.Draw(x - H, y - H);//силаэдр
    
    if Wait mod 2 = 0 then
    begin
      x := x + dx;
      y := y + dy;
    end;
    
    p2 := y;
    
    Rectangle(wbd - 15, p1 - D, wbd, p1 + D);{-1-}
    Rectangle(wwidth - wbd, p2 - D2, wwidth - wbd + 15, p2 + D2);{-2-}
    
    
    if ((x > wwidth - wbd - H) and (y > p2 - D) and (y < p2 + D)) 
        or ((x < wbd + H) and (y > p1 - D) and (y < p1 + D)) then
    begin
      dx := dx * -1; //ударился о прямоугольник
      count+=1;
      mp3p1.Stop();
      mp3p1.Play();
    end
    else
    begin
      if (x < 0 + H) then 
      begin
        dx := dx * -1;//1
        F := 1;
      end;
      
      if (x > wwidth - H) then
      begin
        dx := dx * -1;//2
        F := 1;
      end;
    end;
    
    if ((y > wheight - H) or (y < 0 + H) or ((y < 0 + H) or ((x > round(wwidth / 2) - 100) and (x < round(wwidth / 2) - 100)))) then
    begin
      dy := dy * -1;
      count+=1;
      mp3p2.Stop();
      mp3p2.Play();;
    end;
    redraw();
    if F = 1 then 
    begin
      break
    end
  end;
  
  ClearWindow();
  FloodFill(1, 1, clBlack);
  GameOver.Draw(260, 80);
  redraw();
  mp3gameover.Play();
end.