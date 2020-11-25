program hello;
uses GraphABc, Events;
uses Utils

var Map: array [1..501] of array [1..601] of integer;
var Good: array [1..501] of array [1..601] of real;
var AStar: array [1..501] of array [1..601] of integer; //1 - x + |2 - x - |3 - y + |4 - y - |5 - xy + | 6 - xy - |7 - x +, y - |8 - y +, x -|||
var AStarHelper: array [1..501] of array [1..601] of integer;
var tr, k, ch, ch2: integer;
var b: boolean;

procedure MouseDown(x, y, mb: integer);
begin
    var ix, iy: integer;
    for ix:= 1 to 601 do
    begin
        for iy:= 1 to 501 do
        begin
            if(tr >= k)then
            begin
                Good[iy][ix] += 200 / ((ix - x) * (ix - x) + (iy - y) * (iy - y) + 200);
            end
            else
            begin
                Good[iy][ix] += -200 / ((ix - x) * (ix - x)  + (iy - y) * (iy - y) + 200);
            end;
        end;
    end;
    if(tr >= k)then
    begin
        SetBrushColor(ARGB(200, 250, 250, 0));
        Circle(x, y, 10);
    end
    else
    begin
        SetPixel(x, y, clBlack);
        SetPixel(x + 1, y, clBlack);
        SetPixel(x, y + 1, clBlack);
        SetPixel(x + 1, y + 1, clBlack);
        tr += 1;
    end;
    if(ch2 > ch + tr - 2) then
    begin
        for ix:= 1 to 601 do
        begin
            for iy:= 1 to 501 do
            begin
                var p, p2: integer;
                p := 127 + round(Good[iy][ix] * 127);
                p2 := 128 - round(Good[iy][ix] * 127);
                if(127 + Good[iy][ix] * 127 < 0)then
                begin
                    p := 0;
                end
                else if(127 + Good[iy][ix] * 127 > 255)then
                begin
                    p := 255;
                end
                else if(128 - Good[iy][ix] * 127 > 255)then
                begin
                    p2 := 255;
                end
                else if(128 - Good[iy][ix] * 127 < 0)then
                begin
                    p2 := 0;
                end;
                SetPixel(ix, iy, RGB(p, p2, 0));
            end;
        end;
    end;
    ch2 += 1;
end;

begin
    print('Введите кол-во еды, а потом введите кол-во вредных для плесени условий');
    read(k);
    read(ch);
    print('Нажмите на точки где поставить n еды, а потом на точки где будут плохие условия');
    tr := 0;
    while(1 = 1)do
    begin
        OnMouseDown := MouseDown;
    end;
end.