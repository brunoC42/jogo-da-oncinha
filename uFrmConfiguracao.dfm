object FrmConfiguracao: TFrmConfiguracao
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Configura'#231#227'o'
  ClientHeight = 268
  ClientWidth = 200
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnPrincipal: TPanel
    Left = 0
    Top = 0
    Width = 200
    Height = 268
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object lbPorcentagemVitoria: TLabel
      Left = 61
      Top = 11
      Width = 44
      Height = 13
      Caption = '% Vit'#243'ria'
    end
    object lbMultiplicador: TLabel
      Left = 119
      Top = 11
      Width = 59
      Height = 13
      Caption = 'Multiplicador'
    end
    object lbPreguica: TLabel
      Left = 14
      Top = 33
      Width = 41
      Height = 13
      Caption = 'Pregui'#231'a'
    end
    object lbElefante: TLabel
      Left = 15
      Top = 60
      Width = 40
      Height = 13
      Caption = 'Elefante'
    end
    object lbArara: TLabel
      Left = 28
      Top = 87
      Width = 27
      Height = 13
      Caption = 'Arara'
    end
    object lbCapivara: TLabel
      Left = 12
      Top = 114
      Width = 43
      Height = 13
      Caption = 'Capivara'
    end
    object lbOnca: TLabel
      Left = 30
      Top = 141
      Width = 25
      Height = 13
      Caption = 'On'#231'a'
    end
    object edVitoriaPreguica: TEdit
      Left = 61
      Top = 30
      Width = 44
      Height = 21
      Alignment = taRightJustify
      NumbersOnly = True
      TabOrder = 0
    end
    object edVitoriaElefante: TEdit
      Left = 61
      Top = 57
      Width = 44
      Height = 21
      Alignment = taRightJustify
      NumbersOnly = True
      TabOrder = 2
    end
    object edVitoriaArara: TEdit
      Left = 61
      Top = 84
      Width = 44
      Height = 21
      Alignment = taRightJustify
      NumbersOnly = True
      TabOrder = 4
    end
    object edVitoriaCapivara: TEdit
      Left = 61
      Top = 111
      Width = 44
      Height = 21
      Alignment = taRightJustify
      NumbersOnly = True
      TabOrder = 6
    end
    object edVitoriaOnca: TEdit
      Left = 61
      Top = 138
      Width = 44
      Height = 21
      Alignment = taRightJustify
      NumbersOnly = True
      TabOrder = 8
    end
    object btConfirmar: TButton
      Left = 21
      Top = 233
      Width = 157
      Height = 25
      Caption = 'Confirmar Configura'#231#245'es'
      TabOrder = 11
      OnClick = btConfirmarClick
    end
    object mkedMultOnca: TMaskEdit
      Left = 119
      Top = 138
      Width = 59
      Height = 21
      Alignment = taRightJustify
      AutoSize = False
      TabOrder = 9
      Text = ''
    end
    object mkedMultCapivara: TMaskEdit
      Left = 119
      Top = 111
      Width = 59
      Height = 21
      Alignment = taRightJustify
      AutoSize = False
      TabOrder = 7
      Text = ''
    end
    object mkedMultArara: TMaskEdit
      Left = 119
      Top = 84
      Width = 59
      Height = 21
      Alignment = taRightJustify
      AutoSize = False
      TabOrder = 5
      Text = ''
    end
    object mkedMultElefante: TMaskEdit
      Left = 119
      Top = 57
      Width = 59
      Height = 21
      Alignment = taRightJustify
      AutoSize = False
      TabOrder = 3
      Text = ''
    end
    object mkedMultPreguica: TMaskEdit
      Left = 119
      Top = 30
      Width = 59
      Height = 21
      Alignment = taRightJustify
      AutoSize = False
      TabOrder = 1
      Text = ''
    end
    object gbGanho: TGroupBox
      Left = 6
      Top = 165
      Width = 187
      Height = 61
      Caption = 'Lucro do Cassino'
      TabOrder = 10
      object lbPorcentagemLucro: TLabel
        Left = 116
        Top = 14
        Width = 40
        Height = 13
        Caption = '% Lucro'
      end
      object ckGarantirLucro: TCheckBox
        Left = 7
        Top = 35
        Width = 92
        Height = 17
        Caption = 'Garantir Lucro'
        TabOrder = 0
      end
      object edPorcentagemLucro: TEdit
        Left = 113
        Top = 33
        Width = 59
        Height = 21
        Alignment = taRightJustify
        NumbersOnly = True
        TabOrder = 1
      end
    end
  end
end
