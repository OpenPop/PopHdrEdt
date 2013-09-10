program pPopHdrEdt;

uses
  Forms,
  uPopHdrEdt in 'uPopHdrEdt.pas' {PopHdrEdt};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Populous HDR Editor';
  Application.CreateForm(TPopHdrEdt, PopHdrEdt);
  Application.Run;
end.
