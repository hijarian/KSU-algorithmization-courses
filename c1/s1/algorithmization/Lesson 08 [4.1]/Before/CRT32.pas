unit CRT32;


(*   Freeware
 *
 *   Author Frank Zimmer
 *   Revision Kamil Sevecek
 *
 *
 *   Description
 *
 *   Copyright © 1997, Frank Zimmer
 *   Date: 18.01.1997
 *   Date: 20.10.2004
 *
 *   An implementation of Turbo Pascal CRT-Unit for Win32 Console Subsystem
 *   At Startup you get the focus to the Console
 *
 *
 *   Procedures and Functions:
 *   ( with * are not in the original Crt-Unit):
 *
 *     ClrScr
 *     ClrEol
 *     Delay
 *     WhereX
 *     WhereY
 *     GotoXY
 *     InsLine
 *     DelLine
 *     HighVideo
 *     LowVideo
 *     NormVideo
 *     TextBackground
 *     TextColor
 *     KeyPressed
 *     ReadKey
 *     Sound
 *     NoSound
 *   * TextAttribut // Set TextBackground and TextColor at the same time, usefull for Lastmode
 *   * FlushInputBuffer // Flush the Keyboard and all other Events
 *   * ConsoleEnd // output of 'Press any key' and wait for key input when not pipe
 *   * Pipe // True when the output is redirected to a pipe or a file
 *
     Variables:
     WindMin // the min. WindowRect
     WindMax // the max. WindowRect
     *ViewMax // the max. ConsoleBuffer start at (1,1);
     TextAttr // Actual Attributes only by changing with this Routines
     LastMode // Last Attributes only by changing with this Routines
     *SoundFrequenz // with Windows NT your could use these Variables
     *HConsoleInput // the Input-handle;
     *HConsoleOutput // the Output-handle;
     *HConsoleError // the Error-handle;


   This source code is a freeware, have fun :-)

 *)

interface

uses SysUtils, Windows, Messages, MMSystem;

const
  Black = 0;
  Blue = 1;
  Green = 2;
  Cyan = 3;
  Red = 4;
  Magenta = 5;
  Brown = 6;
  LightGray = 7;
  DarkGray = 8;
  LightBlue = 9;
  LightGreen = 10;
  LightCyan = 11;
  LightRed = 12;
  LightMagenta = 13;
  Yellow = 14;
  White = 15;


var
  HConsoleInput: THandle;
  HConsoleOutput: THandle;
  HConsoleError: THandle;

  WindMin: TCoord;
  WindMax: TCoord;

  TextAttr: Word;
  LastMode: Word;

  SoundVolume: Integer = 16384;

  procedure ClrEol;
  procedure ClrScr;
  procedure Delay(MilliSeconds: Integer);
  procedure DelLine;
  procedure GotoXY(X, Y: Integer);
  procedure HighVideo;
  procedure InsLine;
  function KeyPressed: Boolean;
  procedure LowVideo;
  procedure NormVideo;
  procedure NoSound;
  function ReadKey: Char;
  procedure Sound(SoundFrequency: Integer);
  procedure TextBackground(Color: Word);
  procedure TextColor(Color: Word);
  function WhereX: Integer;
  function WhereY: Integer;
  procedure Window(X1, Y1, X2, Y2: Integer);

  function Oem(S: string): string;  //преобразование char в oem
  // Missing TextMode

  procedure TextAttribut(TextColor, TextBackground: Word);
  procedure ConsoleEnd;
  procedure FlushInputBuffer;




implementation

var
  OldCodePage: Integer;
  StartAttr: Word;



//--------------------------------------------------------------------------
// Part for Sound function - support variables and .WAV data type

const WaveDataSize = 44100;

type
  TInputRecord = record
    EventType: Word;
    Reserved: Word;
    Event: Record case Integer of
      0: (KeyEvent: TKeyEventRecord);
      1: (MouseEvent: TMouseEventRecord);
      2: (WindowBufferSizeEvent: TWindowBufferSizeRecord);
      3: (MenuEvent: TMenuEventRecord);
      4: (FocusEvent: TFocusEventRecord);
    end;
  end;


function ReadConsoleInput(hConsoleInput: THandle;
  var lpBuffer: TInputRecord;
  nLength: DWORD;
  var lpNumberOfEventsRead: DWORD): BOOL;
  stdcall;
  external kernel32 name 'ReadConsoleInputA';



