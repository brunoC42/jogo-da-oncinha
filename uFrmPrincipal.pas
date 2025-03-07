unit uFrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, Vcl.Imaging.GIFImg, Vcl.MPlayer, Vcl.Buttons,
  Vcl.ColorGrd, System.UITypes, uJogo;

type
  TFrmPrincipal = class(TForm)
    lbSaldo: TLabel;
    imgOnca: TImage;
    imgArara: TImage;
    imgPreguica: TImage;
    imgElefante: TImage;
    imgCapivara: TImage;
    imgSorteio1: TImage;
    imgSorteio2: TImage;
    imgSorteio3: TImage;
    tmrAnimacaoImagem1: TTimer;
    tmrAnimacaoImagem2: TTimer;
    tmrAnimacaoImagem3: TTimer;
    imgFundo: TImage;
    spbApostar5: TSpeedButton;
    pnlApostar5: TPanel;
    pnlApostar10: TPanel;
    spbApostar10: TSpeedButton;
    pnlSaldo: TPanel;
    imgEstrelas1: TImage;
    imgEstrelas2: TImage;
    lbGanhouSombra: TLabel;
    lbGanhou: TLabel;
    pnlGanhou: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure tmrAnimacaoImagem1Timer(Sender: TObject);
    procedure tmrAnimacaoImagem2Timer(Sender: TObject);
    procedure tmrAnimacaoImagem3Timer(Sender: TObject);
    procedure spbApostar5Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure spbApostar10Click(Sender: TObject);
  private
    FAnimalImagem1, FAnimalImagem2, FAnimalImagem3: integer;
    FJogo: TJogo;

    procedure Jogar(AValor: Double);
    procedure AtualizaFoto(AImagem: TImage; ANumero: Integer);
    procedure Delay(MSec: Cardinal);
    procedure InicializarTimersAnimacaoImagem;
    procedure PararAnimacaoImagem(ATimer: TTimer; AImagem: TImage; AAnimalSorteado: Integer);
    procedure AtualizarVisualizacaoSaldo;
    procedure AnimacaoVitoria(ASaldoAnterior, ASaldoNovo: Double);
    procedure MostrarInformacoesCassino;
    function ProximoAnimalAnimacaoImagem(AImagem: TImage; AAnimalAtual: Integer): Integer;
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

uses uFrmConfiguracao;

procedure TFrmPrincipal.AnimacaoVitoria(ASaldoAnterior, ASaldoNovo: Double);
var
  LSomaAnimacao: Double;
begin
  pnlGanhou.Visible    := True;
  pnlApostar5.Visible  := False;
  pnlApostar10.Visible := False;

  {Feito dessa forma para que independente do valor ganho a anima��o fique com o tempo controlado, a divis�o controla isso,
   logo se dividir por 100 a anima��o ter� 100 passos, quanto maior o n�mero mais passos, logo mais demorado a anima��o}
  LSomaAnimacao := (ASaldoNovo - ASaldoAnterior)/100;

  while ASaldoAnterior < ASaldoNovo do
  begin
    delay(1);
    ASaldoAnterior := ASaldoAnterior + LSomaAnimacao;

    if ASaldoAnterior > ASaldoNovo then
      ASaldoAnterior := ASaldoNovo;

    lbSaldo.Caption := 'Saldo R$'+FormatFloat('0.00', ASaldoAnterior);
  end;

  pnlGanhou.Visible    := False;
  pnlApostar5.Visible  := True;
  pnlApostar10.Visible := True;
end;

procedure TFrmPrincipal.AtualizaFoto(AImagem: TImage; ANumero: Integer);
begin
  case ANumero of
    PREGUICA: AImagem.Picture := imgPreguica.Picture;
    ELEFANTE: AImagem.Picture := imgElefante.Picture;
    ARARA:    AImagem.Picture := imgArara.Picture;
    CAPIVARA: AImagem.Picture := imgCapivara.Picture;
    ONCA:     AImagem.Picture := imgOnca.Picture;
  end;
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
  Randomize;

  FJogo := TJogo.GetInstancia;
  AtualizarVisualizacaoSaldo;
end;

procedure TFrmPrincipal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F10 then
  begin
    FJogo.AdicionarSaldoJogador(StrToFloatDef(InputBox('Adicionar Saldo', 'Valor', EmptyStr), 0));
    AtualizarVisualizacaoSaldo;
  end;

  if Key = VK_F12 then
  begin
    FrmConfiguracao := TFrmConfiguracao.Create(Self);

    try
      FrmConfiguracao.ShowModal;
    finally
      FreeAndNil(FrmConfiguracao);
    end;
  end;

  if Key = VK_F11 then
    MostrarInformacoesCassino;
