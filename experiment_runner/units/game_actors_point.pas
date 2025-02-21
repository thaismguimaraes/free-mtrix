{
  Free-mtrix - Free cultural selection and social behavior experiments.
  Copyright (C) 2016-2017 Carlos Rafael Fernandes Picanço, Universidade Federal do Pará.

  The present file is distributed under the terms of the GNU General Public License (GPL v3.0).

  You should have received a copy of the GNU General Public License
  along with this program. If not, see <http://www.gnu.org/licenses/>.
}
unit game_actors_point;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type

  { TGamePoint }

  TGamePoint = class(TComponent)
  private
    FResult: integer;
    FValue,
    FVariation : integer;
    function GetResult: integer;
    function GetResultAsString: string;
    function GetValue: integer;
  public
    constructor Create(AOwner:TComponent;AValue : integer);overload;
    constructor Create(AOwner:TComponent;AValue : array of integer); overload;
    constructor Create(AOwner:TComponent;AResult : string); overload;
    function PointMessage(APrepend, APrependLoss, AAppendiceLossSingular,AAppendiceLossPlural,
      APrependEarn,AAppendiceEarnSingular,AAppendiceEarnPlural,AAppendiceZero: string; IsGroupPoint: Boolean) : string;
    property ValueWithVariation : integer read GetValue write FValue;
    property Value : integer read FValue;
    property Variation : integer read FVariation;
    property AsString : string read GetResultAsString;
    property ResultAsInteger : integer read GetResult;
  end;

//operator :=(I :integer) : TGamePoint;
//operator :=(A : array of integer):TGamePoint;

implementation

uses strutils;

//operator:=(I: integer):TGamePoint;
//begin
//  Result := ;
//  Result.Value := I;
//end;
//
//operator:=(A: array of integer): TGamePoint;
//begin
//  Result := TGamePoint.Create(A);
//end;

{ TCsqPoint }

function TGamePoint.GetValue: integer;
begin
  Result := FValue - FVariation + Random((2 * FVariation) + 1);
  FResult := Result;
end;

function TGamePoint.GetResult: integer;
begin
  Result := FResult;
end;

function TGamePoint.GetResultAsString: string;
begin
  Result := IntToStr(abs(FResult));
end;

constructor TGamePoint.Create(AOwner: TComponent; AValue: integer);
begin
  inherited Create(AOwner);
  FValue := AValue;
  FVariation:=0;
end;

constructor TGamePoint.Create(AOwner: TComponent; AValue: array of integer);
begin
  inherited Create(AOwner);
  FValue := AValue[0];
  FVariation := AValue[1];
end;

constructor TGamePoint.Create(AOwner: TComponent; AResult: string);
begin
  inherited Create(AOwner);
  FValue := 0;//does not matter here, this creation method is called by a player, result is sent by the admin
  FVariation := 0;
  FResult := StrToInt(AResult);
end;

function TGamePoint.PointMessage(APrepend,
  APrependLoss, AAppendiceLossSingular, AAppendiceLossPlural,
  APrependEarn, AAppendiceEarnSingular, AAppendiceEarnPlural,
  AAppendiceZero: string; IsGroupPoint: Boolean): string;

  procedure ReadCustomMessage;
  begin
    Result := APrepend;
    case FResult of
      -MaxInt..-2: Result += #32+APrependLoss+#32+Self.AsString+#32+AAppendiceLossPlural;
     -1 : Result += #32+APrependLoss+#32+Self.AsString+#32+AAppendiceLossSingular;
      0 : Result += #32+AAppendiceZero;
      1 : Result += #32+APrependEarn+#32+Self.AsString+#32+AAppendiceEarnSingular;
      2..MaxInt: Result += #32+APrependEarn+#32+Self.AsString+#32+AAppendiceEarnPlural;
    end;
  end;

  procedure ReadBuiltInGroupMessage;
  begin
    Result := 'Vocês';
    case FResult of
      -MaxInt..-2: Result += #32+'retiraram'+#32+Self.AsString+#32+'itens escolares de uma escola pública';
     -1 : Result += #32+'retiraram'+#32+Self.AsString+#32+'item escolar de uma escola pública';
      0 : Result += #32+'não doaram e nem retiraram itens escolares';
      1 : Result += #32+'doaram'+#32+Self.AsString+#32+'item escolar a uma escola pública';
      2..MaxInt: Result += #32+'doaram'+#32+Self.AsString+#32+'itens escolares a uma escola pública';
    end;
    Result += '.';
  end;

  procedure ReadBuiltInIndividualMessage;
  begin
    Result := '$NICNAME';
    case FResult of
      -MaxInt..-2: Result += #32+'perdeu'+#32+Self.AsString+#32+'pontos';
     -1 : Result += #32+'perdeu'+#32+Self.AsString+#32+'ponto';
      0 : Result += #32+'não perdeu nem ganhou pontos';
      1 : Result += #32+'ganhou'+#32+Self.AsString+#32+'ponto';
      2..MaxInt: Result += #32+'ganhou'+#32+Self.AsString+#32+'pontos';
    end;
    Result += '.';
  end;

begin
  if (APrepend <> '') then
    begin
      if (APrependLoss = '') and (AAppendiceLossSingular = '') and (AAppendiceLossPlural = '') and
         (APrependEarn = '') and (AAppendiceEarnSingular = '') and (AAppendiceEarnPlural = '') and
         (AAppendiceZero = '') then
        begin
          Result := APrepend;
          Exit;
        end;
      ReadCustomMessage;
      Exit;
    end;

  if (APrependLoss = '') and (AAppendiceLossSingular = '') and (AAppendiceLossPlural = '') and
     (APrependEarn = '') and (AAppendiceEarnSingular = '') and (AAppendiceEarnPlural = '') and
     (AAppendiceZero = '') and (APrepend = '') then
    begin
      if IsGroupPoint then
        ReadBuiltInGroupMessage
      else
        ReadBuiltInIndividualMessage;
    end;
end;


end.