type
  TPCMWaveFormat = packed record
    ChunkID: array [1..4] of Char;
    ChunkSize: Cardinal;
    Format: array [1..4] of Char;
    Subchunk1ID: array [1..4] of Char;
    Subchunk1Size: Cardinal;
    AudioFormat: Word;
    NumChannels: Word;
    SampleRate: DWord;
    ByteRate: DWord;
    BlockAlign: Word;
    BitsPerSample: Word;
    Subchunk2ID: array [1..4] of Char;
    Subchunk2Size: Cardinal;
    Data: array [0..WaveDataSize] of SmallInt;
  end;

var
  WaveBufferA: TPCMWaveFormat;
  WaveBufferB: TPCMWaveFormat;
  WaveBufferInUse: Integer;


//--------------------------------------------------------------------------








//--------------------------------------------------------------------------


function GetWindowWidth: Integer;
begin
  Result := WindMax.X - WindMin.X + 1;
end;


function GetWindowHeight: Integer;
begin
  Result := WindMax.Y - WindMin.Y + 1;
end;


function GetWindowLeft: Integer;
begin
  Result := WindMin.X;
end;


function GetWindowTop: Integer;
begin
  Result := WindMin.Y;
end;


function GetWindowRight: Integer;
begin
  Result := WindMax.X;
end;


function GetWindowBottom: Integer;
begin
  Result := WindMax.Y;
end;


//--------------------------------------------------------------------------


procedure RaiseError(ErrorMessage: String);
begin
  Windows.MessageBox(0, PAnsiChar(ErrorMessage), 'CRT32.pas Error',
      MB_OK or MB_ICONERROR);
  raise Exception.Create('CRT32 Error: ' + ErrorMessage);
end;



procedure RaiseLastError;
var ErrorCode: Integer;
    Buffer: array[0..255] of Char;
begin
  ErrorCode := GetLastError;

  FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM or FORMAT_MESSAGE_IGNORE_INSERTS or
    FORMAT_MESSAGE_ARGUMENT_ARRAY, nil, ErrorCode, 0, Buffer,
    SizeOf(Buffer), nil);

  RaiseError(Buffer);
end;


//--------------------------------------------------------------------------


// This function is used to handle Write and WriteLn commands
// to the console instead of TextOut function in System.pas unit
function WriteCRT32(var T: TTextRec): Integer;
var PCharacters: PAnsiChar;
    LCharLength: Integer;
    i: Integer;
    LEnterIsPending: Boolean;
    LRowLength: Integer;
    LWrittenCount: DWORD;
