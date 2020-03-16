object frmConsultaDocumento: TfrmConsultaDocumento
  Left = 0
  Top = 0
  Caption = 'Consulta Documentos Fiscal ( NFe )'
  ClientHeight = 508
  ClientWidth = 937
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 937
    Height = 89
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label3: TLabel
      Left = 24
      Top = 7
      Width = 70
      Height = 13
      Caption = 'CNPJ Emitente'
    end
    object EditDocumento: TLabeledEdit
      Left = 24
      Top = 59
      Width = 185
      Height = 21
      EditLabel.Width = 88
      EditLabel.Height = 13
      EditLabel.Caption = 'Nr'#186' de Documento'
      TabOrder = 0
    end
    object GroupBox1: TGroupBox
      Left = 224
      Top = 7
      Width = 281
      Height = 73
      Caption = 'Data de Emiss'#227'o'
      TabOrder = 1
      object Label1: TLabel
        Left = 24
        Top = 24
        Width = 53
        Height = 13
        Caption = 'Data Inicial'
      end
      object Label2: TLabel
        Left = 151
        Top = 24
        Width = 48
        Height = 13
        Caption = 'Data Final'
      end
      object DataIni: TDateTimePicker
        Left = 23
        Top = 40
        Width = 106
        Height = 21
        Date = 43025.455392349540000000
        Time = 43025.455392349540000000
        TabOrder = 0
      end
      object DataFim: TDateTimePicker
        Left = 151
        Top = 40
        Width = 106
        Height = 21
        Date = 43025.455576562500000000
        Time = 43025.455576562500000000
        TabOrder = 1
      end
    end
    object EditCNPJ: TrsSuperEdit
      Tag = -2
      Left = 24
      Top = 22
      Width = 185
      Height = 21
      TagName = 'CTE_EMITENTE_ID'
      CT_Titulo = 'Localizar Emitente'
      CT_TableName = 'CTE_EMITENTE'
      CT_DataBaseName = 'DB_Conect.SQLConnection'
      CT_NumFields = 3
      CT_ColTit = 'Cnpj;Raz'#227'o Social;Nome Fantasia'
      CT_ColField = 'CNPJCPF;XNome;XFant'
      CT_RetField1 = 0
      CT_RetControl1 = EditCNPJ
      CT_RetField2 = 0
      CT_Test = False
      CT_ConsTab = True
      CT_KeyValue = EditCNPJ
      CT_Search = True
      TabOrder = 2
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 89
    Width = 937
    Height = 359
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    ExplicitTop = 95
    object Page: TPageControl
      Left = 1
      Top = 1
      Width = 935
      Height = 357
      ActivePage = TabNFES
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      ExplicitLeft = 0
      ExplicitTop = 6
      object TabNFES: TTabSheet
        Caption = 'NF-e Saida'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        object cxGrid1: TcxGrid
          Left = 0
          Top = 0
          Width = 927
          Height = 329
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          PopupMenu = PopupMenu1
          TabOrder = 0
          object cxGrid1DBTableView1: TcxGridDBTableView
            OnDblClick = cxGrid1DBTableView1DblClick
            NavigatorButtons.ConfirmDelete = False
            DataController.DataSource = dsConsultaNFES
            DataController.DetailKeyFieldNames = 'cCT'
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <
              item
                Format = '##,##0.00'
                Kind = skSum
                FieldName = 'Valor'
                Column = cxGrid1DBTableView1Valor
              end>
            DataController.Summary.SummaryGroups = <>
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.Footer = True
            OptionsView.GroupByBox = False
            object cxGrid1DBTableView1Numero: TcxGridDBColumn
              Caption = 'Nr'#186' Documento'
              DataBinding.FieldName = 'cCT'
              Width = 75
            end
            object cxGrid1DBTableView1TipoNF: TcxGridDBColumn
              Caption = 'Origem'
              DataBinding.FieldName = 'TipoNF'
              Width = 43
            end
            object cxGrid1DBTableView1Serie: TcxGridDBColumn
              Caption = 'S'#233'rie'
              DataBinding.FieldName = 'Serie'
              Width = 40
            end
            object cxGrid1DBTableView1Valor: TcxGridDBColumn
              Caption = 'Valor R$'
              DataBinding.FieldName = 'Valor'
              Width = 90
            end
            object cxGrid1DBTableView1dhEmi: TcxGridDBColumn
              Caption = 'Data de Emiss'#227'o'
              DataBinding.FieldName = 'dhEmi'
              Width = 132
            end
            object cxGrid1DBTableView1NatOp: TcxGridDBColumn
              Caption = 'Natureza de Opera'#231#227'o'
              DataBinding.FieldName = 'NatOp'
              Width = 200
            end
            object cxGrid1DBTableView1UF: TcxGridDBColumn
              DataBinding.FieldName = 'UF'
            end
            object cxGrid1DBTableView1CNPJEmitente: TcxGridDBColumn
              Caption = 'CNPJ Emitente'
              DataBinding.FieldName = 'CNPJEmitente'
              Width = 95
            end
            object cxGrid1DBTableView1Emitente: TcxGridDBColumn
              Caption = 'Raz'#227'o Social Emitente'
              DataBinding.FieldName = 'Emitente'
              Width = 140
            end
            object cxGrid1DBTableView1DESC_PLANTA: TcxGridDBColumn
              Caption = 'Planta'
              DataBinding.FieldName = 'FILIAL'
              Width = 55
            end
            object cxGrid1DBTableView1CNPJDEstinatario: TcxGridDBColumn
              Caption = 'CNPJ Destinatario'
              DataBinding.FieldName = 'CNPJDEstinatario'
              Width = 95
            end
            object cxGrid1DBTableView1Destinatario: TcxGridDBColumn
              Caption = 'Raz'#227'o Social Destinatario'
              DataBinding.FieldName = 'Destinatario'
              Width = 140
            end
            object cxGrid1DBTableView1CHAVE: TcxGridDBColumn
              Caption = 'Chave'
              DataBinding.FieldName = 'CHCTE'
              Width = 279
            end
            object cxGrid1DBTableView1Observacao: TcxGridDBColumn
              Caption = 'Observa'#231#227'o'
              DataBinding.FieldName = 'Observacao'
            end
          end
          object cxGrid1DBTableView2: TcxGridDBTableView
            NavigatorButtons.ConfirmDelete = False
            DataController.DataSource = dsItens
            DataController.DetailKeyFieldNames = 'NumNF'
            DataController.KeyFieldNames = 'Chaveseq'
            DataController.MasterKeyFieldNames = 'cCT'
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <
              item
                Format = '##,##0.00'
                Kind = skSum
                FieldName = 'ValorTotal'
                Column = cxGrid1DBTableView2ValorTotal
              end
              item
                Format = '##,##0.00'
                Kind = skSum
                FieldName = 'ValorICMS'
                Column = cxGrid1DBTableView2ValorICMS
              end
              item
                Format = '##,##0.00'
                Kind = skSum
                FieldName = 'ValorIPI'
                Column = cxGrid1DBTableView2ValorIPI
              end
              item
                Format = '##,##0.00'
                Kind = skSum
                FieldName = 'ValorPIS'
                Column = cxGrid1DBTableView2ValorPIS
              end
              item
                Format = '##,##0.00'
                Kind = skSum
                FieldName = 'ValorCofins'
                Column = cxGrid1DBTableView2ValorCofins
              end
              item
                Format = '##,##0.00'
                Kind = skSum
                FieldName = 'ValorFrete'
                Column = cxGrid1DBTableView2ValorFrete
              end
              item
                Format = '##,##0.00'
                Kind = skSum
                FieldName = 'ValorDesconto'
                Column = cxGrid1DBTableView2ValorDesconto
              end>
            DataController.Summary.SummaryGroups = <>
            OptionsView.Footer = True
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            object cxGrid1DBTableView2Chaveseq: TcxGridDBColumn
              DataBinding.FieldName = 'Chaveseq'
            end
            object cxGrid1DBTableView2CodFilial: TcxGridDBColumn
              DataBinding.FieldName = 'CodFilial'
            end
            object cxGrid1DBTableView2CodFornecedor: TcxGridDBColumn
              DataBinding.FieldName = 'CodFornecedor'
            end
            object cxGrid1DBTableView2NumNF: TcxGridDBColumn
              DataBinding.FieldName = 'NumNF'
            end
            object cxGrid1DBTableView2CodNatureza: TcxGridDBColumn
              DataBinding.FieldName = 'CodNatureza'
            end
            object cxGrid1DBTableView2CodProduto: TcxGridDBColumn
              DataBinding.FieldName = 'CodProduto'
            end
            object cxGrid1DBTableView2DescProduto: TcxGridDBColumn
              DataBinding.FieldName = 'DescProduto'
              Width = 250
            end
            object cxGrid1DBTableView2UnidadeItem: TcxGridDBColumn
              DataBinding.FieldName = 'UnidadeItem'
            end
            object cxGrid1DBTableView2Qtde: TcxGridDBColumn
              DataBinding.FieldName = 'Qtde'
            end
            object cxGrid1DBTableView2ValorUnitario: TcxGridDBColumn
              DataBinding.FieldName = 'ValorUnitario'
            end
            object cxGrid1DBTableView2ValorTotal: TcxGridDBColumn
              DataBinding.FieldName = 'ValorTotal'
            end
            object cxGrid1DBTableView2ValorICMS: TcxGridDBColumn
              DataBinding.FieldName = 'ValorICMS'
            end
            object cxGrid1DBTableView2ValorIPI: TcxGridDBColumn
              DataBinding.FieldName = 'ValorIPI'
            end
            object cxGrid1DBTableView2ValorCofins: TcxGridDBColumn
              DataBinding.FieldName = 'ValorCofins'
            end
            object cxGrid1DBTableView2ValorPIS: TcxGridDBColumn
              DataBinding.FieldName = 'ValorPIS'
            end
            object cxGrid1DBTableView2ValorICMS_ST: TcxGridDBColumn
              DataBinding.FieldName = 'ValorICMS_ST'
            end
            object cxGrid1DBTableView2PorcICMS: TcxGridDBColumn
              DataBinding.FieldName = 'PorcICMS'
            end
            object cxGrid1DBTableView2PorcIPI: TcxGridDBColumn
              DataBinding.FieldName = 'PorcIPI'
            end
            object cxGrid1DBTableView2PorcCOFINS: TcxGridDBColumn
              DataBinding.FieldName = 'PorcCOFINS'
            end
            object cxGrid1DBTableView2PorcPIS: TcxGridDBColumn
              DataBinding.FieldName = 'PorcPIS'
            end
            object cxGrid1DBTableView2ValorFrete: TcxGridDBColumn
              DataBinding.FieldName = 'ValorFrete'
            end
            object cxGrid1DBTableView2ValorDesconto: TcxGridDBColumn
              DataBinding.FieldName = 'ValorDesconto'
            end
          end
          object cxGrid1Level1: TcxGridLevel
            GridView = cxGrid1DBTableView1
            object cxGrid1Level2: TcxGridLevel
              GridView = cxGrid1DBTableView2
            end
          end
        end
      end
      object TabNFEE: TTabSheet
        Caption = 'NF-e Entrada'
        ImageIndex = 1
        object cxGrid2: TcxGrid
          Left = 0
          Top = 0
          Width = 927
          Height = 329
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          PopupMenu = PopupMenu1
          TabOrder = 0
          ExplicitLeft = 1
          ExplicitTop = 2
          object cxGridDBTableView1: TcxGridDBTableView
            OnDblClick = cxGrid1DBTableView1DblClick
            NavigatorButtons.ConfirmDelete = False
            DataController.DataSource = dsConsultaNFEE
            DataController.DetailKeyFieldNames = 'cCT'
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <
              item
                Format = '##,##0.00'
                Kind = skSum
                FieldName = 'Valor'
                Column = cxGridDBColumn4
              end>
            DataController.Summary.SummaryGroups = <>
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.Footer = True
            OptionsView.GroupByBox = False
            object cxGridDBColumn1: TcxGridDBColumn
              Caption = 'Nr'#186' Documento'
              DataBinding.FieldName = 'cCT'
              Width = 75
            end
            object cxGridDBColumn2: TcxGridDBColumn
              Caption = 'Origem'
              DataBinding.FieldName = 'TipoNF'
              Width = 43
            end
            object cxGridDBColumn3: TcxGridDBColumn
              Caption = 'S'#233'rie'
              DataBinding.FieldName = 'Serie'
              Width = 40
            end
            object cxGridDBColumn4: TcxGridDBColumn
              Caption = 'Valor R$'
              DataBinding.FieldName = 'Valor'
              Width = 90
            end
            object cxGridDBColumn5: TcxGridDBColumn
              Caption = 'Data de Emiss'#227'o'
              DataBinding.FieldName = 'dhEmi'
              Width = 132
            end
            object cxGridDBColumn6: TcxGridDBColumn
              Caption = 'Natureza de Opera'#231#227'o'
              DataBinding.FieldName = 'NatOp'
              Width = 200
            end
            object cxGridDBColumn7: TcxGridDBColumn
              DataBinding.FieldName = 'UF'
            end
            object cxGridDBColumn8: TcxGridDBColumn
              Caption = 'CNPJ Emitente'
              DataBinding.FieldName = 'CNPJEmitente'
              Width = 95
            end
            object cxGridDBColumn9: TcxGridDBColumn
              Caption = 'Raz'#227'o Social Emitente'
              DataBinding.FieldName = 'Emitente'
              Width = 140
            end
            object cxGridDBColumn10: TcxGridDBColumn
              Caption = 'Planta'
              DataBinding.FieldName = 'FILIAL'
              Width = 55
            end
            object cxGridDBColumn11: TcxGridDBColumn
              Caption = 'CNPJ Destinatario'
              DataBinding.FieldName = 'CNPJDEstinatario'
              Width = 95
            end
            object cxGridDBColumn12: TcxGridDBColumn
              Caption = 'Raz'#227'o Social Destinatario'
              DataBinding.FieldName = 'Destinatario'
              Width = 140
            end
            object cxGridDBColumn13: TcxGridDBColumn
              Caption = 'Chave'
              DataBinding.FieldName = 'CHCTE'
              Width = 279
            end
            object cxGridDBColumn14: TcxGridDBColumn
              Caption = 'Observa'#231#227'o'
              DataBinding.FieldName = 'Observacao'
            end
          end
          object cxGridDBTableView2: TcxGridDBTableView
            NavigatorButtons.ConfirmDelete = False
            DataController.DataSource = dsItens
            DataController.DetailKeyFieldNames = 'NumNF'
            DataController.KeyFieldNames = 'Chaveseq'
            DataController.MasterKeyFieldNames = 'cCT'
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <
              item
                Format = '##,##0.00'
                Kind = skSum
                FieldName = 'ValorTotal'
                Column = cxGridDBColumn25
              end
              item
                Format = '##,##0.00'
                Kind = skSum
                FieldName = 'ValorICMS'
                Column = cxGridDBColumn26
              end
              item
                Format = '##,##0.00'
                Kind = skSum
                FieldName = 'ValorIPI'
                Column = cxGridDBColumn27
              end
              item
                Format = '##,##0.00'
                Kind = skSum
                FieldName = 'ValorPIS'
                Column = cxGridDBColumn29
              end
              item
                Format = '##,##0.00'
                Kind = skSum
                FieldName = 'ValorCofins'
                Column = cxGridDBColumn28
              end
              item
                Format = '##,##0.00'
                Kind = skSum
                FieldName = 'ValorFrete'
                Column = cxGridDBColumn35
              end
              item
                Format = '##,##0.00'
                Kind = skSum
                FieldName = 'ValorDesconto'
                Column = cxGridDBColumn36
              end>
            DataController.Summary.SummaryGroups = <>
            OptionsView.Footer = True
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            object cxGridDBColumn15: TcxGridDBColumn
              DataBinding.FieldName = 'Chaveseq'
            end
            object cxGridDBColumn16: TcxGridDBColumn
              DataBinding.FieldName = 'CodFilial'
            end
            object cxGridDBColumn17: TcxGridDBColumn
              DataBinding.FieldName = 'CodFornecedor'
            end
            object cxGridDBColumn18: TcxGridDBColumn
              DataBinding.FieldName = 'NumNF'
            end
            object cxGridDBColumn19: TcxGridDBColumn
              DataBinding.FieldName = 'CodNatureza'
            end
            object cxGridDBColumn20: TcxGridDBColumn
              DataBinding.FieldName = 'CodProduto'
            end
            object cxGridDBColumn21: TcxGridDBColumn
              DataBinding.FieldName = 'DescProduto'
              Width = 250
            end
            object cxGridDBColumn22: TcxGridDBColumn
              DataBinding.FieldName = 'UnidadeItem'
            end
            object cxGridDBColumn23: TcxGridDBColumn
              DataBinding.FieldName = 'Qtde'
            end
            object cxGridDBColumn24: TcxGridDBColumn
              DataBinding.FieldName = 'ValorUnitario'
            end
            object cxGridDBColumn25: TcxGridDBColumn
              DataBinding.FieldName = 'ValorTotal'
            end
            object cxGridDBColumn26: TcxGridDBColumn
              DataBinding.FieldName = 'ValorICMS'
            end
            object cxGridDBColumn27: TcxGridDBColumn
              DataBinding.FieldName = 'ValorIPI'
            end
            object cxGridDBColumn28: TcxGridDBColumn
              DataBinding.FieldName = 'ValorCofins'
            end
            object cxGridDBColumn29: TcxGridDBColumn
              DataBinding.FieldName = 'ValorPIS'
            end
            object cxGridDBColumn30: TcxGridDBColumn
              DataBinding.FieldName = 'ValorICMS_ST'
            end
            object cxGridDBColumn31: TcxGridDBColumn
              DataBinding.FieldName = 'PorcICMS'
            end
            object cxGridDBColumn32: TcxGridDBColumn
              DataBinding.FieldName = 'PorcIPI'
            end
            object cxGridDBColumn33: TcxGridDBColumn
              DataBinding.FieldName = 'PorcCOFINS'
            end
            object cxGridDBColumn34: TcxGridDBColumn
              DataBinding.FieldName = 'PorcPIS'
            end
            object cxGridDBColumn35: TcxGridDBColumn
              DataBinding.FieldName = 'ValorFrete'
            end
            object cxGridDBColumn36: TcxGridDBColumn
              DataBinding.FieldName = 'ValorDesconto'
            end
          end
          object cxGridLevel1: TcxGridLevel
            GridView = cxGridDBTableView1
            object cxGridLevel2: TcxGridLevel
              GridView = cxGridDBTableView2
            end
          end
        end
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 489
    Width = 937
    Height = 19
    Panels = <>
  end
  object Panel3: TPanel
    Left = 0
    Top = 448
    Width = 937
    Height = 41
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    object ButPesquisar: TcxButton
      Left = 6
      Top = 3
      Width = 96
      Height = 34
      Hint = 'Pesquisar'
      Caption = ' &Consultar'
      Glyph.Data = {
        76060000424D7606000000000000360400002800000018000000180000000100
        08000000000040020000320B0000320B000000010000000000005A5A5A005263
        6B00846B6B009C6B6B00636B7300A5737300A57B73007B7B7B00AD847B00AD8C
        8400B58C8400EFBD8400BD8C8C00C6948C00BD9C8C00C69C8C00F7BD8C00F7C6
        8C00738494007B84940084849400C6949400C69C9400CE9C9400D69C9400BDA5
        9400CEA59400CEAD9400F7C69400F7CE94009C9C9C00BD9C9C00CE9C9C00D69C
        9C00CEA59C00F7CE9C00F7D69C003973A500C6A5A500ADADA500D6ADA500D6B5
        A500D6BDA500F7D6A500C6ADAD00D6B5AD00D6C6AD00DEC6AD00E7C6AD00E7CE
        AD00F7D6AD00F7DEAD00FFDEAD001873B5002173B5006394B500E7CEB500EFD6
        B500EFDEB500F7DEB500FFE7B5001873BD00E7D6BD00F7DEBD00F7E7BD00FFE7
        BD00FFEFBD00FFF7BD00EFDEC600EFE7C600FFEFC600FFF7C600FFF7CE003184
        D600FFFFD600C6CEDE00F7EFDE00FFEFDE00FFFFDE00EFEFE700FFF7E700FFFF
        E700218CEF00F7F7EF00FFFFEF00FFFFF700FF00FF0031A5FF0039A5FF0042A5
        FF004AB5FF0052BDFF005ABDFF007BC6FF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00560004165656
        5656565656565656565656565656565656562725361217565656565656565656
        5656565656565656565637585236131756565656565656565656565656565656
        56565A5C59523613175656565656565656565656565656565656575B5C595236
        13175656565656565656565656565656565656575B5C59523614175656565656
        565656565656565656565656575B5C5952361417565656565656565656565656
        5656565656575B5C59523614565656565656565656565656565656565656575B
        5C5849015656030A222928201556565656565656565656575B5D4B1E02093E48
        4A4E4A4A44225656565656565656565656564F2C1A484A4E4A4A4A4E4E4E2905
        565656565656565656562C1A4241484A4A4A4E4E515E5E265656565656565656
        56560C3A3C32484A4A4E5154555E5E4C065656565656565656562942232B484A
        4A4E54555E55544E1956565656565656561531421123464A4A4E545555544E4E
        2E155656565656565615393C0B113B4A4A4E515454514E4E3E0E565656565656
        56153942100B23464A4E4E4E4E4E4A4E3E0E56565656565656153142230B1C2B
        464A4E4A4A4A4A4E2E1556565656565656562842413323232B40484A4A4A4A4A
        0E5656565656565656560C3A4E544C231D1C324040464A440556565656565656
        5656560F505E5E3F1C0B101C3242460E5656565656565656565656561F4F5448
        3C33333C4240165656565656565656565656565656062A404242424030155656
        565656565656565656565656565656080F222216565656565656}
      LookAndFeel.Kind = lfOffice11
      LookAndFeel.NativeStyle = False
      LookAndFeel.SkinName = 'Office2007Blue'
      TabOrder = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      OnClick = ButPesquisarClick
    end
    object cxButton3: TcxButton
      Left = 105
      Top = 3
      Width = 104
      Height = 34
      Hint = 'Exportar para Excel (Alt+E)'
      Caption = '   &Exportar'
      Glyph.Data = {
        36090000424D3609000000000000360000002800000018000000180000000100
        2000000000000009000000000000000000000000000000000000000000090312
        086B1E542ED771A680D2274F3398081F0E6001060328020202140808082E0202
        0212000000030000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000184927CA1467
        2EFF1E793BFEC2E5CDFFB0D8BFFFB4DAC2FFAADBB9FEA4CEB3F8E7EDECFABEC0
        C0E5848585BF4B4C4C8E1D1D1D590707072A0101010D00000002000000000000
        00000000000000000000000000000000000000000000000000000F4D23D61C78
        3AFF208843FFB3DDC0FF7FCB9FFF87D9ABFF82DCA9FFA2D9BBFFFEFFFFFFF8FB
        F9FFFFFFFFFFFFFFFFFFFDFEFEFEEEF0F0FABBBDBDE27E7F7FB9424343861717
        1751040404220000000800000000000000000000000000000000115126D42080
        41FF259149FFB1DBBFFF78C899FF80D6A6FF85DFAEFFAFE3C8FFFBFDFCFF8ECE
        A9FFA5DCBCFFADDABEFFB1DCBFFFE6F3E9FFF7FBF9FFFCFEFDFFFFFFFFFFFEFF
        FFFFE8ECECF9B0B4B3DD6E7271B03437367A0F10104501010111125227D32384
        44FF28954DFFB2DABFFF72C493FF78D19EFF7EDAA7FFB2E1C9FFF2F9F5FF78C9
        9EFF86D5ACFF79C99CFF64B883FFCBE4D2FFC5E5D2FF9EDBB9FFA6D9BAFFAEDB
        BDFFEDF6F0FFEFF7F2FFF9FCFAFFFEFFFFFFF8FCFCFE4D52518F135127D12485
        45FF2A964EFFB2DABFFF6ABE8BFF70CA95FF74D49EFFB6E1CBFFE8F4EDFF8CD9
        B4FF8ED8B0FF89D2A8FF7DC598FFD9EADEFFB3DEC7FF86D6AEFF7CCC9FFF63B7
        82FFE0EEE4FFB8E2CBFF95D7B2FF95D0ABFFC7E6D1FF4B4F4E89145229D02685
        47FF2B9850FFB2D9BFFF62B783FF67C38CFF6ACC93FFBBE0CDFFF4FAF6FFD5F0
        E0FFCFEBDAFFCBEAD6FFC6E6D0FFEBF4EDFFB9E6CFFFA0E1BFFF9ADAB5FF92D0
        A8FFECF5EFFFA9DEC3FF86D6ACFF73C594FFACD4BAFF41464580155229CF2887
        49FF2C9951FFB1D9BFFF5AB07AFF5EBB82FF60C388FFC1E1D0FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4FAF6FFE3F2E9FFDDF0E4FFD8ED
        DEFFF9FBF9FFC1E8D4FFAAE0C2FFABDFBFFFD2EADBFF383C3B7716532ACF2A88
        4AFF2E9A53FFB1D8BEFF52A872FF56B379FF57BA7EFFC9E3D6FFF8FBF9FFF7FB
        F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5F9F6FFC7E0CFFFD9E6DDFFF2F6
        F3FFFFFFFFFFFEFEFEFFFFFFFFFFF8FDFCFFF2FBF9FF2F33326E17522BCE2C89
        4CFF309B54FFB2D8BFFF4CA26BFF51AD73FF51B376FFD3E7DDFFF8FBF9FFADDD
        C0FF9CD7B5FF82C69FFF8CC8A5FF98C9AAFF509C68FF228B45FF2C8349FF79B2
        89FFF1F4F1FFA6DABDFFA0DAB9FF9ED4B2FFCAE9D7FF2A2D2C6518542DCF2E8A
        4EFF319D56FFB2D7BFFF489D67FF52AA72FF52AE74FFDEECE6FFFFFFFFFFF0F7
        F3FFA6DCBEFF91DAB5FF75C99CFF31874FFF1C793CFF277F46FF66A278FFEDF3
        EEFFFFFFFFFF8FD4B1FF83D3A8FF6EC18FFFB3DAC3FF2023235B1A552DCF308B
        50FF329E57FFB2D6BEFF449962FF51A770FF4FA76FFFEAF3EFFFFFFFFFFFFFFF
        FFFFE3F1E8FF97D5B2FF398F58FF288347FF338951FF599B6FFF53AA71FFC4E4
        CDFFFFFFFFFFA2DFC0FF9FDCBAFFAEE2C2FFD1ECDEFF1B1D1D521C5730D1328D
        52FF34A059FFB1D5BDFF449861FF54A872FF51A46FFFF4F9F8FFFFFFFFFFFFFF
        FFFFF8FBF9FF509566FF1D7E3EFF228142FF489160FFCBDFD1FFDAECDFFFD5E9
        DAFFFFFFFFFFFFFFFFFFF9FCFAFFECF5EFFFEDF9F5FF151616481D5931D3348E
        54FF35A25AFFAED3BBFF449962FF5BAD78FF5BA877FFF9FDFCFFFFFFFFFFF9FB
        FAFF5F9F73FF208241FF228444FF43915DFF5FB280FF85BF99FFFDFEFEFFFFFF
        FFFFFFFFFFFFADDDC1FFACDCC0FF9ED4B1FFD5EEE1FF111212401F5A33D5368F
        56FF35A45AFFAED3BBFF48A168FF68B786FF6DB388FFFBFEFEFFF9FBFAFF7BB7
        8CFF459860FF48A266FF50A26AFF8EC2A0FF68BB89FF5DB27DFFA8D2B5FFFFFF
        FFFFFDFEFEFF7ECDA4FF80D0A5FF69BC89FFCAE6D7FF0D0E0E37205C34D73891
        58FF39A75DFFB2D7BFFF48A76BFF7AC599FF83C29EFFFCFEFEFFDBE9DEFFACD1
        B6FFA5CAB0FF9FCFAEFFDBECE0FFFBFDFBFF9BC9ABFF8FC4A1FF8DCB9FFFEAF3
        ECFFFAFDFBFF94DCB8FF9FDEBBFFABE0BFFFDDF0E7FF090A0A2D225D35D83A92
        59FF42A965FFB9DFC6FF42AB69FF8FD3AEFF98CEB2FFFCFEFEFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFEFEFEFFE9F6EEFFE7F3EBFFE4F0E8FFEAF6F3FE07070724225C36D83C92
        5BFF4BA86CFFC3EBCFFF40AF68FF9EDEBFFFA8D7C0FFE2F1ECFFE6F3EDFFE3F2
        EAFFDFEFE6FFDBEDE3FFD7EBE0FFD3E9DCFFCEE7D8FFC9E5D4FFC2E0CEFFB9DB
        C6FFADD4BDFFAACFB8FFA9BCB1DB616464964F55548F0101010D225232C74A99
        66FF46A167FF98D9ADFF8ED3A7FF92DDB6FFABE5C9FFA0DDBDFF92D3ADFF83C8
        9EFF78C193FF74BF8FFF6FBC8AFF68B885FF61B37EFF58AF77FF4FA96FFF3F9F
        61FF298E4DFF2D884EFF496E54AA000000000000000000000000102C1A95398A
        56FF459E66FF5FB97EFFD6F1DFFF7DD69FFFB8EAD1FFACE1C4FF9CD7B4FF8DCD
        A5FF81C59AFF7CC295FF77BF91FF70BB8BFF69B685FF60B17DFF56AC75FF45A0
        66FF2C8D4EFF298449FF50785BB200000000000000000000000002060436337F
        4DFE419660FF49A36AFF7FCC99FFD6F0DFFF82CE9FFFA1D9B8FFA2D6B6FF93CC
        A8FF87C59DFF84C39AFF7FC096FF78BC90FF70B78AFF68B283FF5DAC79FF4CA0
        6AFF2D8A4EFF2A8149FF567E63B900000000000000000000000000000000112D
        1A96378553FF429661FF48A068FF73C48EFFC8EDD3FFBCDDC8FF9FCEB0FF92C5
        A5FF8AC09DFF85BD99FF81BA95FF79B78FFF72B389FF68AC80FF5FA779FF4E9C
        6AFF358A53FF3A8855FF668A71C0000000000000000000000000000000000000
        00030F27188D337C4DFB3C8C59FF41935FFF4BA169FF58B476FF74C48DFF80CA
        97FF85CD9BFF8AD09FFF8FD3A4FF94D5A8FF97D6AAFF9AD8ADFF9BD9AEFF9CD9
        AFFF9EDAB0FFB1E3C0FF6C9077C7000000000000000000000000000000000000
        000000000000010302260E241685255335C536744BE732784AF032794BF1347A
        4DF4347C4DF6357D4EF8357E4EFA35804FFB35804FFB35804FFB35804FFD3980
        51FD337148F00F26168E0102011F000000000000000000000000}
      LookAndFeel.Kind = lfOffice11
      LookAndFeel.NativeStyle = False
      LookAndFeel.SkinName = 'Office2007Blue'
      TabOrder = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnClick = cxButton3Click
    end
    object btnLimpar: TcxButton
      Left = 212
      Top = 3
      Width = 112
      Height = 34
      Hint = 'Limpar &Filtro (Alt + F)'
      Caption = '   &Limpar Filtro'
      Glyph.Data = {
        76060000424D7606000000000000360400002800000018000000180000000100
        08000000000040020000220B0000220B00000001000000000000EFA53900EFA5
        5200FFB55200E7AD6B00F7BD6B00AD7B7300AD847300B5847300AD7B7B00AD73
        84009C7B8400A57B8400AD7B8400B57B8400B5848400BD848400E7B58400BD84
        8C00C68C8C00CE948C00DEA58C00EFC68C00F7C68C00D6949400D69C9400DE9C
        9400DEA59400E7A59400B5AD9400EFCE9400B5AD9C00EFCE9C00F7CE9C00F7D6
        9C00CEADA500BDB5A500DEC6A500EFCEA500F7CEA500F7D6A500CEBDAD00D6C6
        AD00F7D6AD00F7D6B500F7DEB500DEC6BD00E7CEBD00EFD6BD00F7DEBD00E7CE
        C600EFCEC600EFD6C600EFDEC600F7DEC600F7E7C600FFE7C600E7D6CE00E7DE
        CE00F7DECE00F7E7CE00FFE7CE00E7D6D600EFDED600F7E7D600FFE7D600FFEF
        D600EFDEDE00F7E7DE00F7EFDE00FFEFDE00F7EFE700FFEFE700FFF7E700F7EF
        EF00FFF7EF00FFF7F700FFFFF700FF00FF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004D4D4D080E0E
        0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E4D4D4D4D4D093436302C2B2A271F1F1D
        1D1D1D1D1D1D1D0E4D4D4D4D4D09343635302B2A2A251F1F1D1D1D1D1D1D1D0E
        4D4D4D4D4D093A3B3535302B2A2A251F1F1D1D1D1D1D1D0E4D4D4D4D4D093B3F
        3B3530302B2A2A251F1F1D1D1D1D1D0E4D4D4D4D4D093F443F3B3535302B2A2A
        251F1F1D1D1D1D0E4D4D4D4D4D0C43443F3B3B3535302B2A2A251F1F1D1D1D0E
        4D4D4D4D4D0D4646443F3B3B3530302B2A2A251F1F1D1D0E4D4D4D4D4D0E464A
        46443F3F3B3530302B2A2A251F1F1D0E4D4D4D4D4D0F494A4646443F3B3B3530
        302B2A2A251F1D0E4D4D4D4D4D114B4C4A4646443F3B3B3535302B2A2A251F0E
        4D4D4D4D4D124B4E4B4A4646443F3B3B3530302B2A2A250E4D4D4D4D4D124B4E
        4E4B4A4646443F3B3B3530302B2A250E4D4D4D4D4D124B4E4E4E4B4A4646443F
        3B3B3530302B2A0E4D4D4D4D4D134B4E4E4E4E4B4A4646443F3B3B353030240B
        4D4D4D4D4D134B4E4E4E4E4E4B4A4646443F3B3B2F281C0A4D4D4D4D4D184B4E
        4E4E4E4E4E4B4A464444443928231E0A4D4D4D4D4D184B4E4E4E4E4E4E4E4B4A
        483E0706050505054D4D4D4D4D1A4B4E4E4E4E4E4E4E4C4B4A3107100301000E
        4D4D4D4D4D1A4B4E4E4E4E4E4E4E4E4E4C31071504020E4D4D4D4D4D4D1A4B4E
        4E4E4E4E4E4E4E4E4E380715040E4D4D4D4D4D4D4D1A4E4E4E4E4E4E4E4E4E4E
        4E3D07150E4D4D4D4D4D4D4D4D142E2F2F322E2E2E2E2D2D2D22070E4D4D4D4D
        4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D}
      LookAndFeel.Kind = lfOffice11
      LookAndFeel.NativeStyle = False
      LookAndFeel.SkinName = 'Office2007Blue'
      TabOrder = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -10
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnClick = btnLimparClick
    end
    object ButSair: TcxButton
      Left = 430
      Top = 3
      Width = 100
      Height = 34
      Hint = 'Sair (Alt+S)'
      Caption = '   &Sair'
      Glyph.Data = {
        F6060000424DF606000000000000360000002800000018000000180000000100
        180000000000C0060000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFDFB096EFD7CBFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFC1693AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFD1916FCC8661FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFE6C3B0B95C2BE5C2B0FF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBC5E
        2DC27147FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFC67B53C26131E4C1AFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFD3997BCA6635C37953FF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFDBAD95CF6837BC5F31FF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFDBAD
        95CC6A3AC7683BE3C0AFCE6C34CE6C34CE6C34CE6C34CE6C34CE6C34CE6C34CE
        6C34CE6C34CE6C34CE6C34CE6C34FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFDAAC95CB6D3FD07345D4A187CE6C34E67F44E57E43E57D42E57D
        42E47C41E47A40E3793FE2773EDB723BC96F3DF4E2D8FF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFDAAC95D17446D87D50C5815FCC6A33E88044
        E27E3CE27D3BE17C3AE07A39E07939E5793DDE743BCA703DF4E2D8FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFD1977BD2784CDC8357C4
        805FCB6933E77D41DE7936DE7836DD7735DD7635E3783CDE743BCA6F3DF4E2D8
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBF6F
        48DC8357DB845BC47F5EC96832E67B3FDD7634DC7533DC7432DE7435E3763CCB
        6833E4BBA4FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFECD6CABE653AE2885DD27C53C88A6CC86732E67D44DC7839DC7738DE76
        38DA7334E0753ADD733DC66C3DF3E2D8FF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFC6825FD47E54E28B60C7734AD6A994C66631E57D44
        DD7A3DE37B43E47B43DD783DDB773CE27841D56E3AC36A3BF3E1D8FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFD4A087C26C41E18A60E18C64BA653DF0
        DFD7C56430E57A43E37942DD743FD6703BE27840DA753BD9743AE1763FD76E3A
        BF602EDCAE95FF00FFFF00FFFF00FFFF00FFFF00FFCF977ABD663BDE895FE08A
        60D78760BA6C47FF00FFC36330E37942DC733EC66C3DC56B3DDB723DE0763ED9
        7239D87139DF733DDD7340C96838BF693CCD8E6DDAAC95C78260B85E32CA744A
        DF895FDD8358E08E66BF6D45E0BEAFFF00FFC1622FDB723DC46B3DF3E1D8E6C3
        B0BF602EDA703CDF743DD87039D66F37DA713CE07A48DE7D4DD6794BD17649D8
        8055DF875CE0865AD97A4CE18C63CB7B56C17E5EFF00FFFF00FFBD5F2EC46A3D
        F3E1D8FF00FFFF00FFEED7CBC1683BCF6837E07541DD7440D66E39D46B36D770
        3CD97543DA7746D97646D6713FD97A4CDF8B63CE7F5ABE7654FF00FFFF00FFFF
        00FFBE6739F2E1D8FF00FFFF00FFFF00FFFF00FFFF00FFC98461C06132D47243
        DF7C4DDF7D4DDC7A49DA7847DA7949DD8053E08A61D78760BF6D45BC7350FF00
        FFFF00FFFF00FFFF00FFF2E1D8FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFEDD6CAC78260B85D30C3693DCF764BD0784ED07A50C7734ABA653DBA6C47
        E0BFAEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFE7CABCD8AA94D7AA94D7AA94DB
        B4A1F0DFD7FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      LookAndFeel.Kind = lfOffice11
      LookAndFeel.NativeStyle = False
      LookAndFeel.SkinName = 'Office2007Blue'
      TabOrder = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      OnClick = ButSairClick
    end
    object cxButton1: TcxButton
      Left = 327
      Top = 3
      Width = 100
      Height = 34
      Caption = '        &Ajuda ?'
      LookAndFeel.Kind = lfOffice11
      LookAndFeel.NativeStyle = False
      LookAndFeel.SkinName = 'Office2007Blue'
      TabOrder = 4
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 14
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnClick = cxButton1Click
    end
  end
  object pnlDica: TPanel
    Left = 510
    Top = 2
    Width = 660
    Height = 146
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    Visible = False
    object Memo1: TMemo
      Left = 1
      Top = 42
      Width = 658
      Height = 103
      Align = alClient
      Color = clBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 16
      Font.Name = #39#39
      Font.Style = [fsBold]
      Lines.Strings = (
        
          '1) Clique com o bot'#227'o direito em  cima do documento desejado e c' +
          'lique em Copiar Chave.'
        ''
        
          '2) Com Duplo-clique o sistema ir'#225' abrir a pagina https://www.dan' +
          'feonline.com.br.'
        ''
        
          '3) Ao abrir a pagina, cole com CTRL-V ou bot'#227'o direito (Paste/Co' +
          'lar) no campo indicado referente'
        '    ao numero do chave.')
      ParentFont = False
      TabOrder = 0
    end
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 658
      Height = 41
      Align = alTop
      Caption = 'Consultar Documento na WEB'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 16
      Font.Name = #39#39#39
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
    end
  end
  object dsConsultaNFES: TDataSource
    DataSet = cdsConsultaNFES
    Left = 117
    Top = 370
  end
  object SaveDialog: TSaveDialog
    Left = 549
    Top = 218
  end
  object PopupMenu1: TPopupMenu
    Left = 349
    Top = 258
    object CopiarChaveNFe1: TMenuItem
      Caption = 'Copiar Chave NF-e'
      OnClick = CopiarChaveNFe1Click
    end
  end
  object PopupMenu2: TPopupMenu
    Left = 461
    Top = 266
    object CopiarChaveCTe1: TMenuItem
      Caption = 'Copiar Chave CT-e'
    end
  end
  object sqlConsultaNFES: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'Select * from VW_NFE Where 1=2')
    SQLConnection = DB_Conect.SQLConnection
    Left = 120
    Top = 192
    object sqlConsultaNFESTipoXML: TStringField
      FieldName = 'TipoXML'
      Size = 4
    end
    object sqlConsultaNFEScCT: TStringField
      FieldName = 'cCT'
      Size = 8
    end
    object sqlConsultaNFESSerie: TStringField
      FieldName = 'Serie'
      Size = 1
    end
    object sqlConsultaNFESNatOp: TStringField
      FieldName = 'NatOp'
      Size = 100
    end
    object sqlConsultaNFESdhEmi: TSQLTimeStampField
      FieldName = 'dhEmi'
    end
    object sqlConsultaNFESCNPJEmitente: TStringField
      FieldName = 'CNPJEmitente'
      Size = 14
    end
    object sqlConsultaNFESEmitente: TStringField
      FieldName = 'Emitente'
      Size = 100
    end
    object sqlConsultaNFESFILIAL: TStringField
      FieldName = 'FILIAL'
      Size = 40
    end
    object sqlConsultaNFESCNPJDestinatario: TStringField
      FieldName = 'CNPJDestinatario'
      Size = 14
    end
    object sqlConsultaNFESDestinatario: TStringField
      FieldName = 'Destinatario'
      Size = 100
    end
    object sqlConsultaNFESCHCTE: TStringField
      FieldName = 'CHCTE'
      Size = 44
    end
    object sqlConsultaNFESValor: TFMTBCDField
      FieldName = 'Valor'
      Precision = 18
      Size = 2
    end
    object sqlConsultaNFESObservacao: TStringField
      FieldName = 'Observacao'
      Size = 17
    end
    object sqlConsultaNFESUF: TStringField
      FieldName = 'UF'
      Size = 2
    end
    object sqlConsultaNFESTipoNF: TStringField
      FieldName = 'TipoNF'
      FixedChar = True
      Size = 1
    end
  end
  object cdsConsultaNFES: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspConsultaNFES'
    Left = 120
    Top = 312
    object cdsConsultaNFESTipoXML: TStringField
      FieldName = 'TipoXML'
      Size = 4
    end
    object cdsConsultaNFEScCT: TStringField
      FieldName = 'cCT'
      Size = 8
    end
    object cdsConsultaNFESSerie: TStringField
      FieldName = 'Serie'
      Size = 1
    end
    object cdsConsultaNFESNatOp: TStringField
      FieldName = 'NatOp'
      Size = 100
    end
    object cdsConsultaNFESdhEmi: TSQLTimeStampField
      FieldName = 'dhEmi'
    end
    object cdsConsultaNFESCNPJEmitente: TStringField
      FieldName = 'CNPJEmitente'
      Size = 14
    end
    object cdsConsultaNFESEmitente: TStringField
      FieldName = 'Emitente'
      Size = 100
    end
    object cdsConsultaNFESFILIAL: TStringField
      FieldName = 'FILIAL'
      Size = 40
    end
    object cdsConsultaNFESCNPJDestinatario: TStringField
      FieldName = 'CNPJDestinatario'
      Size = 14
    end
    object cdsConsultaNFESDestinatario: TStringField
      FieldName = 'Destinatario'
      Size = 100
    end
    object cdsConsultaNFESCHCTE: TStringField
      FieldName = 'CHCTE'
      Size = 44
    end
    object cdsConsultaNFESValor: TFMTBCDField
      FieldName = 'Valor'
      Precision = 18
      Size = 2
    end
    object cdsConsultaNFESObservacao: TStringField
      FieldName = 'Observacao'
      Size = 17
    end
    object cdsConsultaNFESUF: TStringField
      FieldName = 'UF'
      Size = 2
    end
    object cdsConsultaNFESTipoNF: TStringField
      FieldName = 'TipoNF'
      FixedChar = True
      Size = 1
    end
  end
  object dspConsultaNFES: TDataSetProvider
    DataSet = sqlConsultaNFES
    Left = 120
    Top = 248
  end
  object dspItens: TDataSetProvider
    DataSet = sqlItens
    Left = 640
    Top = 248
  end
  object cdsItens: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspItens'
    Left = 640
    Top = 312
    object cdsItensChaveseq: TIntegerField
      FieldName = 'Chaveseq'
      Required = True
    end
    object cdsItensCodFilial: TStringField
      FieldName = 'CodFilial'
      Size = 15
    end
    object cdsItensCodFornecedor: TIntegerField
      FieldName = 'CodFornecedor'
    end
    object cdsItensNumNF: TStringField
      FieldName = 'NumNF'
      Size = 6
    end
    object cdsItensCodNatureza: TStringField
      FieldName = 'CodNatureza'
      Size = 5
    end
    object cdsItensCodProduto: TStringField
      FieldName = 'CodProduto'
      Size = 15
    end
    object cdsItensDescProduto: TStringField
      FieldName = 'DescProduto'
      Size = 255
    end
    object cdsItensUnidadeItem: TStringField
      FieldName = 'UnidadeItem'
      Size = 10
    end
    object cdsItensQtde: TFMTBCDField
      FieldName = 'Qtde'
      Precision = 18
      Size = 4
    end
    object cdsItensValorUnitario: TFMTBCDField
      FieldName = 'ValorUnitario'
      Precision = 18
      Size = 4
    end
    object cdsItensValorTotal: TFMTBCDField
      FieldName = 'ValorTotal'
      Precision = 18
      Size = 2
    end
    object cdsItensValorICMS: TFMTBCDField
      FieldName = 'ValorICMS'
      Precision = 18
      Size = 2
    end
    object cdsItensValorIPI: TFMTBCDField
      FieldName = 'ValorIPI'
      Precision = 18
      Size = 2
    end
    object cdsItensValorCofins: TFMTBCDField
      FieldName = 'ValorCofins'
      Precision = 18
      Size = 2
    end
    object cdsItensValorPIS: TFMTBCDField
      FieldName = 'ValorPIS'
      Precision = 18
      Size = 2
    end
    object cdsItensValorICMS_ST: TFMTBCDField
      FieldName = 'ValorICMS_ST'
      Precision = 18
      Size = 2
    end
    object cdsItensPorcICMS: TFMTBCDField
      FieldName = 'PorcICMS'
      Precision = 18
      Size = 2
    end
    object cdsItensPorcIPI: TFMTBCDField
      FieldName = 'PorcIPI'
      Precision = 18
      Size = 2
    end
    object cdsItensPorcCOFINS: TFMTBCDField
      FieldName = 'PorcCOFINS'
      Precision = 18
      Size = 2
    end
    object cdsItensPorcPIS: TFMTBCDField
      FieldName = 'PorcPIS'
      Precision = 18
      Size = 2
    end
    object cdsItensValorFrete: TFMTBCDField
      FieldName = 'ValorFrete'
      Precision = 18
      Size = 2
    end
    object cdsItensValorDesconto: TFMTBCDField
      FieldName = 'ValorDesconto'
      Precision = 18
      Size = 2
    end
  end
  object sqlItens: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      
        'Select Chaveseq, CodFilial, CodFornecedor, NumNF,  CodNatureza, ' +
        'CodProduto, DescProduto, UnidadeItem, Qtde, ValorUnitario, Valor' +
        'Total, ValorICMS, ValorIPI, '
      
        '       ValorCofins, ValorPIS, ValorICMS_ST, PorcICMS, PorcIPI, P' +
        'orcCOFINS, PorcPIS, ValorFrete, ValorDesconto'
      'From CTE_Itens ')
    SQLConnection = DB_Conect.SQLConnection
    Left = 640
    Top = 192
    object sqlItensChaveseq: TIntegerField
      FieldName = 'Chaveseq'
      Required = True
    end
    object sqlItensCodFilial: TStringField
      FieldName = 'CodFilial'
      Size = 15
    end
    object sqlItensCodFornecedor: TIntegerField
      FieldName = 'CodFornecedor'
    end
    object sqlItensNumNF: TStringField
      FieldName = 'NumNF'
      Size = 6
    end
    object sqlItensCodNatureza: TStringField
      FieldName = 'CodNatureza'
      Size = 5
    end
    object sqlItensCodProduto: TStringField
      FieldName = 'CodProduto'
      Size = 15
    end
    object sqlItensDescProduto: TStringField
      FieldName = 'DescProduto'
      Size = 255
    end
    object sqlItensUnidadeItem: TStringField
      FieldName = 'UnidadeItem'
      Size = 10
    end
    object sqlItensQtde: TFMTBCDField
      FieldName = 'Qtde'
      Precision = 18
      Size = 4
    end
    object sqlItensValorUnitario: TFMTBCDField
      FieldName = 'ValorUnitario'
      Precision = 18
      Size = 4
    end
    object sqlItensValorTotal: TFMTBCDField
      FieldName = 'ValorTotal'
      Precision = 18
      Size = 2
    end
    object sqlItensValorICMS: TFMTBCDField
      FieldName = 'ValorICMS'
      Precision = 18
      Size = 2
    end
    object sqlItensValorIPI: TFMTBCDField
      FieldName = 'ValorIPI'
      Precision = 18
      Size = 2
    end
    object sqlItensValorCofins: TFMTBCDField
      FieldName = 'ValorCofins'
      Precision = 18
      Size = 2
    end
    object sqlItensValorPIS: TFMTBCDField
      FieldName = 'ValorPIS'
      Precision = 18
      Size = 2
    end
    object sqlItensValorICMS_ST: TFMTBCDField
      FieldName = 'ValorICMS_ST'
      Precision = 18
      Size = 2
    end
    object sqlItensPorcICMS: TFMTBCDField
      FieldName = 'PorcICMS'
      Precision = 18
      Size = 2
    end
    object sqlItensPorcIPI: TFMTBCDField
      FieldName = 'PorcIPI'
      Precision = 18
      Size = 2
    end
    object sqlItensPorcCOFINS: TFMTBCDField
      FieldName = 'PorcCOFINS'
      Precision = 18
      Size = 2
    end
    object sqlItensPorcPIS: TFMTBCDField
      FieldName = 'PorcPIS'
      Precision = 18
      Size = 2
    end
    object sqlItensValorFrete: TFMTBCDField
      FieldName = 'ValorFrete'
      Precision = 18
      Size = 2
    end
    object sqlItensValorDesconto: TFMTBCDField
      FieldName = 'ValorDesconto'
      Precision = 18
      Size = 2
    end
  end
  object dsItens: TDataSource
    DataSet = cdsItens
    Left = 640
    Top = 368
  end
  object sqlConsultaNFEE: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = DB_Conect.SQLConnection
    Left = 216
    Top = 184
  end
  object cdsConsultaNFEE: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspConsultaNFEE'
    Left = 216
    Top = 312
  end
  object dsConsultaNFEE: TDataSource
    DataSet = cdsConsultaNFEE
    Left = 224
    Top = 368
  end
  object dspConsultaNFEE: TDataSetProvider
    DataSet = sqlConsultaNFEE
    Left = 216
    Top = 248
  end
end