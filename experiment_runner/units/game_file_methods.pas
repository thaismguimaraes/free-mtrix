{
  Free-mtrix - Free cultural selection and social behavior experiments.
  Copyright (C) 2016-2017 Carlos Rafael Fernandes Picanço, Universidade Federal do Pará.

  The present file is distributed under the terms of the GNU General Public License (GPL v3.0).

  You should have received a copy of the GNU General Public License
  along with this program. If not, see <http://www.gnu.org/licenses/>.
}
unit game_file_methods;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Dialogs, IniFiles
  , game_experiment
  ;


  function LoadExperimentFromResource(var AExperiment: TExperiment):Boolean;
  function LoadExperimentFromFile(AExperiment: TExperiment; AFilename : string):Boolean;
  procedure SaveExperimentToFile(AExperiment: TExperiment; AFilename : string);

resourcestring
  ERROR_SECTION_NOT_FOUND = 'O arquivo não pode ser aberto, pois a secção não foi encontrada: ';
  ERROR_FILE_NOT_FOUND = 'O arquivo não pode ser aberto, pois ele não existe.';
  ERROR_NO_CONTINGENCIES = 'O experimento não pode ser aberto, pois uma condição sem contingências foi encontrada: ';
  ERROR_NO_CONDITIONS = 'O experimento não pode ser aberto, pois nenhuma condição foi encontrada.';
  WARN_CONDITION_WITH_NO_END = 'Condição sem critério de encerramento: ';
  WARN_END = ' será usado.';

implementation

uses LCLIntf, game_resources, game_actors, game_actors_helpers, string_methods, regdata;

// for dev only
function LoadExperimentFromResource(var AExperiment: TExperiment): Boolean;
var
  C : TCondition;
  LConcequence : TConsequence;
  LCriteria1 : TCriteria = (
    Style:(gtRowsOnly);
    Rows:[grEven];
    Colors:[];
  );

  LCriteria2 : TCriteria = (
    Style:(gtRowsOnly);
    Rows:[grOdd];
    Colors:[];
  );

  LCriteria3 : TCriteria = (
    Style:(gtRowsAndColors);
    Rows:[grEven];
    Colors:[gcDiff];
  );

  LCriteria4 : TCriteria = (
    Style:(gtRowsOrColors);
    Rows:[grNot,grEven];
    Colors:[gcNot,gcDiff];
  );
begin
  Result := False;
  with AExperiment do
    begin
      ExperimentName:='test_experiment';
      ExperimentAim:='This is a test experiment.';
      ShowChat := True;
      Researcher := VAL_RESEARCHER;
      ResearcherCanPlay:=False;
      ResearcherCanChat:=True;
      SendChatHistoryForNewPlayers:=True;
      GenPlayersAsNeeded:=True;
      CurrentConditionI := 0;
      MatrixType:=[gmRows];
      ABPoints := True;
      //AppendPlayer(C_PLAYER_TEMPLATE);
      //AppendPlayer(C_PLAYER_TEMPLATE);

      C := C_CONDITION_TEMPLATE;
      with C  do
        begin
          ConditionName := SEC_CONDITION+'1';
          Turn.Count:=0;
          Turn.Value:=2;
          Turn.Random:=False;
          Cycles.Count:=0;
          Cycles.Value:=2;
          Cycles.Generation:=0;
          EndCriterium.AbsoluteCycles := 15;
          EndCriterium.InterlockingPorcentage := 80;
          EndCriterium.LastCycles := 10;
          EndCriterium.Style := gecWhichComeFirst;

          SetLength(Contingencies, 4);
          // test contingency
          LConcequence := TConsequence.Create(
            AExperiment,
            1,
            [gscPoints, gscB, gscMessage,gscBroadcastMessage],
            ['$NICNAME','perdeu','queijo','queijos', 'ganhou', 'queijo','queijos','não perdeu nem ganhou queijos']);
          Contingencies[0] := TContingency.Create(AExperiment,LConcequence,LCriteria1,False);
          Contingencies[0].ContingencyName := 'CRF 1B';

          // test contingency 2
          LConcequence := TConsequence.Create(
            AExperiment,
            3,
            [gscPoints, gscA, gscMessage,gscBroadcastMessage],
            ['$NICNAME','queimou','pão','pães','assou','pão','pães','não cozinhou nada.']);
          Contingencies[1] := TContingency.Create(AExperiment,LConcequence,LCriteria2,False);
          Contingencies[1].ContingencyName := 'CRF 3A';

          // test contingency 3
          LConcequence := TConsequence.Create(
            AExperiment,
            1,
            [gscPoints, gscG1, gscMessage],
            ['','perderam','item escolar','itens escolares','produziram','item escolar','itens escolares','não produziram nem perderam itens escolares']);
          Contingencies[2] := TContingency.Create(AExperiment,LConcequence,LCriteria3,True);
          Contingencies[2].ContingencyName := 'MCRF 1G';

          // test contingency 4
          LConcequence := TConsequence.Create(
            AExperiment,
            -1,
            [gscPoints, gscG1, gscMessage],
            ['','perderam','item escolar','itens escolares','produziram','item escolar','itens escolares','não produziram nem perderam itens escolares']);
          Contingencies[3] := TContingency.Create(AExperiment,LConcequence,LCriteria4,True);
          Contingencies[3].ContingencyName := 'MPUN -1G';

          // test prompt
          Prompt := TPrompt.Create(
            AExperiment
            , [gsAll,gsYes,gsMetacontingency,gsContingency,gsRevertPoints,gsBasA]
            , Contingencies
            , 'Um item escolar foi perdido, desejam recuperá-lo gastando pontos do Tipo A?'
            , 'MPUN -1G'
            );
          // (gsYes, gsNo, gsAll, gsMetacontingency, gsContingency, gsBasA, gsRevertPoints);
        end;

      Condition[AppendCondition] := C;
    end;