begin
  PCharacters := T.BufPtr;
  LCharLength := T.BufPos;

  // First line needs special handling
  if (WhereX+LCharLength) > GetWindowWidth then
    LRowLength := GetWindowWidth - WhereX + 1
  else
    LRowLength := LCharLength;

  while LCharLength>0 do begin
    // Search for the 'Enter character' to avoid writing it
    // to the console and cause incorrect line wrap
    LEnterIsPending := False;
    for i:=0 to LRowLength-1 do
      if (PCharacters[i]=#10) or (PCharacters[i]=#13) then begin
        LRowLength := i;
        LEnterIsPending := True;
        Break;
      end;

    // Actual write to console and increment of the pointers
    if not WriteFile(HConsoleOutput, PCharacters^, LRowLength,
                     LWrittenCount, nil) then RaiseLastError;
    Inc(PCharacters, LWrittenCount);
    LCharLength := LCharLength - Integer(LWrittenCount);

    if LCharLength<=0 then  // Finish the "Write" command without next line
      Break;                // (unlike the "WriteLn")

    // Move the cursor to the next line
    if LEnterIsPending then begin
      if PCharacters[0]=#13 then
        GotoXY(1, WhereY)
      else
        GotoXY(1, WhereY+1);
      Inc(PCharacters);
      Dec(LCharLength);
    end else // Anyway, wrap the line
      GotoXY(1, WhereY+1);

    if GetWindowWidth<LCharLength then
      LRowLength := GetWindowWidth
    else
      LRowLength := LCharLength;
  end;

  T.BufPos := 0;
  Result := 0;
end;


//--------------------------------------------------------------------------







//-------------------------------------------------------------------------
// CRT function implementation
//-------------------------------------------------------------------------


procedure Delay(MilliSeconds: Integer);
begin
  Sleep(MilliSeconds);
end;



procedure ClrScr;
var LInfo: TConsoleScreenBufferInfo;
    LResult: Boolean;
    i: Integer;
    LCharWritten: DWORD;
    LCoord: TCoord;
begin
  if not GetConsoleScreenBufferInfo(HConsoleOutput, LInfo) then
    RaiseLastError;

  LCoord.X := GetWindowLeft - 1;
  for i:=GetWindowTop-1 to GetWindowBottom-1 do begin
    LCoord.Y := i;
    if not FillConsoleOutputAttribute(HConsoleOutput, TextAttr,
           GetWindowWidth, LCoord, LCharWritten) then
      RaiseLastError;
    if not FillConsoleOutputCharacter(HConsoleOutput, ' ', GetWindowWidth,
           LCoord, LCharWritten) then
      RaiseLastError;
  end;

  LCoord.Y := GetWindowTop - 1;
  if not SetConsoleCursorPosition(HConsoleOutput, LCoord) then
    RaiseLastError;
end;



procedure ClrEol;
var LStart: TCoord;
    LCharWritten: DWORD;
    LLen: Integer;
    LInfo: TConsoleScreenBufferInfo;
begin
  if not GetConsoleScreenBufferInfo(HConsoleOutput, LInfo) then
    RaiseLastError;
  LLen := GetWindowRight - LInfo.dwCursorPosition.X;
  LStart.X := LInfo.dwCursorPosition.X;
  LStart.Y := LInfo.dwCursorPosition.Y;
  if not FillConsoleOutputAttribute(HConsoleOutput, TextAttr, LLen,
         LStart, LCharWritten) then
    RaiseLastError;
  if not FillConsoleOutputCharacter(HConsoleOutput, ' ', LLen,
         LStart, LCharWritten) then
    RaiseLastError;
end;



function WhereX: Integer;
var LInfo: TConsoleScreenBufferInfo;
begin
  if not GetConsoleScreenBufferInfo(HConsoleOutput, LInfo) then
    RaiseLastError;
  Result := 2 + LInfo.dwCursorPosition.X - GetWindowLeft;
end;



function WhereY: Integer;
var LInfo: TConsoleScreenBufferInfo;
begin
  if not GetConsoleScreenBufferInfo(HConsoleOutput, LInfo) then
    RaiseLastError;
  Result := 2 + LInfo.dwCursorPosition.Y - GetWindowTop;
end;



procedure GotoXY(X, Y: Integer);
var LCoord: TCoord;
begin
  LCoord.X := GetWindowLeft + X - 2;
  LCoord.Y := GetWindowTop + Y - 2;
  if not SetConsoleCursorPosition(HConsoleOutput, LCoord) then
    RaiseLastError;
end;



procedure TextBackground(Color: Word);
begin
  LastMode := TextAttr;
  TextAttr := ((Color and $0F) shl 4) or (TextAttr and $0F);
  if not SetConsoleTextAttribute(HConsoleOutput, TextAttr) then
    RaiseLastError;
end;



procedure TextColor(Color: Word);
begin
  LastMode := TextAttr;
  TextAttr := (Color and $0F) or (TextAttr and $F0);
  if not SetConsoleTextAttribute(HConsoleOutput, TextAttr) then
    RaiseLastError;
end;




procedure InsLine;
var
 LRect: TSmallRect;
 LTargetCoord: TCoord;
 LEmptyChar: TCharInfo;
begin
  LRect.Top := WhereY + GetWindowTop - 2;
  LRect.Left := GetWindowLeft - 1;
  LRect.Bottom := GetWindowBottom - 2;
  LRect.Right := GetWindowRight - 1;

  LTargetCoord.X := LRect.Left;
  LTargetCoord.Y := LRect.Top + 1;

  LEmptyChar.AsciiChar := 'C';
  LEmptyChar.Attributes := TextAttr;

  if not ScrollConsoleScreenBuffer(HConsoleOutput, LRect, nil,
         LTargetCoord, LEmptyChar) then
    RaiseLastError;
end;




procedure DelLine;
var
 LRect: TSmallRect;
 LTargetCoord: TCoord;
 LEmptyChar: TCharInfo;
begin
  LRect.Top := WhereY + GetWindowTop - 1;
  LRect.Left := GetWindowLeft - 1;
  LRect.Bottom := GetWindowBottom - 1;
  LRect.Right := GetWindowRight - 1;

  LTargetCoord.X := LRect.Left;
  LTargetCoord.Y := LRect.Top - 1;

  LEmptyChar.AsciiChar := ' ';
  LEmptyChar.Attributes := TextAttr;

  if not ScrollConsoleScreenBuffer(HConsoleOutput, LRect, nil,
         LTargetCoord, LEmptyChar) then
    RaiseLastError;
end;




procedure TextAttribut(TextColor, TextBackground: Word);
begin
  LastMode := TextAttr;
  TextAttr := (TextColor and $0F) or ((TextBackground and $0F) shl 4);
  if not SetConsoleTextAttribute(HConsoleOutput, TextAttr) then
    RaiseLastError;
end;



procedure HighVideo;
begin
  LastMode := TextAttr;
  TextAttr := TextAttr or $08;
  if not SetConsoleTextAttribute(HConsoleOutput, TextAttr) then
    RaiseLastError;
end;



procedure LowVideo;
begin
  LastMode := TextAttr;
  TextAttr := TextAttr and $F7;
  if not SetConsoleTextAttribute(HConsoleOutput, TextAttr) then
    RaiseLastError;
end;



procedure NormVideo;
begin
  LastMode := TextAttr;
  TextAttr := StartAttr;
  if not SetConsoleTextAttribute(HConsoleOutput, TextAttr) then
    RaiseLastError;
end;



procedure FlushInputBuffer;
begin
  if not FlushConsoleInputBuffer(HConsoleInput) then
    RaiseLastError;
end;



function KeyPressed: Boolean;
var LNumberOfEvents, LEventsRead: DWORD;
    LEventBuffer: array [0..255] of TInputRecord;
    PRecord: PInputRecord;
    i: Integer;
begin
  Result := False;
  GetNumberOfConsoleInputEvents(HConsoleInput, LNumberOfEvents);
  if LNumberOfEvents=0 then
    Exit;
  if LNumberOfEvents>256 then
    RaiseError('Too many pending events for KeyPressed');
  PRecord := @LEventBuffer;
  PeekConsoleInput(HConsoleInput, PRecord^, LNumberOfEvents, LEventsRead);
  for i:=0 to LEventsRead-1 do begin
    if (LEventBuffer[i].EventType = KEY_EVENT) and
       (LEventBuffer[i].Event.KeyEvent.bKeyDown) then begin
      Result := True;
      Break;
    end;
  end;
end;



function ReadKey: Char;
var LReadCount: DWORD;
    LInputRec: TInputRecord;
    LKey: Char;
begin
  repeat
    ReadConsoleInput(HConsoleInput, LInputRec, 1, LReadCount);
    if (LInputRec.EventType = KEY_EVENT) and
       (LInputRec.Event.KeyEvent.bKeyDown) then begin
      LKey := Char(LInputRec.Event.KeyEvent.wVirtualKeyCode);

      // Ignore system control keys ... Shift, Ctrl, Alt, Caps Lock
      if (LInputRec.Event.KeyEvent.wVirtualKeyCode=16) or
         (LInputRec.Event.KeyEvent.wVirtualKeyCode=17) or
         (LInputRec.Event.KeyEvent.wVirtualKeyCode=18) or
         (LInputRec.Event.KeyEvent.wVirtualKeyCode=20) then
        LKey := #0;

      if (LKey>='A') and (LKey<='Z') and
         ((LInputRec.Event.KeyEvent.dwControlKeyState and SHIFT_PRESSED)=0) then
        Dec(LKey, Ord('a')-Ord('A'));   // DownCase(LKey);
     end else
      LKey := #0;

  until LKey<>#0;

  Result := LKey;
end;



procedure Window(X1, Y1, X2, Y2: Integer);
var
    LInfo: TConsoleScreenBufferInfo;
begin
  if not GetConsoleScreenBufferInfo(HConsoleOutput, LInfo) then
    RaiseLastError;
  if (X1<1) or (Y1<1) or (X2>LInfo.dwSize.X) or (Y2>LInfo.dwSize.Y) then
    RaiseError('Window too large');
  WindMin.X := X1;
  WindMin.Y := Y1;
  WindMax.X := X2;
  WindMax.Y := Y2;
  GotoXY(1, 1);
end;



procedure Sound(SoundFrequency: Integer);
var i, NewWaveSize: Integer;
    SinConstant, SinLengthInSamples: Extended;
    PWaveBuffer: ^TPCMWaveFormat;
    SizeCandidate: Extended;
begin
  if (WaveBufferInUse<-1) or (WaveBufferInUse>1) then
    RaiseError('Invalid wave buffer in use');
  if WaveBufferInUse=0 then begin
    PWaveBuffer := @WaveBufferB;
    WaveBufferInUse := 1;
  end else begin
    PWaveBuffer := @WaveBufferA;
    WaveBufferInUse := 0;
  end;

  SinLengthInSamples := PWaveBuffer.SampleRate / SoundFrequency;
  SinConstant := PI / SinLengthInSamples;
  SizeCandidate := Trunc(WaveDataSize / SinLengthInSamples) * SinLengthInSamples;
  while (Abs(Round(SizeCandidate) - SizeCandidate)>0.001)
        or ((SizeCandidate/2 - Round(SizeCandidate/2))>0.1) do
    SizeCandidate := SizeCandidate - SinLengthInSamples;
  NewWaveSize := Round(SizeCandidate);

  PWaveBuffer.Subchunk2Size := NewWaveSize;

  for i:=0 to WaveDataSize-1 do begin
    PWaveBuffer.Data[i] := Round(Sin(i*SinConstant) * SoundVolume);
  end;

  PlaySound(PAnsiChar(PWaveBuffer), 0, SND_MEMORY or SND_ASYNC or SND_LOOP);
end;



procedure NoSound;
begin
  PlaySound(nil, 0, SND_MEMORY);
  WaveBufferInUse := -1;
end;



procedure ConsoleEnd;
begin
  if WhereX > 1 then
    WriteLn;
  TextColor(White);
  TextBackground(Black);
  Write('Press any key');
  FlushInputBuffer;
  ReadKey;
  FlushInputBuffer;
end;


function Oem(S: string): string;
begin
  CharToOemBuff(@S[1],@S[1],Length(S));
  Oem := S;
end;




procedure InitUnit;
var LInfo : TConsoleScreenBufferInfo;
begin
  HConsoleInput := GetStdHandle(STD_INPUT_HANDLE);
  HConsoleOutput := GetStdHandle(STD_OUTPUT_HANDLE);
  HConsoleError := GetStdHandle(STD_ERROR_HANDLE);
  if not GetConsoleScreenBufferInfo(HConsoleOutput, LInfo) then
    RaiseLastError;
  TextAttr := LInfo.wAttributes;
  StartAttr := LInfo.wAttributes;

  WindMin.X := 1;
  WindMin.Y := 1;
  WindMax.X := LInfo.dwSize.X;
  WindMax.Y := LInfo.dwSize.Y;

  WaveBufferA.ChunkID := 'RIFF';
  WaveBufferA.ChunkSize := SizeOf(TPCMWaveFormat);
  WaveBufferA.Format := 'WAVE';
  WaveBufferA.Subchunk1ID := 'fmt ';
  WaveBufferA.Subchunk1Size := 16;
  WaveBufferA.AudioFormat := 1;
  WaveBufferA.NumChannels := 1;
  WaveBufferA.SampleRate := 44100;
  WaveBufferA.BitsPerSample := 16;
  WaveBufferA.ByteRate := WaveBufferA.NumChannels * WaveBufferA.SampleRate
                         * WaveBufferA.BitsPerSample div 8;
  WaveBufferA.BlockAlign := 2;
  WaveBufferA.Subchunk2ID := 'data';

  WaveBufferB := WaveBufferA;
  WaveBufferInUse := -1;

  OldCodePage := GetConsoleOutputCP;
  SetConsoleOutputCP(1251);       // Standard English code page - CP1252

  Rewrite(Output);
  TTextRec(Output).InOutFunc:=@WriteCRT32;
  TTextRec(Output).FlushFunc:=@WriteCRT32;
end;



procedure DeinitUnit;
begin
  SetConsoleOutputCP(OldCodePage);
end;




initialization
  InitUnit;
finalization
  DeinitUnit;
end.
