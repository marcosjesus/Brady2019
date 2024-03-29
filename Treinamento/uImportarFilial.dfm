inherited FrmImportarFilial: TFrmImportarFilial
  Caption = 'Importar Arquivo de Filial '
  ClientHeight = 511
  ClientWidth = 874
  Position = poScreenCenter
  WindowState = wsMaximized
  ExplicitWidth = 890
  ExplicitHeight = 549
  PixelsPerInch = 96
  TextHeight = 13
  inherited PanFundo: TPanel
    Width = 874
    Height = 511
    ExplicitWidth = 874
    ExplicitHeight = 511
    object Bevel1: TBevel [0]
      Left = 60
      Top = 84
      Width = 740
      Height = 3
    end
    object Bevel2: TBevel [1]
      Left = 60
      Top = 181
      Width = 740
      Height = 3
    end
    inherited PanTitulo: TPanel
      Width = 870
      ExplicitWidth = 870
      inherited ImaBarraSup: TImage
        Width = 866
        ExplicitWidth = 866
      end
    end
    inherited ToolBar: TToolBar
      Top = 451
      Width = 870
      ExplicitTop = 451
      ExplicitWidth = 870
      inherited ButEscape: TcxButton
        Visible = False
      end
      inherited ButImprimir: TcxButton
        Visible = False
      end
    end
    inherited StatusBar: TdxStatusBar
      Top = 489
      Width = 870
      ExplicitTop = 489
      ExplicitWidth = 870
    end
    object cxGroupBox1: TcxGroupBox
      Left = 2
      Top = 4
      Align = alTop
      Caption = 
        'Layout do Arquivo de Texto ( Formato .CSV ) - Campos separados p' +
        'or ponto-v'#237'rgula (;)'
      TabOrder = 3
      Height = 77
      Width = 870
      object Label1: TLabel
        Left = 226
        Top = 40
        Width = 3
        Height = 13
        Caption = ';'
      end
      object Label2: TLabel
        Left = 368
        Top = 40
        Width = 3
        Height = 13
        Caption = ';'
      end
      object Label3: TLabel
        Left = 510
        Top = 40
        Width = 3
        Height = 13
        Caption = ';'
      end
      object Label4: TLabel
        Left = 652
        Top = 40
        Width = 3
        Height = 13
        Caption = ';'
      end
      object lblNome: TLabeledEdit
        Left = 87
        Top = 37
        Width = 137
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'Nome'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -10
        EditLabel.Font.Name = 'MS Sans Serif'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        ReadOnly = True
        TabOrder = 0
        Text = 'Tipo: Texto  - Tamanho: 40'
      end
      object lblCNPJ: TLabeledEdit
        Left = 232
        Top = 37
        Width = 135
        Height = 21
        EditLabel.Width = 32
        EditLabel.Height = 13
        EditLabel.Caption = 'CNPJ'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -10
        EditLabel.Font.Name = 'MS Sans Serif'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        ReadOnly = True
        TabOrder = 1
        Text = 'Tipo: Texto - Tamanho: 14'
      end
      object lblIE: TLabeledEdit
        Left = 373
        Top = 37
        Width = 136
        Height = 21
        EditLabel.Width = 13
        EditLabel.Height = 13
        EditLabel.Caption = 'IE'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -10
        EditLabel.Font.Name = 'MS Sans Serif'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        ReadOnly = True
        TabOrder = 2
        Text = 'Tipo: Texto - Tamanho: 12'
      end
      object lblMunicipio: TLabeledEdit
        Left = 516
        Top = 37
        Width = 134
        Height = 21
        EditLabel.Width = 55
        EditLabel.Height = 13
        EditLabel.Caption = 'Municipio'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -10
        EditLabel.Font.Name = 'MS Sans Serif'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        ReadOnly = True
        TabOrder = 3
        Text = 'Tipo: Texto - Tamanho: 50'
      end
      object lblUF: TLabeledEdit
        Left = 657
        Top = 37
        Width = 133
        Height = 21
        EditLabel.Width = 17
        EditLabel.Height = 13
        EditLabel.Caption = 'UF'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -10
        EditLabel.Font.Name = 'MS Sans Serif'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        ReadOnly = True
        TabOrder = 4
        Text = 'Tipo: Texto  - Tamanho: 2'
      end
    end
    object e: TcxGroupBox
      Left = 60
      Top = 108
      Caption = 'Localizar Arquivo'
      TabOrder = 4
      Height = 54
      Width = 740
      object edtArquivo: TEdit
        Left = 15
        Top = 17
        Width = 560
        Height = 21
        ReadOnly = True
        TabOrder = 0
      end
      object btnCaminho: TBitBtn
        Left = 581
        Top = 17
        Width = 75
        Height = 25
        Caption = 'Selecionar'
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 1
        OnClick = btnCaminhoClick
      end
      object BitBtn1: TBitBtn
        Left = 662
        Top = 17
        Width = 75
        Height = 25
        Caption = 'Limpar'
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 2
        OnClick = BitBtn1Click
      end
    end
    object BitBtn2: TBitBtn
      Left = 722
      Top = 188
      Width = 75
      Height = 25
      Caption = 'Importar'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 5
      OnClick = BitBtn2Click
    end
  end
  inherited DSGrid: TDataSource
    Left = 821
    Top = 262
  end
  inherited QGrid: TSQLQuery
    Left = 820
    Top = 126
  end
  inherited TimerCad: TTimer
    Left = 818
    Top = 58
  end
  inherited dspGrid: TDataSetProvider
    Left = 819
    Top = 172
  end
  inherited cdsGrid: TClientDataSet
    Left = 820
    Top = 216
  end
  object OpenDialog: TOpenDialog
    Filter = 'Arquivo Excel|*.xls'
    Left = 656
    Top = 160
  end
end
