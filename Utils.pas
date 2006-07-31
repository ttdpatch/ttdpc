unit Utils;

interface

uses
  Windows,
  Dialogs
  ;

{-------  WinExecAndWait --------------------------------------------}

function  WinExecAndWait(const aCmdLine : string;
                         const aDirectory: string;
                         const aCmdShow : integer) : Boolean;

function  WinExecNoWait( const aCmdLine : string;
                         const aDirectory: string;
                         const aCmdShow : integer) : Boolean;

{--------------------------------------------------------------------}


implementation

uses
  SysUtils
  ;

{-----------------------------------------------------------------}

const
  PATHBUFFERSIZE = 257;

function WinExecForMulti(const aCmdLine : string;
                         const aDirectory: string;
                         const aCmdShow : integer): THandle;
var
  CurrentDir:         string;
  StartupInfo:        TStartupInfo;
  ProcessInformation: TProcessInformation;
  CurrentDirBuff:     PChar;
begin
  CurrentDir := aDirectory;
  if CompareText(CurrentDir, '') = 0 then begin
    CurrentDirBuff := StrAlloc(PATHBUFFERSIZE);
    try
      if (GetCurrentDirectory(PATHBUFFERSIZE, CurrentDirBuff) > 0) then
        CurrentDir := StrPas(CurrentDirBuff);
    finally
      StrDispose(CurrentDirBuff);
    end;
  end;
  GetStartupInfo(StartupInfo);
  StartupInfo.WShowWindow := aCmdShow;
  if CreateProcess(NIL,                   {ApplicationName}
                   PChar(aCmdLine),       {lpCommandLine }
                   NIL,                   {lpProcessAttributes}
                   NIL,                   {lpThreadAttribute}
                   False,                 {bInheritedHandles}
                   NORMAL_PRIORITY_CLASS, {dwCreationFlags}
                   NIL,                   {lpEnvironment}
                   PChar(CurrentDir),     {lpCurrentDirectory}
                   StartupInfo,           {lpStartupInfo}
                   ProcessInformation     {lpProcessInformation}
                  )
  then {Success}
    Result := ProcessInformation.hProcess
  else {Fail} begin
    Result := 0;
  end
end;

{-----------------------------------------------------------------}

function  WinExecAndWait(const aCmdLine : string;
                         const aDirectory: string;
                         const aCmdShow : integer) : Boolean;
var
  Handle: THandle;
begin
  Handle := WinExecForMulti(aCmdLine, aDirectory, aCmdShow);
  if Handle > 0 then begin
    WaitForSingleObject(Handle, INFINITE);
    CloseHandle(Handle);
    Result := True;
  end
  else
    Result := False;
end;

function  WinExecNoWait( const aCmdLine : string;
                         const aDirectory: string;
                         const aCmdShow : integer) : Boolean;
var
  Handle: THandle;
begin
  Handle := WinExecForMulti(aCmdLine, aDirectory, aCmdShow);
  if Handle > 0 then begin
    CloseHandle(Handle);
    Result := True;
  end
  else
    Result := False;
end;

{-----------------------------------------------------------------}

end.

