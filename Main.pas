unit Main;

{ DONE 1  -cbasic funtionality : Patchman: For bit switches, you should provide a way to switch the entire switch off (and maybe on). Setting all bits to off does not turn off the switch (important e.g. for "mousewheel" and especially "newsounds"). }
{ DONE 1 -cbasic functionality : csaba: Bitswitches that are OFF on load gets saved with all bits explicit. This is wrong. }
{ DONE 1 -cGUI : csaba: Enter range values as off/on/on value [editbox] }
{ DONE 1 -cbasic functionality : Hyro: create ttdpatch(w).cfg if it doesn't exist}
{ DONE 1 -cGUI : Csaba: drop the Update button, introduce Revert }
{ DONE  -cbasic functionality : eis_os: Terminate app if ttdpatch(w) is missing  }
{ DONE 2 -cGUI : Patchman: Tooltips would be nice for the toolbar buttons, and/or text below the buttons. }
{ DONE 2 -cGUI : Patchman: It'd be nice to have Alt keys for the switch values and search box, e.g. alt-n = On, alt-f = Off, alt-v = Switch value, alt-s = Search string, and also the "Update" button. }
{ DONE 2 -cInstallation/Setup :  now it must be placed in same folder as TTD. It'd be good to add option to browse for TTD (I usually hold all tools in separate folder). }
{ DONE 2 -cInstallation/Setup : add option to look for ttdpatch.cfg (like TTDXC) }
{ TODO 3 -cAdditional functions : add button "Run TTD" which closes TTPC and starts TTD }
{ TODO 4 -cGUI : Patchman: I'd prefer an actual menu though because it can be used without the mouse. Or maybe just add hotkeys for the buttons. }
{ TODO 4 -cGUI : Patchman: The mouse wheel moves the focus to the next entry to the list, instead of scrolling the list itself by the amount set in the OS settings (half a screen in my case) }
{ TODO 4 -cbasic functionality : Multi-language }
{ TODO 5 -cAdditional functions : nice to have the possibility to save different configurations and reload them, depending on the game you want to play }
{ TODO 5 -cGUI : Patchman: I think "First/Next" should be "Search/Again"  ## Why}
{ DONE 5 -cGUI : eis_os: 'Update' should be called 'Save settings' ## Superceeded by GUI change}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, JvSimpleXml, Buttons, Grids,
  Outline, TB97Ctls, JvExStdCtrls, JvEdit, JvValidateEdit, Mask, JvExMask,
  JvSpin, JvComponentBase, JvAppEvent;

type

  TSwitchType = (swUnknown, swBool, swBit, swRange, swSpecial);

  TEditResult = (crText, crBool, crSmallRange, crLargeRange);

  TBitDescr = record
    BitNum: Integer;
    Name: string;
    Description: string;
    Undefined: Boolean;
    ConfigValue: string;
    OriginalValue: string;
    Changed: Boolean;
  end;

  TBitDescrArray = array of TBitDescr;

  TSwitch = record
    SwitchType: TSwitchType;
    Name: string;
    RangeLow: Integer;
    RangeHigh: Integer;
    DefValue: Integer;
    BitDescr: TBitDescrArray;
    CmdLineSwitch: string;
    DefStateValue: string;
    CategoryNum: Integer;
    CategoryLevel: Integer;
    Category: string;
    Description: string;
    Undefined: Boolean;
    ConfigValue: string;
    OriginalValue: string;
    ValidDigits: string;
    Changed: Boolean;
    ManPage: string;
  end;

  PSwitch = ^TSwitch;

  TSwitchList = class
  private
    fLines: TStringList;
    fFileName: string;
    fVersion: string;
    fSwitches: array of TSwitch;
    function GetSwitch(Index: Integer): TSwitch;
    procedure SetSwitch(Index: Integer; const Value: TSwitch);
    procedure SortByCategory;
  public
    InitialComments: string;
    procedure LoadTemplateFile(FileName: string);
    function LoadConfigFile(FileName: string): boolean;
    procedure SaveConfigFileCanonical(FileName: string);
    procedure SaveConfigFileUserPref(FileName: string);
    procedure AddFromString(ConfigLine: string);
    destructor Destroy; override;
    procedure WriteAsConfig(FileName: string);
    property Switches[Index: Integer]: TSwitch read GetSwitch write SetSwitch; default;
    property Lines: TStringList read fLines;
    property Version: string read fVersion;
  end;

  TCategory = record
    Name: string;
    Description: string;
    SwitchRef: Integer;
    Level: Integer;
  end;

  TCategories = class
  private
    fStorage: array of TCategory;
    function GetCount: Integer;
    function GetStrings(i: Integer): string;
    procedure SetStrings(i: Integer; const Value: string);
    function GetSwitchRef(i: Integer): integer;
    procedure SetSwitchRef(i: Integer; const Value: integer);
    function GetLevel(i: Integer): integer;
    procedure SetLevel(i: Integer; const Value: integer);
  public
    procedure FillFromSwitchList(SwitchList: TSwitchList);
    function AddSwitch(s: string; swRef, Level: Integer): integer;
    property Count: Integer read GetCount;
    property SwitchRefs[i: Integer]: integer read GetSwitchRef write SetSwitchRef;
    property Levels[i: Integer]: Integer read GetLevel write SetLevel;
    property Strings[i: Integer]: string read GetStrings write SetStrings; default;
  end;

type
  TfrmMain = class(TForm)
    ButtonPanel: TPanel;
    edSwVersion: TEdit;
    xml1: TJvSimpleXML;
    InfoPanel: TPanel;
    mmDescription: TMemo;
    Label1: TLabel;
    btnExit: TToolbarButton97;
    btnSaveCanonFormat: TToolbarButton97;
    btnExpand: TToolbarButton97;
    btnCollapse: TToolbarButton97;
    btnSaveUserFormat: TToolbarButton97;
    ToolbarButton976: TToolbarButton97;
    ToolbarButton977: TToolbarButton97;
    lbTextVale: TLabel;
    pgEdits: TPageControl;
    tsText: TTabSheet;
    tsBool: TTabSheet;
    tsSmallRange: TTabSheet;
    tsLargeRange: TTabSheet;
    edTextValue: TEdit;
    tsBlank: TTabSheet;
    SearchPanel: TPanel;
    lbSearch: TLabel;
    edSearch: TEdit;
    cbSearchDescription: TCheckBox;
    btnFindFirst: TBitBtn;
    btnFindNext: TBitBtn;
    GroupBox1: TGroupBox;
    edSmallRange: TJvSpinEdit;
    rgSmOff: TRadioButton;
    rgSmOn: TRadioButton;
    rgSmValue: TRadioButton;
    GroupBox2: TGroupBox;
    edLargeRange: TJvValidateEdit;
    rgLaOff: TRadioButton;
    rgLaOn: TRadioButton;
    rgLaValue: TRadioButton;
    GroupBox3: TGroupBox;
    rgBoolOff: TRadioButton;
    rgBoolOn: TRadioButton;
    Label2: TLabel;
    btnUndo: TBitBtn;
    Outline1: TOutline;
    JvAppEvents1: TJvAppEvents;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Outline1Click(Sender: TObject);
    procedure btnExpandClick(Sender: TObject);
    procedure btnCollapseClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnSaveCanonFormatClick(Sender: TObject);
    procedure Outline1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edTextValueChange(Sender: TObject);
    procedure UpdateView;
    procedure edLargeRangeChange(Sender: TObject);
    procedure edSmallRangeChange(Sender: TObject);
    procedure btnFindFirstClick(Sender: TObject);
    procedure btnFindNextClick(Sender: TObject);
    procedure edSearchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edSearchChange(Sender: TObject);
    procedure rgSmOffClick(Sender: TObject);
    procedure rgLaOffClick(Sender: TObject);
    procedure rgBoolOffClick(Sender: TObject);
    procedure rgBoolOnClick(Sender: TObject);
    procedure rgSmOnClick(Sender: TObject);
    procedure rgSmValueClick(Sender: TObject);
    procedure rgLaOnClick(Sender: TObject);
    procedure rgLaValueClick(Sender: TObject);
    procedure btnUndoClick(Sender: TObject);
    procedure btnSaveUserFormatClick(Sender: TObject);
    procedure Outline1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure JvAppEvents1Message(var Msg: tagMSG; var Handled: Boolean);
  private
    { Private declarations }
    ConfigFile: TSwitchList;
    Categories: TCategories;
    CurSwitch: PSwitch;
    CurBitIx: Integer;
    CurResult: TEditResult;
    PatchBaseName: string;
    TTDPath: string;
    SearchEditChanged: Boolean;
    Editing: Boolean;
    procedure ReplaceValue(ix: Integer; Value: string);
    procedure CheckEditLargeRO;
    procedure CheckEditSmallRO;
    function SearchSwitch(Search: string; Start: integer): Integer;
    function SearchDescr(Search: string; Start: integer): Integer;
    procedure ExpandToMatch(ix: Integer);
    function CreateSwitchesXML: boolean;
    function FindTTDPatch: boolean;
    function CreateConfigFile: Boolean;
    procedure DisableAllInput;
    procedure EnableBoolInput(s, vDef: string);
    procedure EnableLargeRangeInput(s: string; vMin, vMax, vDef: integer);
    procedure EnableSmallRangeInput(s: string; vMin, vMax, vDef: integer);
    procedure EnableTextInput(s: string);
    procedure FillOutline(Categories: TCategories; SwitchList: TSwitchList);
    procedure FixOutlineLevels;
    procedure BackupOldConfigFile(FileName: string);
  public
    { Public declarations }
  end;

var
  frmMain           : TfrmMain;

implementation

{$R *.DFM}

uses
  Math,
  FileCtrl,                             // SelectDirectory
  IniFiles,                             // TIniFile
  ShellApi,                             // ShellExecute
  JclFileUtils,                         // TFileVersionInfo
  gnugettext,
  Utils
  ;

const

  PATCH_CONFIG_FILE = 'ttdpatch.cfg';
  PATCH_TEMPLATE_FILE = 'switches.xml';
  PATCH_WIN_NAME    = 'ttdpatchw';
  PATCH_DOS_NAME    = 'ttdpatch';

  SwitchTypeNames   : array[swUnknown..swSpecial] of string =
    ('(unknown)', 'Bool', 'Bitswitch', 'Range', 'Special');

  OffOn             : array[0..1] of string = ('off', 'on');

  Pow2              : array[0..31] of DWORD = (
    $00000001, $00000002, $00000004, $00000008,
    $00000010, $00000020, $00000040, $00000080,
    $00000100, $00000200, $00000400, $00000800,
    $00001000, $00002000, $00004000, $00008000,
    $00010000, $00020000, $00040000, $00080000,
    $00100000, $00200000, $00400000, $00800000,
    $01000000, $02000000, $04000000, $08000000,
    $10000000, $20000000, $40000000, $80000000
    );


procedure DebugHalt;
begin
  if (ParamCount < 1) or (ParamStr(1) <> 'NoHalt') then
    Application.Terminate;
end;

{
  This is a (hopefully) fault tolerant parser for the (s)printf formats in the Description
  field. Different versions of the XML seems to have different number of fields.
}

function SafeFormat(f: string; args: array of const): string;
var
  p1, p2            : Integer;
  ArgIx             : Integer;
  ArgString         : string;
begin
  Result := '';
  ArgIx := Low(args);
  f := StringReplace(f, '%%', 'ÖÖ', [rfReplaceAll]);
  p1 := Pos('%', f);
  while (p1 > 0) do begin
    if (ArgIx <= High(args)) then begin
      case args[ArgIx].VType of
        System.vtInteger: ArgString := IntToStr(args[ArgIx].VInteger);
        System.vtInt64: ArgString := IntToStr(args[ArgIx].VInt64^);
        System.vtString: ArgString := args[ArgIx].VString^;
        System.vtAnsiString: ArgString := PChar(args[ArgIx].VAnsiString);
        else
          ArgString := _('(Error: Unexpected argument type)');
      end;
      Inc(ArgIx);
    end
    else begin
      ArgString := '<?>';
    end;
    Result := Result + Copy(f, 1, p1 - 1) + ArgString;
    p2 := p1;
    while (p2 <= Length(f)) and (not (f[p2] in ['d', 's', 'x'])) do
      Inc(p2);
    f := Copy(f, p2 + 1, MaxInt);
    p1 := Pos('%', f);
  end;
  Result := Result + f;
  Result := StringReplace(Result, 'ÖÖ', '%', [rfReplaceAll]);
end;

function IsNumericString(s: string): Boolean;
const
  LoInt             = Low(Integer);
var
  i                 : Integer;
begin
  if (Length(s) > 0) then begin
    if (s[1] = '#') then begin
      Result := True;
      for i := 2 to Length(s) do begin
        if not (s[i] in ['0', '1']) then
          Result := False;
      end
    end
    else begin
      i := StrToIntDef(s, LoInt);
      Result := (i <> LoInt);
    end
  end
  else
    Result := False;
end;

function BinStrToInt(s: string): Integer;
var
  i                 : Integer;
begin
  Result := 0;
  i := 1;
  while (i <= Length(s)) do begin
    Result := Result * 2;
    if (s[i] = '1') then Inc(Result);
    Inc(i);
  end
end;

function ConvertSwitchStrToInt(Str: string; DefVal: DWORD): DWORD;
var
  s                 : string;
begin
  s := LowerCase(Str);
  if (s = 'off') or (s = 'no') or (s = 'n') then
    Result := $00000000
  else if (s = 'on') or (s = 'yes') or (s = 'y') or (s = '') then
    Result := DefVal
  else if (Length(s) > 0) and (s[1] = '#') then
    Result := BinStrToInt(Copy(s, 2, MaxInt))
  else
    Result := StrToInt(s);
end;

{ TCategories }

function TCategories.AddSwitch(s: string; swRef, Level: Integer): integer;
var
  ix                : Integer;
begin
  ix := Length(fStorage);
  SetLength(fStorage, ix + 1);
  fStorage[ix].Name := s;
  fStorage[ix].Description := s;
  fStorage[ix].SwitchRef := swRef;
  fStorage[ix].Level := Level;
end;

procedure TCategories.FillFromSwitchList(SwitchList: TSwitchList);
var
  i                 : Integer;
  cn                : Integer;
  ct                : string;
  ctx               : Integer;
  swxb, swxe        : Integer;
  swx               : Integer;
  b                 : Integer;
  bfc               : Integer;
  j                 : Integer;
begin
  ct := '###';
  for i := 0 to Pred(Length(SwitchList.fSwitches)) do begin
    if (ct <> SwitchList.fSwitches[i].Category) then begin
      AddSwitch(SwitchList.fSwitches[i].Category, i, SwitchList.fSwitches[i].CategoryLevel);
      ct := SwitchList.fSwitches[i].Category;
    end
  end;
end;


function TCategories.GetCount: Integer;
begin
  Result := Length(fStorage);
end;

function TCategories.GetSwitchRef(i: Integer): integer;
begin
  Result := fStorage[i].SwitchRef;
end;

function TCategories.GetStrings(i: Integer): string;
begin
  Result := fStorage[i].Description;
end;

procedure TCategories.SetSwitchRef(i: Integer; const Value: integer);
begin
  fStorage[i].SwitchRef := Value;
end;

procedure TCategories.SetStrings(i: Integer; const Value: string);
begin
  fStorage[i].Description := Value;
end;

function TCategories.GetLevel(i: Integer): integer;
begin
  Result := fStorage[i].Level;
end;

procedure TCategories.SetLevel(i: Integer; const Value: integer);
begin
  fStorage[i].Level := Value;
end;

{ TSwitchList }

procedure TSwitchList.AddFromString(ConfigLine: string);
var
  SwitchName        : string;
  BitFieldName      : string;
  SwitchValue       : string;
  sp                : Integer;
  dp                : Integer;
  i                 : Integer;
  b                 : Integer;
  bw                : DWORD;
  L                 : Integer;
begin
  sp := Pos('=', ConfigLine);
  if (sp = 0) then
    sp := Pos(' ', ConfigLine);
  if (sp = 0) then
    sp := Length(ConfigLine) + 1;

  SwitchName := LowerCase(Trim(Copy(ConfigLine, 1, sp - 1)));
  SwitchValue := Trim(Copy(ConfigLine, sp + 1, MaxInt));

  dp := Pos('.', SwitchName);

  if (dp > 0) then begin
    BitFieldName := Copy(SwitchName, dp + 1, MaxInt);
    SwitchName := Copy(SwitchName, 1, dp - 1);
  end
  else begin
    BitFieldName := '';
  end;

  L := Length(fSwitches);
  for i := 0 to Pred(L) do begin
    if (SwitchName = fSwitches[i].Name) then begin
      if (BitFieldName = '') then begin
        fSwitches[i].Changed := True;
        if (fSwitches[i].SwitchType = swBit) then begin
          fSwitches[i].ConfigValue := SwitchValue;
          if IsNumericString(SwitchValue) then begin
            fSwitches[i].ConfigValue := 'on';
            // Decode the bits
            bw := ConvertSwitchStrToInt(SwitchValue, fSwitches[i].DefValue);
            for b := 0 to Pred(Length(fSwitches[i].BitDescr)) do begin
              fSwitches[i].BitDescr[b].Changed := True;
              if ((bw and Pow2[fSwitches[i].BitDescr[b].BitNum]) <> 0) then
                fSwitches[i].BitDescr[b].ConfigValue := 'on'
              else
                fSwitches[i].BitDescr[b].ConfigValue := 'off';
              fSwitches[i].BitDescr[b].OriginalValue := fSwitches[i].BitDescr[b].ConfigValue;
            end
          end
          else begin
            // Clear all the bits
            for b := 0 to Pred(Length(fSwitches[i].BitDescr)) do begin
              fSwitches[i].BitDescr[b].ConfigValue := '';
              fSwitches[i].BitDescr[b].OriginalValue := fSwitches[i].BitDescr[b].ConfigValue;
              fSwitches[i].BitDescr[b].Changed := False;
            end
          end;
          fSwitches[i].OriginalValue := fSwitches[i].ConfigValue;
        end
        else begin
          // 0 means 'off' if out of range
          if (ConvertSwitchStrToInt(SwitchValue, fSwitches[i].DefValue) = 0) and (fSwitches[i].RangeLow > 0) then
            SwitchValue := 'off';
          fSwitches[i].ConfigValue := SwitchValue;
          fSwitches[i].OriginalValue := SwitchValue;
        end;
        Exit;
      end
      else begin
        // Individual bits are set, activate the main switch
        fSwitches[i].ConfigValue := 'on';
        fSwitches[i].OriginalValue := fSwitches[i].ConfigValue;
        for b := 0 to Pred(Length(fSwitches[i].BitDescr)) do begin
          if (BitFieldName = fSwitches[i].BitDescr[b].Name) then begin
            fSwitches[i].BitDescr[b].ConfigValue := SwitchValue;
            fSwitches[i].BitDescr[b].OriginalValue := fSwitches[i].BitDescr[b].ConfigValue;
            fSwitches[i].BitDescr[b].Changed := True;
            Exit;
          end
        end;
        // Bitname not found
        ShowMessage(Format(_('Bitfield "%s" is not defined for "%s"'), [BitFieldName, fSwitches[i].Name]));
        Exit;
      end;
    end
  end;
  // Not found
  SetLength(fSwitches, L + 1);
  fSwitches[L].SwitchType := swUnknown;
  fSwitches[L].Name := SwitchName;
  fSwitches[L].CategoryNum := 99;
  fSwitches[L].Category := _('<Undefined switches>');
  fSwitches[L].Description := Format(_('Switch not defined in "%s"'), [PATCH_TEMPLATE_FILE]);
  fSwitches[L].Undefined := True;
  fSwitches[L].ConfigValue := SwitchValue;
  fSwitches[L].OriginalValue := SwitchValue;
  fSwitches[L].Changed := True;
end;

destructor TSwitchList.Destroy;
begin
  inherited;
  fLines.Free;
end;

function TSwitchList.GetSwitch(Index: Integer): TSwitch;
begin
  Result := fSwitches[Index];
end;

function TSwitchList.LoadConfigFile(FileName: string): boolean;
var
  i                 : Integer;
  p                 : Integer;
  s                 : string;
  ic                : Boolean;
begin
  InitialComments := '';
  fLines := TStringList.Create;
  try
    fLines.LoadFromFile(FileName);
    fFileName := FileName;
    fVersion := _('<none>');
    ic := True;
    for i := 0 to Pred(fLines.Count) do begin
      s := fLines[i];
      if (Length(s) = 0) or (not (s[1] in ['a'..'z', 'A'..'Z'])) then begin
        if (Length(s) = 0) then
          ic := False;
        if ic then begin
          InitialComments := InitialComments + #13 + #10 + Trim(fLines[i]);
        end
      end
      else begin
        p := Pos('//', s);
        if (p > 0) then
          s := Trim(Copy(s, 1, p - 1));
        AddFromString(s);
        ic := False;
      end
    end;
    Result := True;
  except
    Result := False;
  end
end;

procedure TSwitchList.LoadTemplateFile(FileName: string);
var
  Root              : TJvSimpleXMLElem;
  CatRoot           : TJvSimpleXMLElem;
  Child             : TJvSimpleXMLElem;
  b                 : Integer;
  c                 : Integer;
  bd                : Integer;
  i                 : Integer;
  j                 : Integer;
  LastI             : Integer;
  CatStack          : array[0..5] of TJvSimpleXMLElem;
  CatStackPtr       : Integer;
  SwitchCount       : Integer;

  procedure HandleCategory(Level, Order: Integer);
  var
    i               : Integer;
    b               : Integer;
    Child           : TJvSimpleXMLElem;
    CatRoot         : TJvSimpleXMLElem;
  begin
    for i := 0 to Pred(CatStack[CatStackPtr - 1].Items.Count) do begin
      Child := CatStack[CatStackPtr - 1].Items[i];
      if Child.Name = 'category' then begin
        CatRoot := Child;
        CatStack[CatStackPtr] := CatRoot;
        Inc(CatStackPtr);
        HandleCategory(Level + 1, Order);
        Dec(CatStackPtr);
      end
      else begin
        fSwitches[SwitchCount].Name := Child.Properties.Value('name');
        fSwitches[SwitchCount].CmdLineSwitch := Child.Properties.Value('cmdline');
        fSwitches[SwitchCount].DefStateValue := Child.Properties.Value('defstate');
        fSwitches[SwitchCount].CategoryNum := 0;
        fSwitches[SwitchCount].Category := CatStack[CatStackPtr - 1].Properties.Value('desc');
        fSwitches[SwitchCount].CategoryLevel := Level;
        fSwitches[SwitchCount].Description := Child.Properties.Value('desc');
        fSwitches[SwitchCount].Undefined := False;
        fSwitches[SwitchCount].ConfigValue := ''; // To be read from the PATCH_CONFIG_FILE file
        fSwitches[SwitchCount].OriginalValue := fSwitches[SwitchCount].ConfigValue;
        fSwitches[SwitchCount].ManPage := Child.Properties.Value('manpage');
        fSwitches[SwitchCount].ValidDigits := Child.Properties.Value('validdigits');
        fSwitches[SwitchCount].Changed := False;

        if (Child.Name = 'bool') then begin
          fSwitches[SwitchCount].SwitchType := swBool;
          fSwitches[SwitchCount].ConfigValue := fSwitches[SwitchCount].DefStateValue;
        end
        else if (Child.Name = 'range') then begin
          fSwitches[SwitchCount].SwitchType := swRange;
          fSwitches[SwitchCount].RangeLow := Child.Properties.IntValue('min');
          fSwitches[SwitchCount].RangeHigh := Child.Properties.IntValue('max');
          fSwitches[SwitchCount].DefValue := Child.Properties.IntValue('default');
          fSwitches[SwitchCount].ConfigValue := IntToStr(fSwitches[SwitchCount].DefValue);
        end
        else if (Child.Name = 'bitswitch') then begin
          fSwitches[SwitchCount].SwitchType := swBit;
          fSwitches[SwitchCount].DefValue := Child.Properties.IntValue('default');
          fSwitches[SwitchCount].ConfigValue := fSwitches[SwitchCount].DefStateValue;
          SetLength(fSwitches[SwitchCount].BitDescr, Child.Items.Count);
          for b := 0 to Pred(Child.Items.Count) do begin
            if (Child.Items[b].Name = 'bit') then begin
              fSwitches[SwitchCount].BitDescr[b].BitNum := Child.Items[b].Properties.IntValue('num');
              fSwitches[SwitchCount].BitDescr[b].Name := Child.Items[b].Properties.Value('name');
              fSwitches[SwitchCount].BitDescr[b].Description := Child.Items[b].Properties.Value('desc');
              fSwitches[SwitchCount].BitDescr[b].Undefined := False;
              fSwitches[SwitchCount].BitDescr[b].ConfigValue := '';
              fSwitches[SwitchCount].BitDescr[b].OriginalValue := fSwitches[SwitchCount].BitDescr[b].ConfigValue;
              fSwitches[SwitchCount].BitDescr[b].Changed := False;
            end
            else begin
              ShowMessage(Format(_('"%s" is not a bitfield of %s! Ignored.'), [Child.Items[b].Name, fSwitches[SwitchCount].Name]));
            end
          end
        end
        else if (Child.Name = 'special') then begin
          fSwitches[SwitchCount].SwitchType := swSpecial;
        end
        else begin
          ShowMessage(Format(_('"%s" is not a recognized switch type! The XML file is corrupt.'), [Child.Name]));
        end;
        Inc(SwitchCount);
      end
    end
  end;

  function LevelCount(s: string): Integer;
  var
    p               : integer;
  begin
    Result := 0;
    for p := 1 to Pred(Length(s)) do
      if (s[p] = '_') then
        Inc(Result);
  end;

begin
  frmMain.xml1.FileName := FileName;

  Root := frmMain.xml1.Root;
  if (Root.Name <> 'switches') then begin
    ShowMessage(Format(_('"switches" not found as root element in "%s". Terminating.'), [FileName]));
    DebugHalt;
  end;

  fVersion := Root.Properties.Value('version') + ', ID:' + Root.Properties.Value('ID');

  CatStackPtr := 0;
  if (Root.Items[0].Name = 'category') then begin
    // new xml format
    SetLength(fSwitches, 2000);
    SwitchCount := 0;
    for c := 0 to Pred(Root.Items.Count) do begin
      CatRoot := Root.Items[c];
      CatStack[CatStackPtr] := CatRoot;
      Inc(CatStackPtr);
      HandleCategory(0, c * 1000);
      Dec(CatStackPtr);
    end;
    SetLength(fSwitches, SwitchCount);
  end
  else begin
    // original xml format
    SetLength(fSwitches, Root.Items.Count);
    for i := 0 to Pred(Root.Items.Count) do begin
      Child := Root.Items[i];

      fSwitches[i].Name := Child.Properties.Value('name');
      fSwitches[i].CmdLineSwitch := Child.Properties.Value('cmdline');
      fSwitches[i].DefStateValue := Child.Properties.Value('defstate');
      fSwitches[i].CategoryNum := Child.Properties.IntValue('categorynum');
      fSwitches[i].Category := Child.Properties.Value('category');
      fSwitches[i].CategoryLevel := LevelCount(fSwitches[i].Category);
      fSwitches[i].Description := Child.Properties.Value('desc');
      fSwitches[i].Undefined := False;
      fSwitches[i].ConfigValue := '';   // To be read from the PATCH_CONFIG_FILE file
      fSwitches[i].ManPage := fSwitches[i].Name;
      fSwitches[SwitchCount].ValidDigits := '';
      fSwitches[i].Changed := False;

      if (Child.Name = 'bool') then begin
        fSwitches[i].SwitchType := swBool;
        fSwitches[i].ConfigValue := fSwitches[i].DefStateValue;
      end
      else if (Child.Name = 'range') then begin
        fSwitches[i].SwitchType := swRange;
        fSwitches[i].RangeLow := Child.Properties.IntValue('min');
        fSwitches[i].RangeHigh := Child.Properties.IntValue('max');
        fSwitches[i].DefValue := Child.Properties.IntValue('default');
        fSwitches[i].ConfigValue := IntToStr(fSwitches[i].DefValue);
      end
      else if (Child.Name = 'bitswitch') then begin
        fSwitches[i].SwitchType := swBit;
        fSwitches[i].DefValue := Child.Properties.IntValue('default');
        fSwitches[i].ConfigValue := fSwitches[i].DefStateValue;
        SetLength(fSwitches[i].BitDescr, Child.Items.Count);
        for b := 0 to Pred(Child.Items.Count) do begin
          if (Child.Items[b].Name = 'bit') then begin
            fSwitches[i].BitDescr[b].BitNum := Child.Items[b].Properties.IntValue('num');
            fSwitches[i].BitDescr[b].Name := Child.Items[b].Properties.Value('name');
            fSwitches[i].BitDescr[b].Description := Child.Items[b].Properties.Value('desc');
            fSwitches[i].BitDescr[b].Undefined := False;
            fSwitches[i].BitDescr[b].ConfigValue := '';
            fSwitches[i].BitDescr[b].Changed := False;
          end
          else begin
            ShowMessage(Format(_('"%s" is not a bitfield of %s! Ignored.'), [Child.Items[b].Name, fSwitches[i].Name]));
          end
        end
      end
      else if (Child.Name = 'special') then begin
        fSwitches[i].SwitchType := swSpecial;
      end
      else begin
        ShowMessage(Format(_('"%s" is not a recognized switch type! The XML file is corrupt.'), [Child.Name]));
      end;
    end;
    SortByCategory;
  end
end;

procedure TSwitchList.SaveConfigFileCanonical(FileName: string);
var
  i                 : Integer;
  b                 : Integer;
  Cat               : Integer;
  p                 : Integer;
  sl                : TStringList;
  Desc              : string;
  s                 : string;

  function BitsChanged(Switch: TSwitch): Boolean;
  var
    b               : Integer;
  begin
    Result := False;
    for b := 0 to Pred(Length(Switch.BitDescr)) do begin
      Result := Result or Switch.BitDescr[b].Changed;
    end
  end;

begin
  sl := TStringList.Create;
  sl.Text := InitialComments + #13 + #10;
  Cat := -1;
  try
    for i := 0 to Pred(Length(fSwitches)) do begin
      if (fSwitches[i].CategoryNum <> Cat) then begin
        sl.Add('');
        sl.Add(Format(_('// ----- Category %s ------'),[fSwitches[i].Category]));
        sl.Add('');
        Cat := fSwitches[i].CategoryNum;
      end;

      case fSwitches[i].SwitchType of
        swUnknown, swSpecial: begin
            s := fSwitches[i].Description;
            s := StringReplace(s, '%ld', '%d', [rfReplaceAll]);
            s := StringReplace(s, '%02lx', '%2.2x', [rfReplaceAll]);
            Desc := SafeFormat(s, [fSwitches[i].Name, fSwitches[i].CmdLineSwitch]);
            sl.Add('// ' + Desc);
            if (fSwitches[i].ConfigValue <> '') then begin
              sl.Add(fSwitches[i].Name + ' ' + fSwitches[i].ConfigValue);
            end
            else begin
              sl.Add('// ' + fSwitches[i].Name + ' ' + fSwitches[i].DefStateValue);
            end;
            sl.Add('');
          end;
        swBool: begin
            s := fSwitches[i].Description;
            s := StringReplace(s, '%ld', '%d', [rfReplaceAll]);
            s := StringReplace(s, '%02lx', '%2.2x', [rfReplaceAll]);
            Desc := SafeFormat(s, [fSwitches[i].Name, fSwitches[i].CmdLineSwitch]);
            sl.Add('// ' + Desc);
            if (fSwitches[i].ConfigValue <> '') then begin
              sl.Add(fSwitches[i].Name + ' ' + fSwitches[i].ConfigValue);
            end
            else begin
              sl.Add('// ' + fSwitches[i].Name + ' ' + fSwitches[i].DefStateValue);
            end;
            sl.Add('');
          end;
        swBit: begin
            s := fSwitches[i].Description;
            s := StringReplace(s, '%ld', '%d', [rfReplaceAll]);
            s := StringReplace(s, '%02lx', '%2.2x', [rfReplaceAll]);
            Desc := SafeFormat(s, [fSwitches[i].Name, fSwitches[i].CmdLineSwitch]);
            sl.Add('// ' + Desc);
            if not BitsChanged(fSwitches[i]) then begin
              if (fSwitches[i].ConfigValue <> '') then begin
                if IsNumericString(fSwitches[i].ConfigValue) then
                  sl.Add(fSwitches[i].Name + ' on')
                else
                  sl.Add(fSwitches[i].Name + ' ' + fSwitches[i].ConfigValue);
              end
              else begin
                sl.Add('// ' + fSwitches[i].Name);
              end;
            end
            else begin
              fSwitches[i].ConfigValue := 'on';
            end;
            for b := 0 to Pred(Length(fSwitches[i].BitDescr)) do begin
              if (fSwitches[i].BitDescr[b].ConfigValue <> '') then begin
                if (fSwitches[i].ConfigValue <> 'off') then begin
                  s := fSwitches[i].Name + '.' + fSwitches[i].BitDescr[b].Name + ' ' + fSwitches[i].BitDescr[b].ConfigValue;
                  s := s + StringOfChar(' ', 50 - Length(s)) + '// ' + fSwitches[i].BitDescr[b].Description;
                end
                else begin
                  s := '// ' + fSwitches[i].Name + '.' + fSwitches[i].BitDescr[b].Name;
                  s := s + StringOfChar(' ', 50 - Length(s)) + '// ' + fSwitches[i].BitDescr[b].Description;
                end;
                sl.Add(s);
              end
              else begin
                s := '// ' + fSwitches[i].Name + '.' + fSwitches[i].BitDescr[b].Name;
                s := s + StringOfChar(' ', 50 - Length(s)) + '// ' + fSwitches[i].BitDescr[b].Description;
                sl.Add(s);
              end;
            end;
            sl.Add('');
          end;
        swRange: begin
            s := fSwitches[i].Description;
            s := StringReplace(s, '%ld', '%d', [rfReplaceAll]);
            s := StringReplace(s, '%02lx', '%2.2x', [rfReplaceAll]);
            Desc := SafeFormat(s, [fSwitches[i].Name, fSwitches[i].CmdLineSwitch,
              fSwitches[i].RangeLow, fSwitches[i].RangeHigh, fSwitches[i].DefValue]);
            sl.Add('// ' + Desc);
            if (fSwitches[i].ConfigValue <> '') then begin
              sl.Add(fSwitches[i].Name + ' ' + fSwitches[i].ConfigValue);
            end
            else begin
              sl.Add('// ' + fSwitches[i].Name + ' ' + fSwitches[i].DefStateValue);
            end;
            sl.Add('');
          end;
      end
    end;
    sl.SaveToFile(FileName);
  finally
    sl.Free;
  end
end;

procedure TSwitchList.SaveConfigFileUserPref(FileName: string);
type
  TState = (stSwitch, stBitSwitch, stSkipToValue, stSkipValue, stDone);

var
  i                 : Integer;
  b                 : Integer;
  p                 : Integer;
  sl                : TStringList;
  s                 : string;
  Line              : string;
  Switch            : string;
  BitSwitch         : string;
  Desc              : string;
  State             : TState;
  ValueStart        : Integer;
  ValueEnd          : Integer;
  Cnt               : Integer;
begin
  sl := TStringList.Create;
  sl.LoadFromFile(PATCH_CONFIG_FILE);
  try
    for Cnt := 0 to Pred(sl.Count) do begin
      Line := sl[Cnt] + ' ';
      if (Length(Line) > 1) and (Line[1] in ['a'..'z', 'A'..'Z']) then begin
        State := stSwitch;
        Switch := '';
        BitSwitch := '';
        for i := 1 to Length(Line) do begin
          case State of
            stSwitch: begin
                if (Line[i] = '.') then begin
                  State := stBitSwitch;
                end
                else if (Line[i] in [#9, ' ', '=']) then begin
                  State := stSkipToValue;
                end
                else begin
                  Switch := Switch + Line[i];
                end
              end;
            stBitSwitch: begin
                if (Line[i] in [#9, ' ', '=']) then begin
                  State := stSkipToValue;
                end
                else begin
                  BitSwitch := BitSwitch + Line[i];
                end
              end;
            stSkipToValue: begin
                if (Line[i] in ['a'..'z', 'A'..'Z', '0'..'9', '-']) then begin
                  ValueStart := i;
                  State := stSkipValue;
                end
              end;
            stSkipValue: begin
                if not (Line[i] in ['a'..'z', 'A'..'Z', '0'..'9']) then begin
                  ValueEnd := i;
                  State := stDone;
                  Break;
                end
              end;
          end
        end;

        for i := 0 to Pred(Length(fSwitches)) do begin
          if (fSwitches[i].Name = Switch) then begin
            case fSwitches[i].SwitchType of
              swUnknown, swSpecial, swBool, swRange: begin
                  if (fSwitches[i].Changed) then begin
                    s := sl[Cnt];
                    s := Copy(s, 1, ValueStart - 1) + fSwitches[i].ConfigValue + Copy(s, ValueEnd, MaxInt);
                    sl[Cnt] := s;
                    fSwitches[i].Changed := False;
                  end
                end;
              swBit: begin
                  if (fSwitches[i].Changed) then begin
                    s := sl[Cnt];
                    s := Copy(s, 1, ValueStart - 1) + fSwitches[i].ConfigValue + Copy(s, ValueEnd, MaxInt);
                    sl[Cnt] := s;
                    fSwitches[i].Changed := False;
                  end;
                  for b := 0 to Pred(Length(fSwitches[i].BitDescr)) do begin
                    if (fSwitches[i].BitDescr[b].Name = BitSwitch) then begin
                      if (fSwitches[i].BitDescr[b].Changed) then begin
                        s := sl[Cnt];
                        s := Copy(s, 1, ValueStart - 1) + fSwitches[i].BitDescr[b].ConfigValue + Copy(s, ValueEnd, MaxInt);
                        sl[Cnt] := s;
                        fSwitches[i].BitDescr[b].Changed := False;
                      end
                    end
                  end;
                end;
            end;
            Break;
          end
        end
      end

    end;

    // Add new switches
    sl.Add('');
    sl.Add(_('// Additional switches not previously in the file'));
    sl.Add('');
    for i := 0 to Pred(Length(fSwitches)) do begin
      case fSwitches[i].SwitchType of
        swUnknown, swSpecial: begin
            if (fSwitches[i].Changed) then begin
              s := fSwitches[i].Description;
              s := StringReplace(s, '%ld', '%d', [rfReplaceAll]);
              s := StringReplace(s, '%02lx', '%2.2x', [rfReplaceAll]);
              Desc := SafeFormat(s, [fSwitches[i].Name, fSwitches[i].CmdLineSwitch]);
              sl.Add('// ' + Desc);
              sl.Add(fSwitches[i].Name + ' ' + fSwitches[i].ConfigValue);
              sl.Add('');
            end
          end;
        swBool: begin
            if (fSwitches[i].Changed) then begin
              s := fSwitches[i].Description;
              s := StringReplace(s, '%ld', '%d', [rfReplaceAll]);
              s := StringReplace(s, '%02lx', '%2.2x', [rfReplaceAll]);
              Desc := SafeFormat(s, [fSwitches[i].Name, fSwitches[i].CmdLineSwitch]);
              sl.Add('// ' + Desc);
              sl.Add(fSwitches[i].Name + ' ' + fSwitches[i].ConfigValue);
              sl.Add('');
            end
          end;
        swBit: begin
            if (fSwitches[i].Changed) then begin
              s := fSwitches[i].Description;
              s := StringReplace(s, '%ld', '%d', [rfReplaceAll]);
              s := StringReplace(s, '%02lx', '%2.2x', [rfReplaceAll]);
              Desc := SafeFormat(s, [fSwitches[i].Name, fSwitches[i].CmdLineSwitch]);
              sl.Add('// ' + Desc);
              sl.Add(fSwitches[i].Name + ' ' + fSwitches[i].ConfigValue);
              sl.Add('');
            end;

            if not IsNumericString(fSwitches[i].ConfigValue) then begin
              for b := 0 to Pred(Length(fSwitches[i].BitDescr)) do begin
                if (fSwitches[i].BitDescr[b].Changed) then begin
                  s := fSwitches[i].Name + '.' + fSwitches[i].BitDescr[b].Name + ' ' + fSwitches[i].BitDescr[b].ConfigValue;
                  s := s + StringOfChar(' ', 50 - Length(s)) + '// ' + fSwitches[i].BitDescr[b].Description;
                  sl.Add(s);
                  sl.Add('');
                end;
              end;
            end;
          end;
        swRange: begin
            if (fSwitches[i].Changed) then begin
              s := fSwitches[i].Description;
              s := StringReplace(s, '%ld', '%d', [rfReplaceAll]);
              s := StringReplace(s, '%02lx', '%2.2x', [rfReplaceAll]);
              Desc := SafeFormat(s, [fSwitches[i].Name, fSwitches[i].CmdLineSwitch,
                fSwitches[i].RangeLow, fSwitches[i].RangeHigh, fSwitches[i].DefValue]);
              sl.Add('// ' + Desc);
              sl.Add(fSwitches[i].Name + ' ' + fSwitches[i].ConfigValue);
              sl.Add('');
            end
          end;
      end;
    end;
    sl.SaveToFile(FileName);
  finally
    sl.Free;
  end
end;

procedure TSwitchList.SetSwitch(Index: Integer; const Value: TSwitch);
begin
  ;
end;

procedure TSwitchList.SortByCategory;   // and secondary by name
var
  tmp               : TStringList;
  sw                : array of TSwitch;
  i                 : Integer;
begin
  tmp := TStringList.Create;
  for i := 0 to Pred(Length(fSwitches)) do begin
    tmp.AddObject(Format('%2.2d %s', [fSwitches[i].CategoryNum, fSwitches[i].Name]), TObject(i));
  end;
  tmp.Sorted := True;
  SetLength(sw, Length(fSwitches));
  for i := 0 to Pred(Length(fSwitches)) do begin
    sw[i] := fSwitches[integer(tmp.Objects[i])];
  end;
  for i := 0 to Pred(Length(fSwitches)) do begin
    fSwitches[i] := sw[i];
  end;
  SetLength(sw, 0);
end;

procedure TSwitchList.WriteAsConfig(FileName: string);
begin
  ;
end;

{ TfrmMain }

procedure TfrmMain.FillOutline(Categories: TCategories; SwitchList: TSwitchList);
var
  i                 : Integer;
  cn                : Integer;
  ct                : string;
  ctx               : Integer;
  swxb, swxe        : Integer;
  swx               : Integer;
  b                 : Integer;
  bfc               : Integer;
  j                 : Integer;
begin
  ctx := 0;
  for i := 0 to Pred(Categories.Count) do begin
    ctx := Outline1.AddObject(ctx, Categories.Strings[i], Pointer(-Categories.Levels[i]));
    swxb := Categories.SwitchRefs[i];
    if (i < (Categories.Count - 1)) then
      swxe := Categories.SwitchRefs[i + 1] - 1
    else
      swxe := Length(SwitchList.fSwitches) - 1;
    swx := 0;
    for j := swxb to swxe do begin
      if (SwitchList.fSwitches[j].SwitchType = swBit) then begin
        swx := Outline1.AddChild(ctx, SwitchList.fSwitches[j].Name + ' ' + SwitchList.fSwitches[j].ConfigValue);
        Outline1[swx].Data := Pointer(j);
        for b := 0 to Pred(Length(SwitchList.fSwitches[j].BitDescr)) do begin
          bfc := Outline1.AddChild(swx, SwitchList.fSwitches[j].BitDescr[b].Name + ' ' + SwitchList.fSwitches[j].BitDescr[b].ConfigValue);
          Outline1[bfc].Data := Pointer(j);
        end
      end
      else begin
        swx := Outline1.AddChild(ctx, SwitchList.fSwitches[j].Name + ' ' + SwitchList.fSwitches[j].ConfigValue);
        Outline1[swx].Data := Pointer(j);
      end
    end
  end;
end;

function TfrmMain.FindTTDPatch: boolean;
begin
  Result := True;
  PatchBaseName := PATCH_WIN_NAME;
  if not FileExists(PatchBaseName + '.exe') then begin
    PatchBaseName := PATCH_DOS_NAME;
    if not FileExists(PatchBaseName + '.exe') then begin
      Result := False;
    end
  end
end;

function TfrmMain.CreateSwitchesXML: boolean;
begin
  Result := WinExecAndWait(PatchBaseName + '.exe -!S-S-', '', SW_HIDE)
end;

function TfrmMain.CreateConfigFile: Boolean;
begin
  Result := WinExecAndWait(PatchBaseName + '.exe -!T- -W ttdpatch.cfg', '', SW_HIDE)
end;

procedure TfrmMain.FixOutlineLevels;
var
  i                 : Integer;
  sl                : TStringList;
  Level             : Integer;
  s                 : string;
  n                 : TOutlineNode;
  p                 : TOutlineNode;
  ix                : Integer;
begin
  sl := TStringList.Create;
  try
    for i := 1 to OutLine1.ItemCount do begin
      n := Outline1.Items[i];
      s := n.Text;
      Level := 0;
      p := n.Parent;
      while p <> nil do begin
        p := p.Parent;
        Inc(Level);
      end;
      ix := Integer(Outline1.Items[i].Data);
      if (ix >= 0) and (ix < Length(ConfigFile.fSwitches)) then begin
        Level := Level + ConfigFile.fSwitches[ix].CategoryLevel;
      end
      else begin
        Level := Level - ix;
      end;
      s := s + '|' + IntToStr(Integer(Outline1.Items[i].Data));
      sl.Add(StringOfChar(#9, Level - 1) + s);
    end;
    sl.SaveToFile('qwe.txt');
    Outline1.LoadFromFile('qwe.txt');
    for i := 1 to Outline1.ItemCount do begin
      s := Outline1.Items[i].Text;
      ix := Pos('|', s);
      Outline1.Items[i].Text := Copy(s, 1, ix - 1);
      Outline1.Items[i].Data := Pointer(StrToInt(Copy(s, ix + 1, MaxInt)));
    end;
  finally
    sl.Free;
  end
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  TranslateComponent(Self);
  mmDescription.Text := _('Double-Click or press plus key to expand');
  with TJclFileVersionInfo.Create(Application.ExeName) do try
    Caption := Format(_('%s, Version: %s'), [ProductName, FileVersion]);
  finally
    Free;
  end;
  pgEdits.ActivePage := tsBlank;

  with TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini')) do try
    TTDPath := ReadString('TTD', 'TTDPath', '');
    SetCurrentDir(TTDPath)
  finally
    Free;
  end;

  if not FindTTDPatch then begin
    if SelectDirectory(_('Locate Your TTD folder'), '', TTDPath) then begin
      if not (SetCurrentDir(TTDPath) and FindTTDPatch) then begin
        ShowMessage(Format(_('Could not find "%s" or "%s". Aborting.'),[PATCH_WIN_NAME, PATCH_DOS_NAME]));
        DebugHalt;
      end
    end
    else begin
      ShowMessage(_('Aborted.'));
      DebugHalt;
    end
  end;

  with TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini')) do try
    WriteString('TTD', 'TTDPath', TTDPath);
  finally
    Free;
  end;

  if not CreateSwitchesXML then begin
    ShowMessage(Format(_('Could not create "%s". Aborting.'), [PATCH_TEMPLATE_FILE]));
    DebugHalt;
  end;

  ConfigFile := TSwitchList.Create;
  ConfigFile.LoadTemplateFile(PATCH_TEMPLATE_FILE);
  edSwVersion.Text := ConfigFile.Version;

  if not FileExists(PATCH_CONFIG_FILE) then begin
    if not CreateConfigFile then begin
      ShowMessage(Format(_('Could not create "%s". Aborting."'), [PATCH_CONFIG_FILE]));
      DebugHalt;
    end
  end;

  if not ConfigFile.LoadConfigFile(PATCH_CONFIG_FILE) then begin
    ShowMessage(Format(_('File "%s" can not be found or read. Aborting.'),[PATCH_CONFIG_FILE]));
    DebugHalt;
  end;

  Categories := TCategories.Create;
  Categories.FillFromSwitchList(ConfigFile);
  FillOutline(Categories, ConfigFile);
  FixOutlineLevels;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  ConfigFile.Free;
end;

procedure TfrmMain.DisableAllInput;
begin
  pgEdits.ActivePage := tsBlank;
  btnUndo.Enabled := False;
  Editing := False;
end;

procedure TfrmMain.EnableTextInput(s: string);
begin
  pgEdits.ActivePage := tsText;
  edTextValue.Text := s;
  Editing := True;
  CurResult := crText;
end;

procedure TfrmMain.EnableBoolInput(s, vDef: string);
begin
  s := LowerCase(Trim(s));
  if (s <> '') and
    (s <> 'off') and (s <> 'no') and (s <> 'n') and (s <> '0') and
    (s <> 'on') and (s <> 'yes') and (s <> 'y') and (s <> '1') then
    s := vDef;
  pgEdits.ActivePage := tsBool;
  if (s = 'off') or (s = 'no') or (s = 'n') or (s = '0') then
    rgBoolOff.Checked := True
  else if (s = 'on') or (s = 'yes') or (s = 'y') or (s = '1') then
    rgBoolOn.Checked := True
  else begin
    rgBoolOff.Checked := False;
    rgBoolOn.Checked := False;
  end;
  Editing := True;
  CurResult := crBool;
end;

procedure TfrmMain.EnableSmallRangeInput(s: string; vMin, vMax, vDef: integer);
begin
  if (CurSwitch.ValidDigits <> '') then begin
    EnableLargeRangeInput(s, vMin, vMax, vDef);
  end
  else begin
    pgEdits.ActivePage := tsSmallRange;
    edSmallRange.MinValue := vMin;
    edSmallRange.MaxValue := vMax;
    if (s = 'off') or (s = 'no') or (s = 'n') then begin
      s := IntToStr(vDef);
      rgSmOff.Checked := True;
      edSmallRange.Enabled := False;
    end
    else if (s = 'on') or (s = 'yes') or (s = 'y') then begin
      s := IntToStr(vDef);
      rgSmOn.Checked := True;
      edSmallRange.Enabled := False;
    end
    else begin
      rgSmValue.Checked := True;
      edSmallRange.Enabled := True;
    end;
    edSmallRange.Text := s;
    Editing := True;
    CurResult := crSmallRange;
  end
end;

procedure TfrmMain.EnableLargeRangeInput(s: string; vMin, vMax, vDef: integer);
begin
  pgEdits.ActivePage := tsLargeRange;
  edLargeRange.MinValue := vMin;
  edLargeRange.MaxValue := vMax;
  if (CurSwitch.ValidDigits <> '') then
    edLargeRange.CheckChars := CurSwitch.ValidDigits
  else
    edLargeRange.CheckChars := '0123456789';
  if (s = 'off') or (s = 'no') or (s = 'n') then begin
    s := IntToStr(vDef);
    rgLaOff.Checked := True;
    edLargeRange.Enabled := False;
  end
  else if (s = 'on') or (s = 'yes') or (s = 'y') then begin
    s := IntToStr(vDef);
    rgLaOn.Checked := True;
    edLargeRange.Enabled := False;
  end
  else begin
    rgLaValue.Checked := True;
    edLargeRange.Enabled := True;
  end;
  edLargeRange.Text := s;
  Editing := True;
  CurResult := crLargeRange;
end;

procedure TfrmMain.Outline1Click(Sender: TObject);
var
  ix                : Integer;
  p                 : Integer;
  b                 : Integer;
  s                 : string;
  swName            : string;
  swCmd             : string;
  BitDescription    : string;
  BitName           : string;
  min               : Integer;
  max               : Integer;
  default           : Integer;

begin
  DisableAllInput;
  Outline1.Hint := _('Edit the switch value in the box to the Right');
  CurSwitch := nil;
  ix := Outline1.SelectedItem;
  if (ix >= 0) then begin
    if (Outline1[ix].HasItems) then begin // Category or bitswitch
      Label1.Caption := _('Category');
      mmDescription.Text := _('Double-Click or press plus key to expand');
      Outline1.Hint := _('Double-click to collapse/expand');
      ix := Integer(Outline1[ix].Data);
      if (ix >= 0) and (ix < Length(ConfigFile.fSwitches)) then begin
        CurSwitch := @ConfigFile.fSwitches[ix];
        btnUndo.Enabled := CurSwitch.ConfigValue <> CurSwitch.OriginalValue;
        Label1.Caption := SwitchTypeNames[CurSwitch.SwitchType];
        s := CurSwitch.Description;
        s := StringReplace(s, '%ld', '%d', [rfReplaceAll]);
        s := StringReplace(s, '%02lx', '%2.2x', [rfReplaceAll]);
        swName := CurSwitch.Name;
        swCmd := CurSwitch.CmdLineSwitch;
        if (CurSwitch.SwitchType = swBit) then begin
          mmDescription.Text := SafeFormat(s, [swName, swCmd]);
          EnableBoolInput(CurSwitch.ConfigValue, CurSwitch.DefStateValue);
          CurBitIx := -1;
        end;
      end
    end
    else begin
      ix := Integer(Outline1[ix].Data);
      if (ix >= 0) and (ix < Length(ConfigFile.fSwitches)) then begin
        CurSwitch := @ConfigFile.fSwitches[ix];
        btnUndo.Enabled := (CurSwitch.ConfigValue <> CurSwitch.OriginalValue);
        Label1.Caption := SwitchTypeNames[CurSwitch.SwitchType];
        s := CurSwitch.Description;
        s := StringReplace(s, '%ld', '%d', [rfReplaceAll]);
        s := StringReplace(s, '%02lx', '%2.2x', [rfReplaceAll]);
        swName := CurSwitch.Name;
        swCmd := CurSwitch.CmdLineSwitch;
        case CurSwitch.SwitchType of
          swUnknown, swSpecial: begin
              mmDescription.Text := SafeFormat(s, [swName, swCmd]);
              EnableTextInput(CurSwitch.ConfigValue);
            end;
          swBool: begin
              mmDescription.Text := SafeFormat(s, [swName, swCmd]);
              EnableBoolInput(CurSwitch.ConfigValue, CurSwitch.DefStateValue);
            end;
          swBit: begin
              BitName := Outline1[Outline1.SelectedItem].Text;
              p := Pos(' ', BitName);
              if (p = 0) then
                p := Pos('=', BitName);
              if (p > 0) then
                BitName := Trim(Copy(BitName, 1, p - 1))
              else
                BitName := Trim(BitName);
              BitDescription := Format(_('%s is not defined!'),[BitName]);
              CurBitIx := -2;
              for b := 0 to Pred(Length(CurSwitch.BitDescr)) do begin
                if (CurSwitch.BitDescr[b].Name = BitName) then begin
                  btnUndo.Enabled := (CurSwitch.BitDescr[b].ConfigValue <> CurSwitch.BitDescr[b].OriginalValue);
                  BitDescription := BitName + ': ' + CurSwitch.BitDescr[b].Description;
                  EnableBoolInput(CurSwitch.BitDescr[b].ConfigValue, 'off');
                  CurBitIx := b;
                  break;
                end
              end;
              mmDescription.Text := SafeFormat(s, [swName, swCmd]) + #13#10 + #13#10 + BitDescription;
            end;
          swRange: begin
              mmDescription.Text := SafeFormat(s, [swName, swCmd,
                CurSwitch.RangeLow, CurSwitch.RangeHigh, CurSwitch.DefValue]);
              if ((CurSwitch.RangeHigh - CurSwitch.RangeLow) <= 255) then begin
                EnableSmallRangeInput(CurSwitch.ConfigValue, CurSwitch.RangeLow, CurSwitch.RangeHigh, CurSwitch.DefValue);
              end
              else begin
                EnableLargeRangeInput(CurSwitch.ConfigValue, CurSwitch.RangeLow, CurSwitch.RangeHigh, CurSwitch.DefValue);
              end
            end;
        end
      end
    end
  end
end;

procedure TfrmMain.btnExpandClick(Sender: TObject);
begin
  Outline1.FullExpand;
end;

procedure TfrmMain.btnCollapseClick(Sender: TObject);
begin
  Outline1.FullCollapse;
end;

procedure TfrmMain.btnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.btnSaveCanonFormatClick(Sender: TObject);
begin
  BackupOldConfigFile(PATCH_CONFIG_FILE);
  ConfigFile.SaveConfigFileCanonical(PATCH_CONFIG_FILE);
end;

procedure TfrmMain.btnSaveUserFormatClick(Sender: TObject);
begin
  ConfigFile.SaveConfigFileUserPref(PATCH_CONFIG_FILE + '.usr');
end;

procedure TfrmMain.Outline1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  ix                : Integer;
  ManPage           : string;
begin
  Exit;
  ix := Outline1.SelectedItem;
  if (ix >= 0) then begin
    case Key of
      VK_F1: begin
          ManPage := Format(_('http://wiki.ttdpatch.net/tiki-index.php?page=%s'), [CurSwitch.ManPage]);
          Shellexecute(Handle, 'open', PChar(ManPage), nil, nil, SW_RESTORE);
        end;
    end
  end
end;

procedure TfrmMain.Outline1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  ix                : Integer;
  ManPage           : string;
begin
  ix := Outline1.SelectedItem;
  if (ix >= 0) then begin
    case Key of
      VK_F1:
        if Assigned(CurSwitch) then begin
          ManPage := Format(_('http://wiki.ttdpatch.net/tiki-index.php?page=%s'), [CurSwitch.ManPage]);
          Shellexecute(Handle, 'open', PChar(ManPage), nil, nil, SW_RESTORE);
        end;
    end
  end
end;

procedure TfrmMain.ReplaceValue(ix: Integer; Value: string);
var
  s                 : string;
  p                 : Integer;
begin
  s := Outline1[ix].Text;
  p := Pos(' ', s);
  if (p > 0) then
    s := Copy(s, 1, p) + ' ' + Value
  else
    s := s + ' ' + Value;
  Outline1[ix].Text := s;
end;

procedure TfrmMain.UpdateView;
var
  ix                : Integer;
  b                 : Integer;
  bw                : Integer;
begin
  ix := Outline1.SelectedItem;
  if Assigned(CurSwitch) and (ix <> 0) then begin
    case CurResult of
      crText: begin
          CurSwitch.ConfigValue := edTextValue.Text;
          CurSwitch.Changed := True;
          ReplaceValue(ix, CurSwitch.ConfigValue);
        end;
      crBool: begin
          if (CurSwitch.SwitchType = swBit) then begin
            CurSwitch.Changed := True;
            if (CurBitIx = -1) then begin
              if rgBoolOff.Checked then begin
                CurSwitch.ConfigValue := OffOn[0];
                // Clear all bits
                for b := 0 to Pred(Length(CurSwitch.BitDescr)) do begin
                  CurSwitch.BitDescr[b].Changed := False;
                  CurSwitch.BitDescr[b].ConfigValue := '';
                  ReplaceValue(ix + b + 1, CurSwitch.BitDescr[b].ConfigValue);
                end
              end
              else if rgBoolOn.Checked then begin
                CurSwitch.ConfigValue := OffOn[1];
                // Set all bits that are not defined in the config
                bw := ConvertSwitchStrToInt(IntToStr(CurSwitch.DefValue), CurSwitch.DefValue);
                for b := 0 to Pred(Length(CurSwitch.BitDescr)) do begin
                  if not CurSwitch.BitDescr[b].Changed then begin
                    CurSwitch.BitDescr[b].Changed := True;
                    if ((bw and Pow2[CurSwitch.BitDescr[b].BitNum]) <> 0) then
                      CurSwitch.BitDescr[b].ConfigValue := 'on'
                    else
                      CurSwitch.BitDescr[b].ConfigValue := 'off';
                  end;
                  ReplaceValue(ix + b + 1, CurSwitch.BitDescr[b].ConfigValue);
                end
              end
              else begin
                CurSwitch.ConfigValue := '';
              end;
              ReplaceValue(ix, CurSwitch.ConfigValue);
            end
            else if (CurBitIx = -2) then begin
              // silently ignore unknown bit
            end
            else begin

              CurSwitch.ConfigValue := 'on';
              CurSwitch.Changed := True;
              ReplaceValue(ix - CurBitIx - 1, CurSwitch.ConfigValue);

              if rgBoolOff.Checked then
                CurSwitch.BitDescr[CurBitIx].ConfigValue := OffOn[0]
              else if rgBoolOn.Checked then
                CurSwitch.BitDescr[CurBitIx].ConfigValue := OffOn[1]
              else
                CurSwitch.BitDescr[CurBitIx].ConfigValue := '';

              CurSwitch.BitDescr[CurBitIx].Changed := True;
              ReplaceValue(ix, CurSwitch.BitDescr[CurBitIx].ConfigValue);

              // Set all bits that are not defined in the config
              bw := ConvertSwitchStrToInt(IntToStr(CurSwitch.DefValue), CurSwitch.DefValue);
              for b := 0 to Pred(Length(CurSwitch.BitDescr)) do begin
                if not CurSwitch.BitDescr[b].Changed then begin
                  CurSwitch.BitDescr[b].Changed := True;
                  if ((bw and Pow2[CurSwitch.BitDescr[b].BitNum]) <> 0) then
                    CurSwitch.BitDescr[b].ConfigValue := 'on'
                  else
                    CurSwitch.BitDescr[b].ConfigValue := 'off';
                end;
                ReplaceValue(ix - CurBitIx + b, CurSwitch.BitDescr[b].ConfigValue);
              end

            end
          end
          else begin
            if rgBoolOff.Checked then
              CurSwitch.ConfigValue := OffOn[0]
            else if rgBoolOn.Checked then
              CurSwitch.ConfigValue := OffOn[1]
            else
              CurSwitch.ConfigValue := '';
            CurSwitch.Changed := True;
            ReplaceValue(ix, CurSwitch.ConfigValue);
          end;
        end;
      crSmallRange: begin
          if rgSmOff.Checked then
            CurSwitch.ConfigValue := OffOn[0]
          else if rgSmOn.Checked then
            CurSwitch.ConfigValue := OffOn[1]
          else
            CurSwitch.ConfigValue := edSmallRange.Text;
          CurSwitch.Changed := True;
          ReplaceValue(ix, CurSwitch.ConfigValue);
        end;
      crLargeRange: begin
          if rgLaOff.Checked then
            CurSwitch.ConfigValue := OffOn[0]
          else if rgLaOn.Checked then
            CurSwitch.ConfigValue := OffOn[1]
          else
            CurSwitch.ConfigValue := edLargeRange.Text;
          CurSwitch.Changed := True;
          ReplaceValue(ix, CurSwitch.ConfigValue);
        end;
    end;
  end;
end;

procedure TfrmMain.CheckEditLargeRO;
begin
  if (rgLaOff.Checked or rgLaOn.Checked) then
    edLargeRange.Enabled := False
  else
    edLargeRange.Enabled := True;
end;

procedure TfrmMain.CheckEditSmallRO;
begin
  if (rgSmOff.Checked or rgSmOn.Checked) then
    edSmallRange.Enabled := False
  else
    edSmallRange.Enabled := True;
  edTextValueChange(nil);
end;

function TfrmMain.SearchSwitch(Search: string; Start: integer): Integer;
var
  i                 : Integer;
  s                 : string;
begin
  s := LowerCase(Search);
  for i := Start to Pred(Outline1.ItemCount) do begin
    if (Pos(s, LowerCase(Outline1[i].Text)) > 0) then begin
      Result := i;
      Exit;
    end;
  end;
  Result := 0;
end;

function TfrmMain.SearchDescr(Search: string; Start: integer): Integer;
var
  i                 : Integer;
  ix                : Integer;
  s                 : string;
begin
  s := LowerCase(Search);
  for i := Start to Pred(Outline1.ItemCount) do begin
    ix := Integer(Outline1[i].Data);
    if (ix >= 0) and (ix < Length(ConfigFile.fSwitches)) then begin
      if (Pos(s, LowerCase(ConfigFile.fSwitches[ix].Description)) > 0) then begin
        Result := i;
        Exit;
      end
    end
  end;
  Result := 0;
end;

procedure TfrmMain.ExpandToMatch(ix: Integer);
var
  i                 : Integer;
  p                 : Integer;
begin
  if (Outline1[ix].Parent.Index > 0) then
    ExpandToMatch(Outline1[ix].Parent.Index);
  Outline1[ix].Expand;
end;

procedure TfrmMain.btnFindFirstClick(Sender: TObject);
var
  i                 : Integer;
begin
  if cbSearchDescription.Checked then
    i := SearchDescr(edSearch.Text, 1)
  else
    i := SearchSwitch(edSearch.Text, 1);
  if (i > 0) then begin
    ExpandToMatch(i);
    Outline1.SelectedItem := i;
    Exit;
  end;
  ShowMessage(Format(_('Search string "%s" not found'),[edSearch.Text]));
end;

procedure TfrmMain.btnFindNextClick(Sender: TObject);
var
  i                 : Integer;
begin
  if cbSearchDescription.Checked then
    i := SearchDescr(edSearch.Text, Outline1.SelectedItem + 1)
  else
    i := SearchSwitch(edSearch.Text, Outline1.SelectedItem + 1);
  if (i > 0) then begin
    ExpandToMatch(i);
    Outline1.SelectedItem := i;
    Exit;
  end;
  ShowMessage(Format(_('No more matches for "%s"'),[edSearch.text]));
end;

procedure TfrmMain.edSearchChange(Sender: TObject);
begin
  SearchEditChanged := True;
end;

procedure TfrmMain.edSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then begin
    if SearchEditChanged then begin
      SearchEditChanged := False;
      btnFindFirstClick(nil);
    end
    else begin
      btnFindNextClick(nil);
    end
  end
end;

procedure TfrmMain.edTextValueChange(Sender: TObject);
begin
  if Editing then begin
    UpdateView;
    btnUndo.Enabled := True;
  end
end;

procedure TfrmMain.rgBoolOffClick(Sender: TObject);
begin
  if Editing then begin
    UpdateView;
    btnUndo.Enabled := True;
  end
end;

procedure TfrmMain.rgBoolOnClick(Sender: TObject);
begin
  if Editing then begin
    UpdateView;
    btnUndo.Enabled := True;
  end
end;

procedure TfrmMain.rgSmOnClick(Sender: TObject);
begin
  if Editing then begin
    CheckEditSmallRO;
    UpdateView;
    btnUndo.Enabled := True;
  end
end;

procedure TfrmMain.rgSmOffClick(Sender: TObject);
begin
  if Editing then begin
    CheckEditSmallRO;
    UpdateView;
    btnUndo.Enabled := True;
  end
end;

procedure TfrmMain.rgSmValueClick(Sender: TObject);
begin
  if Editing then begin
    CheckEditSmallRO;
    UpdateView;
    btnUndo.Enabled := True;
  end
end;

procedure TfrmMain.edSmallRangeChange(Sender: TObject);
begin
  if Editing then begin
    rgSmValue.Checked := True;
    UpdateView;
    btnUndo.Enabled := True;
  end
end;

procedure TfrmMain.rgLaOnClick(Sender: TObject);
begin
  if Editing then begin
    CheckEditLargeRO;
    UpdateView;
    btnUndo.Enabled := True;
  end
end;

procedure TfrmMain.rgLaOffClick(Sender: TObject);
begin
  if Editing then begin
    CheckEditLargeRO;
    UpdateView;
    btnUndo.Enabled := True;
  end
end;

procedure TfrmMain.rgLaValueClick(Sender: TObject);
begin
  if Editing then begin
    CheckEditLargeRO;
    UpdateView;
    btnUndo.Enabled := True;
  end
end;

procedure TfrmMain.edLargeRangeChange(Sender: TObject);
begin
  if Editing then begin
    rgLaValue.Checked := True;
    UpdateView;
    btnUndo.Enabled := True;
  end
end;

procedure TfrmMain.btnUndoClick(Sender: TObject);
var
  ix                : Integer;
begin
  ix := Outline1.SelectedItem;
  if Assigned(CurSwitch) and (ix <> 0) then begin
    case CurResult of
      crText: begin
          CurSwitch.ConfigValue := CurSwitch.OriginalValue;
          ReplaceValue(ix, CurSwitch.ConfigValue);
          EnableTextInput(CurSwitch.ConfigValue);
        end;
      crBool: begin
          if (CurSwitch.SwitchType = swBit) then begin
            if (CurBitIx = -1) then begin
              CurSwitch.ConfigValue := CurSwitch.OriginalValue;
              ReplaceValue(ix, CurSwitch.ConfigValue);
              EnableBoolInput(CurSwitch.ConfigValue, CurSwitch.DefStateValue);
            end
            else if (CurBitIx = -2) then begin
              // silently ignore unknown bit
            end
            else begin
              CurSwitch.BitDescr[CurBitIx].ConfigValue := CurSwitch.BitDescr[CurBitIx].OriginalValue;
              ReplaceValue(ix, CurSwitch.BitDescr[CurBitIx].ConfigValue);
              EnableBoolInput(CurSwitch.BitDescr[CurBitIx].ConfigValue, CurSwitch.BitDescr[CurBitIx].ConfigValue);
            end
          end
          else begin
            CurSwitch.ConfigValue := CurSwitch.OriginalValue;
            ReplaceValue(ix, CurSwitch.ConfigValue);
            EnableBoolInput(CurSwitch.ConfigValue, CurSwitch.DefStateValue);
          end;
        end;
      crSmallRange: begin
          CurSwitch.ConfigValue := CurSwitch.OriginalValue;
          ReplaceValue(ix, CurSwitch.ConfigValue);
          EnableSmallRangeInput(CurSwitch.ConfigValue, CurSwitch.RangeLow, CurSwitch.RangeHigh, CurSwitch.DefValue);
        end;
      crLargeRange: begin
          CurSwitch.ConfigValue := CurSwitch.OriginalValue;
          ReplaceValue(ix, CurSwitch.ConfigValue);
          EnableLargeRangeInput(CurSwitch.ConfigValue, CurSwitch.RangeLow, CurSwitch.RangeHigh, CurSwitch.DefValue);
        end;
    end
  end;
  btnUndo.Enabled := False;
end;

procedure TfrmMain.JvAppEvents1Message(var Msg: tagMSG; var Handled: Boolean);
var
  Delta             : ShortInt;
  Lines             : ShortInt;
  ScrollLines       : UINT;
begin
  if (Msg.message = WM_MOUSEWHEEL) then begin
    if (ActiveControl = Outline1) then begin
      Delta := HIWORD(Msg.wParam);
      Lines := Abs(Delta) div 120;
      SystemParametersInfo(SPI_GETWHEELSCROLLLINES, 0, @ScrollLines, 0);
      if (ScrollLines = $FFFFFFFF) then begin
        Lines := Outline1.ClientHeight div Outline1.ItemHeight;
      end
      else begin
        Lines := Lines * ScrollLines;
      end;
      if (Delta < 0) then begin
        // Scroll forward
        while (Lines > 0) do begin
          Outline1.Perform(WM_VSCROLL, SB_LINEDOWN, 0);
          Dec(Lines);
        end
      end
      else begin
        // Scroll backward
        while (Lines > 0) do begin
          Outline1.Perform(WM_VSCROLL, SB_LINEUP, 0);
          Dec(Lines);
        end
      end;
      Handled := True;
    end
  end
end;

procedure TfrmMain.BackupOldConfigFile(FileName: string);
var
  i: Integer;
begin
  i := 0;
  while (FileExists(Format('%s.%4.4d', [FileName, i]))) do
    Inc(i);
  RenameFile(FileName, Format('%s.%4.4d', [FileName, i]));
end;

end.

