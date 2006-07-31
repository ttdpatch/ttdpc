program ttdpc;

uses
  Forms,
  Main in 'Main.pas' {frmMain},
  Utils in 'Utils.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