end;

function LoadExperimentFromFile(AExperiment: TExperiment; AFilename: string):Boolean;
var
  LIniFile : TIniFile;
  i: Integer;

  //procedure HandleRootPath(var APath : string);
  //begin
  //  while Pos(PathDelim, s1) <> 0 do Delete(s1, 1, Pos(PathDelim, s1));
  //  APath:= ExtractFilePath(AFileName) + s1;
  //  if not (APath[Length(APath)] = PathDelim) then APath:= APath + PathDelim;
  //end;

  procedure ReadExperiment;
  begin
    with LIniFile do
      begin
        // must have something
        AExperiment.Researcher := ReadString(SEC_EXPERIMENT, KEY_RESEARCHER,VAL_RESEARCHER);
        AExperiment.ExperimentName:=ReadString(SEC_EXPERIMENT, KEY_NAME,VAL_EXPERIMENT);

        // optional
        AExperiment.ExperimentAim:=ReadString(SEC_EXPERIMENT, KEY_AIM,'');

        // general configs
        AExperiment.ShowChat := ReadBool(SEC_EXPERIMENT, KEY_CHAT_FOR_PLAYERS, False);
        AExperiment.ResearcherCanPlay := ReadBool(SEC_EXPERIMENT, KEY_RESEARCHER_CANPLAY,False);
        AExperiment.ResearcherCanChat := ReadBool(SEC_EXPERIMENT, KEY_RESEARCHER_CANCHAT,False);
        AExperiment.GenPlayersAsNeeded := ReadBool(SEC_EXPERIMENT, KEY_GEN_PLAYER_AS_NEEDED,False);
        AExperiment.SendChatHistoryForNewPlayers := ReadBool(SEC_EXPERIMENT, KEY_CHAT_HISTORY_FOR_NEW_PLAYERS,False);
        AExperiment.ABPoints:= ReadBool(SEC_EXPERIMENT, KEY_POINTS_TYPE,False);
        AExperiment.MatrixType := GetMatrixTypeFromString(ReadString(SEC_EXPERIMENT,KEY_MATRIX_TYPE,DEF_MATRIX_TYPE));

        // used when loading from paused experiments
        AExperiment.CurrentConditionI := ReadInteger(SEC_EXPERIMENT, KEY_CURRENT_CONDITION,0); //zero based
      end;
  end;

  function ReadContingenciesCount(ACondition: integer;LC_KEY:String):integer;
  var
    LCK, LS: String;
  begin
    Result := 0;
    LS := SEC_CONDITION+IntToStr(ACondition+1);
    LCK := LC_KEY+IntToStr(Result+1);
    with LIniFile do
      while ValueExists(LS, LCK+KEY_CONT_NAME) and ValueExists(LS, LCK+KEY_CONSEQUE) and ValueExists(LS, LCK+KEY_CRITERIA)do
        begin
          Inc(Result);
          LCK := LC_KEY+IntToStr(Result+1);
        end;
  end;

  function ReadContingency(AConditionIndex:integer; LCK:string) : TContingency;
  var
    LS : string;
    LConsequence : TConsequence;
    LCriteria:TCriteria;

  begin
    LS := SEC_CONDITION+IntToStr(AConditionIndex+1);
    with LIniFile do
      begin
        LConsequence := TConsequence.Create(AExperiment,
          ReadString(LS, LCK+KEY_CONSEQUE, ''),
          ReadString(LS, LCK+KEY_CONSEQUE_MESSAGE_PREPEND,''),
          ReadString(LS, LCK+KEY_CONSEQUE_MESSAGE_PREPEND_LOSS,''),
          ReadString(LS, LCK+KEY_CONSEQUE_MESSAGE_APPEND_LOSS_S,''),
          ReadString(LS, LCK+KEY_CONSEQUE_MESSAGE_APPEND_LOSS_P,''),
          ReadString(LS, LCK+KEY_CONSEQUE_MESSAGE_PREPEND_EARN,''),
          ReadString(LS, LCK+KEY_CONSEQUE_MESSAGE_APPEND_EARN_S,''),
          ReadString(LS, LCK+KEY_CONSEQUE_MESSAGE_APPEND_EARN_P,''),
          ReadString(LS, LCK+KEY_CONSEQUE_MESSAGE_APPEND_ZERO, '')
        );

        LCriteria := GetCriteriaFromString(ReadString(LS, LCK+KEY_CRITERIA, ''));
        Result := TContingency.Create(AExperiment,LConsequence,LCriteria,Pos(KEY_METACONTINGENCY,LCK)>0);
        Result.ContingencyName := ReadString(LS, LCK+KEY_CONT_NAME, LCK);
        Result.Style:= GetPromptStyleFromString(ReadString(LS,LCK+KEY_STYLE,''));
      end;
  end;

  procedure ReadConditions;
  var
    s1, LS , LPromptStyle, LPromptMessa,LPromptTarget: string;
    i,j , LContingenciesCount, LMetaContingenCount: integer;
    C :TCondition;
  begin
    i := 0;
    LS := SEC_CONDITION+IntToStr(i+1);
    with LIniFile do
      while SectionExists(LS) do
        begin
          with C do
            begin
              ConditionName := ReadString(LS,KEY_COND_NAME,LS);
              Points.Count := GetPointsFromString(ReadString(LS, KEY_POINTS_COUNT,DEF_POINTS));

              if AExperiment.ABPoints then
                begin
                  Points.OnStart.A := ReadInteger(LS, KEY_POINTS_ONSTART_A,0);
                  Points.OnStart.B := ReadInteger(LS, KEY_POINTS_ONSTART_B,0);
                  Points.OnStart.G1 := ReadInteger(LS, KEY_POINTS_ONSTART_G1,0);
                  Points.OnStart.G2 := ReadInteger(LS, KEY_POINTS_ONSTART_G2,0);
                end
              else
                begin
                  Points.OnStart.A := ReadInteger(LS, KEY_POINTS_ONSTART_I,0);
                  Points.OnStart.G1 := ReadInteger(LS, KEY_POINTS_ONSTART_G1,0);
                  Points.OnStart.G2 := ReadInteger(LS, KEY_POINTS_ONSTART_G2,0);
                end;

              Turn.Count:= ReadInteger(LS, KEY_TURN_COUNT,0);
              Turn.Value:= ReadInteger(LS, KEY_TURN_VALUE,2);
              Turn.Random:= ReadBool(LS, KEY_TURN_RANDOM,False);
              Cycles.Count:= ReadInteger(LS, KEY_CYCLES_COUNT,0);
              Cycles.Value:= ReadInteger(LS, KEY_CYCLES_VALUE,10);
              Cycles.Generation:= ReadInteger(LS, KEY_CYCLES_GEN,0);
              EndCriterium.Style := GetEndCriteriaStyleFromString(ReadString(LS,KEY_ENDCRITERIA,DEF_END_CRITERIA_STYLE));
              EndCriterium.AbsoluteCycles:=ReadInteger(LS,KEY_ENDCRITERIA_CYCLES,20);
              s1 := ReadString(LS,KEY_ENDCRITERIA_PORCENTAGE,DEF_END_CRITERIA_PORCENTAGE);
              EndCriterium.InterlockingPorcentage:= GetEndCriteriaPorcentageFromString(s1);
              EndCriterium.LastCycles:= GetEndCriteriaLastCyclesFromString(s1);

              LContingenciesCount := ReadContingenciesCount(i,KEY_CONTINGENCY);
              LMetaContingenCount := ReadContingenciesCount(i,KEY_METACONTINGENCY);

              if LContingenciesCount > 0 then
                for j := 0 to LContingenciesCount-1 do
                  begin
                    SetLength(Contingencies,Length(Contingencies)+1);
                    Contingencies[Length(Contingencies)-1] := ReadContingency(i,KEY_CONTINGENCY+IntToStr(j+1));
                  end;

              if LMetaContingenCount > 0 then;
                for j := 0 to LMetaContingenCount-1 do
                  begin
                    SetLength(Contingencies,Length(Contingencies)+1);
                    Contingencies[Length(Contingencies)-1] := ReadContingency(i,KEY_METACONTINGENCY+IntToStr(j+1));
                  end;

              LPromptStyle := ReadString(LS,KEY_PROMPT_STYLE,'');
              LPromptMessa := ReadString(LS,KEY_PROMPT_MESSAGE,'');
              LPromptTarget := ReadString(LS,KEY_PROMPT_TARGET,'');
              if (LPromptMessa <> '') and
                 (LPromptStyle <> '') and
                 (LPromptTarget <> '') then
                Prompt := TPrompt.Create(
                  AExperiment
                  , GetPromptStyleFromString(LPromptStyle)
                  , Contingencies
                  , LPromptMessa
                  , LPromptTarget
                );
            end;
            AExperiment.Condition[AExperiment.AppendCondition]:= C;
            Inc(i);
            SetLength(C.Contingencies,0);
            C := C_CONDITION_TEMPLATE;
            LS := SEC_CONDITION+IntToStr(i+1);
        end;
  end;

  procedure ReadPlayers;
  var
    LS : string;
    i : integer;
    P : TPlayer;
  begin
    i := 0;
    LS := SEC_PLAYER+IntToStr(i+1);
    with LIniFile do
      while SectionExists(LS) do
        begin
          if i = 0 then
            i := AExperiment.AppendPlayer;
          with P do
            begin
              Turn := ReadInteger(LS,KEY_PLAYER_TURN,i);
              Choice := GetChoiceFromString(ReadString(LS,KEY_PLAYER_CHOICE_LAST,'0,NONE,'));
              ID := ReadString(LS,KEY_PLAYER_ID,'ID');
              Nicname := ReadString(LS,KEY_PLAYER_NICNAME,GenResourceName(i));
              Points := GetPPointsFromString(ReadString(LS,KEY_PLAYER_POINTS,'0,0,'));
              // currently not in use
              //Login := ReadString(LS,KEY_PLAYER_LOGIN,'jogador'+IntToStr(i+1));
              //Password := ReadString(LS,KEY_PLAYER_PASSWORD,'1234');
              //Status := GetStatusFromString(ReadString(LS,KEY_PLAYER_STATUS,'esperando'));
              //Data.Values[KEY_PLAYER_TEMP] := ReadString(LS,KEY_PLAYER_TEMP,'');
            end;
          AExperiment.Player[i] := P;
          i := AExperiment.AppendPlayer;
          LS := SEC_PLAYER+IntToStr(i+1);
        end;
  end;

