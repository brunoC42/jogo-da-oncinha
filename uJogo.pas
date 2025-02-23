unit uJogo;

interface

uses SysUtils;

const
  PREGUICA = 0;
  ELEFANTE = 1;
  ARARA    = 2;
  CAPIVARA = 3;
  ONCA     = 4;

type
  TJogo = class
  private
     FPartidas: Integer;
     FVitorias: Integer;
     FSaldoJogador: Double;
     FSaldoCassino: Double;
     FTotalApostado: Double;
     FSorteio1: Integer;
     FSorteio2: Integer;
     FSorteio3: Integer;
     FGanhou: Boolean;

     {Configura��es}
     FPorcentagemVitoriaPreguica: Integer;
     FPorcentagemVitoriaElefante: Integer;
     FPorcentagemVitoriaArara: Integer;
     FPorcentagemVitoriaCapivara: Integer;
     FPorcentagemVitoriaOnca: Integer;
     FMultiplicadorPreguica: Double;
     FMultiplicadorElefante: Double;
     FMultiplicadorArara: Double;
     FMultiplicadorCapivara: Double;
     FMultiplicadorOnca: Double;
     FGarantirLucro: Boolean;
     FPorcentagemLucro: Integer;

     procedure AtualizarSaldo(AValor: Double);
     procedure VerificarVitoria(ASorteio: Integer; AAnimal: Integer; AValor: Double);
     constructor Create;
  public
     property PorcentagemVitoriaPreguica: Integer read FPorcentagemVitoriaPreguica write FPorcentagemVitoriaPreguica;
     property PorcentagemVitoriaElefante: Integer read FPorcentagemVitoriaElefante write FPorcentagemVitoriaElefante;
     property PorcentagemVitoriaArara: Integer read FPorcentagemVitoriaArara write FPorcentagemVitoriaArara;
     property PorcentagemVitoriaCapivara: Integer read FPorcentagemVitoriaCapivara write FPorcentagemVitoriaCapivara;
     property PorcentagemVitoriaOnca: Integer read FPorcentagemVitoriaOnca write FPorcentagemVitoriaOnca;
     property MultiplicadorPreguica: Double read FMultiplicadorPreguica write FMultiplicadorPreguica;
     property MultiplicadorElefante: Double read FMultiplicadorElefante write FMultiplicadorElefante;
     property MultiplicadorArara: Double read FMultiplicadorArara write FMultiplicadorArara;
     property MultiplicadorCapivara: Double read FMultiplicadorCapivara write FMultiplicadorCapivara;
     property MultiplicadorOnca: Double read FMultiplicadorOnca write FMultiplicadorOnca;
     property GarantirLucro: Boolean read FGarantirLucro write FGarantirLucro;
     property PorcentagemLucro: Integer read FPorcentagemLucro write FPorcentagemLucro;

     procedure Jogar(AValor: Double);
     procedure AdicionarSaldoJogador(AValor: Double);
     function GetPartidas: Integer;
     function GetVitorias: Integer;
     function GetSaldoJogador: Double;
     function GetSaldoCassino: Double;
     function GetSorteio1: Integer;
     function GetSorteio2: Integer;
     function GetSorteio3: Integer;
     function GetGanhou: Boolean;

     class function GetInstancia: TJogo;
  end;

implementation

var
  FInstancia: TJogo;

{ TJogo }

procedure TJogo.AdicionarSaldoJogador(AValor: Double);
begin
  FSaldoJogador := FSaldoJogador + AValor;
end;

procedure TJogo.AtualizarSaldo(AValor: Double);
begin
  if not FGanhou then
  begin
    FTotalApostado := FTotalApostado + AValor;
    AValor := AValor * -1;
  end
  else if FGarantirLucro and ((FSaldoCassino - AValor) < ((FTotalApostado/100) * FPorcentagemLucro)) then
  begin
    FGanhou := False;
    Exit;
  end;

  FSaldoJogador := FSaldoJogador + AValor;
  FSaldoCassino := FSaldoCassino - AValor;
end;

