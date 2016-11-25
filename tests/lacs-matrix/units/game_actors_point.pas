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
    procedure SetValue(AValue: integer);
  public
    //Cycles : integer; // specify when present points regarding condition cycles
    constructor Create(AOwner:TComponent;AValue : integer);overload;
    constructor Create(AOwner:TComponent;AValue : array of integer); overload;
    constructor Create(AOwner:TComponent;AValue : utf8string); overload;
    function PointMessage(APrepend, AAppendicePlural, AAppendiceSingular: string; IsGroupPoint: Boolean) : string;
    property Value : integer read GetValue write SetValue;
    property Variation : integer read FVariation write FVariation;
    property AsString : string read GetResultAsString;
    property ResultAsInteger : integer read GetResult;
  end;

//operator :=(I :integer) : TGamePoint;
//operator :=(A : array of integer):TGamePoint;
//
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
  Result := IntToStr(FResult);
end;

procedure TGamePoint.SetValue(AValue: integer);
begin
  FValue := AValue;
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

constructor TGamePoint.Create(AOwner: TComponent; AValue: utf8string);
begin
  FValue := StrToInt(ExtractDelimited(1,AValue,[',']));
  FVariation := StrToInt(ExtractDelimited(2,AValue,[',']));
end;

function TGamePoint.PointMessage(APrepend, AAppendicePlural, AAppendiceSingular: string; IsGroupPoint: Boolean): string;
begin
  Self.Value;
  if IsGroupPoint then
    begin
      if APrepend = '' then
        Result := 'Vocês'
      else
        Result := APrepend;

      if (AAppendiceSingular = '') or (AAppendicePlural = '') then
        begin
          case FValue of
            -MaxInt..-2: Result += ' produziram a perda de '+Self.AsString+ ' pontos para o grupo';
           -1 : Result += ' produziram a perda de  1 ponto para o grupo';
            0 : Result += ' pontos do grupo não foram produzidos nem perdidos';
            1 : Result += 'produziram 1 ponto para o grupo';
            2..MaxInt: Result += 'produziu '+Self.AsString+' pontos para o grupo'
          end;
        end
      else
        begin
          case FValue of
            -MaxInt..-2: Result += ' produziram a perda de '+Self.AsString+ ' ' + AAppendicePlural;
           -1 : Result += ' produziram a perda de  1'+ ' ' + AAppendiceSingular;
            0 : Result += ' não produziram ' + AAppendicePlural;
            1 : Result += ' produziram 1 ponto ' + AAppendiceSingular;
            2..MaxInt: Result += 'produziu '+Self.AsString+ ' ' + AAppendicePlural;
          end;
        end;
    end
  else
    begin
      if APrepend = '' then
        Result := 'Alguém'
      else
        Result := APrepend;

      if (AAppendiceSingular = '') or (AAppendicePlural = '') then
        begin
          case FValue of
            -MaxInt..-2: Result += ' perdeu '+Self.AsString+ ' pontos';
           -1 : Result += ' perdeu 1 ponto';
            0 : Result += ' não perdeu nem ganhou pontos';
            1 : Result += ' ganhou 1 ponto';
            2..MaxInt: Result += 'ganhou '+Self.AsString+' pontos'
          end;
        end
      else
        begin
          case FValue of
            -MaxInt..-2: Result += ' perdeu '+Self.AsString+ ' ' + AAppendicePlural;
           -1 : Result += ' ponto  1'+ ' ' + AAppendiceSingular;
            0 : Result += ' não perdeu nem ganhou ' + AAppendicePlural;
            1 : Result += ' ganhou 1 ponto ' + AAppendiceSingular;
            2..MaxInt: Result += 'ganhou '+Self.AsString+ ' ' + AAppendicePlural;
          end;
        end;
    end;
  Result += '.';
end;


end.

