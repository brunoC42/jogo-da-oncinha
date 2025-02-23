program JogoDaOncinha;

uses
  Vcl.Forms,
  uFrmPrincipal in 'uFrmPrincipal.pas' {FrmPrincipal},
  uFrmConfiguracao in 'uFrmConfiguracao.pas' {FrmConfiguracao},
  uJogo in 'uJogo.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Jogo da Oncinha';
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
