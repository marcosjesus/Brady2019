inherited FrmContaSaldo: TFrmContaSaldo
  Caption = 'Lan'#231'amento de Saldo da Conta'
  ExplicitWidth = 750
  ExplicitHeight = 513
  PixelsPerInch = 96
  TextHeight = 13
  inherited PanFundo: TPanel
    inherited PanTitulo: TPanel
      Top = 29
      TabOrder = 4
      ExplicitTop = 29
    end
    inherited Panel27: TPanel
      TabOrder = 6
      inherited ButSalvar: TcxButton
        Top = 0
        ExplicitTop = 0
      end
      inherited ButCancelar: TcxButton
        Top = 0
        ExplicitTop = 0
      end
    end
    object Panel3: TPanel
      Tag = -1
      Left = 2
      Top = 31
      Width = 730
      Height = 27
      Alignment = taLeftJustify
      BevelInner = bvLowered
      Caption = ' N'#250'mero da Conta                                 '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object ediConta: TrsSuperEdit
        Tag = -1
        Left = 325
        Top = 4
        Width = 0
        Height = 22
        Hint = 'Conta'
        TagName = 'ECF_CONTA_ID'
        CT_NumFields = 0
        CT_RetField1 = 0
        CT_RetField2 = 0
        CT_Test = False
        CT_ConsTab = False
        CT_Search = False
        MaxLength = 4
        Text = ''
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Visible = False
      end
      object EditBuscaConta: TEditBusca
        Tag = -1
        Left = 112
        Top = 3
        Width = 169
        Height = 22
        TabOrder = 1
        ClickOnArrow = True
        ClickOnReturn = False
        bs_HeightForm = 0
        bs_WidthForm = 0
        bs_SetCPF = False
        bs_SetCNPJ = False
        bs_SetPlaca = False
        bs_LoadConsulta = False
        bs_Distinct = False
        bs_SetColor = False
        bs_NomeCor = clBlack
        bs_IndiceCampo = 0
        bs_Imagem = False
        bs_HideTop = False
        bs_Top100 = False
      end
    end
    object Panel1: TPanel
      Tag = -2
      Left = 2
      Top = 2
      Width = 730
      Height = 27
      Align = alTop
      Alignment = taLeftJustify
      BevelInner = bvLowered
      Caption = '  C'#243'digo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object EdiCodigo: TrsSuperEdit
        Tag = -2
        Left = 528
        Top = 2
        Width = 0
        Height = 22
        Hint = 'Clique com o bot'#227'o direito para Pesquisa (F1)'
        Alignment = taRightJustify
        TagName = 'ECF_CONTA_SALDO_ID'
        CT_Titulo = 'Localizar Cargo'
        CT_TableName = 'TRE_CARGO'
        CT_NumFields = 3
        CT_ColTit = 'C'#243'digo;Cargo'
        CT_ColField = 'TRE_CARGO_ID;DESCRICAO'
        CT_RetField1 = 0
        CT_RetControl1 = EdiCodigo
        CT_RetField2 = 2
        CT_Test = False
        CT_ConsTab = True
        CT_KeyValue = EdiCodigo
        CT_Search = False
        MaxLength = 20
        Text = ''
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 0
        Visible = False
      end
      object EditBuscaSaldoConta: TEditBusca
        Left = 112
        Top = 3
        Width = 169
        Height = 22
        TabOrder = 1
        OnClick = EditBuscaSaldoContaClick
        ClickOnArrow = True
        ClickOnReturn = False
        bs_HeightForm = 0
        bs_WidthForm = 0
        bs_SetCPF = False
        bs_SetCNPJ = False
        bs_SetPlaca = False
        bs_LoadConsulta = False
        bs_Distinct = False
        bs_SetColor = False
        bs_NomeCor = clBlack
        bs_IndiceCampo = 0
        bs_Imagem = False
        bs_HideTop = False
        bs_Top100 = False
      end
    end
    object Panel5: TPanel
      Tag = -1
      Left = 2
      Top = 58
      Width = 730
      Height = 27
      Alignment = taLeftJustify
      BevelInner = bvLowered
      Caption = '  Exerc'#237'cio  Fiscal          '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      object editxtDtRealizacao: TrsSuperEdit
        Tag = -1
        Left = 455
        Top = 3
        Width = 0
        Height = 22
        Format = foFullDate
        TagName = 'DT_EXERCICIOFISCAL'
        CT_NumFields = 0
        CT_RetField1 = 0
        CT_RetField2 = 0
        CT_Test = False
        CT_ConsTab = False
        CT_Search = False
        MaxLength = 10
        Text = '  /  /    '
        TabOrder = 0
      end
      object EdiDtExercicioFiscal: TcxDateEdit
        Left = 112
        Top = 3
        TabOrder = 1
        Width = 169
      end
    end
    object Panel6: TPanel
      Tag = -1
      Left = 2
      Top = 85
      Width = 730
      Height = 29
      Alignment = taLeftJustify
      BevelInner = bvLowered
      Caption = '  Saldo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      object editSaldo: TrsSuperEdit
        Tag = -1
        Left = 112
        Top = 4
        Width = 169
        Height = 22
        Alignment = taRightJustify
        Format = foCurrency
        TagName = 'SALDO'
        CT_NumFields = 0
        CT_RetField1 = 0
        CT_RetField2 = 0
        CT_Test = False
        CT_ConsTab = False
        CT_Search = False
        Text = ''
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
      object EditExercicio: TrsSuperEdit
        Tag = -1
        Left = 320
        Top = 8
        Width = 0
        Height = 22
        TagName = 'EXERCICIO'
        CT_NumFields = 0
        CT_RetField1 = 0
        CT_RetField2 = 0
        CT_Test = False
        CT_ConsTab = False
        CT_Search = False
        Text = ''
        TabOrder = 1
        Visible = False
      end
      object EditPeriodoFiscal: TrsSuperEdit
        Tag = -1
        Left = 472
        Top = 8
        Width = 0
        Height = 22
        TagName = 'PERIODO_FISCAL'
        CT_NumFields = 0
        CT_RetField1 = 0
        CT_RetField2 = 0
        CT_Test = False
        CT_ConsTab = False
        CT_Search = False
        Text = ''
        TabOrder = 2
        Visible = False
      end
    end
  end
  inherited TimerPerfil: TTimer
    Left = 578
    Top = 282
  end
  object QryAux: TFDQuery
    Connection = DB_Conect.FDConnection
    SQL.Strings = (
      
        'Select * From ECF_CONTA_SALDO Where NUMERO_CONTA = :NUMERO_CONTA' +
        ' and EXERCICIO = :EXERCICIO AND PERIODO_FISCAL = :PERIODO_FISCAL')
    Left = 456
    Top = 144
    ParamData = <
      item
        Name = 'NUMERO_CONTA'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'EXERCICIO'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'PERIODO_FISCAL'
        DataType = ftString
        ParamType = ptInput
      end>
  end
end