constructor TJogo.Create;
begin
  FPartidas                   := 0;
  FVitorias                   := 0;
  FSaldoJogador               := 100;
  FSaldoCassino               := 0;
  FTotalApostado              := 0;

  {Utilizamos uma porcentagem de vit�ria inicial em 46%, vizando o lucro do cassino sobre esses 4% a mais de chance de derrota que de vit�ria}
  FPorcentagemVitoriaPreguica := 24;
  FPorcentagemVitoriaElefante := 10;
  FPorcentagemVitoriaArara    := 6;
  FPorcentagemVitoriaCapivara := 4;
  FPorcentagemVitoriaOnca     := 2;

  {
   Calculando que a probabilidade de vit�ria � 46/100 significa que para ficar equalizado o jogo (a longo prazo perdas e ganhos se equalizam)
   o multiplicador do ganho deve ter m�dia igual a 2,173913043478261. Se a m�dia for maior, a longo prazo os jogadores tendem a ter lucro maior que o cassino, e vice-versa.
   Portanto vamos buscar a m�dia de 2,17, com esse arredondamento j� garantimos uma pequena vantagem do cassino.

   A m�dia utilizada n�o pode ser a m�dia simples (a+b+c+d+e/5) pois cada animal tem probabilidades diferentes.
   Exemplo utilzando a m�dia simples:
      Utilizaremos os seguintes valores:
        Mult. Pregui�a = 5,42
        Mult. Elefante = 2,71
        Mult. Arara    = 1,36
        Mult. Capivara = 1,33
        Mult. On�a     = 1
      Se fizermos a m�dia simples veremos que resulta em 2.17, por�m o animal com maior probabilidade tamb�m � o de maior multiplicador,
      o que gera um desbalanceamento em favor do jogador.

   Por isso neste caso devemos utilizar a m�dia ponderada, levando em conta a probabilidade de cada animal, da seguinte forma:
   ((24*a)+(10*b)+(6*c)+(4*d)+(2*e))/46 = 2,17

   Testando alguns valores cheguei a uma configura��o que atende bem o caso:
        Mult. Pregui�a = 1,2
        Mult. Elefante = 1,5
        Mult. Arara    = 3
        Mult. Capivara = 5
        Mult. On�a     = 9
     Com esses valores chegamos na m�dia 2,1696 que � bem pr�ximo do ponto de equil�brio (2,173913043478261)  por�m abaixo, o que favorece o cassino � longo prazo

   Lembrando que esses multiplicadores s�o para as probabilidades iniciais, ao mudar as probabilidades os multiplicadores tamb�m precisam ser repensados
   }

  FMultiplicadorPreguica      := 1.2;
  FMultiplicadorElefante      := 1.5;
  FMultiplicadorArara         := 3;
  FMultiplicadorCapivara      := 5;
  FMultiplicadorOnca          := 9;

  FGarantirLucro              := False;
  FPorcentagemLucro           := 0;
end;

function TJogo.GetGanhou: Boolean;
begin
  Result := FGanhou;
end;

class function TJogo.GetInstancia: TJogo;
begin
  if not Assigned(FInstancia) then
  begin
    FInstancia := TJogo.Create;
  end;

  result := FInstancia;
end;

function TJogo.GetPartidas: Integer;
begin
  Result := FPartidas;
end;

function TJogo.GetSaldoCassino: Double;
begin
  Result := FSaldoCassino;
end;

function TJogo.GetSaldoJogador: Double;
begin
  Result := FSaldoJogador;
end;

function TJogo.GetSorteio1: Integer;
begin
  Result := FSorteio1;
end;

function TJogo.GetSorteio2: Integer;
begin
  Result := FSorteio2;
end;

function TJogo.GetSorteio3: Integer;
begin
  Result := FSorteio3;
end;

function TJogo.GetVitorias: Integer;
begin
  Result := FVitorias;
end;

procedure TJogo.Jogar(AValor: Double);
var
  LSorteioPrincipal, LAnimal: Integer;
begin
  if FSaldoJogador < AValor then //Se n�o tem saldo lan�a uma exce��o
  begin
    raise Exception.Create('Saldo Insuficiente!');
  end;

  FGanhou := False;
  AtualizarSaldo(AValor);//Desconta o valor apostado do jogador e soma no saldo do cassino
  inc(FPartidas);

  {Sorteia de 0 a 99, soma 1 s� pra facilitar eliminando o 0 ficando de 1 a 100
   � usado o 100 para facilitar no calculo de probabilidade por porcentagem.
   Este sorteio � o que realmente define se ganhou ou n�o ganhou}
  LSorteioPrincipal := Random(100) + 1;

  for LAnimal := PREGUICA to ONCA do //for de 0 a 4, usando as constantes dos animais pra facilitar
  begin
    VerificarVitoria(LSorteioPrincipal, LAnimal, AValor);
  end;

  {Se n�o ganhou sorteia n�meros aleat�rios de 0 a 4 (cada um representando um animal),
   por�m se sortear iguais repete at� sortear diferentes, para evitar uma vit�ria n�o planejada que mudaria as probabilidades definidas.
   Este sorteio � apenas demonstrativo para mostrar ao apostador que ele perdeu, os animais sorteados n�o interferem em nada no resultado}
  if not(FGanhou) then
  begin
    repeat
      FSorteio1 := Random(5);
      FSorteio2 := Random(5);
      FSorteio3 := Random(5);
    until not((FSorteio1 = FSorteio2) and (FSorteio2 = FSorteio3));
  end;