begin
  Result := False;
  if FileExists(AFileName) then
    begin
      LIniFile:= TIniFile.Create(AFileName);
      with LIniFile do
        if SectionExists(SEC_EXPERIMENT) then
          begin
            ReadExperiment;
            ReadConditions;
            ReadPlayers;

            with AExperiment do
              if ConditionsCount > 0 then
                for i := 0 to ConditionsCount-1 do
                  if ContingenciesCount[i] > 0 then
                    Continue
                  else
                    begin
                      ShowMessage(ERROR_NO_CONTINGENCIES+SEC_CONDITION+IntToStr(i+1));
                      LIniFile.Free;
                      Exit;
                    end
              else
                begin
                  ShowMessage(ERROR_NO_CONDITIONS);
                  LIniFile.Free;
                  Exit;
                end;
            Result := True;
            AExperiment.CurrentConditionI:=0;
          end
        else
          ShowMessage(ERROR_SECTION_NOT_FOUND+SEC_EXPERIMENT);

      LIniFile.Free;
    end
  else
    ShowMessage(ERROR_FILE_NOT_FOUND);
end;

procedure SaveExperimentToFile(AExperiment: TExperiment; AFilename: string);
var
  i,j , MI, CI: Integer;
  LWriter : TRegData;
  LIniFile : TIniFile;
  LC,
  LCK : string;