end;

procedure TFrmPrincipal.InicializarTimersAnimacaoImagem;
begin
  FAnimalImagem1 := PREGUICA;
  FAnimalImagem2 := ELEFANTE;
  FAnimalImagem3 := ARARA;

  tmrAnimacaoImagem1.Enabled := True;
  tmrAnimacaoImagem2.Enabled := True;
  tmrAnimacaoImagem3.Enabled := True;
end;

procedure TFrmPrincipal.Jogar(AValor: Double);
var
  LSaldoAntesJogo: Double;
begin
  spbApostar5.Enabled  := False;
  spbApostar10.Enabled := False;
  LSaldoAntesJogo      := FJogo.GetSaldoJogador;

  try
    try
      FJogo.Jogar(AValor);
    except
      on e: Exception do
      begin
        MessageDlg(e.Message, mtWarning, [mbOk], 0);
        Abort;
      end;
    end;

    InicializarTimersAnimacaoImagem;
    PararAnimacaoImagem(tmrAnimacaoImagem1, imgSorteio1, FJogo.GetSorteio1);
    PararAnimacaoImagem(tmrAnimacaoImagem2, imgSorteio2, FJogo.GetSorteio2);
    PararAnimacaoImagem(tmrAnimacaoImagem3, imgSorteio3, FJogo.GetSorteio3);

    if FJogo.GetGanhou then
      AnimacaoVitoria(LSaldoAntesJogo, FJogo.GetSaldoJogador);

    AtualizarVisualizacaoSaldo;
  finally
    spbApostar5.Enabled  := True;
    spbApostar10.Enabled := True;
  end;
end;

procedure TFrmPrincipal.MostrarInformacoesCassino;
var
  LPorcentagemVitorias: Double;
begin
  LPorcentagemVitorias := 0;

  if FJogo.GetPartidas > 0 then
    LPorcentagemVitorias := (FJogo.GetVitorias/FJogo.GetPartidas) * 100;

  ShowMessage('Saldo Cassino: R$' + FormatFloat('0.00', FJogo.GetSaldoCassino) + sLineBreak +
              'Partidas Jogadas: ' + IntToStr(FJogo.GetPartidas) + sLineBreak +
              'Vit�rias Jogador: ' + IntToStr(FJogo.GetVitorias) + sLineBreak +
              'Porcentagem Vit�rias: ' + FormatFloat('0.00', LPorcentagemVitorias) + '%');
end;

procedure TFrmPrincipal.PararAnimacaoImagem(ATimer: TTimer; AImagem: TImage; AAnimalSorteado: Integer);
begin
  Delay(1000);
  ATimer.Enabled := False;
  AtualizaFoto(AImagem, AAnimalSorteado);
end;

function TFrmPrincipal.ProximoAnimalAnimacaoImagem(AImagem: TImage; AAnimalAtual: Integer): Integer;
begin
  inc(AAnimalAtual);

  if AAnimalAtual > ONCA then
    AAnimalAtual := PREGUICA;

  AtualizaFoto(AImagem, AAnimalAtual);
  Result := AAnimalAtual;
end;

procedure TFrmPrincipal.spbApostar5Click(Sender: TObject);
begin
  Jogar(5);
end;

procedure TFrmPrincipal.spbApostar10Click(Sender: TObject);
begin
  Jogar(10);
end;

procedure TFrmPrincipal.AtualizarVisualizacaoSaldo;
begin
  lbSaldo.Caption := 'Saldo R$'+FormatFloat('0.00', FJogo.GetSaldoJogador);
end;

procedure TFrmPrincipal.Delay(MSec: Cardinal);
var
  Start: Cardinal;
begin
  Start := GetTickCount;
  repeat
    Application.ProcessMessages;
  until (GetTickCount - Start) >= MSec;
end;

procedure TFrmPrincipal.tmrAnimacaoImagem1Timer(Sender: TObject);
begin
  FAnimalImagem1 := ProximoAnimalAnimacaoImagem(imgSorteio1, FAnimalImagem1);
end;

procedure TFrmPrincipal.tmrAnimacaoImagem2Timer(Sender: TObject);
begin
  FAnimalImagem2 := ProximoAnimalAnimacaoImagem(imgSorteio2, FAnimalImagem2);
end;

procedure TFrmPrincipal.tmrAnimacaoImagem3Timer(Sender: TObject);
begin
  FAnimalImagem3 := ProximoAnimalAnimacaoImagem(imgSorteio3, FAnimalImagem3);
end;

end.