end;

procedure TJogo.VerificarVitoria(ASorteio: Integer; AAnimal: Integer; AValor: Double);
var
  LPorcentagem, LSomaPorcentagensAnteriores: Integer;
  LMultiplicador: Double;
begin
  {Essa parte do c�digo � onde verifica se ganhou ou n�o, e qual foi o animal sorteado.
   Nesta parte utilizamos as porcentagens de chance de vit�ria definidas nas configura��es da seguinte forma:
   Exemplo: Se as chances de vit�ria est�o configuradas da seguinte forma:
            - Pregui�a = 24%
            - Elefante = 10%
            - Arara = 6%
            - Capivara = 4%
            - On�a = 2%
      Logo somando as porcentagens percebemos que existe uma chance de vit�ria de 46%, ent�o a chance de derrota � 54%.
      Portanto:
            - Se o n�mero sorteado for entre 1 e 24, ser� vit�ria com o animal Pregui�a; (24 n�meros ou seja 24% visto que foi sorteado de 1 a 100)
            - Se o n�mero sorteado for entre 25 e 34, ser� vit�ria com o animal Elefante; (10 n�meros ou 10%)
            - Se o n�mero sorteado for entre 35 e 40, ser� vit�ria com o animal Arara; (6 n�meros ou 6%)
            - Se o n�mero sorteado for entre 41 e 44, ser� vit�ria com o animal Capivara; (4 n�meros ou 4%)
            - Se o n�mero sorteado for entre 45 e 46, ser� vit�ria com o animal On�a; (2 n�meros ou 2%)}

  if FGanhou then //Se ganhou significa que na valida��o de um animal anterior j� foi marcado a vit�ria, ent�o sai do m�todo pra evitar processamento desnecess�rio
    Exit;

  LSomaPorcentagensAnteriores := 0;
  LPorcentagem                := 0;
  LMultiplicador              := 0;

  case AAnimal of
    PREGUICA: begin
                LSomaPorcentagensAnteriores := 0;
                LPorcentagem                := FPorcentagemVitoriaPreguica;
                LMultiplicador              := FMultiplicadorPreguica;
              end;

    ELEFANTE: begin
                LSomaPorcentagensAnteriores := FPorcentagemVitoriaPreguica;
                LPorcentagem                := LSomaPorcentagensAnteriores + FPorcentagemVitoriaElefante;
                LMultiplicador              := FMultiplicadorElefante;
              end;

    ARARA:    begin
                 LSomaPorcentagensAnteriores := FPorcentagemVitoriaPreguica + FPorcentagemVitoriaElefante;
                 LPorcentagem                := LSomaPorcentagensAnteriores + FPorcentagemVitoriaArara;
                 LMultiplicador              := FMultiplicadorArara;
              end;

    CAPIVARA: begin
                LSomaPorcentagensAnteriores := FPorcentagemVitoriaPreguica + FPorcentagemVitoriaElefante + FPorcentagemVitoriaArara;
                LPorcentagem                := LSomaPorcentagensAnteriores + FPorcentagemVitoriaCapivara;
                LMultiplicador              := FMultiplicadorCapivara;
              end;

    ONCA:     begin
                LSomaPorcentagensAnteriores := FPorcentagemVitoriaPreguica + FPorcentagemVitoriaElefante + FPorcentagemVitoriaArara + FPorcentagemVitoriaCapivara;
                LPorcentagem                := LSomaPorcentagensAnteriores + FPorcentagemVitoriaOnca;
                LMultiplicador              := FMultiplicadorOnca;
              end;
  end;

  if (ASorteio > LSomaPorcentagensAnteriores) and (ASorteio <= LPorcentagem) then
  begin
    FSorteio1 := AAnimal;
    FSorteio2 := AAnimal;
    FSorteio3 := AAnimal;
    FGanhou   := True;

    AtualizarSaldo(AValor * LMultiplicador);
    inc(FVitorias);
  end;
end;

end.