begin
  LWriter := TRegData.Create(nil,AFilename);
  LIniFile:= TIniFile.Create(LWriter.FileName);
  LWriter.Free;

  // write experiment
  with LIniFile do
    begin
      WriteString(SEC_EXPERIMENT, KEY_RESEARCHER, AExperiment.Researcher);
      WriteString(SEC_EXPERIMENT, KEY_NAME, AExperiment.ExperimentName);
      WriteString(SEC_EXPERIMENT, KEY_AIM, AExperiment.ExperimentAim);
      WriteBool(SEC_EXPERIMENT, KEY_CHAT_FOR_PLAYERS, AExperiment.ShowChat);
      WriteBool(SEC_EXPERIMENT, KEY_RESEARCHER_CANPLAY, AExperiment.ResearcherCanPlay);
      WriteBool(SEC_EXPERIMENT, KEY_RESEARCHER_CANCHAT, AExperiment.ResearcherCanChat);
      WriteBool(SEC_EXPERIMENT, KEY_GEN_PLAYER_AS_NEEDED, AExperiment.GenPlayersAsNeeded);
      WriteBool(SEC_EXPERIMENT, KEY_CHAT_HISTORY_FOR_NEW_PLAYERS, AExperiment.SendChatHistoryForNewPlayers);
      WriteBool(SEC_EXPERIMENT, KEY_POINTS_TYPE, AExperiment.ABPoints);
      WriteString(SEC_EXPERIMENT,KEY_MATRIX_TYPE,GetMatrixTypeString(AExperiment.MatrixType));
      WriteInteger(SEC_EXPERIMENT, KEY_CURRENT_CONDITION, AExperiment.CurrentConditionI);
    end;

  with LIniFile do // write conditions
    for i := 0 to AExperiment.ConditionsCount-1 do
      begin
        LC := SEC_CONDITION+IntToStr(i+1);
        with AExperiment.Condition[i] do
          begin
            WriteString(LC,KEY_ENDCRITERIA,GetEndCriteriaString(EndCriterium));
            WriteString(LC, KEY_POINTS_COUNT,GetPointsString(Points.Count));
            if AExperiment.ABPoints then
              begin
                WriteInteger(LC, KEY_POINTS_ONSTART_A,Points.OnStart.A);
                WriteInteger(LC, KEY_POINTS_ONSTART_B,Points.OnStart.B);
                WriteInteger(LC, KEY_POINTS_ONSTART_G1,Points.OnStart.G1);
                WriteInteger(LC, KEY_POINTS_ONSTART_G2,Points.OnStart.G2);
              end
            else
              begin
                WriteInteger(LC, KEY_POINTS_ONSTART_I,Points.OnStart.A);
                WriteInteger(LC, KEY_POINTS_ONSTART_G1,Points.OnStart.G1);
                WriteInteger(LC, KEY_POINTS_ONSTART_G2,Points.OnStart.G2);
              end;
            WriteInteger(LC, KEY_TURN_COUNT,Turn.Count);
            WriteInteger(LC, KEY_TURN_VALUE,Turn.Value);
            WriteBool(LC, KEY_TURN_RANDOM,Turn.Random);
            WriteInteger(LC, KEY_CYCLES_COUNT,Cycles.Count);
            WriteInteger(LC, KEY_CYCLES_VALUE,Cycles.Value);
            WriteInteger(LC, KEY_CYCLES_GEN,Cycles.Generation);
            if Assigned(Prompt) then
              begin
                WriteString(LC, KEY_PROMPT_MESSAGE, Prompt.Question);
                WriteString(LC, KEY_PROMPT_STYLE, GetPromptStyleString(Prompt.PromptStyle));
              end;

            MI := 0;
            CI := 0;
            for j := 0 to High(Contingencies) do // write contingencies
              begin
                if Contingencies[j].Meta then
                  begin
                    LCK := KEY_METACONTINGENCY+IntToStr(MI+1);
                    Inc(MI);
                  end
                else
                  begin
                    LCK := KEY_CONTINGENCY+IntToStr(CI+1);
                    Inc(CI);
                  end;

                with Contingencies[j] do
                  begin
                    WriteString(LC,LCK+KEY_CONT_NAME, ContingencyName);
                    WriteString(LC,LCK+KEY_CONSEQUE,Consequence.CsqString);
                    WriteString(LC,LCK+KEY_CONSEQUE_MESSAGE_PREPEND,Consequence.Prepend);
                    WriteString(LC,LCK+KEY_CONSEQUE_MESSAGE_PREPEND_LOSS,Consequence.PrependLoss);
                    WriteString(LC,LCK+KEY_CONSEQUE_MESSAGE_APPEND_LOSS_S,Consequence.AppendiceLossSingular);
                    WriteString(LC,LCK+KEY_CONSEQUE_MESSAGE_APPEND_LOSS_P,Consequence.AppendiceLossPlural);
                    WriteString(LC,LCK+KEY_CONSEQUE_MESSAGE_PREPEND_EARN,Consequence.PrependEarn);
                    WriteString(LC,LCK+KEY_CONSEQUE_MESSAGE_APPEND_EARN_S,Consequence.AppendiceEarnSingular);
                    WriteString(LC,LCK+KEY_CONSEQUE_MESSAGE_APPEND_EARN_P,Consequence.AppendiceEarnPlural);
                    WriteString(LC,LCK+KEY_CONSEQUE_MESSAGE_APPEND_ZERO, Consequence.AppendiceZero);
                    WriteString(LC,LCK+KEY_CRITERIA,CriteriaString);
                    WriteString(LC,LCK+KEY_STYLE, GetPromptStyleString(Style));
                  end;
              end;
          end;
      end;

  with LIniFile do
    if AExperiment.PlayersCount > 0 then
      for i:=0 to AExperiment.PlayersCount-1 do
        with AExperiment.Player[i] do
          begin
            LC := SEC_PLAYER+IntToStr(i+1);
            WriteString(LC,KEY_PLAYER_ID,AExperiment.Player[i].ID);
            WriteString(LC,KEY_PLAYER_NICNAME,AExperiment.Player[i].Nicname);
            WriteInteger(LC,KEY_PLAYER_TURN,AExperiment.Player[i].Turn);
            WriteString(LC,KEY_PLAYER_CHOICE_LAST,GetChoiceString(AExperiment.Player[i].Choice));
            WriteString(LC,KEY_PLAYER_POINTS,GetPPointsString(AExperiment.Player[i].Points));
            //WriteString(LC,KEY_PLAYER_LOGIN,AExperiment.Player[i].Login);
            //WriteString(LC,KEY_PLAYER_PASSWORD,AExperiment.Player[i].Password);
            //WriteString(LC,KEY_PLAYER_STATUS,GetStatusString(AExperiment.Player[i].Status));
            //WriteString(LC,KEY_PLAYER_TEMP,AExperiment.Player[i].Data.Values[KEY_PLAYER_TEMP]);
          end;
end;

end.

