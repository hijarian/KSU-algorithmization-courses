program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils,crt32,math;
var
  x:real;
  asw:real;

begin
  { TODO -oUser -cConsole Main : Insert code here }
  writeln('Enter 0.1=<x<=0.6 here:');
  repeat readln(x)
    until (x>=0.1) and (x<=0.6);
  asw:=abs(sin(power((10.5*x),0.5)))/(power(x,(2/3))-0.143)+2*pi*x;
  writeln('Answer is ',asw:12:3);
  readkey;
end.
