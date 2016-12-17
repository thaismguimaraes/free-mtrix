{
  Stimulus Control
  Copyright (C) 2014-2016 Carlos Rafael Fernandes Picanço, Universidade Federal do Pará.

  The present file is distributed under the terms of the GNU General Public License (GPL v3.0).

  You should have received a copy of the GNU General Public License
  along with this program. If not, see <http://www.gnu.org/licenses/>.
}
unit form_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  Menus, ExtCtrls, StdCtrls, XMLPropStorage, IniFiles, Spin, PropertyStorage;

type

  { TFormDesigner }

  TFormDesigner = class(TForm)
    BtnAppendCond: TButton;
    BtnAppendContingency: TButton;
    BtnRemoveCond: TButton;
    BtnRemoveContingency: TButton;
    BtnReorderCond: TButton;
    BtnReorderContingency: TButton;
    CGGlobal: TCheckGroup;
    ChkDotsCleanDots: TCheckBox;
    ChkColors: TCheckBox;
    ChkRows: TCheckBox;
    ChkCols: TCheckBox;
    ChkDots: TCheckBox;
    ChkCleanDots: TCheckBox;
    CheckBoxBroadcast: TCheckBox;
    CheckBoxShouldAskQuestion: TCheckBox;
    CGQuestion: TCheckGroup;
    CBPointsType: TComboBox;
    ComboCurrentCondition: TComboBox;
    ComboCurrentContingency: TComboBox;
    EditMessPrefix: TEdit;
    EditMessSufix: TEdit;
    EditContingencyName: TEdit;
    EditQuestion: TEdit;
    EditConditionName: TEdit;
    EditExperimentName: TEdit;
    EditResearcherName: TEdit;
    GBContingencies: TGroupBox;
    GBContingencyColors: TGroupBox;
    GBExperimentAim: TGroupBox;
    GBConditions: TGroupBox;
    GBEndCriteria: TGroupBox;
    GBEndCriteriaLastCycles: TGroupBox;
    GBQuestion: TGroupBox;
    GBContingencyRows: TGroupBox;
    GBContingencyConsequence: TGroupBox;
    GBMatrix: TGroupBox;
    LabelQuestion: TLabel;
    LabelPointsOnConditionBegin: TLabel;
    LabelC1: TLabel;
    LabelC2: TLabel;
    LabelC4: TLabel;
    LabelC5: TLabel;
    LabelC6: TLabel;
    LabelThen: TLabel;
    LabelOperator: TLabel;
    LabelContingencyName: TLabel;
    LabelEndCriteriaInt: TLabel;
    LabelEndCriteriaLastCycles: TLabel;
    LabelEndCriteriaAbsCycles: TLabel;
    LabelCyclesValue: TLabel;
    LabelIf: TLabel;
    LabelTurnValue: TLabel;
    LabelConditionName: TLabel;
    LabelExperimentName: TLabel;
    LabelResearcherName: TLabel;
    ListBoxConditions: TListBox;
    ListBoxContingencies: TListBox;
    MainMenu1: TMainMenu;
    MemoExperimentAim: TMemo;
    MenuItemFile: TMenuItem;
    MenuItemExit: TMenuItem;
    MenuItemOpen: TMenuItem;
    MenuItemSeparator1: TMenuItem;
    OpenDialog: TOpenDialog;
    PageControl: TPageControl;
    PanelConditionButtons: TPanel;
    PanelContingenciesButtons: TPanel;
    RGContingencyType: TRadioGroup;
    RGContingencyStyle: TRadioGroup;
    RGEndCriteriaStyle: TRadioGroup;
    RGPoints: TRadioGroup;
    SpinEditContingencyPoints: TSpinEdit;
    SpinEditEndCriteriaInterlockingPorcentage: TSpinEdit;
    SpinEditEndCriteriaLastCycles: TSpinEdit;
    SpinEditEndCriteriaAbsCycles: TSpinEdit;
    SpinEditCyclesValue: TSpinEdit;
    SpinEditOnConditionBegin: TSpinEdit;
    SpinEditTurnValue: TSpinEdit;
    TabSheetContingencies: TTabSheet;
    TabSheetConditions: TTabSheet;
    TabSheetExperiment: TTabSheet;
    XMLPropStorage: TXMLPropStorage;
    procedure BtnAppendCondClick(Sender: TObject);
    procedure BtnAppendContingencyClick(Sender: TObject);
    procedure BtnRemoveCondClick(Sender: TObject);
    procedure BtnRemoveContingencyClick(Sender: TObject);
    procedure BtnReorderCondClick(Sender: TObject);
    procedure BtnReorderContingencyClick(Sender: TObject);
    procedure ChkDotsCleanDotsChange(Sender: TObject);
    //
    procedure ConsequenceMessageEditingDone(Sender: TObject);
    procedure ConsequenceStyleChange(Sender: TObject);

    procedure CGQuestionItemClick(Sender: TObject; Index: integer);
    procedure CheckBoxBroadcastChange(Sender: TObject);
    procedure CheckBoxColorsRowsChange(Sender: TObject);
    procedure CheckBoxShouldAskQuestionChange(Sender: TObject);
    procedure ChkCleanDotsChange(Sender: TObject);
    procedure ChkDotsChange(Sender: TObject);
    procedure ComboCurrentConditionChange(Sender: TObject);
    procedure ComboCurrentContingencyChange(Sender: TObject);
    procedure EditConditionNameEditingDone(Sender: TObject);
    procedure EditContingencyNameEditingDone(Sender: TObject);
    procedure EditQuestionEditingDone(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure MenuItemExitClick(Sender: TObject);
    procedure MenuItemOpenClick(Sender: TObject);
    procedure RGContingencyStyleClick(Sender: TObject);
    procedure RGContingencyStyleExit(Sender: TObject);

    procedure RGContingencyTypeClick(Sender: TObject);
    procedure RGEndCriteriaStyleClick(Sender: TObject);
    procedure RGPointsClick(Sender: TObject);
    procedure SpinEditCyclesValueEditingDone(Sender: TObject);
    procedure SpinEditEndCriteriaAbsCyclesEditingDone(Sender: TObject);
    procedure SpinEditEndCriteriaInterlockingEditingDone(
      Sender: TObject);
    procedure SpinEditTurnValueEditingDone(Sender: TObject);
    procedure XMLPropStorageRestoreProperties(Sender: TObject);
    procedure XMLPropStorageSavingProperties(Sender: TObject);
    procedure XMLPropStorageStoredValuesFileNameRestore(Sender: TStoredValue;
      var Value: TStoredType);
    procedure XMLPropStorageStoredValuesFileNameSave(Sender: TStoredValue;
      var Value: TStoredType);
  private
    FExperiment: TIniFile;
    procedure LoadExperiment;
    procedure LoadSectionExperiment;
    procedure LoadSectionCondition(ASection: string);
    procedure LoadContingency(ASection, AContingency: string);// A condition section and a contingency key prefix
    procedure SaveExperiment;
    procedure SaveSectionExperiment;
    procedure SaveSectionCondition(ASection: string);
    procedure SaveContingency(ASection, AContingency: string);
    procedure EraseContingency(ASection, AContingency : string);
  private
    function GetConsequenceStyle: string;
    function GetContingencyCriteria: string;
    function GetEndCriteriaPorcentage: string;
    function GetEndCriteriaStyleFromRGEndCriteriaStyle: string;
    function GetMatrixTypeStringFromCGMatrix: string;
    function GetPromptQuestionStringFromCGQuestion: string;
    procedure SetCGMatrix(AMatrixType: string);
    procedure SetCGQuestion(AQuestionStyle: string);
    procedure SetRGEndCriteriaStyle(AStyle: string);
    procedure SetContingencyCriteria(S: string);
    procedure SetConsequenceStyle(S:string);
    procedure UpdateContingencyList(ASection: String);
    procedure UpdateContingencyCombo(ASection: String);
  private
    FLoading : Boolean;
    function GetContingencyName(IsMeta:Boolean; MustIncrement:Boolean=True):string;
    procedure IncContingencyName(var AContingency : string; N : integer = 1);
    procedure ReadContingencyNames(ASection, AContingency, AKeySuffix:string; S:TStrings);
  public
    { public declarations }
  end;

var
  FormDesigner: TFormDesigner;

implementation

uses game_resources, game_actors, string_methods, strutils;

{$R *.lfm}

{ TFormDesigner }

procedure TFormDesigner.MenuItemOpenClick(Sender: TObject);
begin
  if OpenDialog.Execute then
  begin
    if FExperiment.FileName = OpenDialog.FileName then
      Exit;
    FExperiment.Free;
    FExperiment := TIniFile.Create(OpenDialog.FileName);
    XMLPropStorage.StoredValue['FileName'] := FExperiment.FileName;
  end;
end;

procedure TFormDesigner.RGContingencyStyleClick(Sender: TObject);
var
  LVisible: boolean;
begin
  if Sender = RGContingencyStyle then
    begin
      LVisible := True;

      case TRadioGroup(Sender).ItemIndex of
        0:
        begin
          LabelIf.Visible := not LVisible;
          LabelThen.Visible := not LVisible;
          LabelOperator.Visible := not LVisible;
          GBContingencyRows.Visible := not LVisible;
          GBContingencyColors.Visible := not LVisible;
          GBContingencyConsequence.Visible := not LVisible;
        end;

        1:
        begin
          LabelIf.Visible := LVisible;
          LabelThen.Visible := LVisible;
          LabelOperator.Visible := not LVisible;
          GBContingencyRows.Visible := LVisible;
          GBContingencyColors.Visible := not LVisible;
          GBContingencyConsequence.Visible := LVisible;
        end;

        2:
        begin
          LabelIf.Visible := LVisible;
          LabelThen.Visible := LVisible;
          LabelOperator.Visible := not LVisible;
          GBContingencyRows.Visible := not LVisible;
          GBContingencyColors.Visible := LVisible;
          GBContingencyConsequence.Visible := LVisible;
        end;
        3:
        begin
          LabelIf.Visible := LVisible;
          LabelThen.Visible := LVisible;
          LabelOperator.Caption := 'E';
          LabelOperator.Visible := LVisible;
          GBContingencyRows.Visible := LVisible;
          GBContingencyColors.Visible := LVisible;
          GBContingencyConsequence.Visible := LVisible;
        end;
        4:
        begin
          LabelIf.Visible := LVisible;
          LabelThen.Visible := LVisible;
          LabelOperator.Caption := 'OU';
          LabelOperator.Visible := LVisible;
          GBContingencyRows.Visible := LVisible;
          GBContingencyColors.Visible := LVisible;
          GBContingencyConsequence.Visible := LVisible;
        end;
      end;
    end;
end;

procedure TFormDesigner.RGContingencyStyleExit(Sender: TObject);
begin
  SaveContingency(ExtractDelimited(1,ComboCurrentCondition.Text,['|']),ExtractDelimited(1,ComboCurrentContingency.Text,['|']));
end;


procedure TFormDesigner.RGContingencyTypeClick(Sender: TObject);
var
  i: integer;
  CH: TCheckBox;
  LS,LC : string;

  procedure CreateChkBox(N, C: string; AOwner: TWinControl);
  begin
    CH := TCheckBox.Create(AOwner);
    CH.Name := N;
    CH.Caption := C;
    CH.Parent := AOwner;
    CH.ShowHint := True;
    CH.Hint := C;
    CH.OnChange := @CheckBoxColorsRowsChange;
  end;

begin
  if Sender = RGContingencyType then
    begin
      while GBContingencyRows.ComponentCount > 0 do
        GBContingencyRows.Components[0].Free;

      while GBContingencyColors.ComponentCount > 0 do
        GBContingencyColors.Components[0].Free;

      case TRadioGroup(Sender).ItemIndex of
        0:
          begin
            for i := 0 to 9 do
              CreateChkBox('Chk' + IntToStr(i + 1), IntToStr(i + 1), GBContingencyRows);

            CreateChkBox('ChkEven', 'PAR', GBContingencyRows);
            CreateChkBox('ChkOdd', 'IMPAR', GBContingencyRows);

            CreateChkBox('ChkY', 'AMARELO', GBContingencyColors);
            CreateChkBox('ChkR', 'VERMELHO', GBContingencyColors);
            CreateChkBox('ChkM', 'ROXO', GBContingencyColors);
            CreateChkBox('ChkB', 'AZUL', GBContingencyColors);
            CreateChkBox('ChkG', 'VERDE', GBContingencyColors);
            LabelIf.Caption := 'SE O PARTICIPANTE ESCOLHER';
            LC := KEY_CONTINGENCY;
          end;
        1:
          begin
            CreateChkBox('ChkEven', 'PARES', GBContingencyRows);
            CreateChkBox('ChkOdd', 'IMPARES', GBContingencyRows);

            CreateChkBox('ChkNot', 'TUDO EXCETO', GBContingencyColors);
            CreateChkBox('ChkEqual', 'CORES IGUAIS', GBContingencyColors);
            CreateChkBox('ChkDiff', 'CORES DIFERENTES', GBContingencyColors);
            LabelIf.Caption := 'SE OS PARTICIPANTES ESCOLHEREM';
            LC := KEY_METACONTINGENCY;
          end;
        else Exit;
      end;

      LS := ExtractDelimited(1, ComboCurrentCondition.Text,['|']);
      UpdateContingencyCombo(LS);
      LC += '1';
      with FExperiment do
        if ValueExists(LS,LC+KEY_CONT_NAME) and (not FLoading) then
          begin
            LoadContingency(LS,LC);
            ComboCurrentContingency.ItemIndex:=0;
          end;

    end;
end;

procedure TFormDesigner.RGEndCriteriaStyleClick(Sender: TObject);
var
  LS: String;
begin
  if Sender = RGEndCriteriaStyle then
    begin
      case TRadioGroup(Sender).ItemIndex of
        0:
        begin
          LabelEndCriteriaAbsCycles.Visible := True;
          SpinEditEndCriteriaAbsCycles.Visible := True;
          GBEndCriteriaLastCycles.Visible := False;

        end;
        1:
        begin
          LabelEndCriteriaAbsCycles.Visible := False;
          SpinEditEndCriteriaAbsCycles.Visible := False;
          GBEndCriteriaLastCycles.Visible := True;
        end;
        2:
        begin
          LabelEndCriteriaAbsCycles.Visible := True;
          SpinEditEndCriteriaAbsCycles.Visible := True;
          GBEndCriteriaLastCycles.Visible := True;
        end;
      end;

      with FExperiment do
        if ComboCurrentCondition.ItemIndex <> -1 then
          begin
            LS := SEC_CONDITION+IntToStr(ComboCurrentCondition.ItemIndex+1);
            WriteString(LS, KEY_ENDCRITERIA, GetEndCriteriaStyleFromRGEndCriteriaStyle);
          end;
    end;
end;

procedure TFormDesigner.RGPointsClick(Sender: TObject);
begin
  if Sender = RGPoints then
    case TRadioGroup(Sender).ItemIndex of
      0:
      begin
        CBPointsType.Items.Clear;
        CBPointsType.Items.Append('Individual A');
        CBPointsType.Items.Append('Individual B');
        CBPointsType.Items.Append('Para o Grupo');
      end;

      1:
      begin
        CBPointsType.Items.Clear;
        CBPointsType.Items.Append('Individual');
        CBPointsType.Items.Append('Para o Grupo');
      end;
    end;
end;

procedure TFormDesigner.SpinEditCyclesValueEditingDone(Sender: TObject);
var
  LS: string;
begin
  with FExperiment do
    if ComboCurrentCondition.ItemIndex <> -1 then
      begin
        LS := SEC_CONDITION+IntToStr(ComboCurrentCondition.ItemIndex+1);
        WriteInteger(LS, KEY_CYCLES_VALUE, SpinEditCyclesValue.Value);
      end;
end;

procedure TFormDesigner.SpinEditEndCriteriaAbsCyclesEditingDone(Sender: TObject
  );
var
  LS: String;
begin
  with FExperiment do
    if ComboCurrentCondition.ItemIndex <> -1 then
      begin
        LS := SEC_CONDITION+IntToStr(ComboCurrentCondition.ItemIndex+1);
        WriteInteger(LS, KEY_ENDCRITERIA_CYCLES, SpinEditEndCriteriaAbsCycles.Value);
      end;
end;

procedure TFormDesigner.SpinEditEndCriteriaInterlockingEditingDone(
  Sender: TObject);
var
  LS: string;
begin
  with FExperiment do
    if ComboCurrentCondition.ItemIndex <> -1 then
      begin
        LS := SEC_CONDITION+IntToStr(ComboCurrentCondition.ItemIndex+1);
        WriteString(LS, KEY_ENDCRITERIA_PORCENTAGE, GetEndCriteriaPorcentage);
      end;
end;

procedure TFormDesigner.SpinEditTurnValueEditingDone(Sender: TObject);
var
  LS: string;
begin
  with FExperiment do
    if ComboCurrentCondition.ItemIndex <> -1 then
      begin
        LS := SEC_CONDITION+IntToStr(ComboCurrentCondition.ItemIndex+1);
        WriteInteger(LS, KEY_TURN_VALUE, SpinEditTurnValue.Value);
      end;
end;

procedure TFormDesigner.XMLPropStorageRestoreProperties(Sender: TObject);
begin
  LoadExperiment;
  ListBoxConditions.Items.Text := ComboCurrentCondition.Items.Text;
  ListBoxContingencies.Items.Text := ComboCurrentContingency.Items.Text;
  RGPointsClick(RGPoints);
  RGEndCriteriaStyleClick(RGEndCriteriaStyle);
  TabSheetContingencies.Enabled := ComboCurrentCondition.Items.Count > 0;
end;

procedure TFormDesigner.XMLPropStorageSavingProperties(Sender: TObject);
begin
  SaveExperiment;
end;


procedure TFormDesigner.XMLPropStorageStoredValuesFileNameRestore(Sender: TStoredValue;
  var Value: TStoredType);
begin
  FExperiment := TIniFile.Create(Value);
end;


procedure TFormDesigner.XMLPropStorageStoredValuesFileNameSave(Sender: TStoredValue;
  var Value: TStoredType);
begin
  Value := FExperiment.FileName;
end;

procedure TFormDesigner.LoadExperiment;
var
  LS: string;
  LC: string;
begin
  LoadSectionExperiment;

  if ComboCurrentCondition.ItemIndex <> -1 then
  begin
    LS := ExtractDelimited(1,ComboCurrentCondition.Text,['|']);
    LoadSectionCondition(LS);
    if ComboCurrentContingency.ItemIndex <> -1 then
      begin
        LC := ExtractDelimited(1, ComboCurrentContingency.Text,['|']);
        LoadContingency(LS, LC);
      end;
  end;
end;

procedure TFormDesigner.SaveExperiment;
var
  LS, LC: string;
begin
  SaveSectionExperiment;
  if ComboCurrentCondition.ItemIndex <> -1 then
  begin
    LS := ExtractDelimited(1,ComboCurrentCondition.Text,['|']);
    SaveSectionCondition(LS);
    if ComboCurrentContingency.ItemIndex <> -1 then
    begin
      LC := ExtractDelimited(1,ComboCurrentContingency.Text,['|']);
      SaveContingency(LS, LC);
    end;
  end;
end;

function TFormDesigner.GetMatrixTypeStringFromCGMatrix: string;
begin
  Result := '';
  if ChkColors.Checked then
    Result += 'CORES,';
  if ChkRows.Checked then
    Result += 'LINHAS,';
  if ChkCols.Checked then
    Result += 'COLUNAS,';
  if ChkDots.Checked then
    Result += 'CÍRCULOS PREENCHIDOS,';
  if ChkCleanDots.Checked then
    Result += 'CÍRCULOS VAZADOS,';
  if ChkDotsCleanDots.Checked then
    Result += 'CÍRCULOS AMBOS,';
end;

function TFormDesigner.GetPromptQuestionStringFromCGQuestion: string;
var
  PS: TPromptStyle;
begin
  PS := [];
  if CGQuestion.Checked[0] then
    PS += [gsAll, gsYes, gsMetacontingency, gsContingency, gsRevertPoints];

  if CGQuestion.Checked[1] then
    PS += [gsBasA];

  Result := GetPromptStyleString(PS);
end;

procedure TFormDesigner.SetCGMatrix(AMatrixType: string);
begin
  if Pos('CORES', UpperCase(AMatrixType)) > 0 then
    ChkColors.Checked := True
  else
    ChkColors.Checked := False;

  if Pos('LINHAS', UpperCase(AMatrixType)) > 0 then
    ChkRows.Checked := True
  else
    ChkRows.Checked := False;

  if Pos('COLUNAS', UpperCase(AMatrixType)) > 0 then
    ChkCols.Checked := True
  else
    ChkCols.Checked := False;

  if Pos('CÍRCULOS PREENCHIDOS', UpperCase(AMatrixType)) > 0 then
    ChkDots.Checked := True
  else
    ChkDots.Checked := False;

  if Pos('CÍRCULOS VAZADOS', UpperCase(AMatrixType)) > 0 then
    ChkCleanDots.Checked := True
  else
    ChkCleanDots.Checked := False;

  if Pos('CÍRCULOS AMBOS', UpperCase(AMatrixType)) > 0 then
    ChkDotsCleanDots.Checked := True
  else
    ChkDotsCleanDots.Checked := False;
end;

procedure TFormDesigner.SetCGQuestion(AQuestionStyle: string);
var
  PS: TPromptStyle;
begin
  PS := GetPromptStyleFromString(AQuestionStyle);
  if (gsAll in PS) and (gsYes in PS) and (gsMetacontingency in PS) and
    (gsContingency in PS) and (gsRevertPoints in PS) then
    CGQuestion.Checked[0] := True
  else
    CGQuestion.Checked[0] := False;

  if (gsBasA) in PS then
    CGQuestion.Checked[1] := True
  else
    CGQuestion.Checked[1] := False;
end;

procedure TFormDesigner.SetRGEndCriteriaStyle(AStyle: string);
begin
  case UpperCase(AStyle) of
    'CICLOS': RGEndCriteriaStyle.ItemIndex := 0;
    'PORCENTAGEM': RGEndCriteriaStyle.ItemIndex := 1;
    'O QUE OCORRER PRIMEIRO': RGEndCriteriaStyle.ItemIndex := 2;
  end;
end;

procedure TFormDesigner.SetContingencyCriteria(S: string);
var
  C: TCriteria;

  procedure SetContingencyRows(GR: TGameRows);
  var
    i: integer;
  begin
    for i := 0 to GBContingencyRows.ComponentCount - 1 do
      case GBContingencyRows.Components[i].Name of
        'Chk1': TCheckBox(GBContingencyRows.Components[i]).Checked := grOne in GR;
        'Chk2': TCheckBox(GBContingencyRows.Components[i]).Checked := grTwo in GR;
        'Chk3': TCheckBox(GBContingencyRows.Components[i]).Checked := grThree in GR;
        'Chk4': TCheckBox(GBContingencyRows.Components[i]).Checked := grFour in GR;
        'Chk5': TCheckBox(GBContingencyRows.Components[i]).Checked := grFive in GR;
        'Chk6': TCheckBox(GBContingencyRows.Components[i]).Checked := grSix in GR;
        'Chk7': TCheckBox(GBContingencyRows.Components[i]).Checked := grSeven in GR;
        'Chk8': TCheckBox(GBContingencyRows.Components[i]).Checked := grEight in GR;
        'Chk9': TCheckBox(GBContingencyRows.Components[i]).Checked := grNine in GR;
        'Chk10': TCheckBox(GBContingencyRows.Components[i]).Checked := grTen in GR;
        'ChkEven': TCheckBox(GBContingencyRows.Components[i]).Checked := grEven in GR;
        'ChkOdd': TCheckBox(GBContingencyRows.Components[i]).Checked := grOdd in GR;
      end;
  end;

  procedure SetContingencyColors(GC: TGameColors);
  var
    i: integer;
  begin
    for i := 0 to GBContingencyColors.ComponentCount - 1 do
      case GBContingencyColors.Components[i].Name of
        'ChkEqual': TCheckBox(GBContingencyColors.Components[i]).Checked := gcEqual in GC;
        'ChkDiff': TCheckBox(GBContingencyColors.Components[i]).Checked := gcDiff in GC;
        'ChkNot': TCheckBox(GBContingencyColors.Components[i]).Checked := gcNot in GC;
        'ChkY': TCheckBox(GBContingencyColors.Components[i]).Checked := gcYellow in GC;
        'ChkR': TCheckBox(GBContingencyColors.Components[i]).Checked := gcRed in GC;
        'ChkM': TCheckBox(GBContingencyColors.Components[i]).Checked := gcMagenta in GC;
        'ChkB': TCheckBox(GBContingencyColors.Components[i]).Checked := gcBlue in GC;
        'ChkG': TCheckBox(GBContingencyColors.Components[i]).Checked := gcGreen in GC;
      end;
  end;

begin
  C := GetCriteriaFromString(S);
  case C.Style of
    gtNone: RGContingencyStyle.ItemIndex := 0;
    gtRowsOnly:
    begin
      RGContingencyStyle.ItemIndex := 1;
      SetContingencyRows(C.Rows);
    end;
    gtColorsOnly:
    begin
      RGContingencyStyle.ItemIndex := 2;
      SetContingencyColors(C.Colors);
    end;
    gtRowsAndColors:
    begin
      RGContingencyStyle.ItemIndex := 3;
      SetContingencyRows(C.Rows);
      SetContingencyColors(C.Colors);
    end;
    gtRowsOrColors:
    begin
      RGContingencyStyle.ItemIndex := 4;
      SetContingencyRows(C.Rows);
      SetContingencyColors(C.Colors);
    end;
  end;
end;

procedure TFormDesigner.SetConsequenceStyle(S: string);
var
  CS : TConsequenceStyle;
  //LVariation : integer;
  SCode,
  SPoints : string;
  LPoints //, temp, t2
  : integer;
begin
  SPoints := ExtractDelimited(1,S,['|']);
  LPoints := StrToInt(ExtractDelimited(1,SPoints,[',']));
  //LVariation := StrToInt(ExtractDelimited(2,SPoints,[',']));
  SpinEditContingencyPoints.Value := LPoints;

  SCode := ExtractDelimited(2,S,['|']);
  CS := GetConsequenceStylesFromString(SCode);
  case RGPoints.ItemIndex of
    0: { A & B }
      begin
        if gscA in CS then CBPointsType.ItemIndex := 0;
        if gscB in CS then CBPointsType.ItemIndex := 1;
        if gscG in CS then CBPointsType.ItemIndex := 2;
      end;
    1: { I }
      begin
        if gscI in CS then CBPointsType.ItemIndex := 0;
        if gscG in CS then CBPointsType.ItemIndex := 1;
      end;
  end;

  //if RGContingencyStyle.ItemIndex > 0 then
  //  if CBPointsType.ItemIndex > 0 then
  //    begin
  //      temp := CBPointsType.ItemIndex;
  //      t2 := CBPointsType.Items.Count;
  //      CBPointsType.Text := CBPointsType.Items[CBPointsType.ItemIndex];
  //    end;

  if gscBroadcastMessage in CS then
    CheckBoxBroadcast.State := cbChecked
  else
  if gscMessage in CS then
    CheckBoxBroadcast.State := cbGrayed
  else
    CheckBoxBroadcast.State := cbUnchecked;


  case CheckBoxBroadcast.State of
    cbChecked: CheckBoxBroadcast.Caption := 'a todos';
    cbUnchecked: CheckBoxBroadcast.Caption := 'ao participante';
    cbGrayed: CheckBoxBroadcast.Caption := 'a ninguém';
  end;
end;

procedure TFormDesigner.UpdateContingencyList(ASection: String);
var
  LC: String;
  //S : TStringList;
begin
  //S := TStringList.Create;
  ListBoxContingencies.Items.Clear;
  LC := KEY_CONTINGENCY+'1';
  ReadContingencyNames(ASection,LC,KEY_CONT_NAME,ListBoxContingencies.Items);
  LC := KEY_METACONTINGENCY+'1';
  ReadContingencyNames(ASection,LC,KEY_CONT_NAME,ListBoxContingencies.Items);
  //ListBoxContingencies.Items.Text := S.Text;
  //S.Free;
end;

procedure TFormDesigner.UpdateContingencyCombo(ASection: String);
var
  LC: String;
begin
  ComboCurrentContingency.Items.Clear;
  case RGContingencyType.ItemIndex of
    0:
      begin
        LC := KEY_CONTINGENCY+'1';
        ReadContingencyNames(ASection,LC,KEY_CONT_NAME,ComboCurrentContingency.Items);
      end;
    1:
      begin
        LC := KEY_METACONTINGENCY+'1';
        ReadContingencyNames(ASection,LC,KEY_CONT_NAME,ComboCurrentContingency.Items);
      end;
  end;
end;

procedure TFormDesigner.IncContingencyName(var AContingency: string; N: integer);
var
  LContingencyType: String;
  LExtension: RawByteString;
  LCount: LongInt;
begin
  LContingencyType := ExtractFileNameWithoutExt(AContingency);
  LExtension := ExtractFileExt(AContingency);
  Delete(LExtension,1,1);
  LCount := StrToInt(LExtension);
  Inc(LCount,N);
  AContingency := LContingencyType + '.' + IntToStr(LCount);
end;

procedure TFormDesigner.ReadContingencyNames(ASection, AContingency,
  AKeySuffix: string; S: TStrings);
begin
  with FExperiment do
    while ValueExists(ASection,AContingency+AKeySuffix) do
      begin
        S.Append(AContingency+'|'+ReadString(ASection,AContingency+AKeySuffix,''));
        IncContingencyName(AContingency);
      end;
end;

procedure TFormDesigner.SaveSectionExperiment;
begin
  with FExperiment do
  begin
    WriteString(SEC_EXPERIMENT, KEY_RESEARCHER, EditResearcherName.Text);
    WriteString(SEC_EXPERIMENT, KEY_NAME, EditExperimentName.Text);
    WriteString(SEC_EXPERIMENT, KEY_AIM, MemoExperimentAim.Text);
    WriteBool(SEC_EXPERIMENT, KEY_CHAT_HISTORY_FOR_NEW_PLAYERS, CGGlobal.Checked[0]);
    WriteBool(SEC_EXPERIMENT, KEY_GEN_PLAYER_AS_NEEDED, CGGlobal.Checked[1]);
    WriteBool(SEC_EXPERIMENT, KEY_RESEARCHER_CANPLAY, CGGlobal.Checked[2]);
    WriteBool(SEC_EXPERIMENT, KEY_RESEARCHER_CANCHAT, CGGlobal.Checked[3]);
    case RGPoints.ItemIndex of
      0: WriteBool(SEC_EXPERIMENT, KEY_POINTS_TYPE, True);
      1: WriteBool(SEC_EXPERIMENT, KEY_POINTS_TYPE, False);
    end;
    WriteString(SEC_EXPERIMENT, KEY_MATRIX_TYPE, GetMatrixTypeStringFromCGMatrix);
  end;
end;

procedure TFormDesigner.LoadSectionExperiment;
begin
  with FExperiment do
    begin
      EditResearcherName.Text := ReadString(SEC_EXPERIMENT, KEY_RESEARCHER, '');
      EditExperimentName.Text := ReadString(SEC_EXPERIMENT, KEY_NAME, '');
      MemoExperimentAim.Text := ReadString(SEC_EXPERIMENT, KEY_AIM, '');
      CGGlobal.Checked[0] :=
        ReadBool(SEC_EXPERIMENT, KEY_CHAT_HISTORY_FOR_NEW_PLAYERS, False);
      CGGlobal.Checked[1] := ReadBool(SEC_EXPERIMENT, KEY_GEN_PLAYER_AS_NEEDED, False);
      CGGlobal.Checked[2] := ReadBool(SEC_EXPERIMENT, KEY_RESEARCHER_CANPLAY, False);
      CGGlobal.Checked[3] := ReadBool(SEC_EXPERIMENT, KEY_RESEARCHER_CANCHAT, False);
      if ReadBool(SEC_EXPERIMENT, KEY_POINTS_TYPE, True) then
        RGPoints.ItemIndex := 0
      else
        RGPoints.ItemIndex := 1;
      RGPointsClick(RGPoints);
      SetCGMatrix(ReadString(SEC_EXPERIMENT, KEY_MATRIX_TYPE, 'CORES,LINHAS'));
    end;
end;

procedure TFormDesigner.SaveSectionCondition(ASection: string);
begin
  with FExperiment do
    begin
      WriteString(ASection, KEY_COND_NAME, EditConditionName.Text);
      WriteInteger(ASection, KEY_TURN_VALUE, SpinEditTurnValue.Value);
      WriteInteger(ASection, KEY_POINTS_ONSTART,SpinEditOnConditionBegin.Value);
      WriteInteger(ASection, KEY_CYCLES_VALUE, SpinEditCyclesValue.Value);
      WriteString(ASection, KEY_PROMPT_MESSAGE, EditQuestion.Text);
      WriteString(ASection, KEY_PROMPT_STYLE, GetPromptQuestionStringFromCGQuestion);
      WriteString(ASection, KEY_ENDCRITERIA, GetEndCriteriaStyleFromRGEndCriteriaStyle);
      WriteInteger(ASection, KEY_ENDCRITERIA_CYCLES, SpinEditEndCriteriaAbsCycles.Value);
      WriteString(ASection, KEY_ENDCRITERIA_PORCENTAGE, GetEndCriteriaPorcentage);
    end;
end;

procedure TFormDesigner.SaveContingency(ASection, AContingency: string);
begin
  with FExperiment do
    begin
      WriteString(ASection, AContingency + KEY_CONT_NAME, EditContingencyName.Text);
      WriteString(ASection, AContingency + KEY_CRITERIA, GetContingencyCriteria);
      WriteString(ASection, AContingency + KEY_CONSEQUE, GetConsequenceStyle);
      WriteString(ASection, AContingency + KEY_CONSEQUE_MESSAGE_PREPEND, EditMessPrefix.Text);
      try
        WriteString(ASection, AContingency + KEY_CONSEQUE_MESSAGE_APPENDS, ExtractDelimited(1,EditMessSufix.Text,['|']));
        WriteString(ASection, AContingency + KEY_CONSEQUE_MESSAGE_APPENDP, ExtractDelimited(2,EditMessSufix.Text,['|']));
      except
        on E: Exception do
          Exit;
        //if E.Message = 'E';

      end;
    end;
end;

procedure TFormDesigner.EraseContingency(ASection, AContingency: string);
begin
  with FExperiment do
    begin
      DeleteKey(ASection, AContingency + KEY_CONT_NAME);
      DeleteKey(ASection, AContingency + KEY_CRITERIA);
      DeleteKey(ASection, AContingency + KEY_CONSEQUE);
      DeleteKey(ASection, AContingency + KEY_CONSEQUE_MESSAGE_PREPEND);
      DeleteKey(ASection, AContingency + KEY_CONSEQUE_MESSAGE_APPENDS);
      DeleteKey(ASection, AContingency + KEY_CONSEQUE_MESSAGE_APPENDP);
    end;
end;

function TFormDesigner.GetContingencyName(IsMeta: Boolean; MustIncrement: Boolean): string;
var
  LCount,
  i : integer;
  S : string;
  Extension : string;
  ContingencyKey: string;
begin
  if ComboCurrentContingency.Items.Count > 0 then
    begin
      for i := ComboCurrentContingency.Items.Count-1 downto 0 do
        begin
          S := ExtractDelimited(1,ComboCurrentContingency.Items[i],['|']);
          ContingencyKey := ExtractFileNameWithoutExt(S);

          if IsMeta then
            begin
              if ContingencyKey = ExtractFileNameWithoutExt(KEY_METACONTINGENCY) then
                begin
                  Result := KEY_METACONTINGENCY;
                  Extension := ExtractFileExt(S);
                  Delete(Extension,1,1);
                  LCount := StrToInt(Extension);
                  if MustIncrement then
                    Inc(LCount);
                  Result += IntToStr(LCount);
                  Break;
                end
              else
                begin
                  if i = 0 then
                    begin
                      Result := KEY_METACONTINGENCY+'1';
                      Exit;
                    end;
                  Continue;
                end;
            end
          else
            begin
              if ContingencyKey = ExtractFileNameWithoutExt(KEY_CONTINGENCY) then
                begin
                  Result := KEY_CONTINGENCY;
                  Extension := ExtractFileExt(S);
                  Delete(Extension,1,1);
                  LCount := StrToInt(Extension);
                  if MustIncrement then
                    Inc(LCount);
                  Result += IntToStr(LCount);
                  Break;
                end
              else
                begin
                  if i = 0 then
                    begin
                      Result := KEY_CONTINGENCY+'1';
                      Exit;
                    end;
                  Continue;
                end;
            end;
        end;
    end
  else
    if IsMeta then
      Result := KEY_METACONTINGENCY+'1'
    else
      Result := KEY_CONTINGENCY+'1';
end;

function TFormDesigner.GetConsequenceStyle: string;
var
  CS : TConsequenceStyle;
begin
  CS := [gscMessage,gscPoints];
  case RGPoints.ItemIndex of
    0: { A & B }
      case CBPointsType.ItemIndex of
        0 {'Individual A'} : CS += [gscA];
        1 {'Individual B'} : CS += [gscB];
        2 {'Para o Grupo'} : CS += [gscG];
      end;
    1: { I }
      case CBPointsType.ItemIndex of
        0 {'Individual'} : CS += [gscI];
        1 {'Para o Grupo'} : CS += [gscG];
      end;
  end;

  case CheckBoxBroadcast.State of
    cbChecked : CS += [gscBroadcastMessage];
    cbUnchecked: { do nothing };
    cbGrayed: CS -= [gscMessage];
  end;

  Result := IntToStr(SpinEditContingencyPoints.Value)+',0|';
  Result += GetConsequenceStylesString(CS);
end;

function TFormDesigner.GetContingencyCriteria: string;
var
  C: TCriteria;

  function GetContingencyRows: TGameRows;
  var
    i: integer;
  begin
    Result := [];
    for i := 0 to GBContingencyRows.ComponentCount - 1 do
      case GBContingencyRows.Components[i].Name of
        'Chk1': if TCheckBox(GBContingencyRows.Components[i]).Checked then Result += [grOne];
        'Chk2': if TCheckBox(GBContingencyRows.Components[i]).Checked then Result += [grTwo];
        'Chk3': if TCheckBox(GBContingencyRows.Components[i]).Checked then Result += [grThree];
        'Chk4': if TCheckBox(GBContingencyRows.Components[i]).Checked then Result += [grFour];
        'Chk5': if TCheckBox(GBContingencyRows.Components[i]).Checked then Result += [grFive];
        'Chk6': if TCheckBox(GBContingencyRows.Components[i]).Checked then Result += [grSix];
        'Chk7': if TCheckBox(GBContingencyRows.Components[i]).Checked then Result += [grSeven];
        'Chk8': if TCheckBox(GBContingencyRows.Components[i]).Checked then Result += [grEight];
        'Chk9': if TCheckBox(GBContingencyRows.Components[i]).Checked then Result += [grNine];
        'Chk10': if TCheckBox(GBContingencyRows.Components[i]).Checked then Result += [grTen];
        'ChkEven': if TCheckBox(GBContingencyRows.Components[i]).Checked then Result += [grEven];
        'ChkOdd': if TCheckBox(GBContingencyRows.Components[i]).Checked then Result += [grOdd];
      end;
  end;

  function GetContingencyColors: TGameColors;
  var
    i: integer;
  begin
    Result := [];
    for i := 0 to GBContingencyColors.ComponentCount - 1 do
      case GBContingencyColors.Components[i].Name of
        'ChkEqual': if TCheckBox(GBContingencyColors.Components[i]).Checked then Result += [gcEqual];
        'ChkDiff': if TCheckBox(GBContingencyColors.Components[i]).Checked then Result += [gcDiff];
        'ChkNot': if TCheckBox(GBContingencyColors.Components[i]).Checked then Result += [gcNot];
        'ChkY': if TCheckBox(GBContingencyColors.Components[i]).Checked then Result += [gcYellow];
        'ChkR': if TCheckBox(GBContingencyColors.Components[i]).Checked then Result += [gcRed];
        'ChkM': if TCheckBox(GBContingencyColors.Components[i]).Checked then Result += [gcMagenta];
        'ChkB': if TCheckBox(GBContingencyColors.Components[i]).Checked then Result += [gcBlue];
        'ChkG': if TCheckBox(GBContingencyColors.Components[i]).Checked then Result += [gcGreen];
      end;
  end;

begin
  C.Style := gtNone;
  C.Rows := [];
  C.Colors := [];
  case RGContingencyStyle.ItemIndex of
    0: { do nothing };
    1:
    begin
      C.Style := gtRowsOnly;
      C.Rows := GetContingencyRows;
    end;
    2:
    begin
      C.Style := gtColorsOnly;
      C.Colors := GetContingencyColors;
    end;
    3:
    begin
      C.Style := gtRowsAndColors;
      C.Rows := GetContingencyRows;
      C.Colors := GetContingencyColors;
    end;
    4:
    begin
      C.Style := gtRowsOrColors;
      C.Rows := GetContingencyRows;
      C.Colors := GetContingencyColors;
    end;
  end;
  Result := GetCriteriaString(C);
end;

procedure TFormDesigner.LoadSectionCondition(ASection: string);
begin
  with FExperiment do
    begin
      EditConditionName.Text := ReadString(ASection, KEY_COND_NAME, ASection);
      SpinEditTurnValue.Value := ReadInteger(ASection, KEY_TURN_VALUE, 2);
      SpinEditOnConditionBegin.Value := ReadInteger(ASection, KEY_POINTS_ONSTART,0);
      SpinEditCyclesValue.Value := ReadInteger(ASection, KEY_CYCLES_VALUE, 2);

      CheckBoxShouldAskQuestion.Checked := False;
      if ValueExists(ASection, KEY_PROMPT_STYLE) and ValueExists(ASection, KEY_PROMPT_MESSAGE) then
      begin
        EditQuestion.Text := ReadString(ASection, KEY_PROMPT_MESSAGE, '');
        SetCGQuestion(ReadString(ASection, KEY_PROMPT_STYLE, ''));
        if (EditQuestion.Text <> '') or (ReadString(ASection, KEY_PROMPT_STYLE, '') <> '') then
          CheckBoxShouldAskQuestion.Checked := True;
      end;

      SetRGEndCriteriaStyle(ReadString(ASection, KEY_ENDCRITERIA, 'O QUE OCORRER PRIMEIRO'));
      SpinEditEndCriteriaAbsCycles.Value := ReadInteger(ASection, KEY_ENDCRITERIA_CYCLES, 20);
      SpinEditEndCriteriaLastCycles.Value :=
        GetEndCriteriaLastCyclesFromString(ReadString(ASection, KEY_ENDCRITERIA_PORCENTAGE, '80,20'));
      SpinEditEndCriteriaInterlockingPorcentage.Value :=
        GetEndCriteriaPorcentageFromString(ReadString(ASection, KEY_ENDCRITERIA_PORCENTAGE, '80,20'));
    end;
end;

procedure TFormDesigner.LoadContingency(ASection, AContingency: string);
begin
  with FExperiment do
    if ValueExists(ASection, AContingency + KEY_CONSEQUE) and ValueExists(ASection, AContingency + KEY_CRITERIA) then
      begin
        EditContingencyName.Text := ReadString(ASection, AContingency + KEY_CONT_NAME, '');
        SetContingencyCriteria(ReadString(ASection, AContingency + KEY_CRITERIA, ''));
        SetConsequenceStyle(ReadString(ASection, AContingency + KEY_CONSEQUE, ''));
        EditMessPrefix.Text := ReadString(ASection, AContingency + KEY_CONSEQUE_MESSAGE_PREPEND,'');
        EditMessSufix.Text := ReadString(ASection, AContingency + KEY_CONSEQUE_MESSAGE_APPENDS,'')+'|'+
          ReadString(ASection, AContingency + KEY_CONSEQUE_MESSAGE_APPENDP,'');
      end;
end;

function TFormDesigner.GetEndCriteriaPorcentage: string;
begin
  Result := IntToStr(SpinEditEndCriteriaInterlockingPorcentage.Value) + ',' +
    IntToStr(SpinEditEndCriteriaLastCycles.Value);
end;

function TFormDesigner.GetEndCriteriaStyleFromRGEndCriteriaStyle: string;
begin
  case RGEndCriteriaStyle.ItemIndex of
    0: Result := 'CICLOS';
    1: Result := 'PORCENTAGEM';
    2: Result := 'O QUE OCORRER PRIMEIRO';
  end;
end;

procedure TFormDesigner.MenuItemExitClick(Sender: TObject);
begin
  Close;
end;

procedure TFormDesigner.FormCreate(Sender: TObject);
begin
  FLoading := True;
end;

procedure TFormDesigner.FormDestroy(Sender: TObject);
begin
  FExperiment.Free;
end;

procedure TFormDesigner.CheckBoxShouldAskQuestionChange(Sender: TObject);
var
  LS: String;
begin
  if TCheckBox(Sender).Checked then
    TCheckBox(Sender).Caption := 'Sim'
  else
    begin
      TCheckBox(Sender).Caption := 'Não';
      with FExperiment do
        if ComboCurrentCondition.ItemIndex <> -1 then
          begin
            LS := SEC_CONDITION+IntToStr(ComboCurrentCondition.ItemIndex+1);
            WriteString(LS, KEY_PROMPT_MESSAGE, '');
            WriteString(LS, KEY_PROMPT_STYLE, '');
          end;
    end;

  EditQuestion.Visible := CheckBoxShouldAskQuestion.Checked;
  CGQuestion.Visible := CheckBoxShouldAskQuestion.Checked;
end;

procedure TFormDesigner.ChkCleanDotsChange(Sender: TObject);
begin
  if ChkCleanDots.Checked then
    begin
      ChkDots.Checked := not ChkCleanDots.Checked;
      ChkDotsCleanDots.Checked := not ChkCleanDots.Checked;
    end;
end;

procedure TFormDesigner.ChkDotsChange(Sender: TObject);
begin
  if ChkDots.Checked then
    begin
      ChkCleanDots.Checked := not ChkDots.Checked;
      ChkDotsCleanDots.Checked := not ChkDots.Checked;
    end;
end;

procedure TFormDesigner.ChkDotsCleanDotsChange(Sender: TObject);
begin
  if ChkDotsCleanDots.Checked then
    begin
      ChkCleanDots.Checked := not ChkDotsCleanDots.Checked;
      ChkDots.Checked := not ChkDotsCleanDots.Checked;
    end;
end;

procedure TFormDesigner.ComboCurrentConditionChange(Sender: TObject);
begin
  LoadSectionCondition(SEC_CONDITION + IntToStr(ComboCurrentCondition.ItemIndex + 1));
end;

procedure TFormDesigner.ComboCurrentContingencyChange(Sender: TObject);
begin
  LoadContingency(ExtractDelimited(1,ComboCurrentCondition.Text,['|']),ExtractDelimited(1,ComboCurrentContingency.Text,['|']));
end;

procedure TFormDesigner.EditConditionNameEditingDone(Sender: TObject);
var
  LS: string;
begin
  with FExperiment do
    if ComboCurrentCondition.ItemIndex <> -1 then
      begin
        LS := SEC_CONDITION+IntToStr(ComboCurrentCondition.ItemIndex+1);
        WriteString(LS, KEY_COND_NAME, EditConditionName.Text);
        ComboCurrentCondition.Items[ComboCurrentCondition.ItemIndex] :=
          SEC_CONDITION + IntToStr(ComboCurrentCondition.ItemIndex + 1) + '|' + EditConditionName.Text;
        ListBoxConditions.Items.Text := ComboCurrentCondition.Items.Text;
      end;
end;

procedure TFormDesigner.EditContingencyNameEditingDone(Sender: TObject);
var
  LS, LC: string;
begin
  with FExperiment do
    if ComboCurrentContingency.ItemIndex <> -1 then
      begin
        LS := SEC_CONDITION+IntToStr(ComboCurrentCondition.ItemIndex+1);
        LC := ExtractDelimited(1,ComboCurrentContingency.Text,['|']);
        WriteString(LS, LC+ KEY_CONT_NAME, EditContingencyName.Text);
        ComboCurrentContingency.Items[ComboCurrentContingency.ItemIndex] :=
          LC + '|' + EditContingencyName.Text;
        ListBoxContingencies.Items.Text := ComboCurrentContingency.Items.Text;
      end;
end;

procedure TFormDesigner.ConsequenceMessageEditingDone(Sender: TObject);
var
  LS, LC: String;
begin
  LS := ExtractDelimited(1,ComboCurrentCondition.Text,['|']);
  LC := ExtractDelimited(1,ComboCurrentContingency.Text,['|']);
  FExperiment.WriteString(LS, LC + KEY_CONSEQUE_MESSAGE_PREPEND, EditMessPrefix.Text);
end;

procedure TFormDesigner.EditQuestionEditingDone(Sender: TObject);
var
  LS: string;
begin
  with FExperiment do
    if ComboCurrentCondition.ItemIndex <> -1 then
      begin
        LS := SEC_CONDITION+IntToStr(ComboCurrentCondition.ItemIndex+1);
        WriteString(LS, KEY_PROMPT_MESSAGE, EditQuestion.Text);
      end;
end;

procedure TFormDesigner.FormActivate(Sender: TObject);
begin
  FLoading := False;
end;

procedure TFormDesigner.CheckBoxBroadcastChange(Sender: TObject);
begin
  case TCheckBox(Sender).State of
    cbChecked: TCheckBox(Sender).Caption := 'a todos';
    cbUnchecked: TCheckBox(Sender).Caption := 'ao participante';
    cbGrayed: TCheckBox(Sender).Caption := 'a ninguém';
  end;
  ConsequenceStyleChange(CheckBoxBroadcast);
end;


procedure TFormDesigner.BtnAppendCondClick(Sender: TObject);
var
  i: integer;
begin
  i := ComboCurrentCondition.Items.Add('');
  ComboCurrentCondition.Items[i] :=
    SEC_CONDITION + IntToStr(i + 1) + '|' + EditConditionName.Text;
  ComboCurrentCondition.ItemIndex := i;
  SaveSectionCondition(SEC_CONDITION + IntToStr(i + 1));
  ListBoxConditions.Items.Text := ComboCurrentCondition.Items.Text;
  TabSheetContingencies.Enabled := ComboCurrentCondition.Items.Count > 0;
end;

procedure TFormDesigner.BtnAppendContingencyClick(Sender: TObject);
var
  i: integer;
  LS, LC : string;

begin
  LS := ExtractDelimited(1,ComboCurrentCondition.Items[ComboCurrentCondition.ItemIndex],['|']);
  LC := GetContingencyName(RGContingencyType.ItemIndex = 1);
  i := ComboCurrentContingency.Items.Add('');
  ComboCurrentContingency.Items[i] :=
    LC + '|' + EditContingencyName.Text;
  ComboCurrentContingency.ItemIndex := i;
  SaveContingency(LS,LC);
  UpdateContingencyList(LS);
end;

procedure TFormDesigner.BtnRemoveCondClick(Sender: TObject);
var
  i: integer;
  MustReorder: boolean;
  LS: String;

  procedure Reorder(index : integer);
  var
    i: integer;
    Section: TStringList;
    KeyName,Line,SectionName: string;
  begin
    Section := TStringList.Create;
    with FExperiment do
      for i := index to ComboCurrentCondition.Items.Count - 1 do
        begin
          // whatever the section name is, save and erase section
          SectionName := ExtractDelimited(1, ComboCurrentCondition.Items[i], ['|']);
          ReadSectionValues(SectionName, Section);
          EraseSection(SectionName);

          // then rename and rewrite section
          SectionName := SEC_CONDITION + IntToStr(i + 1);
          for Line in Section do
            begin
              KeyName := Section.ExtractName(Line);
              WriteString(SectionName, KeyName, Section.Values[KeyName]);
            end;
          Section.Clear;
          ComboCurrentCondition.Items[i] :=
            SectionName + '|' + ReadString(SectionName,KEY_COND_NAME,'');
        end;
    Section.Free;
  end;

begin
  if ComboCurrentCondition.ItemIndex > -1 then
    begin
      i := ComboCurrentCondition.ItemIndex;
      MustReorder := i < ComboCurrentCondition.Items.Count - 1;
      LS := ExtractDelimited(1, ComboCurrentCondition.Text, ['|']);
      ComboCurrentCondition.Items.Delete(i);
      FExperiment.EraseSection(LS);

      if MustReorder then
        Reorder(i);
      case ComboCurrentCondition.Items.Count of
        0: {do nothing};
        1..MaxInt:
          if i = 0 then
            ComboCurrentCondition.ItemIndex := i
          else
            ComboCurrentCondition.ItemIndex := i -1;
      end;
      ListBoxConditions.Items.Text := ComboCurrentCondition.Items.Text;
      TabSheetContingencies.Enabled := ComboCurrentCondition.Items.Count > 0;
    end;
end;

procedure TFormDesigner.BtnRemoveContingencyClick(Sender: TObject);
var
  i: integer;
  MustReorder: boolean;
  LS, LC: String;

  procedure ReadContingencyValuesInSection(LS,LC : string; var Keys : TStringList);
  begin
    Keys.BeginUpdate;
    with FExperiment do
      begin
        Keys.Values[LC + KEY_CONT_NAME] := ReadString(LS,LC+KEY_CONT_NAME,'');
        Keys.Values[LC + KEY_CRITERIA] := ReadString(LS, LC + KEY_CRITERIA,'');
        Keys.Values[LC + KEY_CONSEQUE] := ReadString(LS, LC + KEY_CONSEQUE,'');
        Keys.Values[LC + KEY_CONSEQUE_MESSAGE_PREPEND] := ReadString(LS, LC + KEY_CONSEQUE_MESSAGE_PREPEND,'');
        Keys.Values[LC + KEY_CONSEQUE_MESSAGE_APPENDS] := ReadString(LS, LC + KEY_CONSEQUE_MESSAGE_APPENDS,'');
        Keys.Values[LC + KEY_CONSEQUE_MESSAGE_APPENDP] := ReadString(LS, LC + KEY_CONSEQUE_MESSAGE_APPENDP,'');
      end;
    Keys.EndUpdate;
  end;
  //todo:fix bug in here
  procedure Reorder(Index:integer);
  var
    i: integer;
    SectionKeys: TStringList;
    KeyName,KeyPrefix,Line,SectionName: string;
  begin
    SectionKeys := TStringList.Create;
    with FExperiment do
      begin
        SectionName := ExtractDelimited(1, ComboCurrentCondition.Text, ['|']);
        for i := Index to ComboCurrentContingency.Items.Count - 1 do
          begin
            KeyPrefix := ExtractDelimited(1, ComboCurrentContingency.Items[i], ['|']);
            ReadContingencyValuesInSection(SectionName,KeyPrefix, SectionKeys);
            EraseContingency(SectionName,KeyPrefix);
            KeyPrefix := ExtractFileNameWithoutExt(KeyPrefix) + '.' + IntToStr(i + 1);
            for Line in SectionKeys do
              begin
                KeyName := SectionKeys.ExtractName(Line);
                WriteString(SectionName, KeyName, SectionKeys.Values[KeyName]);
              end;
            SectionKeys.Clear;
            ComboCurrentContingency.Items[i] :=
              KeyPrefix + '|' + ReadString(SectionName,KeyPrefix+KEY_CONT_NAME,'');
          end;
      end;
    SectionKeys.Free;
  end;

begin
  if ComboCurrentContingency.ItemIndex > -1 then
    begin
      i := ComboCurrentContingency.ItemIndex;
      MustReorder := i < ComboCurrentContingency.Items.Count - 1;
      LS := ExtractDelimited(1, ComboCurrentCondition.Text, ['|']);
      LC := ExtractDelimited(1, ComboCurrentContingency.Text, ['|']);
      EraseContingency(LS,LC);
      ComboCurrentContingency.Items.Delete(i);

      if MustReorder then
        Reorder(i);

      case ComboCurrentContingency.Items.Count of
        0: {do nothing};
        1..MaxInt:
          if i = 0 then
            ComboCurrentContingency.ItemIndex := i
          else
            ComboCurrentContingency.ItemIndex := i -1;
      end;
      UpdateContingencyList(LS);
    end;
end;

procedure TFormDesigner.BtnReorderCondClick(Sender: TObject);
begin
  // todo: custom reorder contingencies
  ShowMessage('Não implementado.');
end;

procedure TFormDesigner.BtnReorderContingencyClick(Sender: TObject);
begin
  // todo: custom reorder contingencies
  ShowMessage('Não implementado.');
end;


procedure TFormDesigner.ConsequenceStyleChange(Sender: TObject);
var
  LS, LC: String;
begin
  LS := ExtractDelimited(1,ComboCurrentCondition.Text,['|']);
  LC := ExtractDelimited(1,ComboCurrentContingency.Text,['|']);
  FExperiment.WriteString(LS, LC+KEY_CONSEQUE, GetConsequenceStyle);
end;

procedure TFormDesigner.CGQuestionItemClick(Sender: TObject; Index: integer);
var
  LS: String;
begin
  with FExperiment do
    if ComboCurrentCondition.ItemIndex <> -1 then
      begin
        LS := SEC_CONDITION+IntToStr(ComboCurrentCondition.ItemIndex+1);
        WriteString(LS, KEY_PROMPT_STYLE, GetPromptQuestionStringFromCGQuestion);
      end;
end;

//procedure TFormDesigner.CheckBoxIsMetaClick(Sender: TObject);
//var
//  LS, LC: String;
//begin
//  if ComboCurrentCondition.Items.Count > 0 then
//    if ComboCurrentContingency.Items.Count > 0 then
//      begin
//        LS := ExtractDelimited(1,ComboCurrentCondition.Text,['|']);
//        LC := ExtractDelimited(1, ComboCurrentContingency.Text,['|']);
//        EraseContingency(LS,LC);
//        LC := GetLC(CheckBoxIsMeta.Checked,False);
//        SaveContingency(LS,LC);
//        ComboCurrentContingency.Items[ComboCurrentContingency.ItemIndex] := LC +'|'+ EditContingencyName.Text;
//        ListBoxContingencies.Items.Text := ComboCurrentContingency.Items.Text;
//      end;
//end;

procedure TFormDesigner.CheckBoxColorsRowsChange(Sender: TObject);
var
  LS, LC : String;

  procedure UncheckBox(ACheckBoxName : string);
  var i : integer;
  begin
    for i := 0 to TCheckBox(Sender).Owner.ComponentCount -1 do
      if TCheckBox(Sender).Owner.Components[i].Name = ACheckBoxName then
        TCheckBox(TCheckBox(Sender).Owner.Components[i]).Checked := not TCheckBox(Sender).Checked;
  end;

begin
  LS := ExtractDelimited(1,ComboCurrentCondition.Text,['|']);
  LC := ExtractDelimited(1,ComboCurrentContingency.Text,['|']);
  with FExperiment do
    WriteString(LS, LC + KEY_CRITERIA, GetContingencyCriteria);

  if TCheckBox(Sender).Name = 'ChkEqual' then
    if TCheckBox(Sender).Checked then
      UncheckBox('ChkDiff');

  if TCheckBox(Sender).Name = 'ChkDiff' then
    if TCheckBox(Sender).Checked then
      UncheckBox('ChkEqual');

end;

end.
