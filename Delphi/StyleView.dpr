program StyleView;

uses
  Forms,
  StyleView1 in 'StyleView1.pas' {frmStylesheets};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'XSL Stylesheet Viewer';
  Application.CreateForm(TfrmStylesheets, frmStylesheets);
  Application.Run;
end.
