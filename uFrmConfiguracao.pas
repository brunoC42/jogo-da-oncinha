unit uFrmConfiguracao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.WinXCtrls, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Mask;

type
  TFrmConfiguracao = class(TForm)
    edVitoriaPreguica: TEdit;
    edVitoriaElefante: TEdit;
    edVitoriaArara: TEdit;
    edVitoriaCapivara: TEdit;
    edVitoriaOnca: TEdit;
    pnPrincipal: TPanel;
    ckGarantirLucro: TCheckBox;
    btConfirmar: TButton;
    lbPorcentagemVitoria: TLabel;
    lbMultiplicador: TLabel;
    lbPreguica: TLabel;
    lbElefante: TLabel;
    lbArara: TLabel;
    lbCapivara: TLabel;
    lbOnca: TLabel;
    lbPorcentagemLucro: TLabel;
    mkedMultOnca: TMaskEdit;
    mkedMultCapivara: TMaskEdit;
    mkedMultArara: TMaskEdit;
    mkedMultElefante: TMaskEdit;
    mkedMultPreguica: TMaskEdit;
    edPorcentagemLucro: TEdit;
    gbGanho: TGroupBox;
    procedure FormShow(Sender: TObject);
    procedure btConfirmarClick(Sender: TObject);
  end;

var
  FrmConfiguracao: TFrmConfiguracao;

implementation

{$R *.dfm}

uses uJogo;

procedure TFrmConfiguracao.btConfirmarClick(Sender: TObject);
var
  LJogo: TJogo;
begin
  LJogo := TJogo.GetInstancia;

  LJogo.PorcentagemVitoriaPreguica := StrToInt(edVitoriaPreguica.Text);
  LJogo.PorcentagemVitoriaElefante := StrToInt(edVitoriaElefante.Text);
  LJogo.PorcentagemVitoriaArara    := StrToInt(edVitoriaArara.Text);
  LJogo.PorcentagemVitoriaCapivara := StrToInt(edVitoriaCapivara.Text);
  LJogo.PorcentagemVitoriaOnca     := StrToInt(edVitoriaOnca.Text);

  LJogo.MultiplicadorPreguica := StrToFloat(mkedMultPreguica.EditText);
  LJogo.MultiplicadorElefante := StrToFloat(mkedMultElefante.EditText);
  LJogo.MultiplicadorArara    := StrToFloat(mkedMultArara.EditText);
  LJogo.MultiplicadorCapivara := StrToFloat(mkedMultCapivara.EditText);
  LJogo.MultiplicadorOnca     := StrToFloat(mkedMultOnca.EditText);

  LJogo.GarantirLucro    := ckGarantirLucro.Checked;
  LJogo.PorcentagemLucro := StrToInt(edPorcentagemLucro.Text);
  close;
end;

procedure TFrmConfiguracao.FormShow(Sender: TObject);
var
  LJogo: TJogo;
begin
  LJogo := TJogo.GetInstancia;

  edVitoriaPreguica.Text := IntToStr(LJogo.PorcentagemVitoriaPreguica);
  edVitoriaElefante.Text := IntToStr(LJogo.PorcentagemVitoriaElefante);
  edVitoriaArara.Text    := IntToStr(LJogo.PorcentagemVitoriaArara);
  edVitoriaCapivara.Text := IntToStr(LJogo.PorcentagemVitoriaCapivara);
  edVitoriaOnca.Text     := IntToStr(LJogo.PorcentagemVitoriaOnca);

  mkedMultPreguica.EditText := FormatFloat('0.00', LJogo.MultiplicadorPreguica);
  mkedMultElefante.EditText := FormatFloat('0.00', LJogo.MultiplicadorElefante);
  mkedMultArara.EditText    := FormatFloat('0.00', LJogo.MultiplicadorArara);
  mkedMultCapivara.EditText := FormatFloat('0.00', LJogo.MultiplicadorCapivara);
  mkedMultOnca.EditText     := FormatFloat('0.00', LJogo.MultiplicadorOnca);

  ckGarantirLucro.Checked := LJogo.GarantirLucro;
  edPorcentagemLucro.Text := IntToStr(LJogo.PorcentagemLucro);
end;

end.
