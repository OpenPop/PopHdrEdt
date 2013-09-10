unit uPopHdrEdt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, jpeg, ExtCtrls, Registry;

type
  TPopHdrEdt = class(TForm)
    grpSpels: TGroupBox;
    chkBlast: TCheckBox;
    chkLightning: TCheckBox;
    chkTornado: TCheckBox;
    chkSwarm: TCheckBox;
    chkInvisibility: TCheckBox;
    chkHipnotise: TCheckBox;
    chkFireStorm: TCheckBox;
    chkErode: TCheckBox;
    chkSwamp: TCheckBox;
    chkLandBridge: TCheckBox;
    chkAngelOfDeth: TCheckBox;
    chkEarthQuake: TCheckBox;
    chkFlatten: TCheckBox;
    chkVolcano: TCheckBox;
    chkConvert: TCheckBox;
    chkMagicalShield: TCheckBox;
    grpBuildings: TGroupBox;
    chkHut: TCheckBox;
    chkGuardTower: TCheckBox;
    chkTemple: TCheckBox;
    chkSpyTrainingHut: TCheckBox;
    chkWarriorTrainingHut: TCheckBox;
    chkFireWarriorTrainingHut: TCheckBox;
    chkBoatHouse: TCheckBox;
    chkBallonHut: TCheckBox;
    grpMisc: TGroupBox;
    chkFogOfWar: TCheckBox;
    chkGodMode: TCheckBox;
    t00: TImage;
    t01: TImage;
    t02: TImage;
    t03: TImage;
    t04: TImage;
    t05: TImage;
    t06: TImage;
    t07: TImage;
    t08: TImage;
    t09: TImage;
    t0a: TImage;
    t0b: TImage;
    t0c: TImage;
    t0d: TImage;
    t0e: TImage;
    t0f: TImage;
    t10: TImage;
    t11: TImage;
    t12: TImage;
    t13: TImage;
    t14: TImage;
    t15: TImage;
    t16: TImage;
    t17: TImage;
    t18: TImage;
    t19: TImage;
    t1a: TImage;
    t1b: TImage;
    t1c: TImage;
    t1d: TImage;
    t1e: TImage;
    t1f: TImage;
    t20: TImage;
    t21: TImage;
    t22: TImage;
    grpMapTexture: TGroupBox;
    cbMapTexture: TComboBox;
    t__: TImage;
    grpFile: TGroupBox;
    edtFileName: TEdit;
    btnOpen: TButton;
    btnSave: TButton;
    btnClose: TButton;
    btnReset: TButton;
    txtWarn: TLabel;
    txtAbout: TLabel;
    txtALACN: TLabel;
    chkGhostArmy: TCheckBox;
    t23: TImage;
    o00: TImage;
    o03: TImage;
    o04: TImage;
    o05: TImage;
    o06: TImage;
    grpObjBank: TGroupBox;
    o__: TImage;
    cbObjectBank: TComboBox;
    procedure cbMapTextureChange(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure cbObjectBankChange(Sender: TObject);
  private
  public
    strLevelDir: string;
    strFileName: string;
    procedure ReadInfo;
    procedure SaveInfo;
  end;

var
  PopHdrEdt: TPopHdrEdt;

implementation

{$R *.DFM}

const
  { -- Spels -- }
  S_BLAST         = $00000004;
  S_LIGHTNING     = $00000008;
  S_TORNADO       = $00000010;
  S_SWARM         = $00000020;
  S_INVISIBILITY  = $00000040;
  S_HIPNOTISE     = $00000080;
  S_FIRESTORM     = $00000100;
  S_GHOSTARMY     = $00000200;
  S_ERODE         = $00000400;
  S_SWAMP         = $00000800;
  S_LANDBRIDGE    = $00001000;
  S_ANGELOFDETH   = $00002000;
  S_EARTHQUAKE    = $00004000;
  S_FLATTEN       = $00008000;
  S_VOLCANO       = $00010000;
  S_CONVERT       = $00020000;
  S_MAGICALSHIELD = $00080000;

  { -- Buildings -- }
  B_HUT = $00000002;
  B_GUARDTOWER             = $00000010;
  B_TEMPLE                 = $00000020;
  B_SPYTRAININGHUT         = $00000040;
  B_WARRIORTRAININGHUT     = $00000080;
  B_FIREWARRIORTRAININGHUT = $00000100;
  B_BOATHOUSE1             = $00002000;
  B_BOATHOUSE2             = $00004000;
  B_BALLONHUT1             = $00008000;
  B_BALLONHUT2             = $00010000;

  { -- Misc -- }
  M_FOGOFWAR = $0001;
  M_GODMODE  = $0002;


procedure TPopHdrEdt.ReadInfo;
var
  h: THandle;
  dw, dwRW: DWORD;
begin
  // open file
  h := CreateFile(PChar(strFileName), GENERIC_READ, FILE_SHARE_READ, nil,
    OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);

  // if can't open
  if h = INVALID_HANDLE_VALUE then
  begin
    MessageBox(Handle, PChar('Cannot Open File "' + edtFileName.Text + '" !'),
      PChar(Application.Title), MB_ICONHAND);
    strFileName := '';
    edtFileName.Text := '';
  end;

  // check size
  dw := FileSeek(h, 0, 2);
  if dw <> 616 then
  begin
    if MessageBox(Handle, PChar('Warning: File Size Mismatch!' +#13+ 'Do you want continue?'),
      PChar(Application.Title), MB_ICONEXCLAMATION + MB_YESNO + MB_DEFBUTTON2) <> ID_YES then
    begin
      strFileName := '';
      edtFileName.Text := '';
      CloseHandle(h);
      Exit;
    end;
  end;

  { -- spels -- }
  FileSeek(h, 0, 0);
  dw := 0;
  ReadFile(h, dw, 4, dwRW, nil);

  // blast
  if (S_BLAST and dw) > 0 then chkBlast.Checked := True
  else chkBlast.Checked := False;

  // lightning
  if (S_LIGHTNING and dw) > 0 then chkLightning.Checked := True
  else chkLightning.Checked := False;

  // tornado
  if (S_TORNADO and dw) > 0 then chkTornado.Checked := True
  else chkTornado.Checked := False;

  // swarm
  if (S_SWARM and dw) > 0 then chkSwarm.Checked := True
  else chkSwarm.Checked := False;

  // invisibility
  if (S_INVISIBILITY and dw) > 0 then chkInvisibility.Checked := True
  else chkInvisibility.Checked := False;

  // hipnotise
  if (S_HIPNOTISE and dw) > 0 then chkHipnotise.Checked := True
  else chkHipnotise.Checked := False;

  // fire storm
  if (S_FIRESTORM and dw) > 0 then chkFireStorm.Checked := True
  else chkFireStorm.Checked := False;

  // ghost army
  if (S_GHOSTARMY and dw) > 0 then chkGhostArmy.Checked := True
  else chkGhostArmy.Checked := False;

  // erode
  if (S_ERODE and dw) > 0 then chkErode.Checked := True
  else chkErode.Checked := False;

  // swamp
  if (S_SWAMP and dw) > 0 then chkSwamp.Checked := True
  else chkSwamp.Checked := False;

  // land bridge
  if (S_LANDBRIDGE and dw) > 0 then chkLandBridge.Checked := True
  else chkLandBridge.Checked := False;

  // angel of deth
  if (S_ANGELOFDETH and dw) > 0 then chkAngelOfDeth.Checked := True
  else chkAngelOfDeth.Checked := False;

  // earth quake
  if(S_EARTHQUAKE and dw) > 0 then chkEarthQuake.Checked := True
  else chkEarthQuake.Checked := False;

  // flatten
  if (S_FLATTEN and dw) > 0 then chkFlatten.Checked := True
  else chkFlatten.Checked := False;

  // volcano
  if (S_VOLCANO and dw) > 0 then chkVolcano.Checked := True
  else chkVolcano.Checked := False;

  // convert
  if (S_CONVERT and dw) > 0 then chkConvert.Checked := True
  else chkConvert.Checked := False;

  // magical shield
  if (S_MAGICALSHIELD and dw) > 0 then chkMagicalShield.Checked := True
  else chkMagicalShield.Checked := False;

  { -- buildings offset -- }
  FileSeek(h, 4, 0);
  dw := 0;
  ReadFile(h, dw, 4, dwRW, nil);

  // hut
  if (B_HUT and dw) > 0 then chkHut.Checked := True
  else chkHut.Checked := False;

  // guard tower
  if( B_GUARDTOWER and dw) > 0 then chkGuardTower.Checked := True
  else chkGuardTower.Checked := False;

  // temple
  if (B_TEMPLE and dw) > 0 then chkTemple.Checked := True
  else chkTemple.Checked := False;

  // spy training hut
  if (B_SPYTRAININGHUT and dw) > 0 then chkSpyTrainingHut.Checked := True
  else chkSpyTrainingHut.Checked := False;

  // warrior training hut
  if (B_WARRIORTRAININGHUT and dw) > 0 then chkWarriorTrainingHut.Checked := True
  else chkWarriorTrainingHut.Checked := False;

  // firewarrior training hut
  if (B_FIREWARRIORTRAININGHUT and dw) > 0 then chkFireWarriorTrainingHut.Checked := True
  else chkFireWarriorTrainingHut.Checked := False;

  // boat house
  if (B_BOATHOUSE1 and dw)or(B_BOATHOUSE2 and dw) > 0 then chkBoatHouse.Checked := True
  else chkBoatHouse.Checked := False;

  // ballon hut
  if (B_BALLONHUT1 and dw)or(B_BALLONHUT2 and dw) > 0 then chkBallonHut.Checked := True
  else chkBallonHut.Checked := False;

  { -- fog of war and god mode -- }
  FileSeek(h, $62, 0);
  dw := 0;
  ReadFile(h, dw, 2, dwRW, nil);

  if (M_FOGOFWAR and dw) > 0 then chkFogOfWar.Checked := True
  else chkFogOfWar.Checked := False;

  if (M_GODMODE and dw) > 0 then chkGodMode.Checked := True
  else chkGodMode.Checked := False;

  { -- map texture -- }
  FileSeek(h, $60, 0);
  dw := 0;
  ReadFile(h, dw, 1, dwRW, nil);

  if dw > 35 then dw := 01;
  cbMapTexture.ItemIndex := dw;
  cbMapTexture.OnChange(cbMapTexture);

  { -- object bank -- }
  FileSeek(h, $61, 0);
  dw := 0;
  ReadFile(h, dw, 1, dwRW, nil);

  case dw of
    3: cbObjectBank.ItemIndex := 1;
    4: cbObjectBank.ItemIndex := 2;
    5: cbObjectBank.ItemIndex := 3;
    6: cbObjectBank.ItemIndex := 4;
  else cbObjectBank.ItemIndex := 0;
  end;

  cbObjectBank.OnChange(cbObjectBank);

  // close file

  CloseHandle(h);
end;

procedure TPopHdrEdt.SaveInfo;
var
  h: THandle;
  dw, dwRW: DWORD;
begin
  if Length(strFileName) = 0 then Exit;

  // open file
  h := CreateFile(PChar(strFileName), GENERIC_READ + GENERIC_WRITE, 0, nil,
    OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);

  // if can't open
  if h = INVALID_HANDLE_VALUE then
  begin
    MessageBox(Handle, PChar('Cannot Open File "' + edtFileName.Text + '" !'),
      PChar(Application.Title), MB_ICONHAND);
  end;

  { -- spels -- }
  dw := 0;

  if chkBlast.Checked then dw := dw + S_BLAST;
  if chkLightning.Checked then dw := dw + S_LIGHTNING;
  if chkTornado.Checked then dw := dw + S_TORNADO;
  if chkSwarm.Checked then dw := dw + S_SWARM;
  if chkInvisibility.Checked then dw := dw + S_INVISIBILITY;
  if chkHipnotise.Checked then dw := dw + S_HIPNOTISE;
  if chkFireStorm.Checked then dw := dw + S_FIRESTORM;
  if chkGhostArmy.Checked then dw := dw + S_GHOSTARMY;
  if chkErode.Checked then dw := dw + S_ERODE;
  if chkSwamp.Checked then dw := dw + S_SWAMP;
  if chkLandBridge.Checked then dw := dw + S_LANDBRIDGE;
  if chkAngelOfDeth.Checked then dw := dw + S_ANGELOFDETH;
  if chkEarthQuake.Checked then dw := dw + S_EARTHQUAKE;
  if chkFlatten.Checked then dw := dw + S_FLATTEN;
  if chkVolcano.Checked then dw := dw + S_VOLCANO;
  if chkConvert.Checked then dw := dw + S_CONVERT;
  if chkMagicalShield.Checked then dw := dw + S_MAGICALSHIELD;

  FileSeek(h, 0, 0);
  FileWrite(h, dw, 4);

  { -- buildings -- }
  dw := 0;

  if chkHut.Checked then dw := dw + B_HUT;
  if chkGuardTower.Checked then dw := dw + B_GUARDTOWER;
  if chkTemple.Checked then dw := dw + B_TEMPLE;
  if chkSpyTrainingHut.Checked then dw := dw + B_SPYTRAININGHUT;
  if chkWarriorTrainingHut.Checked then dw := dw + B_WARRIORTRAININGHUT;
  if chkFireWarriorTrainingHut.Checked then dw := dw + B_FIREWARRIORTRAININGHUT;
  if chkBoatHouse.Checked then dw := dw + B_BOATHOUSE1;
  if chkBallonHut.Checked then dw := dw + B_BALLONHUT1;

  FileSeek(h, 4, 0);
  WriteFile(h, dw, 4, dwRW, nil);

  { -- fog of war and god mode -- }
  dw := 0;

  if chkFogOfWar.Checked then dw := dw + M_FOGOFWAR;
  if chkGodMode.Checked then dw := dw + M_GODMODE;

  FileSeek(h, $62, 0);
  WriteFile(h, dw, 2, dwRW, nil);

  { -- map texture -- }
  dw := cbMapTexture.ItemIndex;

  FileSeek(h, $60, 0);
  WriteFile(h, dw, 1, dwRW, nil);

  { -- object bank -- }

  case cbObjectBank.ItemIndex of
    0: dw := 0;
    1: dw := 3;
    2: dw := 4;
    3: dw := 5;
    4: dw := 6;
  end;

  FileSeek(h, $61, 0);
  WriteFile(h, dw, 1, dwRW, nil);

  // close file

  CloseHandle(h);

  MessageBox(Handle, 'Saved!', PChar(Application.Title), MB_ICONASTERISK);
end;

procedure TPopHdrEdt.cbMapTextureChange(Sender: TObject);
var
  c: TComponent;
  s: string;
begin
  s := 't' + IntToHex(cbMapTexture.ItemIndex, 2);
  c := FindComponent(s);
  if c <> nil then
    t__.Picture := TImage(c).Picture;
end;

procedure TPopHdrEdt.btnOpenClick(Sender: TObject);
var
  dlg: TOpenDialog;
begin
  dlg := TOpenDialog.Create(Self);
  with dlg do try
    InitialDir := GetCurrentDir;
    DefaultExt := '*.hdr';
    Filter := 'Populous Header (*.hdr)|*.hdr';
    if Execute then
    begin
      strFileName := FileName;
      edtFileName.Text := ExtractFileName(FileName);
      ReadInfo;
    end;
  finally
    dlg.Free;
  end;
end;

procedure TPopHdrEdt.FormCreate(Sender: TObject);
var
  reg: TRegistry;
begin
  SetCurrentDir(ExtractFilePath(Application.ExeName));

  reg := TRegistry.Create;
  with reg do try
    RootKey := HKEY_LOCAL_MACHINE;
    if OpenKey('Software\Bullfrog Productions Ltd\Populous: The Beginning', False) then
    begin
      if ValueExists('InstallPath') then
        SetCurrentDir(ReadString('InstallPath') + '\Levels');
    end;
  finally
    reg.Free;
  end;
end;

procedure TPopHdrEdt.btnResetClick(Sender: TObject);
begin
  if Length(strFileName) > 0 then ReadInfo;
end;

procedure TPopHdrEdt.btnCloseClick(Sender: TObject);
begin
  strFileName := '';
  edtFileName.Text := '';

  cbObjectBank.ItemIndex := -1;
  o__.Picture.Graphic := nil;

  cbMapTexture.ItemIndex := -1;
  t__.Picture.Graphic := nil;

  chkFogOfWar.Checked := False;
  chkGodMode.Checked := False;

  chkHut.Checked := False;
  chkGuardTower.Checked := False;
  chkTemple.Checked := False;
  chkSpyTrainingHut.Checked := False;
  chkWarriorTrainingHut.Checked := False;
  chkFireWarriorTrainingHut.Checked := False;
  chkBoatHouse.Checked := False;
  chkBallonHut.Checked := False;

  chkBlast.Checked := False;
  chkLightning.Checked := False;
  chkTornado.Checked := False;
  chkSwarm.Checked := False;
  chkInvisibility.Checked := False;
  chkHipnotise.Checked := False;
  chkFireStorm.Checked := False;
  chkGhostArmy.Checked := False;
  chkErode.Checked := False;
  chkSwamp.Checked := False;
  chkLandBridge.Checked := False;
  chkAngelOfDeth.Checked := False;
  chkEarthQuake.Checked := False;
  chkFlatten.Checked := False;
  chkVolcano.Checked := False;
  chkConvert.Checked := False;
  chkMagicalShield.Checked := False;
end;

procedure TPopHdrEdt.btnSaveClick(Sender: TObject);
begin
  SaveInfo;
end;

procedure TPopHdrEdt.cbObjectBankChange(Sender: TObject);
begin
  case cbObjectBank.ItemIndex of
    0: o__.Picture.Graphic := o00.Picture.Graphic;
    1: o__.Picture.Graphic := o03.Picture.Graphic;
    2: o__.Picture.Graphic := o04.Picture.Graphic;
    3: o__.Picture.Graphic := o05.Picture.Graphic;
    4: o__.Picture.Graphic := o06.Picture.Graphic;
  end;
end;

end.
