program ball;
{$reference 'PresentationCore.dll'}

uses GraphABC;

var x, y, wwidth, wheight, dx, dy, H, p1, p2, wbd, F, D: integer;
{var arr: array [0..] of string=(
  Easy
  Medium
  Hard
  Hardcore
  );}

procedure KeyDown(key: integer);
begin
  if key = VK_Escape then
  begin
    CloseWindow;
  end;
  if key = VK_Down then
  begin
    if p1 >= wheight - D - 1 then
    begin
      p1 := p1;
    end
        else
    begin
      p1 += 30;
    end
  end;
  
  if key = VK_Up then
  begin
    if p1 <= D then
    begin
      p1 := p1;
    end
    else
    begin
      p1 -= 30;
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
  wwidth := 1024;
  wheight := 721;
  x := round(wwidth / 4) + random(round(wwidth / 2));
  y := round(wheight / 4) + random(round(wheight / 2));;
  dx := 22 + random(7);
  dy := 12 + random(7);
  H := 70;
  F := 0;
  wbd := 20;
  D := 90;//длина ракеток
  p1 := round(wheight / 2);
  SetPenWidth(2);
  if random(2) = 1 then
  begin
    dx := dx * -1;
  end;
  
  if random(2) = 1 then
  begin
    dy := dy * -1;
  end;
  
  
  
  LockDrawing();
  
  while 2 + 2 = 4 do
  begin
    ClearWindow();
    ClearWindow;

    Sil.Draw(x - H, y - H);//силаэдр
    
    x := x + dx;
    y := y + dy;
    
    p2 := y;
    
    Rectangle(wbd - 15, p1 - D, wbd, p1 + D);{-1-}
    Rectangle(wwidth - wbd, p2 - D, wwidth - wbd + 15, p2 + D);{-2-}
    
    
    if ((x > wwidth - wbd - H) and (y > p2 - D) and (y < p2 + D)) 
        or ((x < wbd + H) and (y > p1 - D) and (y < p1 + D)) then
    begin
      dx := dx * -1; //ударился о прямоугольник
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