inherited FrmCadTreinamento: TFrmCadTreinamento
  Caption = 'Cadastro de Treinamento'
  ClientHeight = 666
  ClientWidth = 1251
  ExplicitWidth = 1267
  ExplicitHeight = 705
  PixelsPerInch = 96
  TextHeight = 13
  inherited PanFundo: TPanel
    Width = 1251
    Height = 666
    ExplicitWidth = 1251
    ExplicitHeight = 666
    inherited PanTitulo: TPanel
      Width = 1247
      ExplicitWidth = 1247
      inherited ImaBarraSup: TImage
        Width = 1243
        ExplicitWidth = 1243
      end
    end
    inherited StatusBar: TdxStatusBar
      Top = 644
      Width = 1247
      ExplicitTop = 644
      ExplicitWidth = 1247
    end
    inherited Panel27: TPanel
      Top = 608
      Width = 1247
      ExplicitTop = 608
      ExplicitWidth = 1247
      inherited ButPesquisar: TcxButton
        Left = 102
        ExplicitLeft = 102
      end
    end
    object editxtObrigacao: TrsSuperEdit
      Tag = -1
      Left = 97
      Top = 497
      Width = 0
      Height = 21
      Alignment = taRightJustify
      TagName = 'TRE_OBRIGATORIO'
      CT_NumFields = 0
      CT_RetField1 = 0
      CT_RetField2 = 0
      CT_Test = False
      CT_ConsTab = False
      CT_Search = False
      Text = ''
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -10
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Visible = False
    end
    object Page: TcxPageControl
      Left = 2
      Top = 4
      Width = 1247
      Height = 604
      Align = alClient
      TabOrder = 4
      Properties.ActivePage = tabTreinamento
      Properties.CustomButtons.Buttons = <>
      OnChange = PageChange
      ClientRectBottom = 600
      ClientRectLeft = 4
      ClientRectRight = 1243
      ClientRectTop = 24
      object tabTreinamento: TcxTabSheet
        Caption = 'Treinamento'
        ImageIndex = 0
        object Panel1: TPanel
          Tag = -2
          Left = 6
          Top = 8
          Width = 707
          Height = 27
          Alignment = taLeftJustify
          BevelInner = bvLowered
          Caption = '  C'#243'digo do Treinamento'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object EdiCodigo: TrsSuperEdit
            Tag = -2
            Left = 444
            Top = 3
            Width = 0
            Height = 22
            Alignment = taRightJustify
            Format = foInteger
            TagName = 'TRE_TREINAMENTO_ID'
            CT_Titulo = 'Consulta de Treinamento'
            CT_TableName = 'TRE_TREINAMENTO'
            CT_NumFields = 4
            CT_ColTit = 'ID;CursoID;NomeCurso;DataRealiza'#231#227'o'
            CT_ColField = 'TRE_TREINAMENTO_ID;CUR_ID;CUR_NOMCURSO;TRE_DTREALIZACAO'
            CT_RetField1 = 0
            CT_RetControl1 = EdiCodigo
            CT_RetField2 = 0
            CT_Test = False
            CT_ConsTab = True
            CT_KeyValue = EdiCodigo
            CT_Search = False
            MaxLength = 15
            Text = ''
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            Visible = False
          end
          object EditBuscaTreinamento: TEditBusca
            Left = 191
            Top = 3
            Width = 466
            Height = 22
            TabOrder = 1
            OnClick = EditBuscaTreinamentoClick
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
          object spbLimpaTreinamento: TcxButton
            Left = 675
            Top = 3
            Width = 26
            Height = 23
            Hint = 'Limpar campo Treinamento'
            OptionsImage.Glyph.Data = {
              F6000000424DF600000000000000760000002800000010000000100000000100
              0400000000008000000000000000000000001000000000000000000000000000
              80000080000000808000800000008000800080800000C0C0C000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
              7777777777777777777777000000077777777077777700777777707777770307
              77777077777703307777770FBFBFB03307777770FBFBFB03307777770FBFBFB0
              3307777770FBFBFB03077777770FBFBFB00777777770FBFBFB07777777770000
              0077777777777777777777777777777777777777777777777777}
            ParentShowHint = False
            ShowHint = True
            TabOrder = 2
            OnClick = spbLimpaTreinamentoClick
          end
        end
        object Panel2: TPanel
          Tag = -1
          Left = 6
          Top = 37
          Width = 707
          Height = 27
          Alignment = taLeftJustify
          BevelInner = bvLowered
          Caption = '  Nome do Treinamento'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object EdiCodigoCurso: TrsSuperEdit
            Tag = -1
            Left = 535
            Top = 4
            Width = 0
            Height = 22
            Alignment = taRightJustify
            Format = foInteger
            TagName = 'CUR_ID'
            CT_Titulo = 'Consulta de Cursos'
            CT_TableName = 'TRE_CURSO'
            CT_NumFields = 2
            CT_ColTit = 'C'#243'digo;Nome do Curso'
            CT_ColField = 'CUR_ID;CUR_NOMCURSO'
            CT_RetField1 = 0
            CT_RetControl1 = EdiCodigoCurso
            CT_RetField2 = 1
            CT_Test = False
            CT_ConsTab = True
            CT_KeyValue = EdiCodigoCurso
            CT_Search = True
            MaxLength = 15
            Text = ''
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            Visible = False
          end
          object EdiNomeCurso: TrsSuperEdit
            Tag = -1
            Left = 616
            Top = 2
            Width = 0
            Height = 22
            Options = [soAutoAlign, soAllowspaces, soEnterToTab]
            TagName = 'CUR_NOMCURSO'
            CT_NumFields = 0
            CT_RetField1 = 0
            CT_RetField2 = 0
            CT_Test = False
            CT_ConsTab = False
            CT_Search = False
            Text = ''
            Ctl3D = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 1
            Visible = False
          end
          object EditBuscaCurso: TEditBusca
            Left = 191
            Top = 3
            Width = 466
            Height = 22
            TabOrder = 2
            OnClick = EditBuscaCursoClick
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
          object cxButton1: TcxButton
            Left = 675
            Top = 4
            Width = 26
            Height = 23
            Hint = 'Limpar campo Treinamento'
            OptionsImage.Glyph.Data = {
              F6000000424DF600000000000000760000002800000010000000100000000100
              0400000000008000000000000000000000001000000000000000000000000000
              80000080000000808000800000008000800080800000C0C0C000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
              7777777777777777777777000000077777777077777700777777707777770307
              77777077777703307777770FBFBFB03307777770FBFBFB03307777770FBFBFB0
              3307777770FBFBFB03077777770FBFBFB00777777770FBFBFB07777777770000
              0077777777777777777777777777777777777777777777777777}
            ParentShowHint = False
            ShowHint = True
            TabOrder = 3
            OnClick = cxButton1Click
          end
        end
        object Panel3: TPanel
          Tag = -1
          Left = 6
          Top = 65
          Width = 707
          Height = 27
          Alignment = taLeftJustify
          BevelInner = bvLowered
          Caption = '  Nome do Fornecedor'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          object ediCodigoFornecedor: TrsSuperEdit
            Tag = -1
            Left = 567
            Top = 2
            Width = 0
            Height = 22
            Alignment = taRightJustify
            Format = foInteger
            TagName = 'EMP_ID'
            CT_Titulo = 'Consulta de Cursos'
            CT_TableName = 'TRE_EMPRESA'
            CT_NumFields = 2
            CT_ColTit = 'C'#243'digo;Nome da Empresa'
            CT_ColField = 'EMP_ID;EMP_NOMEMPRESA'
            CT_RetField1 = 0
            CT_RetControl1 = ediCodigoFornecedor
            CT_RetField2 = 1
            CT_Test = False
            CT_ConsTab = True
            CT_KeyValue = ediCodigoFornecedor
            CT_Search = True
            MaxLength = 15
            Text = ''
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            Visible = False
          end
          object EditBuscaFornecedor: TEditBusca
            Left = 191
            Top = 3
            Width = 466
            Height = 22
            TabOrder = 1
            OnClick = EditBuscaFornecedorClick
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
          object cxButton2: TcxButton
            Left = 675
            Top = 4
            Width = 26
            Height = 23
            Hint = 'Limpar campo Treinamento'
            OptionsImage.Glyph.Data = {
              F6000000424DF600000000000000760000002800000010000000100000000100
              0400000000008000000000000000000000001000000000000000000000000000
              80000080000000808000800000008000800080800000C0C0C000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
              7777777777777777777777000000077777777077777700777777707777770307
              77777077777703307777770FBFBFB03307777770FBFBFB03307777770FBFBFB0
              3307777770FBFBFB03077777770FBFBFB00777777770FBFBFB07777777770000
              0077777777777777777777777777777777777777777777777777}
            ParentShowHint = False
            ShowHint = True
            TabOrder = 2
            OnClick = cxButton2Click
          end
        end
        object Panel4: TPanel
          Tag = -1
          Left = 6
          Top = 93
          Width = 707
          Height = 27
          Alignment = taLeftJustify
          BevelInner = bvLowered
          Caption = '  Nome do Instrutor'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          object ediCodigoInstrutor: TrsSuperEdit
            Tag = -1
            Left = 490
            Top = 4
            Width = 0
            Height = 22
            Alignment = taRightJustify
            Format = foInteger
            TagName = 'INS_ID'
            CT_Titulo = 'Consulta de Instrutor'
            CT_TableName = 'TRE_INSTRUTOR'
            CT_NumFields = 2
            CT_ColTit = 'C'#243'digo;Nome do Instrutor'
            CT_ColField = 'INS_ID;INS_NOMINSTRUTOR'
            CT_RetField1 = 0
            CT_RetControl1 = ediCodigoInstrutor
            CT_RetField2 = 1
            CT_Test = False
            CT_ConsTab = True
            CT_KeyValue = ediCodigoInstrutor
            CT_Search = True
            MaxLength = 15
            Text = ''
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            Visible = False
            OnEnter = ediCodigoInstrutorEnter
          end
          object EditBuscaInstrutor: TEditBusca
            Left = 191
            Top = 3
            Width = 466
            Height = 22
            TabOrder = 1
            OnClick = EditBuscaInstrutorClick
            OnEnter = EditBuscaInstrutorEnter
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
          object cxButton3: TcxButton
            Left = 675
            Top = 4
            Width = 26
            Height = 23
            Hint = 'Limpar campo Treinamento'
            OptionsImage.Glyph.Data = {
              F6000000424DF600000000000000760000002800000010000000100000000100
              0400000000008000000000000000000000001000000000000000000000000000
              80000080000000808000800000008000800080800000C0C0C000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
              7777777777777777777777000000077777777077777700777777707777770307
              77777077777703307777770FBFBFB03307777770FBFBFB03307777770FBFBFB0
              3307777770FBFBFB03077777770FBFBFB00777777770FBFBFB07777777770000
              0077777777777777777777777777777777777777777777777777}
            ParentShowHint = False
            ShowHint = True
            TabOrder = 2
            OnClick = cxButton3Click
          end
        end
        object Panel5: TPanel
          Tag = -1
          Left = 6
          Top = 121
          Width = 707
          Height = 27
          Alignment = taLeftJustify
          BevelInner = bvLowered
          Caption = 
            '  Data Inicial                                                  ' +
            '                                   Data T'#233'rmino'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 4
          object editxtDtRealizacao: TrsSuperEdit
            Tag = -1
            Left = 455
            Top = 3
            Width = 0
            Height = 22
            Format = foFullDate
            TagName = 'TRE_DTREALIZACAO'
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
          object editxtDtTermino: TrsSuperEdit
            Tag = -1
            Left = 581
            Top = 5
            Width = 0
            Height = 22
            Format = foFullDate
            TagName = 'TRE_DTTERMINO'
            CT_NumFields = 0
            CT_RetField1 = 0
            CT_RetField2 = 0
            CT_Test = False
            CT_ConsTab = False
            CT_Search = False
            MaxLength = 10
            Text = '  /  /    '
            TabOrder = 1
          end
          object EdiDatIni: TcxDateEdit
            Left = 191
            Top = 3
            TabOrder = 2
            Width = 121
          end
          object EdiDatFim: TcxDateEdit
            Left = 402
            Top = 3
            TabOrder = 3
            Width = 121
          end
        end
        object Panel6: TPanel
          Tag = -1
          Left = 6
          Top = 149
          Width = 707
          Height = 27
          Alignment = taLeftJustify
          BevelInner = bvLowered
          Caption = '  Carga Hor'#225'ria'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 5
          object ediCargaHoraria: TrsSuperEdit
            Tag = -1
            Left = 191
            Top = 3
            Width = 121
            Height = 22
            TagName = 'TRE_CARGAHORARIA'
            CT_NumFields = 0
            CT_RetField1 = 0
            CT_RetField2 = 0
            CT_Test = False
            CT_ConsTab = False
            CT_Search = False
            Text = ''
            TabOrder = 0
            OnKeyPress = ediCargaHorariaKeyPress
          end
        end
        object Panel7: TPanel
          Tag = -1
          Left = 6
          Top = 177
          Width = 707
          Height = 110
          Alignment = taLeftJustify
          BevelInner = bvLowered
          Caption = '       Sum'#225'rio'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 6
          object MemSumario: TMemo
            Left = 102
            Top = 4
            Width = 598
            Height = 100
            TabOrder = 0
          end
          object editxtSumario: TrsSuperEdit
            Tag = -1
            Left = 117
            Top = 32
            Width = 1
            Height = 22
            TagName = 'TRE_SUMARIO'
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
        end
        object Panel8: TPanel
          Tag = -1
          Left = 6
          Top = 289
          Width = 707
          Height = 110
          Alignment = taLeftJustify
          BevelInner = bvLowered
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 7
          object MemObjetivo: TMemo
            Left = 102
            Top = 6
            Width = 600
            Height = 100
            TabOrder = 0
          end
          object editxtObjetivo: TrsSuperEdit
            Tag = -1
            Left = 172
            Top = 24
            Width = 1
            Height = 22
            TagName = 'TRE_OBJETIVO'
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
          object cxLabel1: TcxLabel
            Left = 22
            Top = 26
            Caption = 'Objetivo'
          end
          object cxLabel2: TcxLabel
            Left = 5
            Top = 40
            Caption = 'do Treinamento'
          end
        end
        object Panel9: TPanel
          Tag = -1
          Left = 6
          Top = 399
          Width = 707
          Height = 27
          Alignment = taLeftJustify
          BevelInner = bvLowered
          Caption = ' Tipo de Treinamento'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 8
          object ediTipoTreinamento: TrsSuperEdit
            Tag = -1
            Left = 340
            Top = 3
            Width = 2
            Height = 22
            Alignment = taRightJustify
            Format = foInteger
            TagName = 'TRE_TIPOTREINAMENTO_ID'
            CT_Titulo = 'Consulta de Tipo de Treinamento'
            CT_TableName = 'TRE_TIPOTREINAMENTO'
            CT_NumFields = 2
            CT_ColTit = 'C'#243'digo;Tipo de Treinamento'
            CT_ColField = 'TRE_TIPOTREINAMENTO_ID;DESCRICAO'
            CT_RetField1 = 0
            CT_RetControl1 = ediTipoTreinamento
            CT_RetField2 = 1
            CT_Test = False
            CT_ConsTab = True
            CT_KeyValue = ediTipoTreinamento
            CT_Search = False
            MaxLength = 15
            Text = ''
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
          end
          object cmbTipoTreinamento: TcxLookupComboBox
            Left = 198
            Top = 3
            Properties.DropDownAutoSize = True
            Properties.DropDownListStyle = lsFixedList
            Properties.DropDownSizeable = True
            Properties.KeyFieldNames = 'TRE_TIPOTREINAMENTO_ID'
            Properties.ListColumns = <
              item
                Caption = 'Descri'#231#227'o'
                FieldName = 'DESCRICAO'
              end>
            Properties.ListSource = dtsTipoTreinamento
            TabOrder = 1
            Width = 223
          end
        end
        object Panel10: TPanel
          Tag = -1
          Left = 6
          Top = 427
          Width = 707
          Height = 27
          Alignment = taLeftJustify
          BevelInner = bvLowered
          Caption = ' Periodicidade'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 9
          object editxtPeriodicidade: TrsSuperEdit
            Tag = -1
            Left = 327
            Top = 11
            Width = 0
            Height = 22
            Alignment = taRightJustify
            Format = foInteger
            TagName = 'TRE_PERIODICIDADE'
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
            Visible = False
          end
          object cmbPeriodo: TcxLookupComboBox
            Left = 198
            Top = 4
            Properties.DropDownAutoSize = True
            Properties.DropDownListStyle = lsFixedList
            Properties.DropDownSizeable = True
            Properties.KeyFieldNames = 'PERIODICIDADE_ID'
            Properties.ListColumns = <
              item
                Caption = 'Descri'#231#227'o'
                FieldName = 'DESCRICAO'
              end>
            Properties.ListSource = dsPeriodo
            TabOrder = 1
            Width = 223
          end
        end
        object Panel11: TPanel
          Tag = -1
          Left = 6
          Top = 456
          Width = 707
          Height = 33
          Alignment = taLeftJustify
          BevelInner = bvLowered
          Caption = ' Obrigat'#243'rio para Cargo ou Fun'#231#227'o'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 10
          object rgObrigacao: TcxRadioGroup
            Tag = -2
            Left = 198
            Top = 1
            ParentFont = False
            Properties.Columns = 2
            Properties.Items = <
              item
                Caption = 'Sim'
                Value = 'S'
              end
              item
                Caption = 'N'#227'o'
                Value = 'N'
              end>
            ItemIndex = 0
            Style.Font.Charset = DEFAULT_CHARSET
            Style.Font.Color = clWindowText
            Style.Font.Height = -10
            Style.Font.Name = 'MS Sans Serif'
            Style.Font.Style = [fsBold]
            Style.IsFontAssigned = True
            TabOrder = 0
            Height = 29
            Width = 223
          end
        end
        object ediUsuarioCad: TrsSuperEdit
          Tag = -1
          Left = 6
          Top = 457
          Width = 1
          Height = 21
          Alignment = taRightJustify
          Format = foInteger
          TagName = 'USU_ID'
          CT_NumFields = 0
          CT_RetField1 = 0
          CT_RetField2 = 0
          CT_Test = False
          CT_ConsTab = False
          CT_Search = False
          Text = ''
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 11
          Visible = False
        end
      end
      object TabParticipante: TcxTabSheet
        Caption = 'Participantes'
        ImageIndex = 1
        object Panel14: TPanel
          Tag = -1
          Left = 0
          Top = 0
          Width = 1239
          Height = 576
          Align = alClient
          Alignment = taLeftJustify
          BevelInner = bvLowered
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object Panel21: TPanel
            Left = 1155
            Top = 2
            Width = 82
            Height = 572
            Align = alRight
            BevelOuter = bvLowered
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object ButNovoItem: TcxButton
              Left = 3
              Top = 2
              Width = 74
              Height = 25
              Hint = '|Inclui novo contato para esse cliente.'
              Caption = '&Novo'
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              OnClick = ButNovoItemClick
            end
            object ButAlterarItem: TcxButton
              Left = 3
              Top = 31
              Width = 74
              Height = 25
              Hint = '|Altera os dados do contato selecionado.'
              Caption = '&Alterar'
              ParentShowHint = False
              ShowHint = True
              TabOrder = 1
              OnClick = ButAlterarItemClick
            end
            object ButExcluirItem: TcxButton
              Left = 3
              Top = 60
              Width = 74
              Height = 25
              Hint = '|Apaga os dados do contato selecionado.'
              Caption = '&Excluir'
              ParentShowHint = False
              ShowHint = True
              TabOrder = 2
              OnClick = ButExcluirItemClick
            end
            object ButSalvarItem: TcxButton
              Left = 3
              Top = 115
              Width = 74
              Height = 25
              Hint = '|Confirma Inclus'#227'o/Altera'#231#227'o do contato.'
              Caption = 'Con&firmar'
              Enabled = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 3
              OnClick = ButSalvarItemClick
            end
            object ButCAncelarItem: TcxButton
              Left = 3
              Top = 146
              Width = 74
              Height = 25
              Hint = '|Ignora Inclus'#227'o/Altera'#231#227'o do contato.'
              Caption = '&Cancelar'
              Enabled = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 4
              OnClick = ButCAncelarItemClick
            end
            object btnDownload: TcxButton
              Left = 6
              Top = 495
              Width = 74
              Height = 25
              Hint = 'Download de Modelo de Lista de Participantes'
              Caption = 'Download'
              ParentShowHint = False
              ShowHint = True
              TabOrder = 5
              OnClick = btnDownloadClick
            end
            object btnUpload: TcxButton
              Left = 6
              Top = 535
              Width = 74
              Height = 25
              Hint = 'Upload Lista de Participantes'
              Caption = 'Upload'
              ParentShowHint = False
              ShowHint = True
              TabOrder = 6
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              OnClick = btnUploadClick
            end
          end
          object PageItem: TcxPageControl
            Left = 2
            Top = 2
            Width = 1153
            Height = 572
            Align = alClient
            TabOrder = 1
            Properties.ActivePage = tsbGrid
            Properties.CustomButtons.Buttons = <>
            ClientRectBottom = 568
            ClientRectLeft = 4
            ClientRectRight = 1149
            ClientRectTop = 25
            object tsbGrid: TcxTabSheet
              Caption = 'Grade'
              ImageIndex = 0
              DesignSize = (
                1145
                543)
              object cxGrid1: TcxGrid
                Left = 0
                Top = 0
                Width = 1145
                Height = 543
                Align = alClient
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 0
                object cxGrid1DBTableView1: TcxGridDBTableView
                  Navigator.Buttons.CustomButtons = <>
                  DataController.DataSource = dsParticipante
                  DataController.Summary.DefaultGroupSummaryItems = <>
                  DataController.Summary.FooterSummaryItems = <>
                  DataController.Summary.SummaryGroups = <>
                  OptionsData.CancelOnExit = False
                  OptionsData.Deleting = False
                  OptionsData.DeletingConfirmation = False
                  OptionsData.Editing = False
                  OptionsData.Inserting = False
                  OptionsView.GroupByBox = False
                  OptionsView.Indicator = True
                  object cxGrid1DBTableView1ALIASEMPRESA: TcxGridDBColumn
                    Caption = 'Empresa'
                    DataBinding.FieldName = 'ALIASEMPRESA'
                  end
                  object cxGrid1DBTableView1FUN_MATRICULA: TcxGridDBColumn
                    Caption = 'Matricula'
                    DataBinding.FieldName = 'FUN_MATRICULA'
                    Width = 121
                  end
                  object cxGrid1DBTableView1FUN_NOME: TcxGridDBColumn
                    Caption = 'Participante'
                    DataBinding.FieldName = 'FUN_NOME'
                    Width = 276
                  end
                  object cxGrid1DBTableView1FUN_CARGO: TcxGridDBColumn
                    Caption = 'Cargo'
                    DataBinding.FieldName = 'FUN_CARGO'
                    Width = 150
                  end
                  object cxGrid1DBTableView1PAR_SCORE: TcxGridDBColumn
                    Caption = 'Score'
                    DataBinding.FieldName = 'PAR_SCORE'
                    Width = 100
                  end
                  object cxGrid1DBTableView1PAR_APROVADO: TcxGridDBColumn
                    Caption = 'Aprovado'
                    DataBinding.FieldName = 'PAR_APROVADO'
                    Width = 71
                  end
                end
                object cxGrid1Level1: TcxGridLevel
                  GridView = cxGrid1DBTableView1
                end
              end
              object PanelSQLSplashScreen: TPanel
                Left = 235
                Top = 228
                Width = 350
                Height = 175
                Anchors = []
                BevelInner = bvRaised
                BevelOuter = bvNone
                BevelWidth = 2
                TabOrder = 1
                Visible = False
                object ImageSQLSplashScreen: TImage
                  Left = 2
                  Top = 2
                  Width = 346
                  Height = 171
                  Align = alClient
                  Picture.Data = {
                    0B546478504E47496D61676589504E470D0A1A0A0000000D49484452000002BC
                    0000015E080600000067DECC570000000467414D410000B18E7CFB5193000000
                    206348524D0000870F00008C0F0000FD520000814000007D790000E98B00003C
                    E5000019CC733C857700000A2F694343504943432050726F66696C65000048C7
                    9D96775454D71687CFBD777AA1CD30025286DEBBC000D27B935E456198196028
                    030E3334B121A2021145449A224850C480D150245644B1101454B00724082831
                    1845542C6F46D68BAEACBCF7F2F2FBE3AC6FEDB3F7B9FBECBDCF5A170092A72F
                    9797064B0190CA13F0833C9CE911915174EC0080011E608029004C5646BA5FB0
                    7B0810C9CBCD859E2172025F0401F07A58BC0270D3D033804E07FF9FA459E97C
                    81E89800119BB339192C11178838254B902EB6CF8A981A972C66182566BE2841
                    11CB893961910D3EFB2CB2A398D9A93CB688C539A7B353D962EE15F1B64C2147
                    C488AF880B33B99C2C11DF12B1468A30952BE237E2D8540E33030014496C1770
                    588922361131891F12E422E2E500E048095F71DC572CE0640BC49772494BCFE1
                    73131205741D962EDDD4DA9A41F7E464A5700402C300262B99C967D35DD252D3
                    99BC1C0016EFFC5932E2DAD24545B634B5B6B434343332FDAA50FF75F36F4ADC
                    DB457A19F8B96710ADFF8BEDAFFCD21A0060CC896AB3F38B2DAE0A80CE2D00C8
                    DDFB62D3380080A4A86F1DD7BFBA0F4D3C2F890241BA8DB1715656961197C332
                    1217F40FFD4F87BFA1AFBE67243EEE8FF2D05D39F14C618A802EAE1B2B2D254D
                    C8A767A433591CBAE19F87F81F07FE751E06419C780E9FC313458489A68CCB4B
                    10B59BC7E60AB8693C3A97F79F9AF80FC3FEA4C5B91689D2F81150638C80D475
                    2A407EED07280A1120D1FBC55DFFA36FBEF830207E79E12A938B73FFEF37FD67
                    C1A5E225839BF039CE252884CE12F23317F7C4CF12A0010148022A9007CA401D
                    E800436006AC802D70046EC01BF8831010095603164804A9800FB2401ED8040A
                    4131D809F6806A50071A41336805C741273805CE834BE01AB8016E83FB60144C
                    80676016BC060B10046121324481E421154813D287CC2006640FB941BE501014
                    09C54209100F124279D066A8182A83AAA17AA819FA1E3A099D87AE4083D05D68
                    0C9A867E87DEC1084C82A9B012AC051BC30CD809F68143E0557002BC06CE850B
                    E01D7025DC001F853BE0F3F035F8363C0A3F83E7108010111AA28A18220CC405
                    F147A29078848FAC478A900AA4016945BA913EE426328ACC206F511814054547
                    19A26C519EA850140BB506B51E5582AA461D4675A07A51375163A859D4473419
                    AD88D647DBA0BDD011E8047416BA105D816E42B7A32FA26FA327D0AF31180C0D
                    A38DB1C2786222314998B59812CC3E4C1BE61C6610338E99C362B1F2587DAC1D
                    D61FCBC40AB085D82AEC51EC59EC107602FB0647C4A9E0CC70EEB8281C0F978F
                    ABC01DC19DC10DE126710B7829BC26DE06EF8F67E373F0A5F8467C37FE3A7E02
                    BF4090266813EC08218424C2264225A1957091F080F0924824AA11AD8981442E
                    7123B192788C789938467C4B9221E9915C48D124216907E910E91CE92EE92599
                    4CD6223B92A3C802F20E7233F902F911F98D0445C248C24B822DB141A246A243
                    6248E2B9245E5253D24972B564AE6485E409C9EB92335278292D291729A6D47A
                    A91AA99352235273D2146953697FE954E912E923D257A4A764B0325A326E326C
                    99029983321764C62908459DE242615136531A29172913540C559BEA454DA216
                    53BFA30E506765656497C986C966CBD6C89E961DA521342D9A172D85564A3B4E
                    1BA6BD5BA2B4C4690967C9F625AD4B8696CCCB2D957394E3C815C9B5C9DD967B
                    274F9777934F96DF25DF29FF5001A5A0A710A890A5B05FE1A2C2CC52EA52DBA5
                    ACA5454B8F2FBDA7082BEA290629AE553CA8D8AF38A7A4ACE4A194AE54A57441
                    694699A6ECA89CA45CAE7C46795A85A262AFC255295739ABF2942E4B77A2A7D0
                    2BE9BDF4595545554F55A16ABDEA80EA829AB65AA85ABE5A9BDA4375823A433D
                    5EBD5CBD477D564345C34F234FA345E39E265E93A199A8B957B34F735E4B5B2B
                    5C6BAB56A7D694B69CB69776AE768BF6031DB28E83CE1A9D069D5BBA185D866E
                    B2EE3EDD1B7AB09E855EA25E8DDE757D58DF529FABBF4F7FD0006D606DC03368
                    30183124193A19661AB6188E19D18C7C8DF28D3A8D9E1B6B184719EF32EE33FE
                    6862619262D26872DF54C6D4DB34DFB4DBF477333D3396598DD92D73B2B9BBF9
                    06F32EF317CBF4977196ED5F76C78262E167B1D5A2C7E283A59525DFB2D572DA
                    4AC32AD6AAD66A84416504304A1897ADD1D6CED61BAC4F59BFB5B1B411D81CB7
                    F9CDD6D036D9F688EDD472EDE59CE58DCBC7EDD4EC9876F576A3F674FB58FB03
                    F6A30EAA0E4C870687C78EEA8E6CC726C749275DA724A7A34ECF9D4D9CF9CEED
                    CEF32E362EEB5CCEB922AE1EAE45AE036E326EA16ED56E8FDCD5DC13DC5BDC67
                    3D2C3CD67A9CF3447BFA78EEF21CF152F26279357BCD7A5B79AFF3EEF521F904
                    FB54FB3CF6D5F3E5FB76FBC17EDE7EBBFD1EACD05CC15BD1E90FFCBDFC77FB3F
                    0CD00E5813F06320263020B026F0499069505E505F30253826F848F0EB10E790
                    D290FBA13AA1C2D09E30C9B0E8B0E6B0F970D7F0B2F0D108E3887511D7221522
                    B9915D51D8A8B0A8A6A8B9956E2BF7AC9C88B6882E8C1E5EA5BD2A7BD595D50A
                    AB53569F8E918C61C69C8845C786C71E897DCFF4673630E7E2BCE26AE366592E
                    ACBDAC676C4776397B9A63C729E34CC6DBC597C54F25D825EC4E984E7448AC48
                    9CE1BA70ABB92F923C93EA92E693FD930F257F4A094F694BC5A5C6A69EE4C9F0
                    9279BD69CA69D96983E9FAE985E9A36B6CD6EC5933CBF7E137654019AB32BA04
                    54D1CF54BF5047B8453896699F5993F9262B2CEB44B674362FBB3F472F677BCE
                    64AE7BEEB76B516B596B7BF254F336E58DAD735A57BF1E5A1FB7BE6783FA8682
                    0D131B3D361EDE44D894BCE9A77C93FCB2FC579BC337771728156C2C18DFE2B1
                    A5A550A2905F38B2D5766BDD36D436EEB681EDE6DBABB67F2C62175D2D3629AE
                    287E5FC22AB9FA8DE93795DF7CDA11BF63A0D4B274FF4ECC4EDECEE15D0EBB0E
                    974997E5968DEFF6DBDD514E2F2F2A7FB52766CF958A6515757B097B857B472B
                    7D2BBBAA34AA7656BDAF4EACBE5DE35CD356AB58BBBD767E1F7BDFD07EC7FDAD
                    754A75C575EF0E700FDCA9F7A8EF68D06AA83888399879F049635863DFB78C6F
                    9B9B149A8A9B3E1CE21D1A3D1C74B8B7D9AAB9F988E291D216B845D8327D34FA
                    E88DEF5CBFEB6A356CAD6FA3B5151F03C784C79E7E1FFBFDF0719FE33D271827
                    5A7FD0FCA1B69DD25ED40175E474CC7626768E7645760D9EF43ED9D36DDBDDFE
                    A3D18F874EA99EAA392D7BBAF40CE14CC1994F6773CFCE9D4B3F37733EE1FC78
                    4F4CCFFD0B11176EF506F60E5CF4B978F992FBA50B7D4E7D672FDB5D3E75C5E6
                    CAC9AB8CAB9DD72CAF75F45BF4B7FF64F153FB80E540C775ABEB5D37AC6F740F
                    2E1F3C33E43074FEA6EBCD4BB7BC6E5DBBBDE2F6E070E8F09D91E891D13BEC3B
                    537753EEBEB897796FE1FEC607E807450FA51E563C527CD4F0B3EECF6DA396A3
                    A7C75CC7FA1F073FBE3FCE1A7FF64BC62FEF270A9E909F544CAA4C364F994D9D
                    9A769FBEF174E5D38967E9CF16660A7F95FEB5F6B9CEF31F7E73FCAD7F366276
                    E205FFC5A7DF4B5ECABF3CF46AD9AB9EB980B947AF535F2FCC17BD917F73F82D
                    E36DDFBBF077930B59EFB1EF2B3FE87EE8FEE8F3F1C1A7D44F9FFE050398F3FC
                    6F26DC0F000000097048597300000EBC00000EBC0195BC724900000024744558
                    74536F6674776172650041646F62652050686F746F73686F7020435333205769
                    6E646F7773AB4E5D9C0000000774494D4507DE0B0E0F0E25AD342F290000F508
                    49444154785EEC9D07405557B6FE49D42466E6BD79F39F9937354DA5D74B4740
                    106BFAA4A8E9B15335C9BCE9936243144B924932E976A5F76605E9206047A4A3
                    D895DE6EFFFE6BED73AFA25E4D5450337396F9720A9773F6DDE772CF6FAFB3F6
                    5A66904D36D964FB8159577B0DBACB7D817D7650973A01255ED096BB935CA12F
                    F5847ECF9D918ECE8D3277E88ADDA84DDED017FAA235D5012D29F6B42F807EE6
                    055D09FFCC15BA3217E8CBDCA02EF784B2C4DDE4F1065AA0F675D252BBD7019A
                    323BE88B1E87B6D415DAFDB6D01451FBF77AA3A7A30ABDDCC9956F43936F457D
                    6A45EF8BFA75CF68A82B7CA0A2F7A029F702F67800C5CED05D718EC192AED4A3
                    DF36AF7BD1B5A6FEA475659913DAB7F8E16088258E8739A276F6A3A80DB1415D
                    983DEAC3AC4936774C9521566898E780A6B916680CB6C7C939AE681E6709BDBD
                    2D9AA6F9E1E88BBEA87A3900D52FFAA1FE795FD4BDE48D2353BD50F7C218D4BD
                    38C8A27354D1F9AAA7F9523BFC503B6D021AA64C40CDF3E3683906C7A81D55D3
                    26A2D46F2C126DBCB1FD8B3548D95B8994BC03C8C93E88F4EC52A4ECD98BF89C
                    226CDDBD0FE9B43FAD702FD20B697D10C5E7C8DC45E72F3C8CE4A2FD48C9DD83
                    CCDD7B90915B41FBF622267B0F96ACCFC2DA1D87D1CD9F65AD8EA4A4155ADE69
                    D3715B008D560F95615765D3195887C4C07D7E3CE66C6A4068CA69BC99D88499
                    69C7F172EC51CC4C6EC4AC94E3B7453392E8BCC9C7AED2F4E47ACC4E3E81D712
                    CEE1E594A3F834773FB6E657207A5711C263772232A9102BE248B1058888CB45
                    78CC2E4426E662595C1E96C70FB67211114FE78DDD8D55097988A473F37259F4
                    4E2CA3FDEF6FDA81E4E2A390815736D964FBC199966E5EEA864FA12924F021C8
                    D512F4680924B5A5049902862E87A5DB294DA91B7404B1A0B6F46E73416BA20D
                    DA92ECA1D9498056365A009A6E8F1BBD96DA5DE2024DB13B8130EDBF0CE80649
                    740ECD1E5F825D02EE527F716E3D01BA9EE05C59680F6DDD4AEADB1EBE1F036D
                    A550153D036DB10DBD176A6F29813CBD56BDC79D8E41B05B46A2E3DD2EE0D51A
                    07053CA0117D2501AFBE8CFA7C2FFD6CD7389C8E74C1E159A3D014E288BA105B
                    825E2B93107A3B5547C05D1D6281FA106B34073AE2F8F33638E5698E1E5B1B1C
                    7BD21D8D04BC47083E8F4CF123D0F445F50B9EA89DEA737B809774E8794F1CA5
                    F355D13AEBC8B3A3A90DBEA89F3A46406FF9B301487773418AB92B52A7CDC58E
                    1DD948DA7344C0666ADE3E2413F46C2D3A80CCFCFD482E187CD86531F06E65B8
                    2E384020B317A90565C8CA2531FCD2CF3F4BCEC1D2981C2CDCB0150555CDE23B
                    43AFE9A3FF894FF69D356A8256AB8246A726F8D5424DD4FBF74FB7E3D137BE84
                    DDECF5787A453182934E624642235E8DAFC52C82DE5929C7AE02D3C1D28CA4AB
                    6177663243F0714C4F388137638F6361561D12E8FAEF2ADE872CBA069FA411F4
                    125C2E8FD98DC858025082DC6509BB493962DD34A40EAC96C5E66045A204BD2B
                    699BAFFFB2F87C01BC5FA4E5A1B1BD4F065ED96493ED87667ABA67E8A16E3907
                    65E954A0D80BCA7D5604443E046E630884EE2CF0AA090CF5153ED0E67B11ECDA
                    A135CE1A1DF1B6E849762430F726681C2D5EA32370D413F8EA0ADD081C254FA5
                    A9E30DA418AA41C0AB650F73E9785ADA01E54ED0E4517BF7FD1EBACEA3D0EB00
                    B58EA057AF87BEF61BE191D69738521BD923ED42BFE70C0D81BAB684DA2BBCE9
                    B7A7BFB5A2CFE83D081168739FD1F9B93F9515D486F2315025F9E0F05BA3501B
                    E8828660824D02CDBA50EB3BAAFA104B1C0919819AF90E38F1BA134EFB98A34D
                    618536277B9CF0B6C5A967BD0930C7E0F0547F025F1FD43EE7850682E05ADA57
                    4B003AA822B03D4AA07D94C0B69600B7F6251F1C7D9100F8450F344C1B83A3D3
                    2622276034526D1DB0C3CE1D8956A3B13D3C02191587115D7210C925879141E0
                    B975374127816F524905412803E9E02A9580775B1E0176EE1E241795D1B94B08
                    B8CB904EE0BD6E4731C1CE4E442415E2DD7559F8222507ED2A0D7D6F68E8B3CD
                    CB3B6CF4F7D5ABE9A1AF31127D93ED2C3B038FC018D806AE8553E01638CD8BC6
                    4B5F1D4458FA19BC19DF80D9A9C7F04662433FF01C4C1D23E06D34A9994927F0
                    4ADC710425D62036BB16D934D8C9A0BEDF5A7808517907B12A76179645EF4224
                    C32E01277B7797C6658BF5DBA14802DC485A46C4ED46447C21C2630BB022B914
                    8B37EF4071650D68782103AF6CB2C9F6C332C230A8E8EB4B4BDF60DAFA3882AF
                    47D15BE10235434F8917C1D1ED013093628F27019896A0B26BAB33CEC75AA333
                    C101DD7176E88EB1464F0E7B46FD08DE3CA8DD0492655E0081238A24983379CC
                    01149F030C8E254E50734805C3F91E737416B90027BEA27BB18EFA55870EA25E
                    3501027A4EA2EFC0CB04E5F604CAAED4767ADD1E67FA7D065E777A1FB7AFBF35
                    3440D09611F80A7988736B0DC0DB4B3FD7963B53FBFC71FA9FEEA8983E0AF541
                    566808B5125EDE3B2702DE606ACB7C1B025F679C78C2166DCE96E876B2439B87
                    02A79D2D706EBC2B9A5FF047D5147F54127CD613ECD63FEF8D1A02D24117016F
                    CDD4F138C29EE5295EA87DD90BD5533D51F5A22BEAA6F9A3F8B9F148757345B1
                    B53BB25D3C9160ED80F480C9C8CBCC4652C5016C2E28C7B6DD95D8967388C0B3
                    02F1852502785305940EAE32F3CA919C47C05B508AD4DC1202AFFD48C8DF87C8
                    846D589C908F258905589E5282F0CD59D85E5169F8F6B80B421A389C81069340
                    07BABA7A306BC90E3CFC46225C833713F046C17ACE068C5B9C8DD0E4D39895D0
                    84D7E3EB313D8581D334880EB4A6135C5FA919A4D7138EE3E5C426BCBBFD28C1
                    6E257665972096AE7772FE7EA4171FC1D7E9F9581EBD1D1C5EB09CFA9FC19341
                    94C31B227839C85A199783E5B1D988482820D02E125AB265173E4F2B449F5609
                    BD5E2B03AF6CB2C9F6C33206DE3E6D0F88CBA0EFEA44EFC1E7D05BAA808AC1A8
                    D4DE242CDD2EB1E7913DA8CADD5E684DB045479C3D7A129CD01D6B8FCE382B5C
                    48B425781C037DC518280978D57BDCE8F504BDC5B7273440006F89029A3247A8
                    CBAD097EFDD0576485AE9AD7A0EBA9839AEFC33A15DD8AF9696B1FF5B406BDA7
                    36A06F8F9F14675C6A805E21864D6F01F9A6CE35D03286345CE9E1E5301115B5
                    415942D7FEA00F74DBC7A2E2ED875119688EBA500E2B30ED79BD3DB22159E2F4
                    3B2E38F58A02273D09761576E821B57ADAA25D618EF39E7638FFA40F1A187AA7
                    8D45DD4B6351F3BC8F083730E9951D40D5115C573F37568430D470BCEE8BEE38
                    32C50375AF0408EF6E9A8F2792EC690061ED8774276724B8BB20EB315B6C9BFF
                    0F94EEDF8FB8B2FDD89A7D0859B9879150B41799C5E5B7C5C3CB62E04DA773A6
                    159523A3602FB20A2BB16E7B19DEDF928970829E7002AE1529A5F880A0E7A3B8
                    1DA83FDB22BE3FEEB4E97534985449E8BD79D741D8BEB10956C1E970991B0D7B
                    F6F08644C331340A533EDB8B79E9E708749BF066A214C37B7998C1C04B0A6968
                    BA4AFCB337121A119A5E8BAF0A8F6067511932F24B105FBC1749450790266279
                    CBB03A7E0796C6EE24E8E418DE1C1A7CE4631901EF95DED8C1D00ABADE910979
                    04BA34D04928A681CE0E2CDB988ABD8D67A9A735D0689432F0CA269B6C3F3423
                    2AD32BA1D449933E3467F6435BE40E14F0237702200160FD216C90814C3CD667
                    D179CA08C40ABCD095E284B638029B0467B4C7D8A12B9E809760B723CA16BD99
                    CE049D04C50C690CC815048D25B7077845DF501F29D95BBA673401AF1BBA8A7D
                    A0EFC81537609D5E073DF52DF8D12F3F03D4713FF7A1B76A167ACBC6A04F0026
                    416F298736509FD331063AF6F85AC7BB14C34B3F17AF918097E39FD953ADA66D
                    9E00887D63D1FAAD130E8458A026E85A93D60667225B9D58F2B1490CDBA4A36F
                    D9E158A00267036CD0EA608B4E17055A5CADD1EAFE187A78A9B0C2791F17343F
                    EB8FA32F8D43E5543FD44C21182508BD0C4E39A6D72801AB03213AC7F301A8E3
                    F8E169A37174AA07AAA7D1F9A64D42F1445F64383823D3C10709CE639069EF86
                    0C675764D93B23D6623472A2B720EBF041A4E51C4052EE21C410FCEC20F06118
                    3515773B909280B78280771F52F3F6626B0101F78EFD045CB95844F013C1F19C
                    B1D958169B8B85B1455812958DD85D7BD0A7B90B3CBC3CA8D46BD1DCAA84CF3B
                    EB306A4E141C0363E13C6B139C4263E01C1403DBD9EBE1F1C744CC8A6EC2ECB4
                    1378A31FF08AA541BC3ED09A61086D9024853A4C4F3A8639C98D58BDBD0EDBA8
                    EF330A72915C58814C82DFACBCFDC8DA5D8AD4820AACD9518A88F86C2C8923D8
                    4D2C444434C7D7E65E166B3B1862E08DA46B2E3CCBF104BC74DD976D484346E1
                    5EE96B8CEE145AADECE1954D36D97E7046770C02310D016F0F011A7D8F41B9EF
                    2FE82D7C083A112EE00D0D01A514F3E94622101A24E86538D3F1E37502485D29
                    83970F543BDDD1914080CBA10C0904BE0CBCBC9D6C8FBE387BB4C5DB40B59B7E
                    A7CC071A067482346D116741B8FAF8032E06C5325F825786476F680B6DA13AF4
                    36A0D58810062D87343014D0363F7AD58BFDB47A211E1D1563A94F7962201FCB
                    09BA620E2D18D8AC1846D8BD127A453F5FB14FDA6F58E7098BF47E7ACA9CA1DE
                    EF0C6D8E1F6ADF774455A01DEA434804A0B51CCF2B960CA3B60630BD1C586F5E
                    ECCDB54463302D836D501B668B9A79D6A809354763A8038E4FB5C7690F737438
                    D8A1DDC59E60D71AEDB4DDE96C837685354EBBDAE0F413A3D134752C0EB1D775
                    AABF00DE7A825B16432E436F35C7DA32A80E18F4F224B9001C7DC18720DB9396
                    EEA87B79020E3C331159AE2ED86EEF81AD0A1F44B97963879317B63BB822D3C5
                    0B198F5923617618B24A3886B312A94507914CF099955D36E0C09B6662221CEF
                    CB24D04D27D84AC9A5EDFCC3589B568C459BB663794A1122D9BBCB8FB8098422
                    124B101E9D8B8FE2B271F4E469E91B44C7033B3DB4F41DA2E3F0025A0EB8F171
                    7900A95393E82F8BB6F93B8BBFBBD8223717E3A157BE817D68029C666F845B58
                    1C14C131709AB3192EA1B1B00DDA84C75714202CFD2CC4443282D1D90CA40904
                    BFB43DCB00A5A6A0F5E645C74B3841804B904B803B23E938ADB31AF1E78C1A44
                    E71CC14E1A68A4E6172085AEF7D6BCC3D89A4B038EFC726416ED4762E1417C92
                    928BA531D9884C29C6E21886DDC1075E3EC7B2B87C84C7E663395DEF88985D58
                    1D9586132DED74B7D042CBF709920CBCB2C926DB0FCCE826C5370D6232A55E29
                    BCBC5DE78BD1563C1ABA123B02321FA84BFCA029752108E20C0EDE508AAC0897
                    C3D24088BD9C9A723769A25AE918E8F2FCD09DEA2A60B72BD1119D89D252AC27
                    38A297C09727B1756FA57615D1EB4B38869727ADB9DE1E0F2F81BFA6D817AA0A
                    5B824473A84A27437FA140EA559E357E1DEBABFE0BB4F91604BA0C9E3ED017D3
                    7BDF3BF0C02B52B75D01B7ECDD95F673CCB051FC1A0984197C19C6D57BA9BFF7
                    DA0004E7ED9BC7E0C83C02CF5976689C4FCB9051A82528AD2520AD0F1DD87465
                    0CD2F521E63836D71A0D81B6A80EB347D57C02DEB05138F7AA23CE8EB7C7290F
                    0BB4BBDAA243618576672BB4B959A1D5D94EE89CAB15CEFA39E0CCB3BEA899E6
                    8FC35309D819789F1F8346122F19762BA78D31787FAF04D79B149DE3C8147F02
                    DDD104D204BB2F7AA26EEA6414068C43AABD1BC1AE27C903DB9C3C9045CB2CB1
                    ED856D0E5648B41D836D5FC6615BF96131792923A704DB0A0E13F00E6CA60653
                    C0CB13E4320BF6233D773F9DEF30A2B2CBB18A3D8BD1BB08780A2E3E4617B045
                    EB0C458BA37763434E01DA389E80E093A15745EB2A1EDC0DB0E7975957AB26C8
                    D5AA68D0D8078DA64730B54A9C4789EA73AD50CCFE061633E3E01E9404C59C8D
                    04BED1700BDC02E7C0CD700E8985CDDC4D70793B0E21B1CD084CE0B46006EF6E
                    7C23A901B3120978094CAF86D65BD131CC8823C04E6CC21B04B9AFA79CC4ABF1
                    4D084CAAC13FB3AB6870538654713DA8EF45E80A67C82019AE530601EF96ADC5
                    5815B7134BA9EF1726155EECFFC1159FA3084B638BB03CA1088B376660FBBE2A
                    1EB35F1C60B0C9C02B9B6CB2FDE04CABD7D0F7988AC0570F35678D5576A0EFC8
                    47E82DB602F6D812F0304012DC09AF2BC7990E0E50F23155C51C4A41E05A4AB0
                    BBDD0DED4904B806E0EDAF4E5237016F57923DCE27DA41B98B8FE127012F8742
                    0C20385E5B1E04B9DE744E7BA80A6CA069F8944856434388567EEE776DE3744E
                    BDCDE82E22C82CB426507F0AAA7247D1B7DCCFA6CF75E33282EE95C02B813087
                    4FF0B601788DAFA5FED394709805BFC615EA0A27E8F7F2E063328E2D71C6A199
                    E66898EF8063F3EC51176889060E3508B91A5A6F4DB6A80B25F144B97956383A
                    8FC03ACC0ECD218E38F38C034EB95BE3ACB3353A5D1DD0E96C8B16670BDA1E81
                    367747825F1B74BAD9E00C01F0C9C9AEA87F691C0E12D41E9DE28B6A01A56344
                    C6065EAF1A680F2F016F258735106057BFE081E657C7E3F0D3FE48533821CD91
                    BDBB0CB8572BD5CE11C9B6EE487D6E36D2F30B91B9A70AA979049F059C07F772
                    381D683158A5E49513F056202D9FD60B0EE1F31402DCA81D58995C82C5314600
                    BA1C8A1880C337A6A0ACFE94F499D6A8094CE93B84BE4B549CA777008DFDC57A
                    2D0DCC490CBF2A759F3817480C617FFF572A1E9BF6096C0313E1343B0A2E04BA
                    0EC151709DBB052EC1D15004C6C021281A23677E8B675615202CED34A6138C8A
                    D086D466B19C69F0F29A06D79BD76B74CCB949B49ED88C57E8BCD3E28EE2FDF4
                    5AC4163620AB481A7C18AF018BD793699951C4D77F1F12F3F7E3CBF4022C8CDA
                    8E65A904A0B7097897C61662591287AFECC087B1DB70AA9306197C59FB0DE465
                    E0954D36D97E70A6D6EBA0E3D43E1A7E54D525EE30BD2D27D0B6F70502A01104
                    BC96D0977B4153CC69CA3C81E281075E1DE7A62DF324D822F02A1F0B4D8E17DA
                    92EDD09EC0210C97C3AE51ED86AC0DAD71F41A8EE5CDF72550230015C71B3870
                    BCA6D813BAD71DC8B58676FF73D0F59C614739DD1878F020F5AD29133FA33ED6
                    357D096D11FD6EB98B88E91505344C9DE71664B21F781F67BFE0F613EC8A0C0D
                    3C48E0FEA79FA9398304E7332EA07DD4A6BE3DB47ED0077D09048E7FB2C6A1D9
                    963816EA84A6402B34716CAF98D0C6E10DA6322BDCB8F858D5418E247354878D
                    C091D0C7D014EC84D3AFB8E0ACAF3D5A150E04B634E8A165A7B33DDADD6DD0E2
                    6E8E5601BCD6E85158D16B2C70D2C70E4DCFFBA2EA253F1C9E46303A8D2077AA
                    2194C100BE352C82D581107B916B0876B9F845CD147FD244E4FA7820D9DA015B
                    9D4723D3C9039904B8978BF7F960A7930BB22C1C91B47C35522B8E20BDB81A49
                    BB8B444843FF6C0A03A994FC0A83380DDA1E6C2D3F8475DB8AB0820B0C10E832
                    F42C8F2FB9666680F0A8DDF834311F1D22B0938057DB439F7F352EF90007C8E8
                    6F454FE760872E4FAED5D18051A5E412187A6C2DBB008F37BE866D500C9CDE4A
                    81820097BDBA2EC17150046D86D3DC6838CE25080E4B80E5ACF5700A8BC2CB6B
                    0E636EC649CC20207D33F5385E4F6AC41B04BCBC3D90D91BD863FC525A1D6625
                    10F0269CC62B894D98937218EB72AAB1ADE828F53B412EF73F032FCB10B3CD4B
                    06E1D4BC0A641557624B760581EE2E918B3722EEEAEB30D0628F7E784211C2E3
                    7210B1250325B5CDE811B0CBA30D7E0628990CBCB2C926DB0FCAE82B0C7D5041
                    4F90C61594787E95141F0774D56F4277E918A88B478AEC071A5AE7B006140D34
                    98B147D64D781C5146D0BA672C3AD31DD11A6F8DEE44829A6B006F679C8DC8DC
                    D04DEB6DF1F6E8C9E2345F7EA481F5945E4B527BDDA029B486FEC43ABAD5EBD0
                    2D112FDDF439378369E3CC18A2FA5A770BB407A6A267CF2FA12CF5A7763B0E38
                    F09A92806083879763B2458606BE06F4338ED5569713E016B911F0B2B7DC1B3D
                    A5AE50EF73A2F5F138FD852B4A673D8486B9F6680EB24143E00811DA70793685
                    5B135775AB09B4A7E35A11F08E44ED3C4B9C9DE586D3139C709660B6CBD981E4
                    840E865D673BB4B95A0BE06D71A70112FDBCC3D11CDDB4EFB4BB358E8F73C1F1
                    296305F01E21D865E03542AF319677C0C4C79BE68343BF1F8D86579F42D9E363
                    91EAE8204097C317B28CCB7E62E0DDE6E88F1D8E0AECB0B64192FFD3484CC944
                    CE9E6AA4E64A0034E022B8E230864BDA4B805D8EF8C2BDF830215B141B884C2C
                    C6E2E85CAC489280D7387BFF92785F2916AEDD81ED7B8F4A9334354AA8D57D86
                    346103687C3CFA9BE23F2DA53811FB75F538D5DE85D71764C0EA957504B2A9B0
                    0B8E8563F0163807479162087A79D25A34816F1C9C8262097AE3097AD7C27F41
                    1601682302330942E3EB087A8F617A0A4F2633E6CF1D38BD96568BD7E309A613
                    9B313DF60816EFA844260D6638D77232012F8730F4BF3622C4A178BFF0B66710
                    F0661472F18F83F83AAB18E15BB65F710D064974BD23134BB0785316A2B24BD0
                    41F705B5564BF708FAE6D25EBAB632F0CA269B6C3F2863F85213F28AF91F1C9F
                    453717B55A0B2E46A16C3B81B643EFA1A7D80128616FE068822147822106A501
                    044A02301D81344F54E3DCAFAADDDEA2A25A47BC8D04B6268097431A7A12ECD1
                    116B879E7827B445DB8BD465BA021F02C73103DBBEEBA9D0095DD5B3A1EB3949
                    3DA68146CD1378AEEFE7E25BB7F093D0CD5B7D6A0BBA193A457A33CEE56BE21C
                    B72053E10CBC3419D240DB9CD358C51927442CB43B7415BE5072F9E33D0AE090
                    2794DB47E3C8DFAC7174B6359A8309784346A19AF3E2726883C9F0849B54889D
                    04BF6156680A73C4D9290AB478D8A3C5C11CED2E9604BA36687321D8255D5058
                    A0D5C51C175C6D699B7E46DB5D6E3638EF6A89731E0E38F7F86801B82C23F00E
                    68EC6E3F7128C3113A6EE58B4F207B8C37921D149277F71A210D1CCBBBDDC117
                    690A176C777545E64827A4FEF56FC8CDDB83AC925A82D3810D6B60D8E5B457FD
                    97BC3FA3E420BE4A23D089CBC1D284425281881B8DE40A5F26AB7BE562796C31
                    22E38BB12C2A1DF56D9DE2B3CDB1BC5A8EE31D40D3F31328AD0A2AFA92D27238
                    103F41A1FD6BB61D86C31BDF10CC32D0C6C36E2E87324413D8C6C131680B5C08
                    765D83E3E1129208FBD951700D89877DE04638CF8FC2739F952230B519AF26D4
                    637AEA71CC483926E27967255F1E9270AB9A1DDF8097E9986F10FCFE31F11036
                    EFAEC4F6924348CBDD73B1EFFB5F1B1E80A411F07278430601319777CE283A84
                    98DCFDF8307ED735AEC5C08A073391B10588DC9889AA932D62A0010E1EA1FED7
                    6864E0954D36D97EB0C637915EA8E95B4DA3EFA4AD2ED0BD052A0D4F1201DA9B
                    12D149808B122FE1DD55EDB385DE10DA204D74BA0453372F2E7C40B0C7E05532
                    06ED990AB412EC7627D810ECDA5F05BB46E0ED4AB443579C037A629DD09BE82C
                    421B3A77B80A2F2F575E9380EEF2F3DC5C9B2518BC6C5D403A8161DEAFA13C5F
                    843EBA0FF06357A895D477BD869B8469E3D9EC6AEA70065F7DEF59E8F6BF0B14
                    3C8ABE7D976269B92F246F2F6780B899364BBA987E8C8EC1B0CBE29CBF5701AF
                    E11C1C52A22CF1A573BB405BE68CDE7282DC521FE88B3CD0576E0EFDE1B168FF
                    7C1C0ECFB0406390051AE699E348E8C0961CE6496B8D1CDE10380AB5C1D63816
                    E282A60956E8B0B741AFC2126D1E8F11CC8E92D29111D85E7022C075B521E825
                    B959D1CFADE96716E820F8ED71B6C7B9D14E6898C2991A3896D7E0E1654065E0
                    BD09E8AD7DD1979624E3EFF753CD8B6E687C75228A26F820D5C515A94EEEC870
                    20D8751A2DE0D614F46E757447A2AB3741AF17765ADA20C5CD1369A919482869
                    463A012F57424B37C0519A6182537F50BA113150F123733139CA00BC59250768
                    DF417C1CBB0B1131B9589A5422A5234BE072B2DB4D96B3155014938F1549C558
                    10BB0D7105E5E8E3C4D344A27A4EF53280C6C0ABD1F173281A88AB3994418313
                    E7FAF0D49FE26139731D9C43196663E014180DC76082DDD018D226B804C7D2BE
                    182808869D02E3E04CDB0A0261BB39EBE0F38F64CC8A6D1031BC6F261F13191B
                    E6C63709E0BD951465C614674204D22151CD98967E1AD3D2EAB02CAB0ABB728F
                    20ABA81C89C565D24435EA7FA3F87AF0754EE6786ABA56997965223F7226016F
                    4AE16102FC3D5812B35BBA067C4D0CF1BC46CF6CFFEBF37DC49E5CB17ED9923D
                    F7B908DFB81BB1BB0F89EF319DC88CA1A47B849AEE11E2920893815736D964FB
                    C119DF50F8A9A158B26F97BFD448BD748BE9ED22E83D381FAAA21104499CA5C1
                    119A0A025E014B3706620CB5BA3DCE04616E243A164F902A7687BA88D645D531
                    6FF46D7713E1095D89AEE84E54A023FEEA096B4671BA325E76D2EB39ACA18397
                    494ED0668F867EAF0FB5972BB03909F1F9357B3824E312DC7D3F112412EC6BCA
                    5DA02C74A0ED31E8A6B66AF60700390FE24CED2780F20CDD14E8A6AC57414983
                    07AD5E091D4FAAB986F1408227DDF0EBB8C29DBEA5085DE574EC624B82507FA8
                    093A353C599061B578325425A3455CADE9F65D5B5AF6CA734E62034473660686
                    5B916B97B62F1F1048AF91A058F2E0B3B4BC3400BEBECC07AA0A27A06834AAFE
                    648DFA371D706A9E2D2A421F451D016A4DB014DA600457634C6E7F98ED2F63BC
                    6E7FD5F2EFD3FE934123511942FBC2DC716E9A3BCE388E10A10A5DEEB66865D0
                    65C0358A40B7CD95F6BBD8D2D2B8CE4B1BB4D3F2829B1DCE3EEE85E3CFFBE1F0
                    73DEA823E8AD9FE283A3D33C257865583501B6A6C4AF6F78712C6A9FF3472D1D
                    A3669A87C8B75B3B75346A383BC3CB0138F4FBF1D8E9E68E545B376439FA20C3
                    DE0B594E5E04B757032F87396C73A19F39BA22CEC315499E9EC87CD419312F4E
                    475E3D17A03888BC9D87105B768820A814BB76E523AD587A1C6E0A68AF2D0666
                    F61CEE471A3F2A27A8CA2048CD2C3C400076081F27170A00326664904216A4ED
                    FE9064147B1A5724ECC6D2D81D584ADB11313B70F02CA7AD62EB819EE703D0A0
                    4EAFE554623CC093263BF1DFC98D1B27F8538B9489D29713B06C6D311E7B8DD3
                    90C58BB0050E615004B1086A799D2401AEB48FD78568DD2170332CE7AEC7B39F
                    942324EB1C5E8DADC51C02DF9971F5527A3203BC7E5F3130BF114FBF9B740C73
                    12099EE31B452688390CD089B57839AE16FF47C01B93770439B98548E78A76C5
                    0705DCF6075E165F2BE340843DF0C6810E2B296F1FFE99924F7D4E0393A43C84
                    27E58BDCC8AB63386FAE5489CDD4B53225296CA1008BA3766179124F8ACB4664
                    72091D3B1FE171F459F862133AC525A3FE660F88862724D23515BD2F990CBCB2
                    C926DBBF8D89D13D7DC5A94F1C4627018FB6C81E281E030D81A4E4899420E9FB
                    4840130333412E7B2D1946250033BCA67C34B4799EE84C73467B2C416EBCC290
                    86ECDAC0DBCE93D568C9A06BDC66F8EDC9701513ECB89083BE8C73DD32F0B217
                    D9C770BEEFDF6E968EC0932776A9CAE83822DED515CA3D0ED0157B43D57B907A
                    896E06742750E9A4ECBBC2AE775F672F984E43AFED953C26BD17A0A95B0255E1
                    C304B90CA37C0E1E1C709887AFF0ACF340C154DBBE4B46E83582AED1B32B4170
                    7FF5FF3DC3B6005DE336816FB117D45C28E3901F7A37F9A136D002D533CC5135
                    9FD39349B0DB1F70BF0FF05E2D065F5E3E869A303B1C9BE98633FE766827D8ED
                    70618F2E872D5CA18BB07BC53EB16D83165A9EF571C489677C50F7F23891B1A1
                    66AA0FAAA612F0BE40FB6E0078D9B35BC3A9CD5EE44C0CA371F4456FD4BEE48B
                    232F7091096F544F791CC5FEDE04B2AEC87220D075F026E0F5A06DF7AB6057C8
                    C913692E1ED861EF820C1767A4B9BB21DBDC03090EFEC8FCFC5364EDAFC2B69C
                    03482D3C88A4823DD8B68740971F7713BCDE58CAB24BC09B51B00F9904BB69B9
                    65C820A08EDE5E824803EC0A20E2A5F0205E0E49576A596C3696C4EEC4AAB452
                    8447EFC2BAAD4538D7DD471F68FA1BE0CF3F7DB67544A93C2780F3F4B26E0E78
                    F9F788BE0C1902F636F5C06BE627B09BB385E05502D94B50CB71BB12D85EB6CF
                    00C0E2672131B09DB31E4E6FC7E1CDE87ACCE5621409750276D9D37BA3C02BBC
                    B9FCBB1C0EC1D91E0878197CA7D3F2CDE493989F54874F731A905C78045BE91A
                    F260234578E94D5F3F01BC24E1F1A56DE93A4BAFDDBCAB02ABE2766149CC4E01
                    BC1134285921240D424C5DA76B89617925C16E780CC16F72311D9321B810FF58
                    BF157907AAC4E085072C0CBBB422B655227E5A32197865934DB67F1B63678A1E
                    7403A3FBCC85431FA2ABD89280CC073A82C84B8FF8BF9F18B2A4746106E02D27
                    A8638816396109C28AFD443E5D5164820156C0AC2DC9744803CB08BC2C865ECE
                    D8D0164BA0C3D0BB8B2BAE11F48A7CB3048F046A1A9E187715DC5D5FFC7A8E5F
                    D61374AACB183E5D804227F41499435DF731F552377792F03E69E966CE31D182
                    79AF13D3C01E2FBE8168B54A7A692FF4FCDAD606B4EE9D40030A2E51CC7988BD
                    A1A4FE52572808DA19B46F2EF731C3AE04BC928717E5DEE25A5C0DB9D797F43B
                    5C51CE4BC4F4A2783CCE2E77C29139B6A80FBAE4ADE5E59560DBDF83DB5FC6DF
                    B94C04BC3C09AE72FE281C0BE25CBA7638EF34123D8E04BDEEF638CF1E5C23DC
                    7E0F31F4B297B785746A823B8EBF321E952F12EC4E21502540658FAD986C4630
                    FB7D55FDBC27EAE8778F3EE743EBFE749C00543EE78586577DB1EF89C9D8EEEA
                    860C07CEBBCBB1BBECC525F855B02E4D56336AAB930792DCBC906DEB8E6C7B7A
                    8D930B72ED3D9131C209894FBD885DBB8B9052711829D904437B0E23B6680F52
                    B3D93B7B408050FF094FD797F45ACE06C0DE43862E9EAC169FB70F9F27721535
                    C943F8BD253C84EC6DDC8DF058DEA6F50D1928397A5C44AF731CEF9590CBD5B9
                    6EDA385E48D7255667AF4AC763AF7E01E7390970094CB8E8CDFDBE520445C325
                    680B2C667E8B09CB731194720A33539B45B6864B55D1BEBF66273609D065F095
                    8A4C10ECA61EC76B898D782DEE241667D520A9A41AE974CD920BF623B384BDB7
                    25575C9F4B62D035EAD27E06DE03226DDC57E9055816BD1311897992775D1405
                    E101CB15D7E8BB149D830FE3F311BE2507AB5268D0129B43F0BB0D1FA715A083
                    BE93F86A71AA4AFA9FF8BEE2EC181A8EA136980CBCB2C926DBBF8F71D6061D07
                    36009D676AD15AF10C4123412FC7C79A80A2EBC908BCC65006DEA72996421AD8
                    13ABC9F1477B129710B64137436E822D012C4F5ABB36F01A3DBB2C23FC322CB7
                    C6DAA12395DA98C7191F381E95408D805757AAA0F31A635ABF9FF87DA29844C0
                    DBC7205A3606FADC91D056BC087D770D343A0257BA21A8394FA820571A20680C
                    778B6B98965361E80974F91E4E78A065CF15FDD77B6C0D54C5E6C293AE2FF686
                    9AA0575541EB5CE883B66F1452593CA0605D8ADDE501C08DF58110036FB90B34
                    25D426F614EF77474FA207AAFFE888BAD997E0F54AE035EE33A5CB40D728DA5F
                    136685A3EFD8E1D4EB04B8DEA3D0636F891E85032EB812FCBADD38F07205B62E
                    672B9CF6B2C7F1A7390CC11F475EF42668F515E10D37929A4CE4F09DE285A353
                    E8BD3FCFB01C40BF3F0E47A7FAA3E6353FE4788D459A832B329CDC05D06628DC
                    90E5CCDB2EFD52915D12873424B98FC62E02DE5C3B777ABD0BB6BA79609B8D13
                    D2ECDC90BC7805920FEE450281E9F6E22348C8D983F4FC83486608227035956E
                    EC9A62D825704ACD2B931E99975462EDB652AC8AD949B0B4FB625AAAEF25F608
                    D37229C16E38A72F4B2842C4E6EDF8323917A7FBF86F41278A5008E835002FEF
                    13A3E89B318EFDA1BF961DFB4FC072FA971815140FE759F1700F8CBF21E055F0
                    32908B5244C376D60628DE89C3CBEB2A11987E0AAF24D69B4C2F765D251324C7
                    3560767C93005E8666CEFAC07A25A10173631BF1D5AE6AEC2892CA3727141C44
                    5A117BE8B97CB0896B64B84EA6C4D72CB3F0106273F6E2A378BA5EB1D9589A90
                    8B2571B4A4EB61F23A5D47ECD55F1943031D51518D53D0E5206253328A9A4E89
                    EF7C51C98E2F9758EAE86B4D459BD2B56493815736D964FBF731223286B81EFA
                    C7615CAD35FF427B993501A014137B23327A1519BE18748D8FD9393D16C7EE76
                    A77BA33DC1011D04BCBD02720954E2D8C37BED90066305368EDB35C26F4FB202
                    EDF10E742C057A77784053E423CEC1659151AC10E067AA7DD792005E91B1C003
                    7D25CE047EE3A1E4945D4DEBC58C7135C1AB14B3CB8FFCF806DF059D963D5197
                    6E0C579A4ADB47AFED34C48C70968C2E712C7D6F2BFAF63F87DE2207E80B092E
                    8BFDA12C77A636533F15FB527B6E14780DF1B8A2EF8DE1230CBCD2CFAE7EFD75
                    44BFA3612F397BBBCB7CD1576643D7CD07273F7646E51C7311D2600A62AF09B6
                    A46BBDBE36CC1A4DA16E38FBB42D5A1C4740ED22159838A330BF14D27005D85E
                    4BC2C3EB6C8D2E8525CEBBD8E084BF2B4E4C1D4F90CA65807D4498C20D797819
                    8E09940FBFE04100EC2385363C3F96F64DC2BEE77C916E4B90EB40C06AC8CC90
                    E9C49E5E775A27F065C0BD42ECE14DA3D76EB577C32E07FA5D574F24B8BB21DD
                    D90DDB6D9C113FF1596466A6236B6F15D2B2F76277FE21A4141D442201948801
                    2540FABE4A1571BFEC39DC836482ADC4C2C3F83889C1499A0825C5ED5EE105BC
                    8EF8F79644656355CA1EE1E55D119F8F25EBD291BEAF59FA9C13E86A089404E8
                    92F1930D1DCF8EBD6163EAD2E39C528F97176CC1A8D99B611D9202C59C58B8CC
                    E578DDABC1F65A12AFE5EC0D73A3E11E1A07F399DF2260F14ECC4E3C8E191CC7
                    7B85F7F63BC5E5830976E72648797CDF4869C26B9C8E8CE0F9B5D8062CCBAC44
                    7C510D7650DF6FCD2F4372FE01117F9D59CC71BAA6AF537F5DF2F612F4D2EF65
                    15EE47467125BE492340DDB2437877972610A8D280C5D435BA9E96D3EFAC4CA0
                    418BF00C1720226A2BB6EC2844AB8A132CF27799349FC370F9A016C07BE9FAC9
                    C02B9B6CB2FDDB18C7A3F2779D1667C5975E775B23CE1F088696F3CE0A689280
                    508222C3E4A68BDB57EB62C60082477E2D3F5EE7D85D653E4F54734407C16D37
                    016F0F432F4F488B774667A28240F6DAD06B9CA8C6EB462F6F371DAB33CE1EED
                    298EE8CD1B4DE7F0858E001B04DABCBCB25DD715B5535BA6A075FADDFC31D094
                    DA4359F50ED07BDCF0D5CFDEAC3E7157E06C4C7A1A246874DDB4F7DA2E5E9E6F
                    AE2348E65F60A7B05AAFA23D5DE2E6A23D9188DE727FE88A08288B03082CB9D4
                    B20BF4250CACDFB7EDDCBF46F58FDDF5BA34D0B861E0A5C143390F504805AE50
                    729BAABCA0DCEE83A37F7644F55C825EF6CEF68BE5E50968BCECEFF1ED2FF6E6
                    8AD770CC2E03AF0867A0D787DAE0F4CB9E383BDA12DD8E04AB6E8E38CBA5835D
                    CCD1E16A79295EF77B8881B7D595CB0F5B10345BE38287134E3D31060D2FFA13
                    A8FA0880E518DE4B50CB93D8AE33918D7E5635D51F47A6F8A16EEA68D413F8D6
                    4F1983C3CF4FC4B6319E04BCEE04B15E04BA52CC6EA623C1AE8317B629AE9DA5
                    218B5E93EA4CAF63F0A5D7A5387B20D5D50B3B1D689FAD2376BCFD1E7613E026
                    10F46C2FD88F945C297FEBC5B8CF6BAD5FB12FAD902B7911F4126C710CE9B759
                    45581A938DA5B10504BCF9E2B1F895719ED7123F3E8F4C644F21C3562E96C4E4
                    6065522122A27761F1969DB8D07E4E60AA9206841CC3CBE10C0CBC5ACDCD8435
                    48C4F579560D6C66AD87ED9C18B88724C03198B33230C05E0EB5DF25CEE6A020
                    79CE4F82E51B6BE014BA052F7EB10F73924EDC705A32F6EACE49E072C104BB89
                    8D789D60F7CD24F6FA362230E59CA89C97527A84FAFD30B6D275D8915786D4BC
                    033468396CFA5A5D2111D62024012F5FC38CE2C388CDDE8F7FD2355841FDCE31
                    BC97C5EFF2BAD8E658EC6B5FD3A5B139589E948705748C707AFD87313B507DB2
                    857A9AAF91F0F18A900683839E4C0AC3329A0CBCB2C926DBBF8DF1571BFB7779
                    45ABEB8592E0ACBD3E057DA50E04AB4E12849530F4F2C430F6A44A8FCE4D0213
                    C9F833CEF5CA6208D3167AA12DD30E6DB1ECA175400FA7228BB526F025A04D70
                    4367FC77032F7B75799DE377DBD9D34BB0DC1D678BF371749C1D047D650102F6
                    F4047B37EAE1953C9BF604BD63807C4F28F758437D3659DCCC556AF680D04D9C
                    4312E81EC1B53B185A95A2E429BFC2B4B1FF44A9A29F731A38EA572EF2A14237
                    54B4D4F4B4407D780601AF1550E40F25C1B6BADC8EDA7DBD30047E4FC6F7C5EF
                    51DACF4B065C0E19014F0AA4750E21917E7683FD40C755726ABA721AA81411FC
                    EFF34717B58BB361B4AD1B8B23B32C511D6441D02A852BF0E4B31AC3B629D865
                    D570C10A7A5D4330C32EFD4E180133816F7DA003CE4D74C55985057A5D1C70DE
                    9900D89580D57D143A9C0978AF80DAEB8AE0B8D5DD8664816E3A4EBBB33D8EF9
                    38E3B8F0CA12F412C432E80AC03580EE25F0ED07BA46D16B2A0996ABA68D23E0
                    F5A47D6E687C692CF64CF4438283B334518D80578AE125E0B5F710591AB63BFB
                    88F085AB6097B48D81D7CD0B290A7A9DFD689237B62B7CB0C3D1033B2DAD91A9
                    781C3B37A720A5B21671BBF7605B6105B21882AE0026E376FFE5A5757A0D4F54
                    CBDF83ACB28388CFDB8B55B13B1141B0B324AE40F2F8DD00F0325031EC4626E5
                    223C761756A614229C8EC531BDEF6DDC89ACDD390299D4444BECE155AB5492B7
                    90FF770D13F976C50052CAEC20E24785E9507BEA1C9EFC631C46CE4C804B503C
                    5C67AD8343D866388644DF18F08A496B9CA9211A0EB336C17D1E8173E02678FE
                    3505B3A21A3127F5C445CFAD10AD0BB815E9CAAE2E3DCCC03B9B80776662135E
                    4F68C09BC98D7893B683138F63D1B6161494ECA481CA3EC417542283AE59765E
                    295D87C3482C3842D7E5BB81D7780D59A9051548CA2F159EDFF4E2A3D8905581
                    D5D4E7CB68D022C5F0B2D8D32B5D4729A6970632A6A0977FC6E1108974FD69A0
                    B2383A1B898507A56F2D357F9149DFFE22069B764AE1D7745D4468896432F0CA
                    269B6CFF3646E37951798D5D996A74729829D4ED2D683E100A6DE5CFA1CBF317
                    E567B5258E0443FED05570E104CEA77B353089C95F7BB83CB11B54E56ED0EC65
                    301B0DFD0E4F744449E1082C29BFAEB4FCAE2C0D4619431B2E6DF304363B74C4
                    3A1010537B72FCA85DBE50736ED91B8CE115A047E0A9DDEB42CB9F435DF31722
                    5AADF0EE6AAF535CE2668C6F36625ACEF942EAA33104BD6E50136C83FA4B5FC2
                    1926AE05A9D24440695D02DEFE5E5DDEBE04B8FC3A53398AAF2FFE7D51B299E3
                    810DFBF87A8A361D7246ED1FBD513977148E8712C8CE654FAD23EA68FB583041
                    AF09D8652FEEE1F923D134D70A6767D910F45AE0C83B16A80D76C2F117DDD161
                    6F2DC1AA21CD985817DB5700ED77887FA7C38DD3938D428BC21C5D2E9CA3D716
                    67267A8AE213952F716E5E5F343CEF8BA6E77CD1F8FC18B1FFE8D46B7B79AB5F
                    F0C6D117BD503DC507B52F05E0F0EFC763ABB32BB21CD943CB507B25D87A9884
                    5DA38CA10D2CF6020B89752FA4BB7923CDDC16E9D35EC78E7D87919A5F8DADB9
                    7B909A578294BC4B45298C509451B45F7805791F172F10050C0CFB3272CBB08D
                    7E27A9F8103ECA2CC20704AACB120BB0225E4A497615147D97189A48BCDEFFF7
                    05706DCEC7FE63E7A54FB598E50FF4AA39B998402A93C64F4A54F497A5D629A1
                    576BA0A24121BF9A9F802C8ADD0FC56BFF84CBDC2D700C4A852D81AB22842BAA
                    455D9E76EC7B88539519974EA15C9D2D06F68151787E4505E6A69EC20C82DC37
                    521AF07A72BDF0D6CE4A6A26A82510BE06F0CE4922D025C0E5F46433521A318D
                    5EFB7F690DC8CADB43D761BFE11AD1F5E1EB24C4A0FBDDB07BA544FC350F76E8
                    3A6FCDE76A6C87F149723E1611F0724C2E43EFD2D8ED8848D82960363C3697D6
                    CB4C022F0F70B8C808C3F252BAFEAB62B6A3A5CF00B93C72FF1E2603AF6CB2C9
                    F66F636AFAA752D12D8AE88E63B7543CDA57E9D0DE9C8D8E2205749CFA8BB307
                    147B42BDD712BD85BE0459973C8C574A4B00C74B0D7B82CB474353E089CE6482
                    D3D84BD91606465C8E9827BD39A13D960038C589E091B34BDC846793DF0BFD9E
                    32D701AA7D6E04A347248F15F54FBF0C3D03627C7B67EF2FD727D6D4FF0D7D45
                    8E62C29C04ACDC9E6BB49DAF81F17D89D74ADE7323F05EFC99F839ADDF44C607
                    63BFF1524C8413130EE9389CB1E18017FA364DC2FED047503BDB064D810E383A
                    679480DA86505BD3C04BAA0D3547C35C4B3406D9E008016FF53C6B9C9CA5C0C9
                    0002548501746F519772F3B267D852006F2B7B8CC728D0FC2C81EB343F54BEE8
                    8D9AE77D504F805BFF82AF88EF3D3A95E0963DBE2680F7E80B9EA89EEA85AA17
                    7D68391EC501A391E1E48A0C471F02D86B83ED0D898037C3D91349CE1EC8B671
                    C67A4B27647FB5094955F548CA2500EAE7E115DE3F02DBFEDB0CB9FDB7933905
                    59FE5E6416ECC3A61DA50444BB101ECF1ED95C021F0996AE84A25BD1E28D39D8
                    B8BD186D2A8627C256FA58732E5E0961AF61F445C31340858797D6F51A51801B
                    E5F51DF00EDE00A7195FC131908037341EF60CAD210CAE57E4D9FD9E12B01B18
                    0D275A3A0445C376CE66B8BF958C19318D084A3F89D713EB846672C961914FB7
                    F92AD8356A66CA094C8FABC57482E357534E8B8C0D1F65D7622BC1A91156074A
                    9C6583AF7D262DD38A2AB1614705220DD77145024F3CDB2DAE2D170D59CA401B
                    5F706D0F2F2D79C0F3D7AF939077A449F4355F03F6B47F1F93815736D964FBB7
                    312E80ABE2982DA23B9E69ADD4F12436DA4FBB3A0ADF434F394F5C5240CF851D
                    CA5DD153EC6C80ACABC14C78058B19C40C1EC7622FF46C77C685580B7413984A
                    DE5C53F07AE3628F6F473C4F78E3900707B4D0BA3A9BCE5D42E7BEA697D4B4B8
                    AD2853A0A7E061E86B3E157DC1B770959E0702D7B979DF9471E42F7B5868B5F5
                    00FA0ED0B9F3B81D0499349030C64D5F26EE4B8E2FDE4310CAA580B9CDFC1EE9
                    3A88C97AECE1E5EC180CAA2451818E3DC2A68EF51DE2EBDA5F027C69A9A7E3A3
                    642CEA175BE1F02C5B1C0B7244FDDCC7504DC07B34984B049B989C463A46B0DB
                    1064852361F47BF3AD097C1D71FEF70E38AF18794313D3BE4B5C84A2DDCD0A17
                    DC2CD1EE6225B2369CA3FDE72778A07E9A3F2A5FF04115A966AA9FC8D820627B
                    A7F8A19680F7526CAF41F4F39A295E3832C503352F8DC5A1670390E5EC4CC0CB
                    610C3E060FEDA54969372D274F025E0FA43B7B2157E18E74733BA43EFE32D2F6
                    9422BEA20AA93CDBDFE035E4CA694619BD8822C697A09725FD8C274A1DA4E501
                    FC2B85D34FED140507A43CAE1CBF6B00A001114F7E2B45C4C64C145535D2279A
                    78974687A2D88A5A82589346B0C593DAF8CF4AC365CED5EC210642576763D42B
                    6B44C960BBA0CD7008E5D8DD68380712B4CEE5A213A6A1F67A729ABB45C4F13A
                    13F02A38C4818E6735633D26AF2C4470EA29CC21907D23B15E7875A727366236
                    41ADC8C890DC74851AF17ACA29CC88AFC5CCF83ABC947C0E7FCB6A447CE1416C
                    2B281359172E79766F5D3C798D0B8764D232BDE810120B2BF1793A416DF46EAC
                    882D2690E56B49A0CB13D9E2397B43F615D7E6D2355A42D77D614C0E56466789
                    6BA45572C11095A8BA799DC8938B2603AF6CB2C9F66F631A863A76CDB02753DB
                    478B4E4660B1A96EA8C7D98A3150EEB122E055902641C3B1BC3CC1CB044C3120
                    310C73CC2FF68C817AB7175A93ECD016678B9EC481055E86DC8E04025E025F9E
                    BCD6996887CE7407680B38B5171776B831E855175B4175701CD0D6CABDC1D1B6
                    50F22040DFCEDD3480C6718B6AF4E9B5D24491E6CFD15DF80874258ED48E6BA4
                    25A3BED69611F092449EE132DEBE04BC5C308381574330AC6150A5D7F1EB6F06
                    78D9A3CB55F1FAEF335E57EC73405FB21F0EBF638DAAD916384E405B19688123
                    21B60278A5B8DE7EA27DC767DBA07EBE0D0ECC3347FD5B0A9C7DDD05E73C2DD0
                    696F71C3A10BD792380E016FAB9B35CE395BA0C5D512BDAE0E6875B2428B872D
                    4E3EEF8746CEB430C557787B8FB0D79640B79ED38CB1B79720F7CAB464475FE4
                    2213A3513B6D32727DBD916ECFDEDDD148574871BAA6D28FDD8CB6397A20DBD1
                    13090E4ED8E1E48AF4DFD860DBD29548D97F04C904BC57422ECBB89DCC1EDFCB
                    F61120151FC2BAED65888CDE85657104448904470979888C6538BAC1B464D711
                    C3D4E2B822015F5FA716A2B9AB4F0015745C9442AC99367E94CEC0CB5F399CB3
                    8FFE1E720F9FC3432F7E02C79014388626C03E78131461ECDD8D836B480241EB
                    F74F4976490CCA5BE0C2CBC028B810F0324CDBCFE50A6C9BF1E6865ACCCF3C4F
                    907B0C6F26355C025E4E43768566925E4B3989B904BE6F441F1593D7BEC8ADC1
                    F6C21282D23D97A71BBB2571C80A5D4BF6EE73D111C320267D4F2562B2CBB13A
                    7637966ED94DE02B01ED8A449E54C8C0BB43849D5C7D8DF2B084F62FA041C991
                    D3ADD4D73C094149C0AB864ACDF993C515B9AEC9C02B9B6CB2FDDB98464BC0CB
                    E4455F7E3ABA19E9F54AA8F51D74CBD289390DE7AA3E466B197BF9D893E80E94
                    4E806E8FFD358157AC17D3B2D0177D596E688B251025286DEB574062A0245295
                    114C77C64AB97CDBE26DA0DAC18FF76F1078E97D75136C6A8E6FA41ED14B49F5
                    E9FF3C4F4DA7BB20FA69E08C87177C741E5CD099DAF4E83C321ECA62EA5351FC
                    E21AEDBE0D210D2C710D394B03AD1B336E88B0063A675FB90350310E273EB5C7
                    A1E091C25B5B1D6889EA799626C319EAC2D8C36B8BDA7936383C6F144ECC7144
                    EB134E38C7E5839DED2EC5EEDEA21878DB5D249D73B616852B7ADCEDD0A1B044
                    ABC21C67C77BE0E433BE6898E2874A82DEC3537D0868A56DF6F05E15D240C05B
                    F582276A5F198B8AC703906AE782ADCEBE48717043A6AB148A603244E106C55E
                    DEED0EEED861E78A78374F64B8782077941D527D1FC7AE946DC82A392CBCB862
                    163F2D8D210CFDE3778D210DAC4CFA794C4E393EE462059CCE8A80871F83733A
                    ABA5220FEFC086342C61A08E2BC4920DDB91517694B3531348F5D247FCDA2425
                    A5BCA2C11E9723A6B536DA9CF25E141E797D1D1C82E3613B370A8AD038E19115
                    9916085E79691A6A4D4B4A4B46CB3904BAB4749CB3453A1687489046BEBE0693
                    C2F33027FE1802539AF1466203416F93589A0A6760F1CFA7A79EC0ACB85A4464
                    D520ADE810B6E515D1F529BBD8FFB72EE95AA6E61DA46BCD4547CA6950532A79
                    F10BF6E3AB8C622C27E85D263CBD9C7583C5D77497085F30758D166DD88684BC
                    4362B2AC5ED347FDAEA6EF7C766770EF7F37F1CAC02B9B6CB2FDDB985EC793D6
                    78962E4F24E1DAF8FC354820A6E1296C40CF993A9C2F7E1DDABD8E0440043C04
                    5728F2231092004B7ABCCEE26D7E04EE26B205A87779A035C15EC4D74AF1B603
                    0FBCA2F25ABC1D5449ECE525788A27E8497482B688A18DA14F6AE3E5EDA46D86
                    F5FE9058EC006DD53CE87A9A09F6F5E8E5597C1CD3A056A357CC641E38E3F846
                    9E28C891BC1A3E0FFDA73E150B55A923B5C3596A1FF7E5C5F6F13AEF6380BD94
                    7DE12AE0355C0F49FCBA1B07DE8B031692086560E025F835AEAB797DAF070D2A
                    0818FF6A83DA59AE680CA665D8A3972037F472E06D0876446598256ADFB6C0A9
                    691638EF6E8E36853D5ADD1D8557D614C0DEA818783B9C591CC6407267F8B544
                    A7424A5576CAC31E67278F46F30BFE38FCA20F0E12F01EE16214CF33EC726109
                    A32E016FED3482DE2963913DDA132976EE4877F245BAB327529D1D08784D03EC
                    8D8A81579AECE68664850F329DBDB1D3D101A9564E487E7B01B6151F403AC9E8
                    E9138509F2F70AD0CD2C364C5C2BDA27A037935EC795D5D666E623223647F2F8
                    C51110251408E05D1627CDF237054537258E0FE589530CBC9B73B03A2E0BF5AD
                    2D12425D87A3B4F4B967E9B58CC7C086CC6A98BFF615AC420948433613B0C6C0
                    35241ECE8171025EED830856836E1C785D48AE813102781573A2E11A14074786
                    69025E97A004D8066EC1F3FFDA4BC07B02D3539A302BAD19AF2548C0CB93D466
                    5D39792DB10653E29B119A7E0A51BB0F21A7A018199CEB98AEC3F7493DF6FD24
                    1D272DFF105DD3FD48292C23ED119937B6D2CFA2F3F66175325DD7A85D5841FD
                    BE3CA610CB62F95AD0751583190E3391AE310F6EB850C53F13F3D174B6530C30
                    7876B29A963C4F43A3EDA571093F62BABEC9C02B9B6CB2FDFB187DF989F440F4
                    E5C7B1BB6292167B68087E5504BF3D1A25CE5745A397800CE5B65016125C958F
                    81463C327725D1D290F715A59C733780C0CD1F6DA98E682518ED24006D8DB545
                    77D2D599166E557C3C568F38B6E4496E8FB347F736176ACB1882356F688AF9F1
                    3CB795E08DABA915BB43B35781BEBD76B49F60B1C899DE9B0F706EBBE80E8E2D
                    D412FCD35D59BA4170FF889F0C8CF1D1447E5E3A8552A3125E31F4744359194C
                    D0FB5B02585F517D4D596645F0EB47EDA73656385E845C094819702FE9EAC96E
                    BCDE7FFBFBCB789E8BE733787B19BE55653E50725538DAD7B2760C2A6639A031
                    C80A75810F11E8DAA33AD80A0DF338FD9825EA68BD8E60B82ED41235F3ED702C
                    D0152727D8A18D2BAAB93AE28CBB94A1C114C0DEA8A49006499C9D81D5EAC2C7
                    67A0B641A78315CEF83BA3E1053F1C9D3A964057CAD15BF9A227AA695F3D816D
                    DD8BB424F83DCAD919A678A3FE95F1D8337134D2ECED91E1E8890C076F6C2520
                    CD7072BE0A5C6F451C1E9141C0CBE748B777A76D17A4D92A90E91E801D1BA290
                    59720049C595C8CCD98F9CDC7D882B2C45461EC7EC1E2430DA2FF2BE66E49521
                    ABF420B6ECDE83D5F13B0970194AF305F48ADCBB4618BA8617F0A6C4409DB80D
                    4B09A822E24AB068E30EC467978ACF387F97F09F8FF81322A9E98B45FC0DD17E
                    0D7DF6F929127DE8517B5E8DE73E48C5A837BF816B28416E7094005591568CE4
                    121247F0CA4527D8337B39D45E4FC2C34B62D8159E5E86DC603A167B78F967B3
                    087C03A3E0F9D754CC89934A0633EC32E8CE4DE0C96B04BD49CD62FFAC24E9E7
                    AFA71010C7D6E2E35D0DC8283984A4DC425109CF58FEF96A78BD19198EC3C714
                    052BA43095341AC864F0B2703F366D2F4564344F60CBC7D284225AF2A4B56C2C
                    49E4FCC87958155F80A531BB10C9991D366CC3B6F23AEE79E93B9DFA5F7CB5D3
                    A68EBEDBAE973ECE6832F0CA269B6CFF11C613B6E8F6849E0BCDE8280D85B6CC
                    0EEA623BE84A7C441606ED1E570248670191FC385ECB1EC7D28950EEF4465BA2
                    033A0C502A3CB10CA9030CBC467526F4DBA6735CA0736B72BD09D0097AC5442F
                    82DE6282609E504770AEAA702678634077465F813554B57F007AA5C933836FFC
                    28B747D000C74FF7300A10FCEACE2443BD8F53BE719A321F292F2FC12CC7E5EA
                    A89D5AEE5FE3C0E2A26797019581F4E6E0F6FBE822640BE0F5869AE05BBB97AE
                    F7CEC9A87E5781233346E078081792704055A039EA39CF6EB0051AC2EC501368
                    8323A18FE1F87C27344F73C1E9D1342071B045BBB315CEBB5B0D18F0B2187AFB
                    836FFF7D7D4ED638ED658B86A7BDD130751CEA5E20C0E5B00502DBA304BEB553
                    FC45B6869A17BD51F5E26854BFEC8343BFF743B69733D2EC9CA4FCBA8E04BC02
                    7C5D4C82EBCDC898C66CBBCB68519882F3FA6E77F116FBB32CEC913A673EF2CA
                    0F6053F141ECCC3E8CAD3915882F2DC376029FE4FC7D221B4326C32E7B7DE935
                    5FB0773766BB88DD94C217A4BCAD0CA8030ABB2C06DEE41C8427EC261561594C
                    3E3EDC9489C6736DE253AE11550969499F73762E8AF2C35A862E0D74BDF4F927
                    5B195B8E91AF7D05BBA028B8CD95C217381B831172A51004095AFB03EDF79138
                    964162DB00BBBCED3697F6CDDD02AB39EBF0EC27A508493F2D60F78DF87ACC49
                    6C24E03D86E9090CBDC73183D709785F26107E27A516F10555D85A7A00F15C51
                    AD683F32721944070A78597C2CA3689B732BD392E3B4396B03C7F77E929C8725
                    31B902789725F08026078B930B1019578895F18588A47D118939F8243E07CDAD
                    B7F6844A065ED96493ED3FC4D4128CD10DEB7C4D355AF61034968F80BEC04FC0
                    188310C3A4B6C455787C55E51E50E7FAA03D99C193ABA14913CA78C29AB12CF0
                    ED10C70D77A53900450CBDA3A129E14A66EED010186ACBD82BED0B7DD16468F2
                    08960F12B0B7571BDEEFE01B47F06A38132FDFFCA95F451A382603B50ABADA48
                    F41639D1804241404BB0CE13D9A8BDDA629E9876C9C37B0976194A0717788DE2
                    500B14511FD24047BDD70DD83F16CA241F1C983312757314A8996B89DA402B34
                    CEB746D5DC11A80DE354657638FA961D4E4F77C6195F0B9C5758A0C5D916679D
                    46A1930B450C20F05E4B227B833B83AF0DCEFAB8E0C4EFFD51F3D2381C9AC225
                    837D457EDE1A02DFDA29A351F5BC3B6A5FF243CDCB01C8F773472AC16EA62317
                    94F093805740AAEBE599166E55ECE125D0DDE6EC859D6E3E629D95E9E08AE491
                    A3B1E3D3AF9070B812197947115F7418A95C852BA7403CEECEE470064E4546FB
                    37EF2CC7F2E8ED528C2701E9608BA137C2901B369C806B45520116AC4BC59ACC
                    52B48A2C65F479165E44C993C855D8B81A9B285548565E7D1E5EB3D6C162661C
                    9CE76D8567E86601BBFDA17530C4E0EB111A07BB991B601FB4098E6F45E3CD4D
                    B508CD3C8BD7E2EA303DB509B3383343C231BC9178026FA49CC2CB29C7101477
                    04FFDADD886D7B8ED200630F328AF721B5808177BFE4853540E9602A435CF3BD
                    D894B3172B68A0B1286A37C12DC7F5168A896B1CD3BB24BA002B52CBF0C1BA64
                    14571F177D7D2B2603AF6CB2C9F61F617CB38292A34D810B9D3A9CD9FB1EC1E2
                    4304403E04633C31CC4B78793973839A605759E189EE4C67825B3B025D5BF4D2
                    B23BD646AC771952880DB6D893DCC3191CE8BCEA1DEED45E1F025E0F023582F1
                    0A6A23578F2BF5070A7DD15B6801F589A5E0C9E2FC98EF7698005E7D8FE4EDA2
                    EE556BBB087A55FCB491461587D1B7EF7982DE4780627F025F37113EA02971B9
                    E46925B8BD186E6058BF124E074302780BE85A977AD1757683E68023B8BADB89
                    45AE383C4B81C6101BD473D9E0100BD4721803AD1F09E2185E179C79C6161D8E
                    23D0616F810B0C9EAE96E876B1923CB2832D025E8EE9EDE6185F275B9C99C050
                    EB8FCAA9BE22C4A18A0B4B4CF546CD0BEE04BC1E68787512F6FDDE0F5BDD1878
                    3D90E9E42D72EFA63B7862AB8B17B25CDC699FE98C0B372502DE74065C5A5E5C
                    E7FDCE9ED8F58833E2027E8FEC82626C293F82A4A22A64E65410E4E62225BF98
                    40971F79EF4742FE617C964CB0B37927414F21B80C70FFD9FA83A6E85C910162
                    492C9D3779379D37078B36E6A0F0E859FA306BA15173C08E9AC09727A969C518
                    0F5A9EAE09CC5B9503ABD737C08E33330425C325E86B8251296E773025A03A24
                    5A9AC816140DEB391B303E3C07C1C9273023B101AFA635604672830178CFE0F5
                    A4537825A9160BD30F23B1B0163B083833B20B85773DA3F0202D0F88EC0AA6B3
                    2E0CAC320A18B4CB445191CFD38B11BE79179611ECAE8829266DC732BE16F145
                    58B0391BDF64E6A3478CA459376F32F0CA269B6CFF11A6D177D1FFD4E8D3AAF8
                    213C5A6A8EA3A5D0195A8EE364E015E9B1DC44295A1DC18FB2D0031DC90E52BC
                    6EAC2D7AD8BB9BE080D668AB014D49763D31F02A398C22CA123D694ED015F812
                    B08D114530D404E7AA72076ABB17D4790A741EF2007A7AC4FC34A588381C7CE3
                    68464EC7C4F3D5887AA1D37713F7B641CDF1751A3D54CD5FA08B27071610EC16
                    53BBF7F8D1A082E38D0DE029BCBAC6759E24781B81B788007B8F375415EEE82D
                    33070EBA4399340987DEB1415DB0A580DDEAA051687ADB1EB5C1B6A80EB1C799
                    57DD71DA97AE85A3257A9DACD1E26C85360F1BB43A5B9806D441D01982DE5E17
                    1A7C3958E2BC972D4E3CEB859AA96350F5A2A4DA693EA8E63464537C513D7532
                    768FF144BAA307B20874B9B25A06C16E266D6F2508CD1C680F6F3FA5D9BBD239
                    BC842799D7B3EDDDB1ED778EC858BC1C29555548CD3D8CECFC4304BB8548CD2F
                    11B19DA9C59558B7AD9C8087809367EE2716883006535ED981552E56C6E61370
                    ED26E8A57327E62092CEBD283A1F5F6794E05C7BA7402D1DA7C1A2CF3B4F8ED5
                    0A0003B61D6C80FDEB9FC08E27A6CD8B8343E046B884ADBB2D1E5E0E8F700C91
                    60D7714EB4C8F1EB101A8357D71C4650FA09BC92728C80B70E5C6EF8B5C45304
                    BDC7302FB90ADFEE3A82748E99CE2BC1D6DC1264E6ED27003D84B47EA9E1065B
                    ECE14DCB2F457AC9216CCEDE8B8FB800C596DD88A4EBBE2A3E1B1109F9584CD7
                    7ED1DA0CD49EE529C7F415F33D2BAA5DCB64E0954D36D9FE234C873E68745D62
                    46353F88EF23EA3D59BE125D5C0A97E0515F2EE57B45993750E88DBE2C577418
                    E374E369C913C868BD8DE0B7FD36026F2F8752C4DAA19DDAD2BBD38B00D74F78
                    23B5C52E046C0A02372EA0E105D5C98FC5FBE4146C9C39E1F6989E20409278DC
                    ABE398DE5E3ABB94C754D7D304DDC150A80B6D0868DD09D2474357C65E69E3E4
                    34299C4178D7097639B6D714A00EBC08767990C3212265AE5097129497BB53DB
                    02D0FCA91D8ECC35C7D1304BD4B142AC5137D706C7DF7645DB240501275740B3
                    11A9C83A9D68F0E36E8D736E04BCB721A48127AD9DA7F3B4D37A17676DA0B6B4
                    F82B70EC795F1C9C361647A6F889B086A35346A376EA58944D1A8B0C024E86DC
                    6D0A2E234C30EAC4B1B604C01C7E4010CAFB064A7C4CCEF1CB71BC3B5CA5F85D
                    DECE22C04E737347CE0847248E7912BB76EE42664925B617552129B718993CA1
                    A9E00062761FC4C70985581A9D8DE54985E02213C6496A83298E095E9140E0CB
                    450D08B47829C21C12721111B50D3BF7568B41B2947C4C2B3EE7F4811783CB67
                    FEB40E5673D6C32628066E2151700F8B86ED5CC3843286DEC1149DC33A70BD28
                    37EC169C0497C00498BFB116BEEFA723985394259FC2CCA45ACC486DC24B49CD
                    084CA8C3CA6D47699051858CDC0AA4E7158B6C18E9F90769D0B11FA90504A086
                    38DBC194005E3E2F0376FE0124136C7F9B598A9531D95841838E081A7C2CA1E5
                    E22D5988D95546FD4E7DAFE9A32E97637865934D36D9BED3D821D3C5A91A342A
                    68556DE26675A1B11EAD454F10ECD84157C18FB85D01CE7B9BE383AE58A92004
                    E7DCED4E74221926AC252B70C190968C8174B0D59D40A09DE48473B1F6684955
                    409B47405EC493D408CE091635054E501D980AF4B58849795C7548DC976F97D1
                    F9384D9056CF8F7DD90BA3A3ED3E70890BE18F698C85AA7004D415E650963B10
                    D4B2975AF2EE5E4A436604DE4BA10D83293E87AA844B37BB118C138057F84259
                    C0612C8ED0657BA3F10FAE3810F8186A187883AC703C88207896055A151CBB6B
                    8B664E1546D0D9EB608D56C79138357AE0B2345C4F0CDA1DAE4E38CB21146E56
                    E875B642979B0D4E3CED837D6F8C43D58B01A87C9E2BB08D41FDB449D8E9E181
                    24FBD1C8527863AB932BB63933E0BA22D3D1155B1DBDB0CD89F71300736AB25B
                    968788DD6571DCAE318637D3D19DCEE3896477825E07476C1DE586D83F2D44EA
                    812A24E6EC27E83D8CACC2FD04429558975581882DD9043CBBB12C39178B38BC
                    80C0F362AAAAC1129D6369CC0E01BD915C0861CB6E7C985C88F098ED04DF5BF1
                    697C0EEA5BF8AF8B3EDF9CEB9BF31D924567D7E1A1A73F82654812146149709D
                    B901CEB33740119A4D40CA55D14C40EA00CBF1ED289196CC353011AE7348C1F1
                    1831F30BBCB4EE20E6A45EC0AC841A4C4F6DC0B4A463989770149B736BB1A390
                    80B7904033BF042962B0711829797B9159B687D6194AFB4F361B78719C708698
                    A87800A979FB91469F81A89CBDF828693722E376213CAE144B38FF72CC561C6F
                    EB10DF677AF6AE8B61F4CD9B0CBCB2C926DB7F84F14413A3191F47F6D1F7E7B1
                    C3DB458A2F5DB1AD28E5AB2E9F88B3698FA233DE19DDF10A438AB07E8A27D8BD
                    72DF6089E387530974A22DD11BE380BE1827F4A539533BD953EA0E6DA13B3AF6
                    3A43DB9AC98E277A3F1C53CBDE56F1F6EEAC29D55011F172533407DF06765B41
                    5BEC8EBE3205813A7BA909DC39BD5AA90BBD1F77A098B7B93A9B298FEC6088C0
                    D71052214130AFD340A2DC0D1736DBE0E04C739C78EB311C0EFA054EBDE98536
                    3F4BB43813F4BA10E4925A48175C694910CADB17083E2F10880EB6BA393D1941
                    2E9FBB8DC0FBBC8B259A09B8CFBCE083DAE7FC443EDEAA398F6377801332AC6D
                    90E6EE8F5427025185E4D9BD534AB7F742FC682F24BBDA6187831F52D76DC1B6
                    8A5A64ED3E8244029E2D04BFAB093897C690E24BB024BE9440740F22630BC544
                    A6C156646C91B4CE396159C67D717BF0DEC66CACD95D843E1EC2E9A59CBBCD2D
                    9D04B9D1B00A8A8143480CEC59A1719242A244A881C36D90A338172994D659BC
                    1EBC058AF971783DB11933D21AF05262B5484FB67CDB71A4171D21D064B065D0
                    95D2845DD295DB83A8E2C348D8BD175BF71C90F232971CC69AAD3C597137C1EE
                    5E846F4842696595E86B1A4B4349DFD9B7FADC4A065ED96493ED3FC67886B58E
                    3D90FC48D2601D678EA1B930149D07ACA1DBE38F9EAC005C4820B04824E04D74
                    41672241EF1D93333A93A47CBCBD716EE889A5F62429A0CEF12430E312C2D650
                    D6BC07A8CE08C8D5EA54D0A1473C02BCD3A6D3AAA0A27E56B157E6C24E025D3F
                    E8F63E0255450074E5DED09679424370A9297396B22510706A193809446F8744
                    2E6313D255D0A067F7249C7E7F340EBC360A8D7FF241DD342F9C70B646BB932D
                    DA147626D5EE6C7F5BD441E76A75B623C096CE798127AFB9DBE1E453A3513E73
                    1C6A9E0D40CDD393B1DDD51369B6DED861330E5B9DC620C5D983E479C7C493E5
                    3825DA2E0B076458D0F66B6F2335AF8800EC00924BF7E28BB49D5819B71511A4
                    55C9BB0934B76159DC764424703CE79DD152D287F1BBF051DC2EFC7563060E9D
                    6BA12F11FA44D31FD8C28D7950BCB909AE3363E13E3B0E9E73E2E1353741C873
                    6E3C5CE6C6DE39CD918A543CB5BA0873D34EE3B5B8A3F87BDA51C415D7632BC1
                    6EFAEE52A4E71F1071BC77429C7339A3603F5273CB447B18C0B38A0F22A5F030
                    3E89DD8E459B73B126B30067BA7BA501B39AB3BFD0605E4C16B87993815736D9
                    64FB8F3023E8B28CA985D8F8E9E4E9EA74B41EF0070A08BE627CA08CB6809AD4
                    15EF888E843BA7CE0427B427D8A183A0B72BC199DAA3406B1C814E3A4FB47383
                    6AAF3FF4E7F789DCA0FC9055AFEF825223DD24EEB4A9E806C593D7FA08C2B912
                    526FC3FB50978FA441C54491F24D55EE4E72318827E07910F41A0B800CBE40E7
                    BA4A1C2652E1021CF0425792B7A8AAD6FA325D8B3123D0E5F4183A5DCDD1E166
                    5AEDAEA36E8B3A5874BE4E5A76BB8C4217A9CD6D145A7C2C71FE59058EBD3416
                    8513BC11E5E088344F1F024D0F6C751C8D2C07EF3BAA4C7B1F642A7C84A779BB
                    C20B69F67E88FBEA73EC3E7A086BB7EFC3AAA89D5811938B157179888CCAC1AA
                    181257DE8A2942644CE11D119FFB236AD747D1597837AE085F64E48BCF7679F5
                    39B887C56254E016D884C55C947568B4902DC939888B43DC3939CDD9022F6AE3
                    ABEBEB1196D488CFB6EEC5CEA262ECC8CD43661E17FCA82095DF31A5E6948A8A
                    6B193925C8E22A7BBBCBB1BDF43062B61562D9FA6D28A93E2E3CBAA290908A9F
                    5AD17737BB7A6FC164E0954D36D9FE23CC08B8C68A3C17F369D27A7B5B338E17
                    BD8DF36904385B46901E45CB9647D0BAE93768DBFC2BD2AFEF985A36FF2FDAA3
                    68B9496A072FCF6EFE197A331F85EED82A224B15BAE92DA978328D5603B55A9A
                    B676A74D491D2BCA3C6B806EDED159014DC94B440B4F00FB7C81BD3E245E8EB9
                    B4BE8F96FBEFB00E7AA3AFDA17DD9593511BE18A66EF4770F2B7FF83E6877E83
                    B30FFD16E77FF71B122F2FD739DA3FD8E2739F7AF4B738FDE8EF70EE113AEFC3
                    745E5A9EA3B69DFEEDAFD1E8EC8C92C901C872F142BC831762B9B8848B3792B8
                    DC2FE7C275BC334A226D777017CBF56E0EC8B2B3419A8515929F998AECED19F8
                    7CE77E7C9A518A8FD34BF14956393E4A2BC197DBCAF14946113EC92CBEA3FA2C
                    730F3E4EADC0C79995F82CB9100547CEE12FFFDA099BD9B17099170DB7B04D70
                    9FB7191EF3B7C09DE4F156143C491EF362493183ABF93174FE68B886465D25F7
                    90CD183D7B331E5F5288C5DBCE61FBE193D85B7914F91555C83D588DBC4347EE
                    A8F2AB6879A40A5B2BF623F7482DB6EF3D84DD878F20FBE07EC46EDB23260972
                    1618065EBD5A0F551FCF08B8B5A1BC0CBCB2C926DB7F945D19D2C0E5763B880F
                    CF3534A0BB2E1EDA139F41DB90017DFD76A03E03A8CBBAB3AACD04AA33A1AF4E
                    97B6EBB3A03B9A0A346E037A9BE816A083126AA8F4748BE039793C794C274DAA
                    B9A3C65DCCDC4DEAD67788C96D1776AEC59148739C5C310627578DC5C995E371
                    6AD5445A4EA06D7F9C583D16C73F1A775BD448E76A32296AC74A6F9C5FE587F3
                    FF7C16C8F802D89103641642B533137DBBD248E9976B671A94D919B745EA5D19
                    D06CA5EBBF351D3A8245F58E0C5AA6439F918AF6AD49D8F7F77770CA631C54CF
                    3E8F9A09FE383FF9099C7AE6719CFC3DE9D93BA313BF7F021D8F8F43EBD34FA1
                    EEF9A7D13129006D4FF8A3C9EB71147EB90613FFBC0E2F2F8AC31BCBD3316D71
                    2AA62E49C62B11B47C3F063317C56306FDEC4EE9B5C5C99812BE156F46A4E3E5
                    3F7F817756C56262D897B07A791D9CDFF8062E6F7C05E7D72FC9E54DDAF7E6D7
                    707BED9B41972BC9FDF56F4DCAEDCDB5B07E95D667ADC39C55BB30EFC314CC5B
                    1587F92B3348A998BF2A819478C714BC3C0173239311B63A1BC12BB231FFC36C
                    BCFD6106E62EDE8CAAFAE39CF1187DAA1EE8D4F445429C2B7D675FFADEBE1993
                    815736D964FB8FB0FE610CC6B006B14FC486D117A9213C4C4D2BFC2AF64CB23F
                    E16E90F1AB9EDB75D97EFA9F28A5C15E10AD129CA752AB93CAA0DE69D3E9A91F
                    B51AE8D52A1A54748B8C0D9A9367B1EFBDE77168FACF5139FB11D2081C99632E
                    96957379FB2154CEA1F5DBA043B31FC5E1CBF498D8573DCB1CB52FDBA17ED648
                    9CFAC20B5D0D1BC5FBB975FFD2C0180F65F8A3CA6DE1257BC28CC31BDE3E5B92
                    810BA3DDD065F54B5C707D046DCED638CF13ED149668B9436A5558E1A4E2B7E8
                    72B642BB9302A75C46E2FC63FF8BBEC060A0B31DBF7DEE4B988D980933B7BFC0
                    CCE5AFA4F724B9B3FE7687F477496E7F829933EB5DDCEF3C0BBBF79D40E4865D
                    3073FC03CC7C3EC03D6316C0CCF7035AA7B60ABD2F34C49BC4CB41D6BD741E53
                    32230DA176393CB71463DF5C81FB7DA8BD766FC1CC89DE9323FDDC89DA7DC7B4
                    90F447BAC624575AB7A77EB3FF33CC7EF706BC83A5BF372DA739E4E7565A1DE8
                    2B0D6A5A6AE43CBCB2C9269B6CDF6DFD81F722ECD29728279117F9B4446D7CA0
                    9BB6B97E929AFE71CC18E7ECBDD3D20A318A73E002FB3EB85D1C23CBFE5DC21C
                    0DB79D63DCBA4548C3DD603A2E4841FFB8857CF3EA15DB406B79316A5EF92DEA
                    826DD014648F9AB9F6680AB643F31C1B3404D9E018EDE3FD83A963C1B4E4F306
                    39A031D0168DC1B6A89F6389A6103B1CA7EDAA599638BECC196D2923713AF369
                    A2C8FDE8A5BED7D03FF17E688064A8A64C3761093E6FA7C4F5E6F3D2C208BFBC
                    ADA18FB256D987EE0FDE43D763BF83D2C51CAD4E36A2425B87AB253A5DADD0E1
                    6229D4E5662DADD3FE41978B15CE7A8E829ACED76E4F6D701C85768505D45909
                    DC7244179DC28F3DFF41A0B818F78D0BC783A4A1E3223064E24ADA5E81FBC60F
                    BE868E5B896163090C0322F1C0B8480C1DBB0CF74F5A45FB176328FDDCCCEEEF
                    981D9E22DADB78B60D6EAF7E08B3D12B716FC062DC3B3E1C43C6AEC6F071ABE9
                    F796D2BE48DA777B744FC0320C99B082FA6A05EE25DD3381F6D1F63DE396E317
                    4F84635CD05778E19D757078E34B0CF15F867BFC3EA4D7AFA2D7F2EF2FA5F570
                    5A52FB272EA3251D8B9643260CBE864DA67E1DF32E1E0C58447D1C0E33BF65F8
                    D9C4F750769EFFAA68804903789D18C0D3F7B4F8ACF35F9EF4B39B3519786593
                    4D36D9641B70E362146CE246C5772C321E70703CEF8985CFE3E0F487D018320A
                    55F3EC09741F41D3ACC75017E644B2BE2DAA09E4D2C136A80EB1C0D1306A47E0
                    63A89F6F83FAD99638166A8FD60D3EE84A1D89962D23D0B32702BD9A6E31118F
                    7381EA7492F79A074C3C86E25BF19D366E9956A7164F01340DD538E9EA0695ED
                    636821E86D77B7459BB30DDA5D39C383B550A7BB3D5A14B42EF2FB0EBE3A5D6C
                    71DEC38ADA310A2D5623D0FD7630B45D6744DBB5EA1E4CFD5312CC5C091EC72E
                    C14F09C0EEF55B40D0B6140F042C272D1B74DD377E1501EB0AFC9840F7476396
                    60D89845B87FFC7298515BCC7C17E3677E7FC7B1F3EC4F97EC9B94120C735D42
                    BF47ED9CB010F7057C841F11300FF3A3F5092B4D9E63C045507BDF98706949ED
                    1E46CBA1FE4B096A9760F88425707AED634C0C5D8BA782BFC193B4FCED93CB60
                    36763141F22A1A4810CCFB2E21C0A74106EDBB9FFA792841271F4BEAF3C1D5BD
                    343078C03F023FF6FF8006141174ED17E1EF6BCAA867A5B46F836132F0CA269B
                    6CB2C936E0668C9316C0CB1E5183779DADF77036EA668C44DDAC5FA321D40DC7
                    E7FE8EC0F311D4062B504F305A1F46E039C8AA0921E00DB6445DA80D8E065AA1
                    318CC03BC416D5B36C7076990BBAD30812639DD01DED80332901509EC9169E54
                    89DDE97F9A2EE8551D4CF1F4262FBDB73B677AA8087895D23803CD9F4740F9FF
                    7E892ED75138E3C9210D049B2E04BD9CC7D700BD179C2C4D16B8186831F0763B
                    5BE1B8DB28743B3E8A931E2ED09716512BD53400923E273B0F36E17FC6113CFA
                    4610802DC73002B80726444880C41036C8BA873D8DFE04B0FEE1B87F6C040163
                    24860444E0DE719130B37D1BEF7E9E27DA09F1A4823DFD80E78C8F09D4DEC53D
                    FEEC095E8A07C72FC5BD04C743C713F08E33C0E3206B3881E37DD4DE217E4B71
                    3FB57508C1EE3DDEEFE197CFACC4B8796BF178E8B7783CE85F786ADE3AB8CDFC
                    063F9A40C0EB47904C807F2FC1327BD41FA0B6DF4FEF75C818EA6F13E7180C0D
                    A7C1C40313A8DF2752FFBA2F80E3AB9FA1EA340F87076FF02803AF6CB2C9269B
                    6C83620CBB4633822F1B1708EDDEBC00D5AF3D8CE3B347A261BE356A58732C50
                    1BCA9E57AB4115970BAE09B3404D30C13541AE281D1C6A8FA3B3CD71FC2F0A74
                    C57AA23D6B242EC428804467B444FF16BDB9D301D57951AC4449D273F4AC96A0
                    574DF073E96DDE51D3E8B45069D5E8A4752EA5DDEA17803ECBC770C18D01D706
                    2D04B9ED6E7662798100B895E1F70A381D2C9D771E059DC202CD16BF45F78A48
                    E1C7E36EEB40970890E6509DBFFC2B1D433C16C36CCC72DC3F7E0586FB11FC12
                    8831D00DA6EE27B81E327E2181EB020C1BBF8C609BF61368DF4F6066E6F1013C
                    DEF802EDBD1AE8FACE529BFBA05473EBB5283DD106338BF978C0EF33FAFD0518
                    1AF00FFAFD1530F35E4400B9CCE4B90656CB04F00E0BE0900A3ADFB81518E2FB
                    3E7E3A7E313CE710EC32F0067F85C7033FC313215F61D2DB9B30EA39EED7C5F8
                    11BDCFFBC6866318C1EE3082F361FE04ECE3565E71FC41125DD3077C69704003
                    1A33FF48FC880638513B0E539F72B70EDEE051065ED964934D36D906C58C9E5D
                    23F80A2F2FAD33F0F61CAF42D3FF3D89C6377F8183EF38A16AAE1D8ECF1F2580
                    B7EE36E86888052D6D511FC431BC76A80EB44055E86368FBC413DD69AE684921
                    184CB08532CE125D318FA17593057A1BE205A5F552FBFBF44CBD6A11FE7D3744
                    4DEB692CA1E780620EB7A08598DCB62D1EE7CC0976ED2D087425F0E492C80CBA
                    2D04BC1DEEF6B70D7ACFBB5AA1CBE661B47B8F07DA4F8B49803AE24695BE8F3E
                    12DC833DA83BDD0A87173E82D96829AEF33E065F02C7C1D7720C1DFF01EE9FB8
                    14F7716C2B833641E090310BF163EFBF62D3D6A3DCC5649D50ABDB45E808941D
                    62CFCCF7926166FF5782460266BFF771FF8495E211BDE9F30CBCEEE3108A7111
                    C2AB7C8F1FB5DFF73D983FBF0A4FBCBD051303BFC4E3215F6272F0170898FB29
                    2686AD815FE0D7F8C5842518EAFD1E86FA531F8F8F245037002FAD9B3AC76068
                    38C713FBF3E066119EFB730C683C41D64A9F63D9C32B9B6CB2C926DB0FCC1874
                    351A8E79956E6246F0E56A70BDB47A21F12B1C99CB71BC56A809B44353D848D4
                    99083F180C557338034F5623E0AD0BB6C6A1E087717C892D7A377BA13BC91E9D
                    890EE849A165BC2594C98EE88C7A0CE7B74EA37BF22101935D04699C028EE73C
                    6A45E4EC9D35EE5AEE6BAD9650B28FFDBBB4ADEAC085A0209CB21841A06B830E
                    373B29AC8100D418C77B3B8097431ADA0978EB473D0CFDFA28314050710CB45A
                    0F3541BA524F43081D0F83800F37E7E15ED7B7308CC168EC2ADCAED0008E6565
                    8FAEF09406ACC07FF1A376A7F978E14F1BD0DEDD2BAEB14AD34340D64D630AFA
                    4C0B48D7E04053277E33F1AFB8C77B01B577051D8B3D984BAE3AFE60E9BEB10B
                    30746C38868C5B817B7C97E0FF11B48F9EF1399E22B89D18F82D26877D8BF121
                    5F636CE0179810FC359E7E7B036CA77E82FB47BF8B21BE8B308C27BB11F0B357
                    FB4112F781A9F30CB486054460F8F815F889D73BD87D488AE5D66BBAE8EF69F0
                    868F32F0CA269B6CB2C936E0660C61E0A51174A5755E691788A839DB88A6054F
                    A1E98D9FA2F16D1BD4CC2528EA07A51C5F2BC5F40E745C2FC7EFDAA036D04678
                    77AB0247615FD86FD0B5D61BCA786FF4C4DBA0873DBB09CEB810AF4067921D7A
                    627922DBEF80431BD8B12BF26570F96422377A4FA2B4C61D35EE56AE6AA7D4F6
                    91546027642BFF2027032D6E0E68B11F890E0F7B025E5B025F7A2F04BC0CBF0C
                    A3A620F566258EC750CD204DE762B5BADAA1CBE27F71EA89F1343AE813A9D454
                    1A82481D812EB5B38BFDBDEC9DD66839C0014EAFAD84991B7B5D5760B8019018
                    C4D8337825380D8404E48D5982FBFD566098FF4A0CF38BC450EF7FE0BF272C46
                    5C490BB5A897FEE9D0C96930747DA2C04B3BF76D5F377D0A34F8DBE67C98397E
                    80FBC77C8A0702389C61D1D5E7188CB613A80EE798DC313C114DF2D48E9CF229
                    9E7E67339E9CFB192604ADC3F8D035F00FFD1A13DFA2750E6F08FA0AE3E645E3
                    679C95C17721864D20E025C8E73E78704CF8C0022FC75FB3685D78767969D87F
                    CFC4089839BF87B7C233B92769E0A3A48F000D80F4ECFB1F1C93815736D96493
                    4DB601B7FEA06BB48BE0DBA723C4E912191B3AF2B7E1E0EB8FA0297424AA821D
                    51FB962D6A422D7124F05134CC63D0B5456D902DEA4307187A4347A1668E39EA
                    431CB06FF6A3685E6E0755FA68B426D912E83A921CD029CA3BB3A4F5DE040B9C
                    8AB6A3461F25CCD1084F1F087E741AC6B43B6FD4E352BF33FED27F9C5F9AFBF8
                    EC82F771D2C61CB023D87531478BAB392EB85AA1D381C0D775E03CBC7CAC7667
                    73B47A2870DCC301ED1EB668F118854EC5083459B9A06FD72EA9480A0F147AB5
                    E8D34B29DE380EBA8F060E2A1E4990E51E688499E574988D8DC03D633F105ECC
                    FBC72CC08F27AEC650BF7011B33A909E5F0E6918CE99027CFF8AA1131760284F
                    54B308C7BC85B1A23D6C865EE50FB110AFAB0D93158F9DEC80CF2BAB60E6BA00
                    43C62FC1837E0B709F017019F444B8008125C7AFF2FA95E7FF3EE2DF15D0D85F
                    04AA9CBE8DDBFE80CF02FC76D2328C0DDE8809C16B3121F40B4C0CFE06134258
                    04BCBC0CFE5AF2F2CEDB80D16F7C81A11E7FC790B1CB71EFC40F0998D933BDD8
                    E4B96F4A0CBAE3A98DD41F436830317CFC2AFC88DEFB707F1E107C0033BF0F61
                    661D2AFA0FDA1E1A4ED02783FAD5F83468304C065ED964934D36D96EAFD18D4D
                    A3EB93E66377B5E2D43F4350FDD24F5147705B13C493CA2CD1389F279859D2B6
                    25EA821850AF00D65B546DF0483484DAA172CE28D4FFC516BD6B7CD095E484CE
                    641B01BC9D8904BD890E0649DBBDF176B810638D96B2F7A057F60804D232F40A
                    12BAF3C6B060141BC32F3F20D6D51EC029FFF1E8B6790CE7DC1E1193D8BA1576
                    38E1612979614DC0EB0D4B78726DD0E9320A6A7B5BB4BB2BD062F930940A4B9C
                    1EF55B28FFFA1ED079011740FD46FDC5E1DCDD7A1A2C18B25C708B457A37BD14
                    DAF0FAA2549839FE1F86308C4E88C48304B8665E1F1044458AC7EF2621EB2625
                    016F3841E562DC376129EEF18DC42F7C17E2D885EB5F5835FF98DF0CD997C907
                    30DCFBEF301B4340EE7F09C68DC03B9CDA7DCBC06B42C338EFAECF42FC9840D2
                    F9CD6F3031742326857C4560FB2F01B913097005F8F2D200BD4F847E43AF5987
                    877FCFB9841762D878CE274CFD1A70736DBB96B85FEF0FA001C0A415227BC4FD
                    9C1F983DE93CB18FAEED27A975A2EFA0EF164F25949CF66FF07857065ED96493
                    4D36D96EAFA9086C340C3A6AA5001DDDD1521C9DFE186A037F87A6205B34045A
                    A049841D98A326C40A8DF31C447883A9C96737253E76202DE7D9E360C863B8B0
                    DA1D48F0476BAC053A93AC250FAF00DE4B62E0ED89B34577820D4E263A4173BC
                    947DBC928772106FD2376246AFBA117A2F7AD4495DDF7C85E647FF17ED9E23D0
                    4A70DAAB7040F3E811030ABC2DAED638EF6941304D7D48FBCE13FC2A6DACD13C
                    C60B9ABD45D45F7AB4F29445BAF41A2DE73BA0F6F280818B0B6875506B395644
                    F296671FBE80DF4D5C4040B61CF7FA45E2FE895C1882636397622801E555DECE
                    5B1203257B1E57D2B109C6ACFF0FE151F9A21D62C4700DEB633ED7768B308D56
                    15F0C45B9F63A87704EEF5FF980057825D063F865C5E37E9A5FD9EE2DF65AFF1
                    65E27D135709E0FDDD33AB307E5E1401ED37783CF8734C0EFA97F0EE0AE8ED27
                    B18F60F8A9B7D6C12B703D1EF45F80A10CA1E33837EF6A93E7BE59711B878D61
                    AF7184A84877CFA455301B47FDEBB91863667F82F34A35541A0E09EA1339AEC5
                    9F117F1E06C964E0954D36D96493EDB65A17DFDAF846A75289C96B6CA7BF7E0B
                    556FFC12CD214E381662873A82DEBA600B825E5A72EA30CE9B7B457AB19B56A8
                    15EA82EC5049405DFFAE25BAD7794295E4868E78737424585D05BB46E0ED8A35
                    476FBC0DDAA31E425BE19FA0E96DA396EB388CF7AEB2CB3CBD04BD3C814DA7ED
                    C4C9497EE818F95BB473110A852D3A5C470AF83509B0372863ECEE19770B347B
                    5BE39C9B39CED3F2AC259D674538B8BC34E735100E5DBAE86AEA341EEEE8FB38
                    4B03B78F060F1AA2462D01317D2ED4D4F4BFFF7307CC147F23D05D2162541FE0
                    EC07FE0C501C1E6000BE01127B8D877328836B38ECA7ACC2094E3DA6239895A2
                    2C4C9A9493B98BA09D13C1013B0F9CC4FDCE7FC1D0B11F1B3C9C97C21A4C9DF3
                    46C493F84CE95EBF70FC37F58BCBEC3598347F1326067E2EF2EE3E19F4F9B581
                    977E3639EC2B4C786B23463E4FA03BFA5D3C10C0D5E63EC6FD86BCBE03237AFF
                    017CCD16119847C08CE0DC8C3DDC7E0B91985723FA4CA75342AB5741A9934AA2
                    F3E761B04C065ED964934D36D96EAB8969291A0232ADE4E1E387D89AE6BDA87A
                    C707956F8E424388BD21F4C012B54104BD1CD610768597F616C493D6AAE7DAE0
                    60D82338F7A902DD7104BB7136E84BB64557BCB5219CE16A75C698A327DE1ECA
                    584B9C8A3387B2761BDDA17BAEE704BCAD66F4F0F6F7F4EAF931313590FB5C93
                    168573FFFB30DA3C08EA5DADA051D8A36580627819783B08A4BB1DAC70922BAA
                    11F85EB078048D131F07AAABA4F33320D28A5EC91E5D8ED925C8E11868F6F48A
                    F6125D7249D93E691260655327EC7E1F0E33F7BFC14C94FD25882258BA7F3CC1
                    2F01707F6FE2ADEA81891FE15EEF7F60B8E22F58BFBD8A5A241A4A4466189199
                    302D7D7E353CF14E846148A036E3833898598581F3F8F6875E06406338C395E7
                    FE3E1200C9CBCBB41CF7BAFF1DE62F7E8C49EF446152E857783CF80B02DE2FF1
                    64C8B717C3182E03DE600E67F84A40EFC4D035F09DF3357E16B000F7FB71410A
                    292B86A9F3DF9CB8F2DB1209783924256025CC3CFE0FAF7C10836EEE32025D3D
                    F59D4AA3845A78F86934248D2206C564E0954D36D96493EDB69A9E20A28F1F6B
                    3389697B45A10476929E4FFB0C07678EC4A1402BD4BD6D8F9A9051A80FB14263
                    B00D1A08806F26651983F2A54C0F04BC626983A373AC706AB1137AB678A233C5
                    01E7E247A12FC9015D710E268197F77547D9A333C91D1D89B4DCFCFFD09D310D
                    FA965AD1F6BBC11870FBE73D96BCBCB44E60D9A32698A4FE6E9D3D1BE76C7E89
                    732EBFC3057B05C12A03AF04BDECED357A7CBF6FBA32065D7EAD98FCE662871E
                    4747B4D331FAEC46E1B4C5A3684BDD28DA22E677B1579F209127AE69B8D7886D
                    186F785D275EC0ED67972AAD1B6279BF482EC070AFB7614630F660C06A3CE84F
                    001CC015C2AE8E19FD3E620813CBFE93DE68DF907104632E7FC1D43F7D8BB61E
                    825D9D5284DDA845FAB16B18013A7F8E55A2D4347B83FB70BA07F8A9D73C9879
                    4BA9C944AC2D7B3909004568036D5F3CEF0D8881D70892C6F5A16397E1177E0B
                    3036782D9E7C6B2DC1EC67783CF44B917F7772E87AD3C0CB13D8E8F58F87AC11
                    45299E98F72D9C5EFD04C3C72E10E9C9FA9FF362C6063A57FFFDDF4B74ACFBC6
                    53BF4E5C2A8A5C0CF15D0E339FE518F9EC42ECA96C12DDA7E79C7E7CDDA9FFF8
                    B3C9E5BA07D364E0954D36D96493EDB61A3FB6E4E20D3A9D8A6E723DC2FBC798
                    A3BFD088134B9EC481598FA0F66D9E50F6181A430876830980432F4F59F67DC4
                    61100D61B6F4BB36A8E51860DAC7DB0D41D6A87C6B24FABEF18532CE9D809780
                    2DC11C5DB176E88E63B89526AA5D0EBC0EE88977466B922B5A92ED803873B46D
                    FE355A0F6F11ED672F25DFB419E0C4142C5A179E56DABE9D66845D36717EDED6
                    F540AF2698A47D3DFB72D1E23212175C1FC23937375A37802E87391820B6C5D9
                    4A82D96B412FEF37EAE27E0978CFB939A1DDC31EBDBFFB0D4E4E7992DEFF7974
                    7293347A708E55EEA12EFABFC8C84040AE64CF1EAD2BB5ECE5E3DCC6D2E047FA
                    44F4E26C570F02C2BE8499EB220C1BB3123F1EB78A406F89803E93A0751D3178
                    726CED307F297C41C0E83892C8D01081DF3C1E811DFB1BC5D999B7551A8D3431
                    ED5AA6A3CF315D7C355F65118EC16D0696ACCD8599E2EF02CA455E5F7FAE88C6
                    A04A1028A0F2C600520033B5557889459B23053C7339618769FFC4337FD88CF1
                    1CC210F419C1EC971817F835268572B686AB81772201EFF8C0357822643D1E27
                    30E60A6C0121EBF0F327233064FC5201B7C6F349ED3478A86F027AF977868EA5
                    EB367631EEF15F89A1A397E2DDCFA43464ECDDED93AA4DD09F0AFDAD88BE63CF
                    BFD835282603AF6CB2C9269B6C7785F1BDEE4C51326A67709AB2877024D8028D
                    731D501D6A8DDAB09B00DE402B3A8E036A826D7194F3EE86DAA329C41E0D6F5A
                    A1EAD391E84EF44477BC232D6DD015CFB2376468B81A7805F4D26B3A93ADD119
                    E704558C357A12FE170D89A381F63A29D453CB1965F58469742327C8640F214F
                    D4BAE3C620AE622F2AD0A9EBC0F9F005E81835021DEEBFC339172782557BB438
                    59A2D3D58AA0D71AE7155C99EDDA4529440E5F9231976F07EFA7A5B46D852EA7
                    4770D26214948579D2F9D9B37B33FDA0E3096C7D482F3F0333E7B708F256E1BE
                    31ABF180EF2202B31B075E06AFE19C7FD6670986FBAFC003048CC30216E19E09
                    8B0850DFC7BC95512276584B4DE5EBA956B3A757B4C4A449030A0E1B91DE9B58
                    EAB5E8E8EC83FBABFF8299E7DF6136FE43DCEF1F89FF1EC3E1189104815C9CE2
                    0681D77F311E1C174EF0C8A578094827ACC610EF05F8D9E4958638DD4B606B8C
                    DB350DBBACAFE935EB3181A0777210032FED0B5D0FC737BFC47D3EEF52FB1876
                    C36970B19006051CCF4B830B02ECA1344830D5B66B89BDC30CF93FF15E427DBC
                    84DABD18762FAC04772977EA9DF8BB90815736D964934DB6BBC2045BF476A23E
                    32048DAFFF12D5210A3405D9A186C0B536CCD624D45E4FB561D604BB96A80FE5
                    4970B48FA0B7720E5773B3457BAC2BFA923CD09BE844906B83EE043BF4243AA3
                    23E6522AB2CB6097F6756F71A6D72984A7571D6D0F6DEC63381345A05CB28040
                    876FE29C5B56C58E4B293E991FD31AFC9577D408C4341A15A1A3C18B76681FCE
                    8F9B882EBB5FA1D58921D78A40D5022DCEA34816A2225B0BC3EB15A02B609797
                    06EF2E972736AE33005F70A1DFF1B442E76F7F8BF37F0EA653750A0F294F48D2
                    F1E3EB1B358247BDA110C1943F47C1CCE16FB8771C01A33FC1D41580F59D62CF
                    EA040237BFC5F83181E210DF70DC1FC000BA5C841F3C3CE903EC6BE692186474
                    FDD47A255D521EB848BBAE6546D8651300CC179FEC9BCC0ADCCFA10D047DF7FA
                    2FC57F4F0CA773BE2F3CCA26DB773D8D27F01CB7848EC379773FC25082E71FFB
                    2F84D31B5F10C07E2B20D634DC9A1081F084903504C4DFE289E02FF064E83778
                    226C1D7C0880473EB70A66BE74AEF12B08AE693040ED1E46A03ACC3F5CA45533
                    86837C6FD1EBD9933E74E2C730B39987CD39528966B58A3F87DFD1B1836032F0
                    CA269B6CB2C9765718FB01198B341545A87CCD1275B349ECDD0D34974212FA4D
                    3CFB4E8558A37A9E258E848C4463B0358E07DA8ACC0F07C346E0ECF231E84B75
                    4167823DDA62ADD1116F8B6E02DF1E8ECF8D575C137839DEB723DE09ED4904BF
                    D14ED0C5D1CFA21E412B6DAB4F16099C5472252E5A118FE679E5F63BB2AE3662
                    0B0E26E8D37508D7253F48EEF8F89F681DF14BF4280870151CE23002ED5E5638
                    47EB1DAEF6687766B8BDDAC32B8097C4406C9488E165D1EB3BEC1F41BB932B34
                    9579E8E421009DAC57C469DE38E08881030D1AB8D1958D4A9829C2C42CFF2113
                    78029BE151BF7804FFDDE270002E653B640C7B4B09E4388C61CC32DAF711CC46
                    FD11CBBFDD295D2ACE12A1D5A14FC9B5D4BE1B78AF32C3F5E6508CA7E77F0133
                    B77F10F4728C30575F5B40E27CBFA6DB68521C0A41BF73CFD845B837602541E4
                    27B8CF271C8F3EBD0CE3C3BEC22402D66B7B73AF16BF7652182D43BFC2E490CF
                    3199E37E09981F0F5B8FB173BF117984CDC6501F73D804F5D7FDE397D3206111
                    7E3481E3884DB4EF3ABA8FA0D98CAE9599E7324C98F38DE81A1E7469D5D4AF22
                    66FBF69A0CBCB2C9269B6CB2DD15C6C0D86D08E23BB93902875EFD098E8658A2
                    61DE08348430F49A00DB6B8980B72AD41C35F3099A032DD11C6883AAA04750FB
                    81257A6326A22BD90EDD04AA027693085C13146889E2900667D3210D09F4DA64
                    279C4EB0C2D9644B5C48B4474FAC17FAE23814E22738BF7336F49D6745DBA1E1
                    DB7A1754DA3EA6F83B6E3CF15DC591C6BA5E74A9B5523E81AE73687BF639B4DA
                    3E8A76372B517D8DBDB3E705F0DAA1CBCDD16448C395C0CBEB1DEE04C86E76E8
                    60F81D39127D9F7E841EF48AD000FE9F9EAFE94D0467F26F68B99CAF216BC3E2
                    8D793073780BF7F81334DE00EC1A35D48F96046143C72CC050FAFDE1933F2688
                    FE131E7D3C521C9F637235CA4E41DA7A3D171396BCF5D7B38BE9DFFA9BF0666B
                    B0ABB409BFF6FD3B864FF81066011F621801E3030CB026DA763D71CCF2BDA461
                    1356E15EEF70FC4FC052784DFF024F857E6EF0D89A865B930AFE06E343BEC078
                    02DDC9B49C1CF83926919E08FD16CF84ADC3432F7D8B7B7CB87F96D1F9568AD0
                    84A16316E23ECEB6D0AF4DDF2901EA1C82B104C3BD3E40753387A7F4D035A53E
                    E578671E11DE6693815736D964934DB6BBC234FCE89D505170D285461CFC831B
                    8ECE7C1435C18F10C09A9B0C5BB89EB868057B866BE7D232C81255EF3C86739F
                    3AA22769343A626DD043202BC9490A6788B5435F32012FC1EDD5C0EB887602DD
                    B304C8E7936DD04AEB6DB1AEF43B9CBFF797688D7782A6368EDE04BD031DFB53
                    BB0984087C6EFF7DFD2AE312B87A1E4EA83462B220C7A98A6665ED40FDA8DFE1
                    98C2122D6E04AFB46C7721F875B6C005C3C4B52B650C69B818BFCBA04B6A77B5
                    C179FB51384D10AD3D56C3782D3CDD6A2E23CCF9C8AE93DEEB5AC671BF9C6542
                    2B023F5538D6D209D7A94B61E6F1AE981066F231FA354500374E7A54FFA3B1E1
                    B8D78F8E33862052311731BBEB0D27EC815EA716490300257D1E5512B45FC738
                    8C813363188DB7755C89C4E0C10CFD6023CC9CFF48C0FB3186F845884961A6DB
                    776D313C3E308EC32F2230D4F75D8C7C713526866DC053415F6062D08D012FBF
                    7602FDDEB8C04F699B3DBBBCFD2526D1FE49415FC13B64237E3E91FAC56F3141
                    2FC1EEF81518CE611804D9A6DA763DF135E238E63F7E982EA51CD3D3DF854E45
                    7F22CA9BFA3CDCAAC9C02B9B6CB2C926DB5D611C33A9D7A8A1A47B21E3426BCA
                    2738F9D2EF501D6481A36176A80F35A61793322E08B015FB2E075D49D6A27430
                    E7DBAD0F71C0912073342DB0813AD61BDD899C6FD701ED3186B85D025D9EB0D6
                    9DC0A10D7604BC57C0AE01783B13CDD11D3B1ADD314EB4EF21718CAEB831B4B4
                    8632FA21746E7D19BAF663E04850155125C7F0EA84DFFACE1A9778502BBB8493
                    55A7D243A9E923F090227A7B9E7B1255F65638EF628F4E272BF410B8B6B85AE2
                    9CAB0501EDD5C02BA0976375857797333BD8D1B62D5A1CCD718E80B767FD5722
                    ED183FB556D2F9FAE89F9E5DCC573841BF9F715A3025DA081E09439926F16574
                    1E1E181D8E21A27C2FE7E365B85A064E3376DD185302CD7B69C9C51AFE8B34C4
                    2F12662E7FC6B37FFE163DCC5E3438E1121D6A5AAAA9DD1A6D1F94A22882D492
                    EBD99571BC3A92F06AD3F0A2B9A51D3F19FB7F30F35F496D5E42ED0837B49943
                    32FAB7517A0F62FFC57D86F5B191F83197FEF57D0F3F99BC001E41DFE2F1F99B
                    F0C4EC6F85C756A41AEB07B5D7138734F044B5C9815F4AA01CB6166383BF4240
                    E8D71817F6251E9FB716F62F7F8CE1FE0B3184FB4CC0368960FB525B2F976823
                    BDD6B86E6CBF99CF528C9CF615AA9A4E505FA8D0ADD1D26082FB87F39870FFDC
                    5E93815736D964934DB6BBC30CB0C0CE1FAE41A06B3F81CAC52FA176FA6F085A
                    197A1D84EA02CD713264246A83AC5035DF199CB2CC54584355F04834CE7744FD
                    1C771C09B544FB1A57F424BBA28DE0B59B20B6938135D18996047B629D9609F6
                    9720B79FA4DCBC0CC52EE88E9726BA719843176D77D231BAE3ECD0BDDE1CDA03
                    FF14B77215119F28FC201E6FDF59E3C8682D0D24047312C1715C2C177CE09675
                    9514E29483153AED46E202412C6769687175A4A5E335637855F696384D90DBE5
                    E24CAF3387C66514EA47FE16675E7B5D5C383E0F4FDA638FBD8EFE0920FC1EE0
                    78A5710604AD86BD82743C11CBAB4473BB1A1367AEC650572E39FC0FDC377121
                    EE1BFB211E20807D70E252DCE37F0D4F24C1E5B009ECD95D82FF1AFF11EEF15A
                    849F8DFD00997B380D5997F8EC89D61A3F7F74DDD853CB4DBF5193BCBE7A0267
                    F6A7034BBEC98299F93CDC377E35CC38F5D7249E3CB7043FE6896063A84DBEE1
                    04E2D4FE80D518E61721C518FB2FA0362FC283F4FA21FEE122C4E07EDFBFC1E1
                    95957862DE1A3C41A03A3964C34D012F7B73452884F8DD6F319ED6C7D3312670
                    3C70E06708085983DF3C4EFDE5BB487879878C8B00178E30827A7F31DC0EE76C
                    171C6EC16122E316E27FFC3FA0F744BF33610556AF4DE1486832B5F0EEEAD56A
                    D13F7C6D6FB7C9C02B9B6CB2C926DBDD6104176A35575CA29B21012FD7D83F9D
                    F32DAA826CD134FB51E1D5AD9EE7804682D7A6B90FA336D01247E7BBA12EC4F2
                    AAF2C162D25AD828D404D1CF021D7072B103FA125CD1914A10C7E9C72E82ECA5
                    F0856B5558338A7FCEAF97647CBD033A0878DB135DD0B7E5D7B8903E11BAD65A
                    017D6ABAC1DF1431DD46639054FDFD0FE818F55B9C77B1C0494F025B0E515038
                    98065ECED9EB66896E6705CE38DBA3C56D24D42E23D0FCD828A0708778DF5ABA
                    7E026ABE2B00F63B8C8E42C7A0FE2332E7C7E05AF408AF7452CE210C777D1F3F
                    7E6219CCC62E22E05D8907C74662D8980F08CCAE9DF68BD3630D23C834F35E8A
                    7B5DFF81A06519E8E3CBA3E7096A036CF4FEB9FD1AFA0CB751A3ED9F5E0233B7
                    F7613621920092E38917E181B14B319C6391798218C1E17D7ECB3194B3478C5B
                    8CFB021610F42EC4FD01E1C2D36AE6F3017E3E79092610E83E339F8035E82B02
                    D53512C812B05E09B6D71343AF140641BF67FC5D865FD2E490CF3071DE7A38BE
                    FA0586FB2EC490314B3074E20A0CA1B69AEA5301BC639761C8F8E5302330FEEF
                    49F43E3CFE41EF63091E99B20A5D7D1CB7CBD7524B832C2E26C24F7168FB0E8C
                    0365E0954D36D96493EDEE30820F2E4EA0D4B2178836F9A6A86C46ED677F14B9
                    794F878EC2D1C011A89D674DF06B85A6104E37668D5A131E5E86DEE6303B54BE
                    F9301AFF6285BE287774A659A33D6D243AE2ADAF82D99B17C16F8282A0D701DD
                    49BFC3B98DFF83AEDCB7C5DBE1D2B91A432CE7DD6ADC3AFDF106B44CF445BBDD
                    4368F6B247ABC25CC4F15E09BB2CAEA2D6E463851E476B9C75B5C0798F5138F5
                    C8C3E8099A278E27A56323D863EFF62DC2BE56A7A1C10FBBFA69432C9422C69B
                    6DEAFB1B61E6F0170C1BF799C860F0C0B845B877F4623C3871F5A58953FD4590
                    F923FF551846706CE6170EEB17225179BC8D8EA48386631806D0D8A3AE26B8E3
                    0C156282165954F6510C73FF8BC880C0F97419168773BBC68663A8FF62DC4380
                    CB93D9D8933A8CC31E267059DE080CF1E37D2B70BFFF0238CDF80A4FBEBD11E3
                    E7708189AF313E6C9D04AE3708BCD71203EF13615F8992C313E645E3A1A75762
                    98F7FB525B1878030870FBF7A941F78D5F0533CFBFE1C1F1CB70AFDF87F4FACF
                    30DCE32D6C3F7C41BC77A5F0EAAA69D92DFA46738B03A19B35197865934D36D9
                    64BB2B8C1FFFEBB9FA9AF007017D7D0C0F3A745496E04890028D731F4513416F
                    65D0485411CC3610F036CFB53099BD8121B871AEBD00E2F31F3AA12FC5051792
                    2DD09A68218533988AD3BD09090F314F684BB4414B9235D4D18FA025DA1CCA13
                    2582D3B4B7087D836DECE1640CE9F9E69FE8B119814E7B5B9C73B542A7FB28E1
                    CDBD0A7A69DF59775B82E251E8F4B444BBA3055A1CBCA1AD2C1713E2060A76D9
                    D8FBCC5E72F6F28A0C6F3A251D5BCA957BB0BD1BF739FD0943467F84A1048B0F
                    4E5888E104B39CA396D395711AB2CBC48FDBFD56E23EDFD53073FB039645E78B
                    E340D329AED3401A7F66B57A6A377F8805F5B6A05DADC38B7F8E8699CB5FA9AD
                    91D4CEA5B88F8B398CE7C95D8B71FFF8452255DA1082DD7BA9BD43025610CCAF
                    A4E587E2B50FFF7E05C6BFB50593C2BEC5F8B99F61F2BC6F302E540A473005AF
                    372386679EB8369EC431C21E33BFC64FC72DC410DF05346030D1A746D120E347
                    FEEF53DF2EA4F7F339CC9C16E2F77FF846EA0BEE5CD1C1D42722265A8B3E2DFF
                    85DF7E93815736D964934DB6BBC2F4743364A8E1093FECC7EB236090E2FF7438
                    FDF55F513ADD1CC7C3CC511BC4D06B87DA107B9C24F8359DAECC0A95D3AD70E2
                    AFAEE8E6FCB9C90E6849B0457B3CC7DBBA49A06A02606F541CD6C0452B3AE32D
                    7121DE13FA584F746EFE095AF3E7496FE02E3776A076F2CAB966743FFB147A1F
                    1B85935EF6E875350DBC1CC3DBEE4C60EF668D66B787D0F6980D34E1AB45B001
                    3BEE4428C300413E83A3B16005A727138FC4B9E6AFA118C5FF7DB85378798706
                    2CC2BD7E04BD012B71FF58D35E48D6F0B12B60A6F8004E2F2DC5790E0CE6046D
                    D4019A017EBE2EA09FCBE55237E894FC189F7B588BCCA206FC3AE07D0CF17E1F
                    0F8EE3D2C691A2543017951846D02EDE873FAD8F5B8E21FEF43EC613F0D26B86
                    FB2D82FB8C7F61E2BC0D22FE7672E8D704BA5F0AE015F1BBC1A601F646258E15
                    44D01BFC152DBFC0137FD88891CFAFC4BD5EFFA0FEBB761AB861FECBF0237A0F
                    F7730961BFE5F86FFF45387C8AD390D1DF32FD13F1E3D4CFDC271C23ADE6D8EC
                    01FA8CDC88C9C02B9B6CB2C926DB5D627C236450D011DC708A322E5A60986C75
                    FC304AFEFC34AAA73F8C5341E6A89FA740AD98C0F69004BC2192D8B32B421C42
                    AC5015668D0B1F7BA127D509AD49E6E822D8ED21D8ED8A377866AF80D79B9188
                    E38DB7436F9C05DAE2BC48EEE88B7F18ADF10EE8E334650C6877B1E909449486
                    47CCAAE8689C74B6C339A7516853585F4C41C65E5D5E17DBA40B9CCDC1DD02C7
                    AC7F8D8EC79F87B6B686A77DD1E51B5888D152BB443C30C1223F12D772F533FA
                    54E838372F2D6BCFF562C453EFC2CC6B111E18FF111E1CBF02F78CE1F006638C
                    E9E5B1BCF78C590E33FB5024ED3C288EAFE66C1586E30FA4B15753A7A6B6D320
                    40431BEABE3E3A874A4CBE9B15910633C7F9183E3E020F4EFC90DA1421A0F7C1
                    090C944BC0C51A1EE00A70FE91A248C6D0B18BF0F073ABF0F8BC75184F303A9E
                    F3E612F006D072E2FCB598184AB03A50210D62F2DB5A518862C2DC7FE2E977BE
                    8177E037F89FF19CBB38FCB2BE348A63787F44EDBFD73F1CC31E8F84995328FE
                    FE45AEA1237AA5EBC57FD3ECA527F1C085FFC6197C6FB7C9C02B9B6CB2C926DB
                    DD617443ECD169845F082A4E61D4875E4E546FF0C09D8E5981EA371FC5E95923
                    D010EC84CA202B34CC3747ED65A02B816F4DA0254E2C70465FEC68B4A78F444B
                    C2EF084A1DA18CE33CBBA34CC2EBCDC838714D2D0A5038E144B239945C892DEA
                    D738BDE319687ACE88B6F35BE27BBCB8CFD3FF6EFFEDDEB4F5EA5BA157A9A5C7
                    EF64D5339F827EE4AF71D65D21C12E016E8B71F21A7B7C495C98A2D6EB61E8CD
                    CDA159FF95805DF1B6D4A2A4C5C01973381DB84FDD4DF0D845923C8682AB39DE
                    85F67CB4F5A078846EE6FD31EE13B1AF0C8E0463C2FB688432097CCDDCC3E117
                    FC251F9978B90F2ABA0E7D7C2D84B777008DDAA7E39CC7BA7674EA7AA5F6F244
                    4C02E0DC63C06F9EE594687F12B1AF43C7ADC6BD5CCE978172EC125204AD2F13
                    F03EC4E703FCF499E5F00C5E8B27086A9F9CB746785E2785119892FC087A07DA
                    C33B21680D1EE79086E08F3139E8133CF5A76858BEF41586FA2C12707B1174A9
                    7F8DC0FB63EF451836E94398F9BC07B7E0CFD0D0229E19503728A1E2CA8304BD
                    5A35C7A4D07F5A025E7EACC01BB7D964E0954D36D96493EDAE377E88CDB7C8DA
                    779FC2C1E9BF466D901381AE39EA82A5021387421F43F53C731C0B7440DD2C02
                    B2B709D2D63AA12B85ABA771DE5C2774C4DBA323812452905D0DAFB7A27663E6
                    078EE78DE3F3D07AF4C3501D88845ACBB968098244510A0279BAE9DF0DE9CA84
                    71BB3895985E8516DEACAFC78551B6E8B31F891E3B07B4B83BA061B4357A9DAD
                    D1E56C8356777BB4B8FC1ABDD634F078FD7574F79E93A691D171BAA41A6EB7C5
                    C439A9CD9DED6ABC18FA0DC1EC5F71EFB825F81141EF50BF703CE8BF18F7FB7E
                    88A15CE56CE25F604650F93BCFBF624F5D1BE317FD6B17DE6D866A956A8081F7
                    3BECF375BB6166B71866130878C7BF8F07C7723C6F2486F9731A305A4EFC0443
                    FC5662B8DFFB707AFD433C3EFF5B29B3028BC19401D708B90304BB2C3EFEC490
                    35181FF42D2686AEC324D2E3F3D62360F66778F8A9A530F3E3D8624EEFB612F7
                    F87376092E37BC14F7737AB8B1FFC2709FA558BF8BBDE71AFAAF5B7C26EE2693
                    815736D964934DB6BBDE44A530B2CE920434CC1E89EA39235017E68C062E171C
                    668BEA100BD487DAA0718E3DAA0247E2D43267F4C6795E16BAC0C0CB55D47869
                    DC37506A8FB3BB6A5F67AC15CE673D0EEDB9BDA2F5ECA1D472F95A8E55D68820
                    803B6E6A9D9E009CDA4512DE676A69CFC2BFA2E59187D1EA6183938E23A17177
                    C20585253A48A7DCADD0E6FE6B9CB3B1813667A71885A8D58C901C9B29455CDF
                    0E530A4695CE17BFBB163F1DFB7791016158C04ADC4750369CBDBD014B3164DC
                    4AA9AA9ADB5FF18795DBD04E10A66230E7C7ED1CCEC0C02F05CDDC26D3A18BCE
                    39E2A96530F35C24AABF09681C4B2049C07BBFA806B7528469FCEAC948F813CC
                    4F9E2701AF29481D48F1392685AEA52501AF017C2787ADC79304BDCE6F7E49ED
                    5B827B7CA98D1356E05E025E0EC5183E8E8B5350FFBA47E0D93F6D41ABE84A7E
                    62C093D4EE2EE295815736D964934DB6BBDE74FA1E6809AE943D6D38B3E235D4
                    CCFE15EA8215A8097C8860D7127581B6381EA440ED6C1BD4FD79145A37B8A037
                    CD4D00AE11408587D7A0FE607AAB329EC308D317CF49CBF3510FA1B7F88F02A9
                    7AD9E545A0A51233F8EF8ED85E294440492278ECE169468491B5A568F5F5C739
                    A787D1E66C813E5BAEBC66830E172E416C89B3A37E82BE77FE40EF460751F557
                    A72288246096E692DD16D330697335336DAFF02BBFF28FF53053BC8B61E33F95
                    60CC3F9C60F71FB897E361BD3EC263CF2C4171F539F1BB6A4D27B59986206A8E
                    2BA5F7ACBD7D9E69695001ACDF7E0066F6FF07336FF6F24662981FE7E65D82E1
                    13570A0FF570BF057078E30B4C9ABF9E00F4AB01F5E45E5BEC45FE06E302E97C
                    B4CDEBE383BEC613F3D622206C231EFAFD87B89FDAC5212243397D1A012FA755
                    339BF839FEDBEF7D649671110F7A8F1CBE40FDAABA8DFDFA7D4C065ED964934D
                    36D9EE7A137045602626B2EDDF85E6F936383AEB51D485DAE368D048D4CFB547
                    C31C471C993312A7FFE980CE6405DA93A40A6A0CA057AA3FB0DEAAF878DD4952
                    C8047B7A8D40CD15D8FA6246E1C29647A13F7740C0A49EB09743080401DF05A6
                    576BA164E0658064E615796355E8FBEC639C1EF92BA85D09DA5D2DD1E6628D2E
                    92C6DE02A7463C02D41F14B1BB9D7C410878956ADABA8D0E3D919F97E151D7C1
                    5BD8DFACC27D0E6F61E8D80F0974576058C0520C9BF42EEEF1258874598A05DF
                    668B970BEF23670251A9A1E5F2CFB447731B27163260EBD1892E1AF03C1DB481
                    A0F75D3C3099DA3C26024345B96482499FF7082E57C23F946037F46B4C0C3294
                    01BE0D622FEFB8C02F68FD6B4C0E5B23D6C7CDFD82DAB1061EB3BEC64F0216E2
                    1EEF0F8497978B783C302E0266CEE17863F166E90D32E41A62D4B52278F9EE31
                    197865934D36D964BBEB8DF3C5EAF59D50126029F55AB4ADF91BF6CEF90D6A83
                    15A80F3347FD2C1B54CD3247CD3FCCD11DED86DE5405DAE2AC058C0E8657F74A
                    F53F3EC3AF715F2F17A5D8F833B46D7F9338524F604940A021D8BA8DDED0EB99
                    5EA3A116694436046A1E342A0E4E206B69C485D7A6E2ECA39638E1638376372B
                    281DAD71FCD187A05BF9B1605BCEBAC63E3C154F5633962EBE5D469F01C6559D
                    BE8FDE8354296DE5A612988D9A290A35DCE7BF1C0F4C8C2418FB0B46BFB61A17
                    BAF915F41B04BB9CD497274272FA300DB55BCF0390DB645C7258AFE75CC21AE4
                    1E38875FF9FF0D66EEEFE2BE092B09789763E89845F89FF10BE13EF3733CFEF6
                    463C1EFC051EE792BFB7C1C3DB3FA48133424C0E5B47FBD7603C6D73E686A7E7
                    AF81E594D504BCEFD3C062198688C21834A0508481871DFC7C401A4870780C2D
                    79307417990CBCB2C9269B6CB2DDF5A6D271590335549A5EE1E5D51F3F82C63F
                    8D46F58C87D1106281BAB95638126A8ED6AF3D08365DD01D678FEE7882DD84C1
                    8BDBEDAFFE31BC462FB2386FA21394F1B6E8DC3C02EA9A4DC2CBAB62E822B0BC
                    1B4CA5554B13E9FAD4047F1A30176A3504BFD4CB3D59B168B371478B82FAD5DD
                    1C3DA346E1D4EFC7A2E7FC59C9E3AEEE1513F0943A86383D01F3EDF3943260AB
                    F43A1AFCD0B9393C44DD23DAFEF0843FC3CC6B21EEF78BC4109F4F70AFC7DF11
                    535C29FD0E81B95AA3A2B672FA3B4E8F45EF99461E5CDDEF7699006DBEF4D486
                    6E5A7FE7A3140C25E015A117635763A8EF228C9AFA21FCC3D610E87E8527823F
                    C764825EA9A2DA208BA0765CE0D798CCD0CB13D782D708F89D40CB27A80DCF85
                    7D01FFD00DF8EF49CB61E6BB04430396C1CC7501BE892F11EF4D45D741A9A64F
                    0EF5A98809BF3B3EE2174D065ED964934D36D9EE7AD31282F1DC7AADBE4FCAF0
                    44A64AFB274A5E7E18C7822D501DE880DA77CDA14C1987F30936E88AB5466F82
                    13DA392B0383E7C5E560C9707C026BCED8C04B4E59D61A6789EE1447746F1981
                    F61D93A0EEA80323BB527777B8BF442BC4F3678E67D572C00538472A6121547D
                    EDE8981E8256FB8771C1E577E8B4A03EDDB4562A54A126E4256024EA15B1D50C
                    BC5ADD6D745BF3643B5A88F6735E5EC3B9BF4D2E859982AB967D043387085144
                    41BC415D37BD3F0673F60B535BF51AD15EA9D8091F893B819783293A07C71DD3
                    AA5A257995F7D69E87D533048EA397E1FE318BF1F3718BE133FB2B4C9EFF0D1E
                    0FFB52A408E3EA67E342094619480751E3E91C63B9D25AE8B7B4FD0D2DBF4100
                    8738B0F737F44B3C1DF2399E0BF902D6AFAC26E025E8F55C82D1B33FA241A820
                    78FA48D0E081AE087F2ED4ECF5E7F80DF12C60F0A513E113F469E04117FF6DD1
                    E791FBD93898E1EA7F32F0CA269B6CB2C976D71B432EA7F2E7C9466ABA97095C
                    68AB43C5DF9E43F58C5FA0E96D77747CEE88DE74379C8BB720D8B5468F113CEF
                    904448439C337A9209C0A33DD01E6309E5E18F84E7ABF3767A436FC2185558EA
                    FD45386FFD183AEC1F42F7AB2F417BA155FCFC4E1B0376FFA5647AB477F5C12F
                    6C13CC9CDE8599CB5F5054D54CFB6990A4211463E0A57725A9FF3FE3BEC115FF
                    E33CB4627040EBC6A224CB36E413A4FF19F78EFE1B5C5EFB1C4FBFB50901733F
                    25F8FC9C807D0D9E085A874973BFC1A4C0DBA42BCF45DB01419CA3F71B4C09FC
                    124FFDF11B919EEC476322905A7A44BC0753D6FFCADC1EE3334A0309E3B9F933
                    2C9632F0CA269B6CB2C9F643301D3B72D813A75109E0E50007BEB97516C4A1FC
                    8D5FE1E4023B20CE0B9D890467896E50C5BA4319E744C0A9406FEC1D129F3FD6
                    0B1D5B6C68E9860B1B1DD19E14001C3F207926EF62E3FE167D4ED63DFF0F38F5
                    F387A1DB9E28FC69778331C03038F292D5DF52720FE08111D3F1E682F5863D77
                    973192750B24E376EBD1D406D83CFB57DC3729028A59EB318E80DD3FF81B8C99
                    F7AD580F98BD0E4F066D226DBC43DA8409C16BE113B2057E4149709FFD292CA7
                    2EC693EFAC43FE71156ACF77A3FA6CE71D54076A4FF5E248F3051C39751E474F
                    77E2F071DA7FAE0735675AA4EF0D32197865934D36D964BBEB8D9F9AF2E367A8
                    7BC125677B8917042EF4A970F2AB77706ACB6FD19DF1284E13F09E4F75C2F904
                    2BB4248E444B8A355A9269FD8EC81AE7A84D6DC936E8C8FA0DDA3247A233E147
                    5095CC461FC79DDECD46FDCB6571755A3DB4E74E41F98F48DAEE1471B246EFD9
                    DD6246F0959CBDFCA990B0BCB1578B4FB764216BF741641554206D773152B30B
                    EFA08A909E9D8FAD857B91985B86ADB9F9C8CCCA44C1FE1A6C3D70164199DD98
                    B478175C67AF857BE0062802D76274580CDC0237C229780389977746EEA11BE0
                    3827060E813BE11BF2058A1A2E20A3A4164BA372B03C6A3B22AFA1E55BB60DBE
                    A2B662F5E65C446CDC8AC8989D88D8BC0B2B620B1011B5035FA66D47677B1BFA
                    FAFA64E0954D36D96493EDEE37CE06C05E51AE08C68F87356A3D3B7BA5079867
                    CBA16AB687F2E87F43576D075D8D0DF4B52368F9086D3F7647A5AD7B94DAF208
                    D4477F036DD548A0EAC7D03785A29B27AEDDE5A6516B04F032E1F6F6B64B2829
                    E260A59FDF4963C86519EDA2A7977769FBD0AEEDC6FA6DE558B27137A28AF722
                    BE601F52F3F6213DBF9C547187548ECCFC7D48D8B50F494535627D677E19C1EF
                    217C9451893752CEE1F94FCAE112BC198E04B98E415BE01448A2A54D68146CEF
                    A0EC8336C2393419BF99B206EFAFCD157D5ED5D08C5531D9088FCDC5D2B83C93
                    5A965040CA1F5445F032AA0891F185581A9F4FE72D42446C3116AE4F475E4D93
                    682B9B0CBCB2C9269B6CB2DDF5C660AB25C0E1D847FE070D8B275931E3B412E3
                    BC859E93FF05FD3982DED33F83EECCFF407FF67F0886EFAC7427FF17DA73C381
                    F38F407BE2A7E83B630328B3A0363C66BD6B8DFA5A456D54513FEB555A70C906
                    95963DECEC6A975E7227CD08B846E835AE4BB1B25AECAF3D834882DD773767E3
                    A3ADC5482BAE23E03C843402DFB482FD774604B8DB4B8F20664739920AAA91B2
                    9B20B8E800D614342038F6285E4B398EB0A49308787F1BAC67AF87E3BC583804
                    47C33990141C7347A5088985F9F4B5F00CFC1C0D6DEC41D7895CC8C9B97BB124
                    264702DC7813BA0280074BCBA30BB022B100E17139589E40C0BB7937D66616A0
                    8D3F1E86CF880CBCB2C9269B6CB2DDF526C21908BE187A359C3755C3B3B17BD0
                    41C8DBCBECD85582BE5316D05F3023E8FD3574CDBF81FEC42FA03FF533E84FFE
                    FC0EE96700C1B7F2CC2F08C07F0DCD5933747704128EF540CF2EEBBBD8181AB9
                    325CA78E1AAA548A7A029CB64CA557DF0DBC2B18E6A257978C67E91BE1F74277
                    2F6252F760F9869D88CCA8C0C22DBB10BFAD109979E548C9933CBDA9B986E5ED
                    149D333DB7141925071093B7179925FB9052B217EFA694E1C5A413782DB916A1
                    C92730E3EB2AB8CC8B8375D066388646C3298844E07BBBE468D0A57D51B00F89
                    C78857FF854FB2F68B3E86B28B2E820EF5675B11119B8DA5B1395816972DD697
                    117446F0B6D8777BB492E13A762722E2E99AC7E662E5866DA83ADE22B5958C3F
                    2732F0CA269B6CB2C9F60330821923695D465CBC5F2D26587577AF82EAF48F80
                    E6FF85E6C42FA139F50BE0C4AF087A7F49FA5F026082D01304C0277E2AED3B39
                    4012C7E66332E412641BF6E3E4AFA1A276E8CEFD17F40D3F85AAD5097A6DA5E4
                    24E54A613F2433F4F9655D7F474D03B59A8B46E8A1D572980BC77673090D20ED
                    D029446CC9C20A02B095F1B95811958B0F638B119FBB1F99C51548CBDF8FF4A2
                    C3482D3888F4C2FD04C165B4DC87B4C2BD83AAF482BD482ADA8F045AE6EC2E42
                    7E41053EDCDE8CD7E3CF622E7B78131A313DF91882D24F62C2CA3C8C7CF36BB8
                    CE8D850B49111403FBD99BE11C1C0BD7D0F88B4BDEAFA0F5819073502C6C08B0
                    F9B8AE8174BEE0CDB00DDE42C09B8291AFACC56BCBB270B69DFFDE54D0A89586
                    7C08C08E8A23F8604D2A96C61723924318B66CC5EAD4422C8ACFC7F2B85C2C27
                    181D4C2DA373AC48CC179EE6483A67C4A6AD88DB5D4EC3356AAA6140C4832119
                    7865934D36D964FBE11ADD7FC5C42AF441D7730EDAF3E3A16B3223006508FD15
                    41278127C12D084A41B02BE9A7867D03253E361FF3E7743ED2C57D04BEA769D9
                    FC1BE8CE9841D7FE19B555853EA2734E612BDBCD9B56AF14B02B2A21D3D5578B
                    C2247A9C6AEDC387498508DFB21D4B637761557201411001514C2ED66C2D424A
                    F17E6410DC66E4723CED7E24E7ED456A21812F412843EFA08ACEC1E74F2928C1
                    8EA2726CCAA9C41F53EAF01A7B7793EA05ECCE48398E59A4D7B71C85D7DF5261
                    3773135C83E204D8BA85250818750A8C86C31C02D1B951027C1954074AF621D1
                    70A17339CF8D8163482C1CE6C7C37E4E8C9848B7A5B091838900150D2EF43A91
                    2D4547838C565AF967C22E2C8ECEC592D87C2C8DD985A5D13BB02C918094C30D
                    4C40EA808ACEB184AE7104836F421EFE199F8D63EDFC7C82AC5FBE6B19786593
                    4D36D964FBC11A3FC55613F4A8A0145E5EB4E6A1E734DDDA4EFE170127016F3F
                    28E510838B3AC5E10E03280E5FA0A504BDC6739208BCD5CDF742D7EA05746B08
                    14B834B24606DE5B34C22D71ED39BFAE4EAF1555DE987D396CE0FD8D0C5B04BD
                    7139884C260023180B8FD98E9509D9D89CB31F59C507B12DB7145BF3CB904CE0
                    9B5474046904A36904A583ADE482723A6F1E52A90D0BB71FC3F4B85ACC486DC0
                    8BE9273033E938A62735617A4203E6659EC50B9F95C366F6463810D82A087219
                    7A197659BC2E60772045C0EB181A2580D7714EB40863700C8B87E56B5FE19DCF
                    76A25D2DA68D42DBD7293CFD1A7101A4D89C82CA63F8606316C2934AB1342E1F
                    9171D9581DCFE106795846503AA822D00D4F2C9626CF6DCAC48EBD356292AB56
                    437F64FDB2A1C8C02B9B6CB2C926DB0FD6F89EAB518BFA4E8440843CDD04BF1D
                    CF4073CA0CFA6623D8FEDCB024E8352C75A77E3680E2E3335033F8F63F1FE9F8
                    4FA03C47B7DAD6ADFC149EDAC875D6B84A99704DCA7693C631C65CD698637735
                    BCA47DD5E73BB07C6D1A9644176079120150423E96C4672382803732311B4B62
                    76E1D3F45264161FC28EC20A6CCD2B058734C4171E2618654FEFBE41577A6E19
                    720A8AB17EF75104A59CC69BF1C73027B106D3524E6166C271BC115F8719498D
                    0822009E1DD320BCBC96B3D60B207524F0E5B006865DA3A77740C19780D72978
                    135C83E9B8C17150CC4F83C5F4B50898B716B995E7A987B92A1D979396AA1DB2
                    9757AFA5CFB14E8336A5065F67166231C1E7A2F842AC4AC8C38A2DDB1041403A
                    D85A164FE78C2BC4CAA4227C9EB40BA7DA38791E7D3770D810B7CF6032F0CA26
                    9B6CB2C9F6C335225EBD9E3D4F84929A0E68088075BDA5E83DF3FFA03BFE3F22
                    C440F2EA1A430D2449F03B7012C7E449721C4A61F022E3C4CFA13E753F34ADBF
                    077A9877F5D4CA76FA3FC79ACA2EDE5B31065E9E44C7731919763B097AA37757
                    60D1DAED584EF0131E9B87E5C905584490BB2C7137569096C4EE4644DC6EC4EE
                    DE8B6D4507C424B6AD25FB9198C72107B7C7C3BB33BF1CDB8B2A119ED180D7A3
                    0972E39B3127FA28DE486CC6ACA466BC99D028421ADE8CAB4370DA49BCF06505
                    6C08421D666F814B48DC4538357A7B07DAD3EB34770B81F54628C2E2E1189282
                    912F7C880FBED9C66335FA5BE3B011A91CB34647034CEE7F911B5082CABDC7CE
                    62E1E60C82CF7C91226C7534F5BD00D2C1D57202DEC5317958BA310325479BC4
                    E7417C2A440D72F6454B2603AF6CB2C9269B6C3F60E344547DE2D1A5966EC0E2
                    01AB8EF6B52D80E61443E74F04780A8910835F493240EA80491C9797745C03EC
                    A2F941A8CF3840DF5326E209FB1872755CE6B68B0330B8A5B2DDA431F00A239E
                    61A429AC3C8A884D1904B46558199F23650D48CC27E0CD4664423122A2088EE2
                    F2101EB5039F261722219727AC1D44467E05A954C0A8C9B8DB5B90117219A605
                    5017ECC3D6E2327CBEBB9600F7045E8EADC7CCC446CC483C86D9F18DA41304BD
                    C73123A9096F26D66146420382534F2260D12E09788325E065D0656F2F03F040
                    032FA74173E23CC0C13118F5F27AFCFE8F71A83FD921BA9A43187A947D506979
                    E8A61512D781D9B28FB3A5689158BCCF30B028C66AEA770E37E07EE7585B29BC
                    81B60DBA2A16F77B8A8F79715D1C8BD66372F06D7A1EFAC49F950E9ABE1E11DB
                    AFEEF7672603AF6CB2C9269B6C3F58E3CCAB1A0E0FE0D4077483EBE3DB301190
                    B6EF30B4E7DC45F604DDA9FF828E8054644E60203DC1B1B6FD60F516C51E5E9D
                    C80AF14B684FFE3F31494D7FF247D09CF831B42D7FA3467688F8521165AA2344
                    5069A1E4580CD96EDAB80A9C9E2F340D6ECE7576626DC62E2C25B85D1A5F8AC8
                    D85D58CEE9AA088696728AAAC41244C6146245422122E835CBA27661DDF6BD48
                    2D3E82D4DC3DD85E5032A0C0CB609B5AB01799F96502A8930B0F21B9E000B20A
                    F7880218EF6656E385B853783DB919D379825AF249CC4920C08D3B46B07B0C6F
                    F07A6A135E672F6FE629BCFCCD61B8CD4B80635094005C070E6B088CE907BBB7
                    06BD7C1C49B104BA9BE13A3F1ED604D423A67E8E7519B5A2BFB55A691298247E
                    AA2201AF8A969C2A50CFF1B2B4DDD0D28E0FC504364E135648838DDD589EC013
                    CA383F2E812A416FA4F0004BB0DA1F64BF4B123CB3B73E5F5AE7DF678866A05E
                    9786BAF3DD6218A955F79054FCD13000B06432F0CA269B6CB2C9F6833643E621
                    32864815DD80FBC40C726DFBBFA039FD1BA84EDD47F0F95B684FFC9A40D4E0F1
                    BD025A6F451CB7AB39FD73749FFD399D8B80BAE911688F9BA1EFFC68E8D45552
                    D3641B5023DE8546A916F955B30FD4203C7A0716C51048091832014AEC0914A0
                    5584A55B76E1A3C43CC4E51D4066D15E6C2D18400F2FC32E2D93E9B8DBF34AB0
                    2DB70CF1F9D5882B3A8A6D4505F8645735E6C535607A7423C1EE05BC967C166F
                    2634616E529D34612DB11133938F612681AF58121007A69EC4C4A5D9B009DC00
                    17825BCECEE0161C079740433AB15B005E23EC4A93E1787D2314A1F1786CC606
                    3CFBF728A87A1971AF1F8023C288E83A700612FE0BCCA9388C456BD311915044
                    70BB13CB137920428390A4DD027657F1E083963702BCE29AD275E42C0C0CCF22
                    FD191D6345423E166FDE85E4AC3CA92DC2E7AC865A4D435F7ED2C335C90D2603
                    AF6CB2C9269B6C3F68BB04BCC2BF039D9E0306B4D0773740DD1600D5B1FF2230
                    FD0574277F09EDE99F12F08EA4ED010A691019197E05DDF9FF87BE93FF0D5DB3
                    0DD03C0C7DC71F84BAE3136E8E6C83607AC363F5936D1DF8346997F0E42EDC92
                    830F138B04E05E0D4CB9029296C792689B4BE27E95964F904AD09BBF67408137
                    A38896A48CFC7DD841C7CFCAAD4046F11144E71FC09F53AB313D968037AE4980
                    EE9B04B6B3528E617A42BDF0EE723883005D4E51C6DBB40C4A3D85599BEBE1F4
                    562CAC67AE85E7BC4438CED942C04B807A8BB06B5C17F1C01C2A119C028B399B
                    E14CE7492E691200CB30AB97A2784D1ABF8673228B806AB2B33D3A7C18BB0311
                    744D96C5E4223C7637C12E97FDE55007C92B2BA52BBB510FEF6EACA0E3BCB771
                    1B56A75660690CED8F26F88DC9C199F61EF1D72F06BAEC751693D5B804F9A576
                    CBC02B9B6CB2C926DB0FDA2E012F1B3F6A15B73EC1BFFA8E3428CF3C00FDF11F
                    417FE6275013E8EA4F3C0251814D6453B84519AAAA694EFF0CDA13FF0F383E02
                    BAD366E83E3F0EBAAE331283CB36F0A6EB155EC7F8BC722CD8BC1D4B134AB022
                    A1082BB7641B66EE5F2E06ADC804E951387B059747EDC2EAE8ED88D95D81B4E2
                    830396962C958097E375330ACA919C77085904B95C6422ADE00022B2AAF046C2
                    31BC9A7C5A4C4C9B9358873949F598997A0CAF253610E432EC5EAE19C98D9891
                    D088B0D43378EE9FA5B09ABDEE628AB2FEF07AA3E2DFE71860E344380978A308
                    78333062FA06CC5B918E9E3EFE5B027AD94B2A26AC99367E8D96CB4ED3875D84
                    37D05A5ED57184AF4DC5CAA472EAFB222C8A29C0E258EAFF845C2C8DE36A6CEC
                    71BFFA3A5D4F9C766C09293CB11011492534C82180DE9485F47D4D625CD9A7E6
                    C12EB547C7D93B1874B9DCF4A511A70CBCB2C9269B6CB2FDA0CD585EF692F136
                    7BA568A9A49B71DB2B50726EDE53BF809AA0547DFABF24503505B037214E4BA6
                    E4D8E0E687A03B3604CA0BC3A1EBCB04278F10937A641B14AB3C711A11B13BB0
                    30AE000BA3F3F051621156C5ECBA06F0B297703749F22A0A8F6FEC2E7C9E968F
                    C4A24A01A9A600F666949A5F41E05B4E907B1899B97B914D30BD76E7210427D6
                    625AF2D9FFCFDE5900C6755DE95F892150DAC2EE7F79B7BB6D37608CEDB0D94E
                    8ADBDD62128364A12949534EDB906D99E3B4E1C44EE218C41A913931CB0C6286
                    1969C4CCD2E0F73FDF7D33B6AC8C1D5B92A19BFB25C70F66E6BDFBEEBCD1FBBD
                    F3CE3D074F24D628CF6D581281B710730576E726310FAFC0ADF2F0F6855E0B82
                    F97E53051E7C360977066DC484275910C24851D617663FCDBC9FE1D46B46C687
                    28DC312F0A539E8A445A49ADF4308303DCB0D1BBCB72DE1791F1EB935F9B40A6
                    4B4E7ABB402F078F6EDE7E004BB61CC0EAB8E3088F3EA66E4A569A52111EFB91
                    02DF2B025E7A8619CE1077182F451F16F84DC5CAA8BDD8B82315D59D462E6027
                    0BBAA839698DB4C16653D9788D15220DBC5A5A5A5A5AFF27655CAE45ADE9E86E
                    641605C6F07E11F69A2F0095BD8B520CCC3818CE562DF3D67F808DE10C6D8F2B
                    073351C1B8F46B0DB688311B920F0AE8EEC792F82302501C0CB50FAB38284D00
                    E9138FC3C556C70A7CC51F1048E6F4B0AC3F80B5F1FBF1DEC767B183610802AB
                    83611CB09670E43476318E57C0D7949A8725DB0B3037CE8227122A3137BE1C01
                    71C50816D00D4A10D865384372B507708D5086F3610D02BC49659823EF797267
                    1D1E7B374395FCBD2B6413C62CF4C02EABA4F502DA4F33036E2F845DDAE8D028
                    DC3DEF3DACFC30557A97186B5319195C04490E10BC88F80A33A4303D20C34CE8
                    E5E5A7F3AC5558B9F523AC8A32A07755FC09B154B9F9D87B6E005BDFEFE952B6
                    52C5EE1E5203E256998EE0E5A83D38925D6CFCC639709503E964DF5E399D7669
                    C77950D7C0ABA5A5A5A5F57F42BCD8F17AE735A75C0495CFC721F3752FC05926
                    973CEBFF8383E57E2F88E1F52CAB78DC4B987ADDFB5E01662E5732EFEEDFC359
                    2DCBE5B7C25DFD2F70771F5229401D7C14ACCABF690DB6328AAAB1F47DE67C3D
                    82E5260E60FA082B637663558211B6F049583A843502BBAB59FD4B9657C4D24B
                    78403EB31F6B130E61CFF18C73E585E9A535E0955EDF2B2C392CDBE0A0B5B8A3
                    67B0E7D001EC3F7A1CEFEE2FC07C01D6C7E3CB1020901B2290CB746481260B82
                    12997BB71C8109552A9697A10E0A723DB1BC1CC4E69F604640B2BC26F38BE22B
                    30EDF9DDB82B78134679B236D008B2DEE9A7D9682FF0721A16AD9609BB238222
                    F0D0333128AB63E1063BEC8C8577F5184F2A0C37AE4FF1098BC3C1CA770E9932
                    3B821D0E81CD6EF911C41ECBC38A4D3B55968CE551A9F21D1C51372684D7BEDF
                    D1A5CCB86111E0E54D8D40F392AD7BF0E19EE39EEA6F3DF283EF928608E00A98
                    AB018D0E863330C482B1BC8634F06A69696969FD9F505FE0E5286D87533D9005
                    3ACAD1553B1EB68AA17057FD135C1603565539609597F75F80EAAFC255F96503
                    6E7DC12E8B5958FE0DAE8A7F86ABFE7601E72FC359F50F9EB4675F4677951F9C
                    6DCF28C06E47B35C74194FA181B7BF2248D99D0E74CB77C95E74AB32B62EB474
                    76E1AD6DC7B02C82850D0E9FF3D67250131F7B5F0C78553883E735F5385DE669
                    8C058DD8751CDB8F6763DBE1D3D89E7A0ADB0E9D41E281746CF75461F309B7BE
                    4C016F3A125233B1E730E7F3F1BBA45C815D33E6265629C80D26D8260AE40AD0
                    1A53C3BCC0EBF5EE9EB70A01605662B3603ECB0F6FCEC7D8C5111815B819E33D
                    71B80458565F23D0D25BDB1772BDC6F73DB438162343B6E0AEA7127177D866DC
                    17F621EE5D18852FFF7C1312B6ED557DCF985C0EFE62442E4B373B2F41BCC6EF
                    CE3035C08D29E33CEF2FA86FC65B717B11BE791FD6C49D92EFE70856C5EC9179
                    7E5F177E47973202EF9A98BD78D9B40F2B4C02CF5B7723BBA28E7B878BC52FE8
                    533ED70E9E3BDEF9F3EDD6C0ABA5A5A5A5F57F521CAFE272D9853F7905EC80B3
                    7D05BA6A6E53D5D05CE584DCAF8A09C45AFF9F00EB3FC8FCDF0ABC0AF0FAF2F4
                    2AE015C0B5FEABCCFF139C755F80DDFAF7B2AD7F1750FE029CE59F83A37E2CD0
                    99AB20A1470137314D036F7F4560E17767532C23FD683746E21F4C2F104815F0
                    E1E87F815802AF3120CD37EC7AED1C60A9F79C7F1F07B4BD21D3B84319D87E2C
                    1DC9878E23E5E049EC48CD10F0CDB8622F2F07C06D4F4DC38EA3F978E7A342CC
                    371509F05A312F5EA0568097A9C608B6179A01BBBED6CF13E09D13578100C6F8
                    C697CAF62CF8EE8A031815B2F55C78020B5170EA85DD8B412FD398DD1B16897B
                    1646E39BA15B049C4DB84F80F9AE27DEC603CF24CAEF446ED2440EA74B0D00E3
                    0D87CCC9B770E5E7B17C1C9DF2CFEE937958B1798FF4F331B154AC35ED97EFC0
                    F0B47BBF834F337E770C67088FDA8BE7B77C8CADFB4F1B3B91BDB0C4F4E54803
                    AF96969696D6FF49B9E86912B3BB19CBD70DD8AC7036CD84BBEC0B02B95F839B
                    29CAAABF0457E5578DC2142C4851CDB2C0E74B069F2F1DFC7770C87ABE0FD5AC
                    DC26EFB37C1DB07E5DB6730B6CE55F84B3F50DE5DDB5B95AD56355567F53C1BC
                    5AFD129D847687E0964BB0D7D6296B9C303776E0B5C4C35816B9D70021054386
                    A756CDF7D35644ECC3FAED27907C3C0729874F63C7A153F888F0BBFF940A71B8
                    12DB2E9FFFE8C819C41C2EC2EF4CF978DC5489C713AB1118578490444F9EDD2B
                    31015FFF840ACC55A10E6684255A1114558A71BF8A5703D7C67840776448849A
                    27D45ECACB3B4680776CE8268C5B1881D18B76E2CEE014DCFDD85FB03BBB41F5
                    3B43718CAC0BF21DC8941E53EFF21549FD08DCA868E9C4FA5D47F1FCE68FB02A
                    E118560BF4AE64CA321FDFC3C58C3729CBE38E60598C2C6FDD85FA6E690F6F82
                    E437C61BCCCB91065E2D2D2D2DADFF937271D0985C145D72C5B60B2CA9A7AC6D
                    89700AB83AAC5F814B60D75DFB05015642AE802C4B03ABAC0B02C07DCC5DF515
                    E1E57F809D6583ABBE20EF650AB27F50E0EBAAF1434FDD54A0AB5C5500B3B918
                    CFC8F8C716B9146BE0EDAF384ECAC12FCD25DFA3A30B9DB222E1680E5E8A646A
                    ABC3CA33CB8C0C0335164060D18A97E30F23627F1AB61DCDC4CED4D3D8C3F086
                    4302C102B1976DCCC37BC41804F7CA9E3CCC8B2EC14F4DF5989554871053814A
                    4566C4E83223C3A71B3337F89BCC02BBE5986DB2C0DF13FEB020B90A3F78FD38
                    462C88C088D0ADB86771AC8AE9E540B6D10BA2D4BC2FD8BD8740BC301EE3E76F
                    C1FDF337CB67B7E13FE6C4E2E9570F189E5C4FA6830B4314DC02C12A30E8CA44
                    17B18371F4C091A272BCB439450D2E5C19CD5CC8A9D2F757F0FDF1BB361DC38B
                    5BF763775AB1B1793927DC2C29DE2B3BC3A5A481574B4B4B4BEBFFA49825C1E5
                    E4E3588618B0AEBE5C163B81EEE69FC26EFD2AEC555F86B3F68B40EDD7A006A1
                    29E0FD5B815B1FC66A6A55FF0857EDDFC87BC5E8E1ADBA0D8ECA5B60ABFA57D8
                    3A229577D7CE8133B21B174788D333795997622D5F52FD48F0F23C66CFB43661
                    65D4C77891A3F45944424068A09E5D65B28DF084A3CAEBF856722A1253330558
                    D3B1FDE009EC387246950AF6E5C9F5691CF8269FFDE0503E7E99988D27E2CAF1
                    4462831A94169C502C53E6DBF5E1C5BD8471E01A07BBCD11E00D48B4624EBC05
                    81A632842697E3C15FA7E0AEC04DB867618CE1E9151B4D0FEE828B0D608BC6A8
                    D0583CF44C2246CE7B1F77CEDB8A871646E148418BFC603AD40D22A157653860
                    5883F2F0CA1741BB52F1BBB3D303EB4293CD858DBB0F63C987DBB13AEE98F4BB
                    5169CDE7F7E1D30E6259D401BC96908AFA2EA64061DCAEFCBEDC0EE57DBE9CD6
                    69E0D5D2D2D2D2FABF29212675C1960BA3CD6D57A993E86EEA721D85B3E2EF05
                    54FF5EA0F76FE0AEFDAA002C81F76F0566C5FAC6EF7A62789D04E31A566AFB47
                    05C8F6EA9BD159F535386A8355EE516E9B23DA29567C62C9D57E608296476AE0
                    91FAFE9C6813C6F9706F3A5EDCBC57158E603CA71AAC46E0F558EF98CF2B32F9
                    EC8A84C32A2E9815D8B6EC398DED4739584D60F7C869233697204B53F1BC46F6
                    0602AE11B76BC4F87299DEDDC4D40C3CBF5BE034BE00B3122B0474AD08892BC5
                    DC447A682F16ABEBDB54BC6F8259B6518A7902B901899598156BC19CE862CCDF
                    6EC513AF65604C28B32C449E8BE31DC52A6C9E816C845CEFD46BA3832271CF22
                    0E588BC0A8796F62D9C6A368E3792BC0CB93D8C53001E6DD75B9E0B43B606709
                    E74BA425BB94F8DDB99CC68F22BBBC06EBB6EC507D6EE4451690EDF5BDF58EB1
                    F6DEC818CBC6FB57467C8C53055586D75F658490B649BB740CAF96969696D667
                    5BBCCEBAE4C208B980BBDBD4B2D3D56C64C6AD9B20B0CB1085AFC059F965B8AD
                    84DABF35E2787D02EFDFC3517D1BDC04E4F26F0AF4FE1B7AAA87A0B3F66EB83B
                    13D02E3C6073B42B68B0DBBB648F6DB0A15903EF65C870200ADCD2D4B25AC1B9
                    73B074C65C87E736EE4278CC61BC12C7414FDE5CBA0243ACB8A506B07900A91F
                    161EB3172B0578D744ECC19BA683483E928D9D27739078F8D4390FAF31208DF0
                    EB3142AF40F039CFAE2C6F97F9C8839902A9E5789C6108496558945082B0983C
                    81DF7204245720E80AA097C01B9C6856F1BF41A67281DE0A0169F9BC6C3B30A1
                    08BFDFD68AA9CFEEC1C8E0AD2ACD1881D60BBCBD61F7DC744134EE5F108F3B02
                    6270E7D30978E437EFA3B4A655F5B1D345AF299F4C300CC7293788CC6D4B0FBB
                    4C9867EF0AC54F301335B33C18DF2710B5EF245ED8BADD086D50B0EB4923E701
                    DF0B41D7586F7877F761EBFE74B4751B1919DCF66E15F2D2AD7ED36CAFB1FD4B
                    4903AF96969696D6674EBC06F754FF33503E148E8A2FC35143B0FD2A5C56666B
                    E020B53EC02BE62EFF1A9CF55F519F7355DE2AA07C0B6C2D0B8C2BBB56BFA51C
                    760244F4D871EAA2275E65B8301E5BD7F700AF251DC092888F111EBD0F6B55E1
                    820BBD83033102D69A98FD02CDFBB13C7EBFEC63373ED8958A8F8E6560D7A134
                    241DCA44F2D14C6C3B9E89A48367B1E350063EDA9F8DBDA9276192D7E38FE462
                    FBC1E3D87BF404A28E14E277898598A38A4758044A59298D99166459E62F9E8D
                    E1E246E83D9FD9E1C2CFCF4DB6624E7409463D29C01BB215E3057AC7D18BEB09
                    69A0D797F0EBCDE630767E0CC685BE8731F313F05FFE11D8B82B4B7D07B0F5A8
                    CC22832D0376EDF2DD76AB9F496163275E8D939B15B9B9088FD8873F9B4E6255
                    E4C7F23DECC2CB49FBB14C6E5C96241EC5DAF86358137910AB559CEF7EAC96EF
                    3EDFDA6C6CB49FD2C0ABA5A5A5A5F59993DBDD0D34BD0C77F570C0FA8F02AFFF
                    28F362155FF309BBCAC35B351CEECAAFCB7BBE0E3B41B97E0CD091271772C30B
                    A9D53F1939538DC151AA4C34BD8A025F8C2725F6EE4F2FC4920F53B03AE12856
                    9B52A1525A31E76E1F701D882D8F32D2642D17C05A1AB907AF9AF6227EFF29EC
                    3C9285ED02B849874F23E9C819241E3A8994C369D8793813DB53D3912CB62DF5
                    0C3E4A3D8A9D474FE3B5BD05088E2E3400B78FB1825A6F581D0C9B27C04BCFEF
                    F7D71EC1DD411FE29EF9F4F2466384802E3DBD845C6FC606C2EF18AE5F1C8FFF
                    98FD211EFB532C9A0C8729DC0E6633616F0FAE1C4EC6031B9E63BB7CB71DF2BD
                    EE399D8FF0AD3BE43B94EF32FAA8EAFBD5F17BB12296E07B142BE20F6079B47C
                    2FD1A9F27D1FC3B2ADBB545EE3EE01DE586AE0D5D2D2D2D2FACC498524F658E1
                    AE9F2EC0FB35382AFE16EE9ABF03B32F1803D5BE76A155FE1D7AEA87C97BBF01
                    77F9DFC256753B9CCDAFF13A8E1E8E84D3EAB708B96AE091025D23AC8195BA78
                    1B616E6AC3DB897B551AB27081A1657187B1465556331E7D0F8EB1F8844C05A8
                    5724A4AA0A6CABA23EC6FBBB4E20E548B6F2F2A61C627AB253483E721A8902B8
                    4987CFA88C112C23BCE7C011EC4D3D822879DF1FB615E3E7319502B7A517645B
                    38977541950F1E3CF34FB02024B11CC111A5B8EF99788C0ADEA206B0793DBC2C
                    4671418E5E01E26F2ED8817FFEC96B484DB7AAFE67AC3B0B96395C835F06DB29
                    DB76322C45C5D0137C81BAE656BC99BC1F4B63F609D09EC4B2E8C358C592CFAC
                    A2167314EBE2F76345F401B9C13929372047B172EB76589BBAD46707220DBC5A
                    5A5A5A5A9F39C97558C526A22D163D55FF0FB6CAE170547F5E80F7C27464E7D2
                    92557E15B65A82EFDFC065BD19CE4601E5CE7AB59D1EB41B1BD5EAA7F845F482
                    5E59E2C0247A03934EE463C9C664AC493C2AF0730CCB4DF4000E5E4A321AE179
                    3963494D4764DB47B14AF6B13C7A3F5E311D46D48174EC4A4DC38EC31CBC26D0
                    7B548057CC24E06B3A5680ED874E63EFE1546C4F3D8D75BBB2111857829F2535
                    639EA9446556E86B81899F84E0FE9A37655980C982850915F8F16BA77167F046
                    8C12A81DBB2846950D26E4D208BD84DF098BE3F04F4F6CC69C95BB55CFA3A759
                    9DC3C6330A0348075374D8BB189EE2F240AF9D1937DC38525886A55BB6493FCB
                    77197F04CB596A38FE2056471FC52BB11FAB98EC65B1A978E1C33DD871324F6D
                    CB2D37410391065E2D2D2D2DADCF9C987AA98757794737BA1B4361677960EB6D
                    46A686BEE10C1E730AF43ACABF8C9EFAAFC0DDB19DE37AF8A0562EDF83EF19FB
                    2CC9A94A06AB4CC90A7D99E182CAB1D663150B4C44EF13C04D1500A25797D914
                    3CE10CDE51FD0335660088DFA7A06B798C4057AC0058F4212C13E87D33251549
                    87D35405B6A48327917C58ECC859241DC95003DB76C9F2EEE3E978EF50219E4C
                    28C2CFA2CD989354E9F1C05EE590060E824B2943407C29424DE5981F578187FF
                    B81D77876E5603D8E8D5655883D7CB4BBB2B682B26067F803365ECF32EB9C1E8
                    86CDE106C7A479D3BF0D9E3C212A22955E4EBE5DB7025F07DAE43B8EDA771CCF
                    AFDF8135BCC1A08737EE20D6CAFC5AC6EDCACDC68B5B77E19DC4439E5006DE0C
                    0D0CC835F06A696969697DF66477C985DE2E977CB994769E84BBEA4EA0D20FAE
                    CA7F12B8FD3B99EF0BBCB2AEEC9F60AB1A067B6B10D0D3A53C632E7A778D6BBA
                    567F25A0C5CC00F4043257322349DB7BBA11B5FB10C223F60A8432C6534057C0
                    97991456F1D1B740910A6B181413E88DDF83D571FBB03AFA20D6C41CC69AB854
                    B5DF55317BB065CF116C3B9E856D87CE60FB61960DCE44E2A14CEC1010DE73F0
                    38128E66E1A55DC5782CB61CB3132A1126E0EB3B869783D67C80EB002C20C9A2
                    3CC7C1B2EDF90956CC792F1F23E76FC198B0ADB867BE51716DDCC238959D8199
                    1CBE191885D7B7A40B74BAD1EE6A41B790AE9DC02BBF0523DBC1608A3F10A634
                    333CF7CC1E2613991A37362575ED58BE7197CAC4101E27DF73FC5E4FBAB99308
                    97EF3B3C6A27CE9454AA2D3955A53DC30FDD5F69E0D5D2D2D2D2FACC8949F5ED
                    B009F0CAC5984EA7C6A57054F9C159F93581DE7F05AA594AF86FC4BE24B0FB35
                    35A80DD6CFA3BBE1EFE1E838A53EA306E3B87B60D3C03B20750B097134BFD32E
                    37114E8782A11305E558B52545E047C0336ABF8ADB3560885ED9C11DB0C6D458
                    ABE3651FF102BBB2BC5A96D77A529E85C7EEC5ABC98791909A8D9DA919483E74
                    560D544B3A9C8EDD0705848F65E3F5BD2578D264C6EC38ABCAB31B92C8F8DD4F
                    C6DBFA5A3750F38F17E04D10F84DAE4450BC150B4CD57874D901DC19B4112317
                    C761744834EE9B1F897BE79B047623F0C3674DB09433DF2EF1D129E72E070B12
                    44E57730E8776EDC302B1C1A0312B91F15E220331CA8C81B9BC44372B3B051BE
                    679340AFCABE71002F451F57991B22F71C4587CD66788795677860EDD3C0ABA5
                    A5A5A5F599131F9F33078053C855AEC3707767C355F54D382A08BDFF2470FB77
                    B0D77C094E31301D1941B8E226D85B9E84CBD1A12ED66E3E8A97CFEB808681A9
                    4B4110FB938FD45D6811B6792BF1109647EEF5E18DBDB616AE6C1F36EF38835D
                    4772907CF80C128F9CC176B1BD878F23F26809FEB85DE033B60C81029FFEF125
                    F05729C93840ED93E62B16B7DFC66D9ACA3137BE4C40DBAAC077514A1DFC37E6
                    63C4C22DF8CFD0CDB86F7112C6CEFD10E39FDA89FF98BB011B124F199D7EBD45
                    8015953476E3E5C83D088FDA2BFDCC816A87B124EE38FE1CF111720B8D4175FC
                    9D129607CAE31A78B5B4B4B4B43E7352F1A22E9BBA86DADDACC92FD7D3E637D0
                    553D04AEEA5B00F3DF080033BCE15F0478BF0A7BE5CDB0D5DC077497C9676CCA
                    3BAC2EC54EFAC9B406227AFFEC76DE36188FBA0FA417E28FEF9A0438195670E0
                    BA1A2B7C2DDDFAB1CA1D6B3A928EE413E948397C127B0E3176371B7FD99D83F9
                    A6023C115F8A398986179731B57DC319AE86316C22D824B01B2B906D2A15D82E
                    45D836865458F19DB5877177C8264C088BC0F8D09DF8FB8028FCF4B908D4B40C
                    76D8423FA506A0395585B7BD99255811B113AB14EC1E541EFDC48319E854C1DC
                    AC9368DC94AA936300D2C0ABA5A5A5A5F519945320D7AD3C8B9DEE363545771D
                    BA9B7E00BBF52681DC2FC059F9777056FD0360651AB25B606F5BCF8FA948421B
                    631A1810E1B00FF43AACE560288371F351DED4813F47EE14D814F011E065CAB0
                    EB651C44B53A2E156B638E6075D4477867E761241E4F13E03D858F0578230F17
                    E2B70999981D57809F2759303BC96CC4D5C613460DF8BDAAC6B00681DC209319
                    216ABF04DF12046FB3C23FAE140FFD3A1EE3E66DC0A8457BF02FFE1FE0407695
                    EA6E862F5C77B909BC72E3E872A1A1AB07EB930F223C620F5E8A398C576377A3
                    A2C5786E6297F382412E2A7787065E2D2D2D2D2DAD2B93938F54E9D5753915BC
                    F2B2CAE4FBAEF6DDE811C8755A6F05AABF22C0FBFF60B77C19F6C62972F5AD57
                    A3D91DF2393B634DDDAD020F0E956B54ABFF723BBB04675C68937E4D3A928965
                    9B776055C25184C7326DD83EB1FDD7C99817F6205E893F8AE5911F6145D44E44
                    3327EFB11CEC3C9A8555BB0A111C9B8B598966CCDE568EB949A50849B4629EC9
                    8AB902A4734D57DF08BEAA821BA702BE73047AE70A7C07EDA8C28FFF721AF72D
                    88C43F3EF62E16FF65BFBA5173AB9CD1D71F78F97DBB545608A7CA737224A704
                    AB23766149C47E1C4CCF516D75C90D297FA70A785500F0C07E671A78B5B4B4B4
                    B43E73B23119BE5CF7095B8CE6B5B95DAAD8016C5DB037CF87AD6298CAD4E0AE
                    FC27F454FF1B9C5D11BC4AA347DEEF90B7B95DDD7231EE51B1854EF760A773FA
                    6C89E9A618209255D184BF30076B343333185ED6D5B1FBAFAFC51CC05AA6428B
                    DD879502BDEFEF3889F863C5D874280B8B12F230274E2033B1120149AC785622
                    C662101502A365D7C4B85F169F981B434F6F390264DDACD852CCA1C737AE0213
                    7EB30DA367AF45613941974F34E839BDFE3768045A9B4B5057BE7B97FC965A7A
                    6CD8BC2B15CBB6EE4687DC5112705D7663201D4B90A8F16A9E1467FD95065E2D
                    2D2D2DADCF9C6C72415583CE1CAD02BA3D90EB2D7D4EF24A1BD07110F6CA7F85
                    C32297C8AADBE16EFAA95C7CDBD089065591CAA5F2C6D6C3251766A65A72A155
                    6D53AB7FE2E3EA0EE9C894E369F873FC477867CF29FC39F910DED9751CEFEE10
                    DB799D8CFBDE7D0A6F483BDED8731C1FEC3E890DC9C71175D48217138EE2FB9B
                    B3F1FD982AFC30AA123FD95C84599BF2F1D3C862FC20B21CFF1351724DEC7BD1
                    16D97F197EB8B9143F8D28C34FB658F0DF9B8BF1A39872FC30BE16E3569CC6F2
                    0F8E492F13311DB04B3F3B6E809006FE825414BCB34360564CFE3B56508E8F8B
                    9AD5EB0E1B33A01837A1045E071FAD0C8C7735F06A696969696979A58A428975
                    76AD419B00AFB3E1DFE1EE39A63CB95AFD17D3C0B19E33872075396DE8711979
                    900DD75D37620FE4E39E59AFE3C185D1181FF436A63EB9050F866DC403F3DFBF
                    AEF6E0C2F5B83FEC6DB1CD7878412CEE99F336FC579AB0BDA40567CADA9055D6
                    848CB27A1C2B6BC1F1CA1E9C2A6B4686A50EC7CBDB71A2BCEDBA19DB91596A45
                    71452D5ABB99E740BE0339899995E446F0F05E0F69E0D5D2D2D2D2D2F248E50B
                    858058B7059D75A3E16E5D0006EDBA3D5919B4FA276F2E56960CE6CD038B1C18
                    7DDA85FC461BEEFCC1EF71EB832FC0EFBE3FE1A6077E03BF7B7F0DBF097FC04D
                    1364DD75B49BD8867B7F27F32FC26FC4EF70FBB417F1D8AB7BF04E410BCF128F
                    8CF3C2187647DD1840C9409B1EF6B54CD9E7CC7DEB901B0C86097C16A581574B
                    4B4B4B4BCB2B0102C6E4D2F1D85AFB367A5A0E2B8FAFD3C164FD1A78FB2B6606
                    B033A305018C3710CE1E381C6DEAB55FBE790C7E772FC4E71E7D13B77DFB4DDC
                    327D35864C5D856133D662A8CC0F9DBEE6BAD810D9F7F0692FE3B6C9EB70EB23
                    2FC3EF81DFE3C1257B101C6F45407C1D0AEA3D3741CE4EA1C96EB81C36558CC4
                    E5E8927388399EAFB309D8F24643DD6CC8F9CC296F3888BC9F4569E0D5D2D2D2
                    D2D2F24A012F7DBCAD686F6A4377BB0D76E599D41EDE8189B065E42C76D819CA
                    C0FE74C3DAD68CDBC63F8B5B1F5E8AE1535FC197BEFB166E9DBC02374F0917E8
                    5C21F692D892EB63335EC22D02DEB74F7C057E0FBE842FFEE8CF088C2FC7FC6D
                    55F8496421FEFC51015AE4289C7247E472D263ED460F330BC8F9225C799D8D9E
                    74E963863028DA15009675764EE9EEFD0C4A03AF9696969696D639D103E64237
                    6C700B9D092A4025CD5279433F9BA0302822100A687531A71B21CC650404042F
                    D900BF91BFC7F0494B3164E2127C69E66AFCFD77D762D8A4E7316C5A386E99BC
                    FCBAD9F029CB71DBA41502BCCBE037F6697C6F5D2A9EDA558D79092508309931
                    F7DD433852C3985891BD03B075284FB6FC23C72BB0C9AC1FD7D154F610B6C378
                    44A19AA960FC337A1A6BE0D5D2D2D2D2D2F24AD8C0219060931937BD641C6025
                    FFB96C02119A77FB2F271FABCB8D04F31FBB8CA202517B8B3164CCAF306CC62B
                    F09BF61286CD7C11B74D7D1EFFFCDF7FC6ADD396C36FCA1299AEC62DD7D5A41D
                    0FFD1EFF1EF83616A49811986C86BFA90CF3E2ABF1B3982ABCB4BD10551D845C
                    814B87DC1A095CBA85285D6075B0EB670C68E09309BBC3A1B289D003CDE21E0C
                    B9A027FAB3280DBC5A5A5A5A5A5A5EA9C7C1C45DA62C1334B0D3DFDB26B040A8
                    F1BC47EB8A45EFAEDD6E57C0EB42079A3B5CF8EFF9EBE13761296E9EBA1AC31E
                    5985A1339761C8A417F0C5192BF0C5EFAEC3F069E1183A75E9391B3E7D398670
                    5ED60F9BB6EC2A18F7B114C3A62E31E6A72E83DFC4E771CBCC25F8C9DB5958B4
                    B3197312AC0848B22020B110B3B635E3F12DF988C96E3837808DD11A4C48A1CE
                    95EB68CAC92CB3F4E67295F10F1BE66DDC674F1A78B5B4B4B4B4B4B4AEAA1C42
                    5E4EE12C879BC00BBC137B1C5FBAFF59F84D5A82DBA6AEC22D93570A68AE16C8
                    149B1C8E2F3FBA4A4C4078CA72C3A6AE3406B34D5989A1D3D7CAFC2ADC3A8836
                    6CDA72DC22A07DDBCC15183679296E9BB112C3655F373FF03CC63D158D450955
                    98976815E02D837F821981F116842616E027F1D5783AC58CBC06A3F888CB2147
                    C703D5BAE1A481574B4B4B4B4B4BEBAACA2E1CC8C868A013150D5D7870CE3AF8
                    DDFB5BDCF688C0EBE46502B504DE55182AD3219304781F5989AF7C575E13101D
                    3E355C41E910016186190C53A1062B3F01AD03B161D3651F330572A72FC75001
                    DE2F7C7B2DFC0476BFF8FDB5F8D9864C3CB9AB01B358452DD182B971A50813F8
                    0D4AB2E2F1981284C41460E3C96A7490E4193FCB9859AD1B4E1A78B5B4B4B4B4
                    B4B4AEAAF888DDED689439279E7FF520FCC63D6BC4ED0AE4DE3A255CA076396E
                    9DB106B74C5FA33CBA84E02FCC5C852F3CB246C5F332BC41AD17381D3A851ED9
                    15B865EA0AF9DC60D84ADC36835386502CC7EDB2DFA10C67B8FF0F98F06C0AC2
                    76D4618EC0EE9CE432CC3695C23FBE1421624F245661414211E6441762616219
                    CED4783279107CB56E3869E0D5D2D2D2D2D2D2BAAAE28035C26051653BFEF6FE
                    E7E0F7D00ADCFCE86A01CB55029B84D9651822103B7C06BDBA2B316CD232DC36
                    391C7FF39DB502BE02C19396CA7A42EE4A015E015F79CFE0DA520C15C81E3E4D
                    007CE65AF84DF82DFE69F63B98176341C0B64A05BA73056AE7C6972038A90C41
                    02BCB312AA101A5F007F81E11F479663E5EE52B468E7EE0D2B0DBC5A5A5A5A5A
                    5A5A5759F47E02FFFB9B08F88DF8A5002E21375C00771D6E9BB914374F59023F
                    015CA3D8C36ADC4AAFAB80ED171E59892F09F4DE22EFBD652A3DBD8657D65758
                    427FED1681DCDB662E91F91502DF6B71D3A4E5F09BF402BEB3F6309EDA45EFAE
                    19212915981B5782C004338292CB3DD32A59578CD0E46A3C115F85391179D867
                    E95283C5B46E3C69E0D5D2D2D2D2D2D2BACAEAC2B1AC7AF88DFA23FCA62FC3E7
                    A73F87CF4F5C8A215319C6F02286323B02430966ACC6CD9338706C396E1500BE
                    7DEA527CE57B2FE3F6192B31E461034A09BCF4CAFA82D7FE9802DEE94B306C2A
                    6384D7C2EFC170FCE3AC0D787A5B2DE627962338A10C81B1A508662803BDBC02
                    B973130574134B0586AD084CACC0BCC44AFC3CB61ABF356508F0EA416B37A234
                    F06A6969696969690D8298C2AD4715EC70BB6CB03B9CAADE81CBD9853661C0EF
                    2DDC00BFBB7F852FCD5C875BA62C551EDC5B260A700AC4DE32DD0058C6E87AC3
                    0C185E3064EA4A7C4E20F86FBFB3069F9FBA0CC3A72C51EFF542AF2FEB0BB49F
                    6E2B31749240EF34864EBC28C0FB3BFCF8AD3358B4B30E0109160409F406AA69
                    999A9F27F3816ABE0C01268BC06E995A372BA65415A4D890476FB64D8EDB814E
                    95B4410EDED901BBCA8FAB75BDA481574B4B4B4B4B4B6B1044CFA61D0CD775AA
                    6C052E387A0C6FE7BA9813183EE1697C6E7238864D5F8DA1330432A72D17D0EC
                    05A88C9FED05A2EA7D4C53366505BEF26DA6295B85A1135F3406ACC9EB0A7AFB
                    58FFC21DD8865770332BAA3DF007DCF34C0C9ED9590F7F81587F01D8A0A47265
                    811E53F302B9A1DBAB8C8A6B71256A1DA1F7899812CC4F2881B9A1491DB75325
                    E515C90D0013B279EAB2695D0769E0D5D2D2D2D2D2D21AB8846D3938ADD3E164
                    CD0EA1BD2EF9A713F996168CF8D94AF84DF81D6EFFCEABF09BB40C370BC0DE34
                    6DC9B9416ABE6CB8D8308160A609FBDCF415F8EA775FC6F0494B8C785EE5E535
                    DE7381117C657A4526DB1A3679256E966D7FE9FBAB317B631E16A754E189E842
                    0408D8126E7D196197191B381F94642CCF892DC6ECE802BC7BAA061DEC1387FC
                    EBEC56853754595FAED3BA2ED2C0ABA5A5A5A5A5A5357009CDB98474BBDC2C6C
                    2BF0DBD5AA421C9E7B6D0F86DEFBACCAC870F3D4973164CA6ADCF208C3085EC2
                    6D535609A81A9ED9BEE6F5D80E9DB24CC07405BEF0C82A7C7EE62ADC3A85D5D0
                    56080C13883F697DB77339C67CBFACE276DFB329589058894081578633D0C3CB
                    016AF37C5860A2310D30957A962D02BE16CC8AA757B80AC72BBBA5135872B85D
                    555F73C9CD80DBAD91F77A4903AF969696969696D6C0E526D4B9D5A37B1B2B8E
                    89CE94D4E2DF1E7D09373DB814431E0EC7B089EB045AD7E1367A6D05646F5731
                    BC3EBCAE1E63D53355658DF35396E3CBDF7D195F50B1BCCCD8D0C7BB4B53F0FA
                    C9ED5CDA56E1A689CFE3CBFFF30A02A3CC084BAE10802D45508A55A09720EBDB
                    C34B6318038197DE5DB54E96E798CAF0A3E80AAC3D60453BFBC16D37F2100BEC
                    127AB5AE8F34F06A6969696969690D588C62B00BD4395D82BC2E863300414B92
                    E137FA77183A632D864E5A8EDB67BC82DBA7AEC69089CFE13656379BBACE1343
                    DB37AE568CB1BA939728281D3A630D864C5E812F3EBA125F7994504BCFACC02A
                    01B717E4729DCF6D7DC2CEBFCF00DE3F62FAD2FD78667713E6269460767CB180
                    6BB18ACDBD98CD8E2952210D9CF7C6F2AA1007597E224ED6C594604F89D10F70
                    09F43A7548C3F594065E2D2D2D2D2D2DAD01CB005EA7809D5DE69CF8E87409FC
                    BEF9146E9AFE670C99B90243A72FC7B0292C11BC54E65FC24DCCBD3B65F505F0
                    798109D4DE3A35DC085F10E01D4AA89DB2147FF7DD35F8FC8C55CACBEBF5D09E
                    0F4F58EE7B5B340F14D3B8CC816F9CDEFCF0527CDD7F3D7EB5AB1901B125989B
                    28D0BACD8A397145CA83DB177469F4E6867906AD79A197A696630B119664C6FF
                    4456E237A602385CD233F67638ECEC177A7AD95386BCF3DAF37BF5A581574B4B
                    4B4B4B4B6BC05203B39C3D326747B7FC3B62AE00EDC425183E69156EBFA8E7F5
                    D21E5915A6E0015B15C62050CB12C47FFF7D0E607B1EC309BE8FBC8C9B2687AB
                    C16CB709107B41B6AFB170C52DDC8640F6B069ABE57DAB551CB1DF7D7FC04F22
                    B311B6C300D879628457556842C0D60BB37DEDA2AF255A10985082C7921AF0E3
                    C80224645AA5375CD22B76B83870CD03B7EC2FEFBCCD6614E6D0BA7AD2C0ABA5
                    A5A5A5A5A53560D159E9F4783137A69C85DFA8C518C29CBB0C5B98E21B422F65
                    4688C2F934635EEF2CC316FEEEFBEBF0C599323F6D0586CA32EDF699AB543687
                    8B012FBDBFFCFC6D0C8F98647884FDEEFD1D462D88C2C23D75084EB67A62720D
                    E0E57C6FEFEDE518C31982C5E6998A312BA90A73A22DF8B5291D252D4C484673
                    5EE0D5A5F5F6F86A5D3D69E0D5D2D2D2D2D2D21A0419E0565ADD86F13F598121
                    0FADC14D335E11B85C6A78573DC07AB94620E5F4B6190C7B308097530E5EFBC2
                    8C95F8D2B7D7E03601DCA14C53A63EB3425E6346874F6E8B76AB7C86E58CBDCB
                    7E935EC4ADDF598EC00F4B11B6A352555063A605FF782316D74835C6B4632C34
                    71F9362F91191E4A1120F3C10935F8D1878578EF64BD102EFBC7710E70BD1E5E
                    A7F33C046B5D3D69E0D5D2D2D2D2D2D21A04B1D21AF087D7B763E87DBF82DF44
                    01CB47FE8CA1539F13D85CAA3CB3469CEDE51B0197C0DB7B9931BD2C33FCF999
                    2B55AAB25B047299CD61C8A46518CAD00681D9DEDBA0DD422FF0F4E502C78C23
                    967502BE7E0FFE010F3EB70BCFEC6EC0ECD84278538C296895791AA1D73B7F39
                    C61466FE620C6B0831956076520D1E33B5214CB69F55D5AE7A8970DB1B7235EC
                    5E1B69E0D5D2D2D2D2D2D21A141DCAB2E25FBFF302FC262D55763B430C66BE84
                    5BA62F53B0DA1FF37A6469DEE56153C3F1B9192BF1E54757E30B02B2C327BDA4
                    4078F8236BD5E0B4BEDBA0DDC4F8DE9984E695B8E9C1E7F10F8FBD89C0180354
                    198EC09006956521B14CCDCF8D637EDD8BC7F05ECC18D610400F71BC193F8D95
                    ED27356256443E96EFB7A0C188F850F28633784DEBEA4A03AF969696969696D6
                    8045669BF3C758F88DFF0DFCA6BD81E193D7E28B935FC05001D161D3D628D0F4
                    05A2973205B753CE675EE0B2F2F4CE5C839B27BE842F3FB20A5FFDB6C0F0E4A5
                    183E6D35864C17E0BDC87E8608180F99B15C8557B078C577561C46585225E626
                    3194A14C0D52EB1DBFEB9DBF62936DF9C7972120B152A6B29D842204C7E5E3E7
                    A6121C2AAE03EC1CD2A781F75A4B03AF969696969696D665CB65EF5095D4BA05
                    D21C2E99731A1906761E2BC1CDF7FE09373FBC04C3A7BF825BA7AE510526864F
                    25A8F61F78BD9EDDDECBC36630BDD932DC2EF0FBD54705AC67ACC6505660A347
                    D9F39EDE210D84E66102BA43A785C36FD273F8B7C00D589850A972E586249D1F
                    ACE6CDBCC065EFFC45B3315CCCE4FDF40C07245A119420DB4A2C417042291E33
                    59F0A7DD169477B3BF1C70BA9DB0AB126CCC5BAC81F76A4B03AF969696969696
                    D6E5CBDD89F61E27BA0476EDF64E0136A62203A6CF5B05BF7B8DD0020350053A
                    3DE0D91FD8ED6D5E88F52E0F15B0E5B66F99148EBF11D8FDEAB705B0A72DC390
                    A94BCEC5F132F69753C2AEFABC80F7B069CBE137E54FF8DEEBA7B0607B0D8204
                    4203E32F0EB4570CBB1E53C02C364F0D641300F6D813D14588CE6F56FDE5669A
                    32A7036E815E615EADAB2C0DBC5A5A5A5A5A5A5A972F37D0432F2FABA9B90478
                    451FEC2884DFBF3DAED283112E7B7B570DE03D0FAD03356E6BC854A3B4F02D02
                    B7B78B7D4580976587874E7E119F7BE46505B9DCEFED33D7A829976F9BC23464
                    CF62C45351F8D5C7CDF017D80DDA5681D9F146E802C17430CC0BBC7D8DAFCD11
                    E09DB7390DA52AAAC106A7538CCE5D8F975CEBEA4903AF969696969696D6658B
                    4FE1DDEE76F9A74396EC28AE77E09BDF5B83210F3207EE85B0EB85D4DEEB06C5
                    649BCA733B355C655CE000B6AF7CEF65DCC6016C6C83D830E6E895D78688717E
                    C8C32FE0D6692F2138D282F92995986332636EA2057309BB9E2C0B8365CCF6E0
                    CB8292ACF8DFCD0578E744B5DC37B8E016D0ED66548306DEAB2E0DBC5A5A5A5A
                    5A5A5A972DC6EF3A6C4DCABBCBA403BF7F7B0FFC46FF0EC366BC2A706B402EA1
                    B437EC7AE707CB6E9BC618DE70016CC6E68663E8E4A5F8E2CC55F8F2B7D7C0EF
                    E11771EB8C15CA8630AE77EA3201DF65F09BF8273CF88714FC6A7713FC053EE7
                    2496C25F80D73FD18ABEB9740766174F6516905481C713EA10129D8BF46A234D
                    59979DF978754CC3D596065E2D2D2D2D2D2DADCB16D18C9E49EA704E0DFEE5FB
                    CB70D3A4E5183A7DAD2AFFEB0D5FF0822EA7DED8DBC130565263A9E2E1CCA74B
                    8FAE80ED500E6013B8FDDA775EC6E71E59AD00984528387FDB8C95F07BE845FC
                    DDCF5F4748BC05210C3D482913D02D5529C49851A177FCED60983784E142B360
                    B6A90C73926AF0F38822BC72B01C7572C740D8A5B757EBEA4A03AF9696969696
                    96D665AB9B3E5EA15E97DD8DA79644C26F0CD3902DC32D33C2559801A1540D18
                    13D0F52EDF3A6D108DDB9BB81CB7CB945917860AF0DEC2EC0C935EC25767AEC6
                    17BFBB4E203B5C951AA607F8A6875F54610F3357A72224A502FE4966CC8E2F10
                    D8B52020AE1441B1160FA8127C07C3BCC0FB490B48AA94A9406F420D0223F270
                    BCA4567AD48E2E9DA4E1AA4B03AF96969696D65FB55C8C817439C5E875B4C1E1
                    90A900845B3BCD0624E689ED2BC565F646997620E24419868CA3A775296E9AF4
                    5B0C7FE4750C9D2E002A9079B5ED6601EC9BA7322B43B8B29B6902BF43C4BEF4
                    9D35B8750ABDC06B71F383CB70D343CFE3BF023F40A8A9426054803341A6629C
                    06261A16602A1F549BE7C3B83E34B11CB323F3057CAB312BC68ADF265B616E93
                    3EB5B54AE7F6C0E5B4ABF356657B53E73573F5EA137930A481574B4B4B4BEBAF
                    5A8403979BA55AF9B0DDA1008179FC752EFFC1158B23B8D8A9B66ED4DBDC7838
                    F855F8DDF322864D09C7ED8FBE849BA67A32225C0333D29DF9B0692B70DBCCE5
                    F8DB1FBC8AE10F2EC1EDF2BE5B6786E37FDF4C47704A15E62694F9B6441FEB06
                    DB641FF3E24B109A548EC7A24AE19F548BC0881CC465D541257673DBC5E4C6CD
                    29FD2CE734BB9AC0CB9B39AD814B03AF96969696D65FB50C30A087D7F086698F
                    D8E04941AEEA574F35309A685DDC11F88D9E8FA19359506235864D5F82E13356
                    0B74F6CAA470158D71BCDE98DEDEC698E1A1535E12E0FD0BFE46E0F7E6FBFE80
                    3B174562FE8E3A046EABC09C8452814F1F9678F58D83E48212CC088A27EC5AF1
                    44520D1E8B2EC42F133371A69BFD6AC0ADBAA910391C0E389D1C16682C6B0D4C
                    1A78B5B4B4B4B4FEAA25380627A14CE605CB041A3C9E48AD018980EB747A6F24
                    CEF767ADCCFEFBB77F0BBFB1CF186583272D87DF43CF63D83481DE89CBAE890D
                    7B7889D852DFC6E2130F3D87CF4F7A019F9BFE2202B6140BEC56613653833153
                    C275B4A0040BFC230B1026ED792CB60CB31264BA2503AB4ED7ABBE75CAF96B97
                    3E37FADEAEC273F40DDCE04803AF96969696D65FB504C914EC32E6D1CEC154B2
                    C092B71A790726826E6F79A1F7B7AF9A70ABC0EEDFFEE035FCCD7FAFC557BEFD
                    32FEDF0F5EC797BEB70C5FF9CE1AB1D557DDBEFADD3517B1B5F8DAF7D6E1ABDF
                    5B85BFFBEF5578E4A5DDF8E3DE76FC6267239EDE598F277754E3A91D359F30AE
                    BFDAF694D8A26DB5F8CDEE66FC22B90A4FEF90F6EC6EC3E2945A844495A2A2DC
                    62A47C733AE4FC15D00561D729E0AB53960D8634F06A69696969FD158BDE5D03
                    089A9ADA515151073BF39AAAFF34F20E4404DCBE46AD89388A7BE77C8899BFDF
                    8BC9BF8DC3D45FEFC0D45F7D8CC9BF8BC1D4DF6E134BB9BAF6BB6D98FC9BE40B
                    6C8AC726FF4AA6CFA4E0815F9A30EDA51D58146BC6F417B661E2AF65F9B95D98
                    FADC4E9F36EDF95DD7C41E7EFE234C7B6127A6FF3E0E8F3EBF0393FFB80B939F
                    DD8DF1BF48467169097AA48BEDEADCB5CB79CDC85EB9E9E01D9CD680A581574B
                    4B4B4BEB861759CB002E15C0A0A6845DBEE086033D4E37CCD60664E695A1A9AD
                    5321837A1F1F071B1FE666D436FA7A2EB57CCBDB577D431AAA3B5C981212816F
                    CE8DC298B08DB837743346CCDB88518B37616CC8668CB906764FD816656365DF
                    B4D1B26E7498BC363F02E30223312264237EF4E6712C4E2EC794E75370D7EC0D
                    B83BE003B5FECEE08DB82BE443DC11F401EE0ED9A43238DC1D24EBAE81DD1DBA
                    05DF94BE1A2BED18336FBDB425025F7FEC2D042CDBA9FA567978D5D9CBDCBCBD
                    CE5FAD014B03AF96969696D60D2F27AFFDEAC24F10E0401E9AAC64BCAEFC57DB
                    D2899CF226A495D4A3C85A876E9BE775B798C0B03198CDF0526AE01DA86C782D
                    A510FF3E2B0263E7C7E35E01CF910B047A9F8EC73DF36370CF82AB6F63E647CB
                    BEA2316E01A7511825007EF7C2488C5C148DD1411198FCFC4E849ACC084E2A85
                    FF87F918FF9409A3823663FCE2288C9E1F89318B62306A8100BB4C478745F9DC
                    C7E05B2C460BE08E5D108F51A1D118BF3016DF0C8EC6034F7E8082F2064FDF6A
                    5D2D69E0D5D2D2D2D2BAE1759E5119BE6017CE15639CAE3070A7C06DB1B501D9
                    9626B156649754A1B6B1450D645352906B98B1A83D6603930B753D6EFCE8F914
                    FCDB631F087CC6E29E450918B538F2DA00AFEC63C402815B01D7098B6231362C
                    D23081DF3B83370BD046E1F10D5958BCAB0AB3A272B138A51ADF597104238236
                    C9FBB628501E23EF57A01C2A535FFBB81A26ED1E2B803D619100774814462CDA
                    897F7BFC1D2CDB7458DDBE695D5D69E0D5D2D2D2D2BAE14576358095C0EB5430
                    CB45062E54D47522BBA80E59A52DC8B1B40BF0D623BFA4166D1D8C8314C0954F
                    B8058ECF0DFED1BC3B30A9FEEBC0AE8C328C98F7A1C067B2C05C1C468646F806
                    BDC13602EFA26805BDF70840125EC72F8CC178796D64C8164C5F7900618915AA
                    74F0ACF862CCDF560DFFA852DCFF9B24DC15F801EE7B52203978ABB271F41287
                    450B2CFBD8CF609BB47BA440F9B8051FC83E63F1EF21DBF03FCF9A5055DF2EFD
                    A907A65D6D69E0D5D2D2D2D2BAF125E4CAB004978B210DC45C46EE025D763772
                    2D0DC82B6B4156490B32057A8BAC1DC82CAE86B5B61D9DF23AF9CCE576C8263C
                    5E61A7DAA2563FA53CE4EE3674387AF0CBB75371A7FF168C9E4FCFA949C02EFA
                    93A037D846705C6C7879E9D5A5A7761CBDB5415B70DF330998176346684A0566
                    C5321D590566CB74C18E1AFCE88D331821ED1C13BA05130474C7874462C28258
                    8CBA56A02E7677C856DCBF284A8551DC1DB81991FB4A3CBDDAE5996A5D2D69E0
                    D5D2D2D2D2BAF1E524643127AC802B5335C9AA2E870B558D02B7A5750A78732C
                    CDCAF2CBDB9065AE57719175CD3D9E685F7ECE06373DC3DA993620D9590C416E
                    1CE8953C945B83898B3660ECC2AD181372ED8077F44201DCF991E76278C78446
                    6244F016FCF7DA13982F901B6032C35F2C8055CD22F311945C8EA0B8324C7A71
                    0FEE08F800F72D8C13A37758C033ECDA00EF5881EC7B17096087446364E856CC
                    7A21024DDDAA47A53F55AD35ADAB280DBC5A5A5A5A5A37BE189B20D84A4F2D73
                    EC12B79A3A6CC829A94066792332047AF3057A0BAD6D482BA9414E4533B28A6B
                    60A96A4637419971BFB00934BBB4877780B2C94D030711F23B911EC5EF371DC0
                    37E76CC5788148C2A801775ED023007BED3CFC0DD4C60AE412740DD88D1088DC
                    8A7B9E8CC32F12EA55F9DE1001DD80388B806F398293AD084C342324B90A8F6D
                    C8C3DDF323309AEF5F10A5E280EF5A4C68F6BD9FFE19B7671CF358D907BDD086
                    C5E0FE9008D9E7367C2368133E4AB3A8FEE4130BE3FCD6BA9AD2C0ABA5A5A5A5
                    75C3CB2180E5709C0BC8855DA6A5B58DC832D722BFBC0979658D6ADA7B3EDBDC
                    80ECD25AD43577181B71BB559627CFD835AD7E8ACE5D3AC91DCA2BD98EAAC656
                    4C0A7D0D5F0F4DC288455B3066FE564C20E0051148E9F58D372050992F40BC32
                    234C8F5DE8F1EE86122863F19F81EFE3C7EFA661C1CE2A81DB320409F0721A98
                    58AEE683641A986C41E8B60ACC0C3F80AFCF5A8F312146A684B10B2206117809
                    BB6C9F0977872662C2FCED78382409F707D32B1D896F3DB90D5F9FBD09BF7B25
                    49F525D003A79DE7B57EEC70B5A581574B4B4B4BEB86979152CCF0843184B4BE
                    A903F96575C828AD3F07BA175A2372CA5A905BD68C124B1D3A3A8D47C62EE549
                    D3C43B20399DB03BDCE8713158443D9347D4E10AFCFB4FDFC0A8C5F118CD47F7
                    8BE3303694D913A2303A94A01B6BC0A04F48BC3223F08E5B1CA93CBBDCC75DC1
                    5B306DC93E04C799312FD16CC02E21D7635EE89D1D578CD0944ACCDD548CB14F
                    C6636458044606339C613081576CBE4038539F2D8EC6B84572CCF3B6E0BE0571
                    18F96434FE4BFA66C4DC37616E56DD263760F491B38CB07EEC70B5A581574B4B
                    4B4BEB86973144CDA16278BB7B9C282EAF432E3DB89656015F0E5AFBA4E596B5
                    22575ECF2CA842755D331F1C0B60C836DC3A09D480E4646904415D970B76E5E5
                    75A245EE217EFCAB8DF8C6DCAD18BD2801DF0ADA84FB7F1987710293CC84C0F8
                    559F70D80F33C22504A6659BA3045A472F8EC1EC8D0558905C097F5389C7B3FB
                    490B90D7E6C59BF164521DBEB7FA2846CC17E06568C3427AA23FB99FFE9891ED
                    819E63D976D8FB18F7E46635486EECC2588C60BF3CFE1AC2B79E54DDC84E74C9
                    4D83DDD9AD231AAE8134F06A69696969DDF072C326506013C072A3BAA91D79A5
                    75C8B1D083DB26505B2B26007C81D5CAEBADC836B722ABB80E25D606B476F5C8
                    7698CE4C0F101A90ECDDCACBDE23FFF4F006C293EE6DEFC9328C98F33E46093C
                    DE19168D714F0B90066D10F81B5CE0A58D6666858531B82B6C331E5D79102171
                    E5083459302F512CC1ECD338706D6E5C0942E3E5BD5B4B71EF6F12949797397C
                    7DEDA33FA6B24684C5605C689C1CF38718B578A380B500F5C214FC977F0C7EFC
                    DB2D2869F0646470F206CC852E47071CEC50ADAB2A0DBC5A5A5A5A5A7F05E260
                    35073A6C2E145809BB8DC8B63423BBAC05F9658D60DCEE85D680DCF216F59EBC
                    F266E49AEB61A96E824D3D3AD670312071D09A9DDF870B3D0E3B1C8E6ED86D5D
                    E8B1038BD77D84FFF8E95F70CF2FB66144C81601BF0F3166C1568C15381DCCB0
                    016665609686D14F472220B21061C915981B538CE0C40A9FDEDDC0A432CC3395
                    09F45A3137AA084FEDA8C5F75E398211615B5595365FFBE89F09DC87C5E29E90
                    64551463E482088C5820601D1C8731733722E2A342E51D67AA10B7AA062867B6
                    CA3AA2431AAEB634F06A69696969FD5548180BE575AD6AA05AB6B509D9E584DE
                    3A1FF1BB62654DC8B53620A7BC4EBD37CB528F1CF95C4363B77A94AC3500C9FD
                    82D3C1586A869810DA58E0835E73374E165661CAA2F5B8238815D092F0F0E278
                    01D3CD18BDA07F61030C1130ECBC8798DEE2F1F363719700F50FFE7C04F3532A
                    1024403B37BE4480B752C1AD377EB7B7F9C79A119C62843D84A558111C5D8A29
                    7FDA8D514106F072BB6A5F5E6F34A757DC666E2316E3C252704F184B184761F4
                    5349B86BCEBB58B06E072ADAE52466A610970D2EB94990FB37D8A43F1D4ECFC0
                    4AADAB260DBC5A5A5A5A5A3784E8773DE77B558F788DA2119CE55C5B670FB24B
                    AB9161694096006D9E806CBE006FDE458037AFBC16B965B50A7673AD2DF2D93A
                    980592ED4CF1C02D123C64E386713F6A475A9F22A64466D53BB743A0CD69834D
                    853830CFB191F378654C06BE316B23262CD88631815B30E6A9088CEAC7C03003
                    72099DAC4E6680E81842E942014A01DE714FC7626142054292CB10105F8CC004
                    0B824C1CB0E61B78031318D2508A80640BE6C415AA92C373DECDC158667A50FB
                    88352097FB0A93750B3D6DB89276B37D6A805E9CB4711346866DC5DDB2FCE082
                    B7B0FD7481D17F0C01711A29F6EC720E3220C48D4EF59AD6D593065E2D2D2D2D
                    AD1B42644DA60C33C09318402870AB7536570F8AAB2A9026C09B59D18AEC72C6
                    F136A2B8B4FE22C0DB28EB5B51606D17286E51210E79965A59AE855565FBB72B
                    2F1BE1C30BBC2EE63ED3DEDF01889DD78DDC2A3BBEF76C0C460BEC8E0A8BC198
                    C55B0528B75E31F0324F2EB31D8C13F81C2FDB6146865102A0772D8AC5DD41EF
                    E1B10D6908DE598DB902BAC1A632CC4FB00AF09A2FC8D07081C9FBE631CE37C5
                    8A59F125088CB7E0A9844A3CFAD24E8C08609961862244E2DE45268C66BEDC45
                    D1AAC0C59501AF1C2FDBBD7823EE0DDE84510B77E35FE645E1F76F6F37BA8827
                    9AD67591065E2D2D2D2DAD1B464EC6878A2978528FCC6559961A5A3A50505E8B
                    0C733D320562B3C5F2CC8D28345FC4C32B966369427699B7FA5A23F2ADF5C835
                    5723ABA45A792489D85E0FAF12C95A036FBF458FB9DDD9A93C96EF6F2FC27F3E
                    B141A0311EA342B660BC40EAB95081CB3101477A57478646608C40EFA8600152
                    0E845B14876FCEDB88897F48C6C2A40A0409F03E1E538490442B4212CA314740
                    D627EC8A05C69B057ACBE43D663C11578C7989E50893CF04461462F47C96FADD
                    22D01B83F184D6B0485594A23FA1182C8A317AFE8798B03805DF0C4A1058DF80
                    9C2A8F075703EF7593065E2D2D2D2DAD1B46CC47AA1EF90A79BAF8D857E63AEC
                    2E94589B9547378B9917CADB9153DE8A7C4B030ACC0C5BA8479E0FCB91D7998B
                    375B4D1B50C81088F206641557A1B1A51DAC6341719F5EE825606BF553BC5F70
                    33AF6C275ABB81EFFCDE84FF0CDA8AFB16998C9CBC3EE0F0A246E05D18831102
                    9C631646ABAC0C13649960CA3CBFFEEFE760E18E6ACC4A326376A21961299508
                    10909D25201B9868F16DF1A502C502BC2633E6C867FC99B521C18C85BB6AF0FD
                    D5277047F026DCC37DD1BB1B2280FD14730AF727F638528039022316EDC63FFC
                    F86DBC1C7D54750F53EAE9B3EBFA4903AF96969696D60D23863070508FCB6957
                    10CA413D15F5ADC8296E14C06D477E59874A3796E7F1DA16A87CBB759F045E4B
                    1DB2E5B51C6B0BF20496B3CCF5C8162BAC6841BE2CE798ABD0D469536114CADB
                    2B30A2F6AF89A4DF72CB7F0E9790AEA35D2DEFCD6DC13F7D7F2DC632DE36CC18
                    10E61B107D9840E6E805D118B53816F7D00472C72C8CC49DC11BF1FD15A95894
                    58A9C075764A39E62595C13FA604730468FDB73156D7FC09D865410A863D3075
                    19B33604C867E6C8FBFC39D84D2C34C68A09BF49C4DD619B31E1C9788C08DA22
                    F01B8B51579AB28C70CC38DEC571F8FA9C487CE799ADE852C918DAE104E39C55
                    D7685D0769E0D5D2D2D2D2BAB1E4722A4F2BD9B34568A1A0BC0659A50D28B0B6
                    09F00AC09A9B8C18DD32990ABC72809AEF90860664327657DE432F6F6609431A
                    98A2AC09674B6A515ED78E1E3B0326B827C39BAC9343F55F045E75A3E2B04B5F
                    D2D30B3CF3CA4E7CE389F518B728E1CA421AC4C6CC8FC2189932448021067785
                    7D8809BF8DC3DC0FF35591098625CC22B4D2731B2FD09A5221CBA53EC3199425
                    962B2F3073F5F23373E24A109864C56C5329162657E387AF9DC49DF33FC43D8B
                    04B44322303A3412E317319FEE958462C87B17C6C876A271C763AF22E548A9EA
                    19554298A9C81836A3755DA481574B4B4B4BEB86111DBC4E87516E95DE5E6B2D
                    BDB102BC963A01DE46555022DF62941356F0AA20B8F113B0ABD292C994C0ABD2
                    970928675998D981DEE116A4A92A6CF5686A6913DEE5FE1C0A760D3FAF56BF24
                    DF9DCBE946977C6F4E2707067623B3B80EE30558BF1114AB322D9CF3802E10F3
                    CCFB0247BECE4164F732DB41A8002F4B08876EC27FBF7E02618956CC8B2B857F
                    6219E60ABC0699CA1026C01B142F207B910C0DB479F27E7FCFC0B560796F1063
                    7A651A6892A96C2738D68C87FEB40377876C31DA41AF3407B2495BFAB64F99A7
                    EDCA73ED0D7B90E9A805B1F8E7A0CD0859BD03ED1D7246393AD0237DE3508322
                    F52384EB250DBC5A5A5A5A5A3786DC4EA8D2BF8CE395C5867687AA9A9653DE80
                    3C0E3A1363B605961226D4D2C3CBA212BE8197591A08BD02C99E7963701B4321
                    3890AD5560AC16E6CA0674AA0200F44E324D996A89567F247DE716E06508B6E1
                    E56D51C9B6566C3D89118F7FA806AFDDF38B4D18B32001F7849A306E6124462F
                    8CF30DBD0A8AE3E4F5788C5D1483BB82DEC7837F4844585C194293AC0888373C
                    B9CCC8109C2840CB500531169660C8425FD855EF95F584DE2031F51999AA5466
                    329D9B64416872051EDB908E918BB6624C9891B5814524543AB4307A99A3CEB5
                    6F8C40F8C845B118CDAA6A0C7B906319317F934ABF36322842E0FE437C74AAD2
                    E817BB07789D729EC939AE757DA481574B4B4B4BEBC6904B60404089D4D92DB3
                    A5356DC86691090FB0F606DA73CBBE60D76B17843A18C06CBC5FB6676E45AE59
                    40BAAC16B5AD9D2A9C41656910E8D5EAAF5414AFF4A377BE93C9DF54E18FEF3D
                    1523C0FB21EE5AF801EE0A89C5F8F902B261CCCF1B7F51E01DBD2016A3169AE4
                    FD5B65BA053F79FD04160A94063016979E5D82AC802BA1D79B8AEC62B0DBD77A
                    7F8646CFB0BFC98C1081E6A94B76A858E131A1D22E815E822EC31B7A032FF3F4
                    8E5848108EC678AE5F148DBB17CB7B9E8CC59D733EC053AFEE412B6B71D8BAF8
                    C8421597306EE334F05E2F69E0D5D2D2D2D2BA412490E43062696B5A7A905552
                    A3609703CE948797E03B1846AF2FE380CB5B55318AFCB21AB4751A20C20A625A
                    FD938AE185CD7062DA65C9DD834EBB51416CC3C739181DB00123C376E2AE05F4
                    886E169864C605DF210346D18918550CE2BF02DEC7CCA51F637152A582536658
                    50B04A0FED2018ABB4CDF6C4022FD85689C088228CFB85006CC08718BF20CE68
                    0F3DCEBDC07CAC80EE88F95BA57D02BDA102BF6102E78B127147C0664C79320A
                    F9D58DEAB8DDF64EF5D480C0EBA687576520D1BA1ED2C0ABA5A5A5A57543A953
                    E820BFBC1E9902BC3902A859960615DA30B866788039B02DA3B80A95F5466601
                    1DD2D07F29FFAEDB0EA753E608BC2E07ECB63679C5811AB99179FC791346FA6F
                    C3E8A7E9B97DDFA86C164680F40DBC84CD514102958BA331E7836C2CD85E8939
                    09A5989564C13CC6E20AA40E86050A40CF8D17F815F065C5B62777D4E0FB6B0F
                    E38EA00F7CB6CD6B23C336491B23402FEF88F909B83BD484FF7AEC2DBC1C9F67
                    F487B353F8B64379B909BCEAE985271B88D6B597065E2D2D2D2DAD1B42844DFA
                    57AB9A3A905154899C7263E019A157554A1B4C63B961D92E07BD6596D4A912C5
                    EDDD4E4113ADFECB0D17336CC817C9D2C32C3BCC8A7670F1D93EB0E74C0DEEFE
                    D97ADC15BA59555F33C0D1779E5B6320188B417C88EF2CDF8FA7B655631EF3E7
                    0AF0CE493206A0F9F2D6F6CF38F0CDD8E6DCF812846DAB4060541126FC3246F6
                    BFF1C276793CBD1C70378E79814399BB97D5E4B6E18ED91BF1BDA7DF478D4A50
                    C1E8E56E9597D821279543FAC3CD901D23DE43EB3A4803AF96969696D60D21E6
                    286DE974A2C8DA808C925A81D116815D015E157FDB3B1E77E0E6F5F2E6B28805
                    07B0C9FE2AEA9B61D331BC0312998E15D718CB6B7708F0B918932D2F30965514
                    BA3609DF98F51EC62C4C320A4AA8D0060F50F60A19A08D0A8DC07DBF32C17F53
                    9E2A32E11F578A808432CC4BB02A6FAC37FE76A0C66D052754626E9C59E5E7F5
                    4F28C1A2944AFCF8CFC7307A3E07B0F50A659036329E57B579719CCC6F56D5D8
                    4685C66242E07B589F785A1DA75B60DFEEE891BE306EA138A1079C411F5AD747
                    1A78B5B4B4B4B4AE8F0C1638278E192BAF6D5195D0F22B04422D8DC81238BD5A
                    C0CB0C0FD9967681DE4E6495B07845159A3B0C30A3CEC1CAB97FB42E29B29C00
                    2FB311B8DCDD82BC027D7203A1EE217A047CD18193759DB863D666DC19B81DE3
                    9E8CC1DD0BDE1778642684F340E99D8E0CDB8A1FAE3B8A27536A3027A610FE89
                    A5986712388DBF782686FE9802DEF80A05BCB3128A31DB5488F9C9562C8EB560
                    F2EF53302A38E21CF0127615F0CAFCC8D0288C5D24B0BB3012DF9AFB017EFADC
                    36B4AB50F006E37C11B3DBA52F1C3639979CD217FA09C2F594065E2D2D2D2DAD
                    6B2AE5EDE2C82626E2F70CE2E158B1DA961E649B8D9463DE6C0A867D125807C7
                    2EDC476E59134A2A9AD1D96380895B1AC53854952ACDAD3D7303118722DAED7C
                    CC0FBC16710A77CCD9806F2D8815E8A587371AA399DA6B711C46B2C8842C8F0D
                    89C183BFDF86D9F1C508DD5EA93228306E9703CB0218773B881E5E1AB7A7C21B
                    120CE3BE8252AC78ECC34C8C7D722B46856EC27D8B4D02BFD2CE45B11829A07B
                    DFC20895CDE1BF424C98307F334E6595C9D139C00CC45A379E34F06A69696969
                    5D53A92A6A6AF00E4B082B979840A60B65D52D2AAEF693607A6D4C556E2BAF47
                    4D433B9C1EEFAE51E2D8A5804DABFF62565E97DB88E5CDABECC2777E1D8D3B43
                    23306221CB061B95D458596DFC53268C0C31E27B1F7B2B0B2102BB04D200015E
                    5A70B2157359216D103DBC34022EB7E9DD8F11DB5BA6D2943D1AFE11EE0AFD50
                    DA1581F1D25EC6178F9C2FED5D2060BE3011DF08781F7FD87004ED42BA0C5970
                    E84C0C37A434F06A696969695D5339F968971E5EE5E535A21AAB9BBA9067AEBD
                    7060D975B05C694391B51E1DDD7C040F381C0E692BDBA81F460F4444C01E5BA7
                    7CE7CC5AE0C27B1FE562C4DC0DB873C10E8C15D8F5960F1EB7381677046DC2F4
                    17F6212CB612F312CD02A46502BAE502BAC586E755796309A8836706F05ACE01
                    AFCAE020CB6102D8019BF330EE99588C14401FBF300E2382B708EC460904C7E2
                    AE90244C7EEA43A415D4ABE3ECE079E2323CD95A379634F06A696969695D53D1
                    C34BAFE939EFAE0DC82FAB5725842F4C1D763D8CEDA843657DAB823469A8E191
                    562DD5EAAF78C3E076CBCD83A34596ECA8EC70E327CFC6E21B7319B31BED293B
                    2C1019B41923166C85FFC622CC4FAE46404229FCE34B04424B14F406984A15F8
                    72DA37BDD8408CA9C90CE0E5764BD594CB2C39FCF48E5A4C5FFEB102718633B0
                    BDA3C3B660C29329F8E727D6635DC409CF31BAD0CDFB22278F51EB4693065E2D
                    2D2D2DAD6B2E05BC2EB78ADDAD6CEC405A512572CB5A3E1166704DADAC0979D6
                    6635582EDF528BB64EC3CBAB184623EF80C4EFBBDBDE0DBBB31B6E170706BAB1
                    2FAB16A39E78052399E28BC01B1689BB823FC48CF08FF1F4AE46F89B2C2A8481
                    21078CDD65888177DA372461A0E60D67A0A7971620FBE694B04DD00E8DB762DC
                    2F62A57D9B317E21013D1277046CC223BF7A1FADCAA1EB84C32D67097390B955
                    5E32AD1B4C1A78B5B4B4B4B4AEB9E835A55ADA3A51505E8B4C330B4C10787B0F
                    24BBF6C634689902DED92535A8A86D82839117D24E3DBE7E807239D069B38128
                    E870F42828E4EDC46F5E37E1DF6747602C4BF7066FC583BF4A44F0D652846CAB
                    C09C447A73E97165B84119E6C4955C00A8BD8175A0E6855C6F4883312F966456
                    591B7EB1BB093F793DDD0867086585B548FCFDCFDFC0AE1366E3F004E81D4E81
                    5E1BC374D42AAD1B4C1A78B5B4B4B4B4065D2A17AB1871D13BF5CE73F0126378
                    1D76372AAA5A915B5AAFD28F658AE5953523F77A5A798BB485E9CA18D35B83FA
                    56A334AE5B90D73886F352B1BD1E70D7BAB498E9C2297D653352748819DEF3B2
                    FA667C63F607B82B600BEE0A8EC6FFAE3B8185029C814995989B508179A622F8
                    C7172130A144E68B11926C817F5CA15A0E12201E2C9B27DB53FB48609C70B19A
                    A7050858B32D4171455824F30FFE711B468445E29B02E94F3CBFC9605B391687
                    93193DE47C10E8E529C1F5D7DB98D79AA64E517A9ED54A31F6FF27DE7D8DCD1B
                    2AC49C756C8E6A27FF3E706ACCD3F85E0E70E5EF6FA071F41A78B5B4B4B4B406
                    5DAAE296CAC4707E4AC855EBD1214B4E34B7DA5058DA82FCB23681CC06649737
                    22DB4CD8BC4E26FBCE2913E02D6B426E453332CC3528AB69529768B86CEA224D
                    C8F5E6E755176C45135A9F2603642EEC2FEFFCB39B33F0F59FFE19137EBF0781
                    D1668425E40B74328CA10AF3E22D08B88EE66FAA4040423542138A307F7B11FE
                    F7BDB3F8AFD0ADB8634E24D2330B54FB791C6E9A1A84295327D3D8C9797E2DCC
                    C77F828AF29F137601F11EB743A6F2DB93DF203DEB76678FDC78F079C5F5FD8F
                    5FBDB7229FD3635CA7CE137553CCAE94774ABB59C084C0CBFF06220DBC5A5A5A
                    5A5A83AEF37023172D0F20323B8392DB86A6F64E98EBDB042A1B905126A029C0
                    9B69A95590797D8D6DA8438EB509E9255528AF6D86CDC10BAFD1761E93916582
                    1768EF316A5D8E7ADF2CF496B9B50B8F3CFD3A7EF2E6698424D7206CBB05A189
                    05989F5281C0C4EAEB6A41C9D598A3CA0D5B31D7548285DBEB30F1D9282C7CF3
                    10EC9EAFDEA9BC943C2ECFB1A9271A37829827ED7C3CB171E349A3779DE7B377
                    F97A18F74F635FB18DBCA164DA3A1ADB6D5790DB23BF353BE157A01D9EDF607F
                    A581574B4B4B4B6BD0D51704B97CCE332AD72D7375238A9ADB51D0624371BB0B
                    556D2E5434DB51DEDA739DCD86F21607ACAD4E589A6CA86CEA425D7327BAEDBC
                    48CB75D8036D1A74AF4C17835D4376249F28C19C370E636E5C0D1E8F2C474864
                    3E8236A52130BA402CFFFA59543E42628AE0BFB91081915508DA6AC6531F1CC3
                    DEE246E4D7B6A2A4A10B0535ED28A96B47514D0B8AAB9B51A4ACE51A99777F7D
                    4DDA223792D6CA261455B6E370990DC71B9C3851DD89B4AA4EA457DB905ED573
                    DD2CADCE8E53B5769CA9EE4656BD0D99D28759551DA8ECE13922B0EB6C17EB12
                    E065916A416435185003AF96969696D60D2E231ECF507D73370AAC0D286CEA44
                    7187034502BD658D3698EB3B6169EEBAAE666EEC5456DA2C6D12F02DAA695319
                    1B1A5AF85855ABBFF27AC37B43AF01C19CE941656337FEFB971B70F3C32F62F8
                    77DFC017BEBF069F7FE4797CE9DBCBC5C2AF932DC7E71F5D8A2F3EFA12BE3873
                    19BEFCBDBFE0B6292FE0077F8AC2EAB8FD78396E1F966EDA89659B766045C46E
                    2CDFBC03ABB6EEC2AA885D581AB103CB22E4B5EB623BB024620F9E8D388488A3
                    D9884AB3E2F10F4EE2B1840A3C1E9B89B991399813552C56747D2CB2084FD0A2
                    4A303BBA18B3A52DB3B6E6E1B12D39084AAA503E5F97CB2E94DB0587DC1D1378
                    6D4CE7A281574B4B4B4BEB4697D721DAD363434E493D328BAB915BD92460D98D
                    922681CB663B4A057A2C0296D7D5A43DA52D02BE2D7694B53A915FD986AC12C6
                    F2B6A15BDADE17D8B42E4FECABBED0CB798603B86C4631DE2D3BCEE28BE39F81
                    DFFDCB71D3A4E50A7E873CB85C2CFCBAD9D0892B3064E24BB86DD20BF09BF02C
                    BEF2DFAFC0FF830CFC3E25074B638F223C2E15AB124E6049E4012C8DDA8FB549
                    2764BA0FCB4CA958167FF8BAD90BD187B0DA7442850D35CB6FEF778925F8FEE6
                    72F827D72340C077B6A91C73AE9B5931CB64817F620566C59763765225FC53EA
                    F0834D0598F0CA711CB5761BE5995DDD727E74AB000C6F1CF240A481574B4B4B
                    4B6BD0E5055CAFC8381CC1DE545F872C4B2B722C8DAAB259596D07CA9BBA5126
                    805924D3926B663D9F58572C562A666EEE12E895F6D4DB90C5AC0DA50D0A7ADB
                    DADAE418CE8736F4F65A6B7DBA7A43AF7799990DBA1DCCCBEB44B7AC7EECD79B
                    E137EE390C99BA0A43662C135B89A16243A60B78CE5821F38671FEAA59AF7DDD
                    3C7D35864E7F05C327BF04BF077F8F07971E42C8AE563C965886F084A3581D7F
                    04CB6353B1325EC037EE1096457E2CD383581D2BC0790D6C55F441C362CEDB4A
                    590E8FDE8F94F41CE9D746B1362415F7E0271166F80B60CE33952020D98279B4
                    24C30238EDB57C358DFB62068C90C452CC8D2FC6DCC472CC12089FBE3E13E3FF
                    7C0ACF6D390555BA8331BD76A3008C8303F134F06A69696969DD685228C87F98
                    73D5D5AD465E3777BA9059DA8402B17C4B0B72CD8DC8B7362BEFAEB9A507858D
                    5DB0B43A502ACB06905E1D63B84231BDC9B22FDAF9F576B11E816F1B4A1BBA90
                    53D6882C733D0ACADB90536214A66857D9B45C707B72C97274F9C02EC39F2D29
                    C8E5DD4F2F290F9E6740525E493DBE36FA2981CC57719380EE2DD39662E89417
                    70FBCC70DC3A7D196E9E22366D156E99BE5296E5F541B4E15357A8E96D335663
                    D894E5B2DF700C9BBC4A6C35FC26FD095F7BE2653CBDA70E41F11604C5566351
                    52215E4A388D57620E6075CC5E993F8C1502C15C5E29F0BB2A5600F42ADB7293
                    C0B6E988CCA70A001F91761CC6CAA87D782B2915DD5DDD721B21FDEAE4003060
                    D5EE5CFC38DA82B90935083595615E2C2BD699314FE03D38A10C81B125084C2A
                    BFEAC6BCC7FEACA0C72A774935981357891F7E588829EFA461F2FA748C7A270B
                    A634E63776A2C7DDA532367475CBDF9001061569E0D5D2D2D2D21A7429279E5C
                    9F5C2A9D97033D0EA70A0BC8340BF09A5B902FD36C81494265715DA7025EC2A6
                    173E1952D0DBBCA03A58D61778CFED4B5E2B6BEE46516D3BB2A56D6C637E7933
                    F2CCCDC82AAD47657D87402E8FCD78C4CA4BF0C0220BB59CD2973C5F1C4E23A3
                    C0D2B70EC2EF3F1761E8775EC590294B05420544A72D93E972DCFEE81ADC3273
                    B582DD5B057C6F9D3E08E6D9CE2DD3047CC508BCE75F5B8DE193C205789FC3FF
                    BE7D0AF3B755203891258EAB30CF548A67E333B036F6B080E6C758167F00CBE3
                    0E628D1778AFB2AD14E05D233842E5490000659549444154B01B1E2DE01B9F8A
                    F0D80302BE07F0E286249C2E6B35CE4DD2A2DD0819395E6743704C01FC936A31
                    2B9629D7CC08499163892B966312E04DF864418EAB65812CE7CC8222C935F869
                    940533DFCDC29477D33171431A1E78330B815B4E21B78E9E7FC066537799034E
                    7EA181574B4B4B4B6BD0458031E2355D7C188986960E81C61A641178E9DD2D6D
                    448EC0A42AF050D98CD2267A7709A21E6FAB074039A5291016181D3423E42A6F
                    B2679EFB9365738B2CD7B523B78240DE60B48F79792DCDC814E0CDB5D4A2BDD3
                    0033E614E6F131ABA956FFE574744A67CA54858B70B0A00DFF34FD79F8DD1F8E
                    A15357E3B6475E11D8A5D77505864F09C7AD5396098812820D401D0C23E4D294
                    97D7B3AC5E9BB21C37DDFF27DC11BA094FEFA84360A2050162FE89563C2ED0BB
                    382E1F4BE28F634DDC7E81CDBD5819BD5FE60F0BF01E54D07BB56D2DC3196205
                    761352B122F1105EFA30055B779F401BFB537AD325379A6E7523E1468374EF3B
                    C7CA313BAA50DA5E09FFE40A557083C53D020440E7265621488E8D55ECAEB605
                    0B6C07AB5CCB567CEF833C4C7C2B4D6037130FAD4FC38CB7B330EED5B37825B5
                    56A524437787B45E6634F06A69696969DD68E2536B97535DA6D06173A0B8B24E
                    00B70EB902BCF9AAC84303720426B32D8DC82EAF43716D1B2C7DA1B497150B94
                    16733A58E601DE12015DEFBC5A6EEA466195B4AFAC4EC16E4E5983407AA3AAC0
                    96CD0A6CA52C39DC02BB72F312D288BB1A780722B7BB5BA057FA903747EE66B5
                    EE2FD199183AEAD702BCAB14F4FA4D5C81DB67ACC3EDD357E1F393970A982E17
                    33C210066A04DBA193C3D5D4BBCE0BBC373DFC023EFF6838666DC8411801CD54
                    8A3909A5028716FC3CA11681026EBF35656285E918D6C4EEC39A987D582DC0BB
                    22F6205608905E6D7B394A003BF188C0EE1184CBFE576C4942714DBB3A2355FE
                    5A4F7603B7B347DD84E6D6B7E099C47C3C1E63867F4A3566C5172324B11873E3
                    4AF044A21C8F1CDB3C861A5C650B315910965C851F6D2DC2E477D2306943161E
                    DE908189EBD33165FD594C782B173F10103E5143EFAE00AFAB038E3EA130572A
                    0DBC5A5A5A5A5A832F5E67C5E8B3AB6C6A476669250A2B9A9167A1E794B1B102
                    BA0293B9E5B22C60995FD988927A4F0CAFC7A3CBB00305BC32DF1780076C84DC
                    5EDE63B55F595F5CD781FC726997C5F03EE7B0E431A7D616658CE9CD2DAD4663
                    5B8F820A6300164DABDF7238E57F56D462168C7659D181EA561BA605BE01BF51
                    BF54F0C9416CC3A7ADC5AD02A1B74E7A09B708F0DEC2585E7A6107680C5D60CC
                    2EE7BD00CCE9D0C9CBE1F7F073B8F777897852E02C34B902B3E38A11902CE09B
                    64C61C5385CA38B020A908CF27A409F0A6E2E5D803581D7F58851BF8F2C80EAA
                    C93ED6C9BE960B64AF8A3F8417DE4F42E2910C74AA9B31A33299536E3A55360C
                    7B07EF40C1B3363AA711733E4CC3E3D27E7F39AE405331E6C971F927D75D3B0F
                    6F4219E6259663A640EE436FA761EA870598F46E16A6AECFC2FDEF9FC6D4F732
                    31EECF27F0AB9D45EA1481B3197655A0A2FFD2C0ABA5A5A5A535F8522008B474
                    D9041A6B9069AE459E95C0DB8CAC7231C6F00A481AC04B0F6A1D0AAB5B8D3003
                    0F841AE1063605A6DEE5C1322FF0F6B62201ECFC9A36E44A5BF3CB1B15ECB28D
                    04DE6C026FB9807B990070490D4AAA9BD0D5439C97E31CE0E8F1CFBC04CA9CEE
                    6EB93912A0917908F852C9272A70DBC43F61E8C37FC2AD8FAE859F40EFCD02A2
                    B7CF5C81DBD4C0354F9CED008D806B843470D980607A7C874C0CC7FFFBD91B98
                    1B99AF002D745B85F28406C97C103D94F1C5982DD0F684D853F17958157B12EB
                    6208A0078C385B0152659C1F80116C7DCDAF8A3D84E5A6FD5811B71F2B23F6E1
                    6D532AAC2DDDB0336E1EAD72C3D9836EE94F5511CED10317B31EB8ECA8949797
                    A56463564C196625D509EC5A1012CF10831A0426C9B1F589B71D88717BDE816A
                    41D24FDEF5CCD4F03F5B7330F1DDB37878431626ADCFC194F5D998F96636EE17
                    D89D26203CF5EDB378706D2AB657C9CD3303345CBC19EABF34F06A69696969F5
                    5BDE51F76AE43D5D9E6ADE25175B8E0E77A2B2A119192595C8263C0A2CE6B38C
                    B0802FE78D9001C26E9380703DF204328B1ABAD4C031022807B131A656C5D50E
                    22F09670BB02D2A51EE8E53AEEB3A8AE53DAC0908B7A1458A54DD24E865D107C
                    B3A4BD394C51A6A61CC456879AA60EC15D7ACF3ACF1D3B67D4F1AB79ADCB91CB
                    E146A7BD4D9046808CF70E641B57179A647EF6B264F88DFF1D6EF2A40A1B3679
                    9900E972034C7DC06B7FCD880F663883E1DD1D3685210EE198F8E24708492E43
                    40820573E24B15ACF90BF4069B4AB14020774E62197E965881D0F822BC10978E
                    97E38E6065F4C7CA03BB4AC5F21EC20A015305AAFD00E08BC2AEC75E8CDE8735
                    8CDFFD70270E64941BF96BA5035DEE36319BF428CF45392BE5B7E870C8AB9E9B
                    B3DD858D98155D801FC554C9B1581146CF75BC558E6FF080979E5C2FE4CEE300
                    35CFBAE0242B1E97BE9CBE3E0D0FBF7B06933EC8C143EF6460FABBD978F4ED2C
                    3CF86E2626BF938E6FCBF284B5673127B60C0D6CBB93B1BC7208F20FEF8B386F
                    FCD648F45CBAB434F06A69696969F55BCC8D69E45635AE406E1612E0E023B713
                    9DADAD2810D8CD62CCAEB55DE0B6090565F52ABD573EC1B28FE50A5CE6096896
                    B11045931D25AAE259B7327A7AFB826B7F8DC05BDE28D3066EDB88E96589D822
                    2B07D3312B83C02EDB28307E411BA5ED59667AA5DB9587BAB0BC016DB62E396C
                    964215D055A9B5ECD2177615DBAB3550397122B3045F9BB1127ED3D70988BE80
                    2F4D5E8EDB26AF5199159842CC17BCF6C708BCB74E5B8BE1B2ED5B047AFD1EFE
                    13FE65CE1B08A53737D90A7F0134A6F0F2C25C80C922D312F8279A315780D83F
                    B1044F25E46079C259AC8B3928907B00AB4C02A202BDCB981B97397263F78979
                    BCBF97695EC85D1EBD5FCDAF916D727E0553A1C5CBEB5127B072EB5EBCB7ED20
                    2ADB3B79AF20E79FD3732E5E44F27B2518FFE9E35CFC6F6429C2E2AB303FAE08
                    8FA79C07D4C1B040E9BB90F80A05B873E3A5AF92CC0890ED072654E0DB1BF330
                    512077CAFA4C4C79D7984E5E9F219689491BD230E39D344C5D9F8F7B3694E2E1
                    D78F20F62CD394B1E986C7BA470E8F55D89CF45C3BE5464903AF96969696D6D5
                    14E18E17588A5E4DA7C398B7D91DA8AC6D518FFFB32C2DC8AE6C17506C445E69
                    CD8510D9CBF2183A205658DD0EB30069992A04D12580DAF509681D883186D7D2
                    28D0EB89DB35B7DA5158D3AE529015F868D779AB47266378CBDB04CE5B55C5B8
                    CAFA5618E3AD182B69B827BD37015A0314075BC964F1AA44F88DFC3586308677
                    86C0E9D470E585F505AEFDB59B95E758E6A7ADC6CD9396E2E6292FE0476F9CC5
                    A2ED35CA3BE9356F0C2AE7831304E04C65989B5421C06BC17C533EFE90908E70
                    D309AC89DDABCA0F1370578A2D27F07A41B61F5EDEE551FB14EC7A815701B040
                    EF72D331846FD98D9385952A9F312BD7393D21211795870DCFD674232C221773
                    63AA116CAA41409CE1C11E4C0B8C97FE4A20E49A313BBE180102BF3F8F28C60C
                    02AE07742F3059377143161E599F8E696F65E1C10FCCB8E79563581C711C45CD
                    8677DAF89BE380DDCEFCDEF2BB93F3E472A481574B4B4B4BABDFA227D3003DA3
                    4CACDB7335AD6BE9415E790BD24B1B91696D438EB55D55562B30D720B7AC5EE6
                    7D98C02E078531CCA19440AA0A4074A2A4A9D3F0C20E921537F728E05503D518
                    D220F339150CBDA8953633CEB8CE77FBCAB8BE51A0BC457979338BEB915FDA80
                    F64E75C8EAD8E959F3F6079957736FFFC50157148B7DFCDDBDBF86DFC3EB70D3
                    A32B307CE652DCE2195C3658364CB6375CA6B7CF5C05BFB1CFE01B219BB038B9
                    46A0564037919E5D42AE5960D722904B302C4370BC19FE711695CE6B6EA215F3
                    E2F3B128311B7F48CEC0CB717B55D686B5F107B0266E9F00EA3EA31A1BBDBE02
                    B0170C3EBB84F1BDABE53334C606D3CE2D471FC0EF3E4CC6E683A7D164A4AA95
                    4EE349E780533DE6F72D754F2AEF71CBC9B9FEB0153FDA5C8C39894D088933CB
                    B112EA07CBA4CFE486C0DB5F01B23C27A10CDF7B3F0793DF6691893EB0EB01DE
                    87D76763EADBA7318D1EE00F8A31F1FD423CB82E15AF1FB218EDB775C88FAD4B
                    6EB00D00F69C269F2A0DBC5A5A5A5A5AFD97BADA10EE7A6077DA14EE76763B51
                    686D459AB90559156DC892F92C4B237204240BAC460684BE30C9752A3B820065
                    66691D4A6A3A15F05A9ABA054EE9E5F5841E0C8279D3903186B7BCD98EC2CA56
                    B54F8276769F76F5B6DCD25A55192E8B9926CA5AA5CD02F2C50D305776AAC7AC
                    440CFA24BD9E5EB5E2322FC65A9F94BA6160760151D4F642F8FDD793F09BB604
                    43A7BEE0135AFB6F2B04785783052EFC1EFA236EFFEE32CCDD5288C53BEB3197
                    D5C704DE8CD85603DEBC0037CF440F6639E69A2A04E62AE06F12383615E2C96D
                    F9CA134BEFEC5AD3C173C0BB9CE9CA18D77B05C04BF3826EEFCF19D09C8A259B
                    E350D26644EEBA6D36C06EDC6CD93D25B07D89AFB839800DED28E974E0A9EDA5
                    F8616C39FC53ACCA13FB4970EDBFF90BE432E699DB0DD95E85FFDD5A28606B84
                    2E7843192E3401DEB7B331734316A66F48C7036FA5E1A1F5F998F06E3EFE67FD
                    099CAA6C523F2B38DB65EA90DF9D5BA508BC9C9F99065E2D2D2D2DADFE4BB88E
                    C575EDAE6E615F076C7235AAAEEF444E698331484D603257A60C175031BAE57D
                    E262FB980A6B90F7E6595B606EE84499F2C6127807314B0307C0B5D855DAB3D2
                    FAEE73904D2F2F53A5F96A172D8FA590E55818D690CDF08C8A1623C3841C6BA3
                    40874DAEBABCF43ACF8DBC32BA48ABBF22C6D8A51F3B5442AA89FEAFC06FDCAF
                    318C3972A7F7AA86360876F3E4E518366D29FC1EFE1D1EFC633216A530944160
                    368E00783E9D9637B4818FEB99933730412091E02B364F80772EF3DA2697E0C5
                    8433586A3AA1E0949E5EC6EFAE60318A5886295C41488380AD771A1EB54F412F
                    D39E31A4E1852D1F23E5C81975B61971F43D70BB5460C325019083D858DD0EE8
                    41979CA4B139F5981399839FC9F104F7094918887190DADC44B3F40B3340B06F
                    2C78F4BD4C3CF46E3AA608D0FA025EC6F14E7DCB98328303D3944D7E270BF76F
                    C8C384BF1CC50BBBCDA861D3E5183956C0E1905F9C7A8CF2E9C8AB81574B4B4B
                    4BABFF22F00AE8BAD57870075ABB1C2826E096D41A1E518607A8345FF5CA3B9A
                    4168F401935E63C800C138533E5B54D30A2BBDBC045EC6F3FA02D7CB1DCC26EF
                    65A607AF15A9EC0F761456B5AA8A6FCC149165A51950FB897609E0169819B7CB
                    90867A8163815E6B9D806F8DB4B716A5B2DCE550C993A41F780196B9CB7DD6AA
                    751109D008C03904CE887031FBF3F095FB9F87DF432B0DE0F59404F61ABDB5BD
                    973F697CDD6BB2DCEBF343A6ACC44D935EC0DFFE641D02B714603E612DBE14F3
                    5435B2F331BC5EE380AC391E400C8C3723284E20580099991CFC4DC5F86D5C26
                    FE949086F0F854AC8EDDAF421B08BA04D64F40EDA7D839CFAE8A0396797A7C05
                    7897C51F454DA3E101F7FE061D4E415899BF64284D0FF31EF3DD6A0135AD0EBC
                    B8AD183F13A00FA2F5025663DE807DEFFACB357E7E4E82C0AE7C3634C98A1F6D
                    CAC694B7CEE00101DB8902B21703DE47DECAC243F2FA83323FE5EDB3F88E00F2
                    C3EF9CC2BD02BD53FE721C1FCBDF108A2144AA743207AD5D4656140DBC5A5A5A
                    5A5AFD161D45AC92E572BBD4A099D2EA066495560A20B224AF61F9CA6B6A802E
                    BDA97D61D26B845D56612B286F455689C0A47CAEA4BE1366EFA035C2AA4C5541
                    0ACEB7DA553CEEC5A05785307800B7F77A8BBCDFDAEA14A0EE5095D408D8DC3F
                    A7176B9FF24C0B08E7591A553BB99CEB3D4699A757BAA6B953312E335510789D
                    97A40EAD4F974BFA93393088BB1DE8E8EE81FFEF36C36FDC52DC3475293EF7C8
                    72DC225316A11832391C5FF8F65A0C99B4E41CC45E680C5D588B6153D660B837
                    C3C3CCE5321F8EA1D396E1F6492F61A800EFA465FBB078772366C79508B89620
                    38D97A8187B7B7CD135360C729B339300381CC33563530B1147F8CCF16D03D22
                    B0FA319688AD8E4D3D5776D817D8FA3282EE2AC6EDC61E107816688E3FA106C5
                    BDF0610A8E64E47BFA89BCC7670B72ABC5817ED26797E43F393FC98936759E32
                    3FAF1BFBCA6D786C530602531AD440BC2039F690A452CC892D96E3B12238A5CA
                    38CE5E40EB356F7FF435C603CF492811F0B5624E9C1533DF4AC3E437055EDFCB
                    C62402EEC53CBC4C4B26F37CCFA477D2304D8077F2BB6978E4DD6C3CF05A067E
                    2E3724CAC9CB185E9B03DD0E017C2E7F8A34F06A69696969F55B643A8E8FE105
                    A7B9D32E00588D2C738D40601F60A4D7D487E7F4BC11349B05785B043C5989AD
                    5E016F5E658BCAD66069318A4F2823B8322441E68B5A2E0EBCDE12C2346F1843
                    598B43016F59A34DE5D95595D3C4D80605BE9768E305E118BD8E87C7CA18E552
                    696B67B771E9753B980BF5722EC35A1715CB368B75136CD0A556EDCFA8C63F3E
                    CAB4614B31648A40EFCC9502BB2F8A2D11A05D8EDB671A25817D02EFD4D5183A
                    6535864F5FAD3ECB1086E1D3653A5DC0F7813FE0EB73D6C33FD2027F86293015
                    99C05E6F8FA72FF37A41558E59CF7C80180B52FC3A3E4F20F524569AF6213C66
                    0F56C71C526587AF147857CBFB97470A30271DC1D298A378312A15EF6C3B8C86
                    E626D527572A97BD5B0132E35FDD4EF6AB1D1542902B3FB2E06751150850611A
                    66C3922C981D6F5155D17A1F776F33BCDE0CF7386F06F4F27316CC4D28C70F3F
                    C8C794370578DF6191890C6553046CFB02AF177A150C7B8098F0AB627EDF4E17
                    00CEC1F8574E2236AB5EDA2DD46EEF41B7BA21D21E5E2D2D2D2DADAB283E4AA5
                    B785159D4A2A1A90555CABF2EDE60800328FADF2865EA615585B64DA824CD946
                    AE55B621DBC92AAB43715D3BCADA8C416684566657E0A03356463BE7C5E5B48F
                    29D095F73374815E614E998A8CC09BAFE26F193A516778763D5EDE0281605F6D
                    BB9411D0592E39B7B446A529A39757E525D61AA0083202BC7257E51428730BDA
                    3096F70FAFC663C87DCF63E8A435B8596076A800EB6D33C271D3432FE07333D6
                    28E0ED6B0C5F603AB361D397E1B64756E2E6C94B71F3A470151AC1F8DD5B263F
                    8F1FBF9E86A776D2BB2BA047CF2E414E41DF859ECB4F3501BC80F84A81E542FC
                    3A214DC0F528FE1CCD9086BD02B01C7C6680ECE5DB41AC8CDE8775A623088F3D
                    88655BF7E08C9C6BFD95DB6993F3D3A9FAD2CD01960C8390F912F97DCCDA5288
                    B9D14508309563567C294252AC2A3699E60D6DE86B7DC33DCE997C2654B6F3B3
                    A8124C7CFB341EA4A7767DB60257C2AECF2C0D173381DFFBDFCBC2E4F77270EF
                    6B87F1BDF78FA28CC91AE8FF777F4A1A368F34F06A69696969F553843A5E70DC
                    6868E912E0AB4376293318B429E0CDB510262FDF088FD92C3D6CE6A0B56695B7
                    37CB5283FCCA269413741B7B5445B4B236A7F2E01278BD9E5EE5CDED6BB29E90
                    EB055E4BB3006F8B0325755D464606815C1AC31818C76B002F3DBDBEDB7771A3
                    37BA59B6518B42596EEE209CF166407592567FC5146F0E3B7A047819D660771A
                    F9DF6A9A9A70E70FD7E1A6FB9760C8232FE32601D95BA62FC1EDACC6F6B0C0EB
                    34564CEB6B2B954777D8B41771EB4CA3D004617798BCD7EF81E771C7824D7832
                    A516C102684149563C115D28B05701FF786669300BC05D81990404E3AAF04452
                    294293F2B0342E0DAFC61C11E0FD08CBE3F7A9CA6B2B04642FC708BCE1B107B0
                    263E152BB7D053FC31B6EE3D8DD66EDE0C184F56AE5C0E389C0EB949E5E7652B
                    F4F2BA18D1EBC2BA634D08DC9A89B9045E311E3F4B0FF398989ECDD7F17A3357
                    F43575C3209FFDEE07D978F09DB378F0FD1C4C62F685773231F51D4FA686CB35
                    01DE07D7E760E2860C4C7BF7241E782D0D7F3952233743D27E7BF765FDD834F0
                    6A69696969F5538C1AB4A3A3C7865281D33C7333F2057659598D9919BC31BC97
                    6B04CF2C82A380A72A39CCF5E50D2A9D59495D27CCCC9DDB24E02BE0EA0D5BA0
                    B7F7621E5E7A8409BBEAFDF2D93299D2BBCB3464DCBED708BA045E02B72A29DC
                    A75D976339652D2AB421B3B81A965AA31885F6F20E542CDB6C531E73BB2A3660
                    83DD6140EF3B09F9F0FB863F86CE580BBFA9AB3094E10DD309BB4648C3276D15
                    86CF308077E8D4E518269FB965FA1AF84D7C11C3A72DC1AC8802CC4FAE52C517
                    94D7D24490BB3043C3655B42996CA7124F240A300A24FE363E5F60F7A4183335
                    B0625A5F0FEE252CF6A0077C0F237CEB3EAC8AD88E826A23948103B6FA758631
                    4FAF002F53E9F16615D2AF70B2EC700FB25A9DF85D7C161E8F2A827F52B5006B
                    29E631A481610EBE8E55CCA777578CC0FBD3AD8598FAF6594C12D87DF8FD5C4C
                    5C2FC0AA0096DEDE3E507B4913407E3B0B0F6F48C7A3EFA661F26B79F8F67B67
                    905EC9F3418E4103AF96969696D6D5945D2E9ED5F5ADAA0003B318B00A599682
                    C05EF1AE97692A7D99B505D9326F785F1932C06DD1E3DBA4CAFFD2434B4F6F09
                    BDBD1EEF6DDF41695EF382302157C5EDB25C71ADE1DD65560605BC9E7DAB4C0D
                    B24F23A4E1936DBBB4713B02F9D65664980D406F6A1750538382B4FA2B0EBEB2
                    F7D8D5637787C326CB1C90450836F20B8CFAD1B3F01BFF2C6E99F917DC3E6335
                    6E7AF879DCF6E8CBB85500F79331BCAB9487F796194B048E578AADC290C9CB71
                    F3E4E731FE99683C7DA005FE7146CC2EA197DEDDB9CC1F2BCBBEE2562F650C81
                    F027F49A2A15F8862514E3D9847435F06C0DF3E97A6076155394798DCB2AB6B7
                    577C2FC15880774DFC1184471FC6D2A803883F90E6F1EA1A8523FA23238519E3
                    A2857399C356FA5999C309BB4CB79CAD877F5481C07A2542E55882122B304FE6
                    8D5CC49F3C5E05B7BD00D86BFEF166CCFC204B159998F65E2EA66E10E815D09D
                    24D04A80BD580CEF454DC5F4A6E391F5D998F4562EEE79E334967E548A2E3582
                    EDD3A581574B4B4B4BEBD2EAE53D393F6BCC74F6385062A94741A9006B895160
                    82E9BAF2ACF5971C00F60913F824D46609F0660A781246B309A402A205E50DC8
                    2CA9455175BB8AC1A5A7D70BBC06D47E1278B99E9E5DC2716943B7FA1C07AA15
                    56B59D2B32610C8C33E2702F04DECB877563709E6C438E9B2594732B5A9129D0
                    6BAE6C503942A90BFACCB3D0AB4BB52E227A7655DA2996CA65ACB8F427D36919
                    5DE744D2D92AF8DDF73BF83DB012B74DA16777196E9A16EE137669C3A62EC3AD
                    3319DEB05A99DF432FE20BDF5F8185D1459893CC2209026EA6520409C005C496
                    226C7B9582395F9077290B20F09A8A11165781C0D86ACC3199F154729600EC51
                    AC8BF1E4E225CC3236D76346CA322FE872DEB34E6C4DDC112C8B3982E7B67E84
                    2A95858CC54DBAA50B045AFBC1BCE443DE38B89CCCAB223715B28D6E99E55309
                    B8DA90DF0EFC72A715B3E20CF8F797E9BC040378FB422D8F9753AF47D70BBFCC
                    58F1786C311E60C534E6DC7D8B9EDD6C4C16E07DE8BD344CDE4080ED03B49732
                    79EFA40D6998F8D6599916E03E16A5589F8B7B5F3F84A3A51CC04679C0DDBB24
                    C7787E4903AF96969696D6A7895E20CFE3F9F3A0665C30CDF55D027CF5C8B1B0
                    0A99018DFDF1EE2AE3E77C7C5641A559A0545E2BACEF54836B8A9ABB8D108706
                    862FF8065E6FEC6E7153B78AFB2DAC694786B94E79A0FBEEC36B57DA762FF016
                    9BABD5B16794B5205DA03DCB528DAAE616810917BB4F79D5540E3731C57097E9
                    95D2BA8854A52D606E7822FCC6FD0AC3A60BC44E5B8EE193056A7DC0AE1AB436
                    231CC3662EC76DB27CF3C34B3064CAF37874CD212C48F1EDB9F402DD951AC12F
                    C024009D5469941C8E2BC6E2B84CFC3E3913CBE34FE095A8C358177D48E6F7E3
                    A5847D5826C66A6C2B2399B62C15AB63F66155CCC75815BF17CB4D1FE14581E0
                    E7367F8C8359A5EAD0BB855079EC4E42EF20DF39A91B0CD870ACA40173A30A31
                    2BB112FEF145EAB808B3BE2C9855E698B398F1BE0925084AAE12D8ADC0D4B708
                    B8198631244179680D78BD72EF6E261E14E07DF00316A6C8C6B7DF2D12F84DC7
                    C36F9CC08F622A5167E70FAA1376B939EA915955F2DCD104BBFCE795065E2D2D
                    2D2DAD4B4BAE814E0FA1F1FAEABDC6B6B5B723B3A406D9A546F18502166D1000
                    54B1B7FD855E1F46A82C286F569ED9BC9AB67331BA664F7A319F55D87A853970
                    A09B8569C82A5B9029C0CB50095FFBE98FA9B611C4CD552A0639B3BC05190CEB
                    28AD47696513DABBED0A4E08BC7C34AF1EC93BC40619543E7362DCA9E8405E23
                    FEF5072FC2EFC197E03771256E9FBEC6C8B1DB1778C508C4B74E17E340B5879F
                    C77F046E4440542942922DE7528A0D8AD1FB491814D8F5A7C55B10169F8FA713
                    72F092E924D6C4A4E2E5687A6FF70BF41E103B887531F4F8A60AE4D2CBCB6A6A
                    87102EE0BB5CDEB32C7A3FDEDB7D0A356DC631F3D4311271191EDA41153DBF72
                    AED6C9CF7DED7E337E16598079DB6A119070F178661E1FC197212121C9560424
                    55E0071BF330ED2D03747D02EC959A02E72C4CDB9087E96F6662A6CC4F7D3F13
                    0FBD730AE3FF720C51695546FB59F151FE56F1A680BF3797AA3C674803AF9696
                    9696D6A525D75497271E5501AF4CF9B4BEAC921E5D663730066E1990DBA8CA0A
                    1B9E5E0E041B1CE360B28CE21A15735B5CDF792EE382B9C1939ACC97D1CB2BEF
                    E360B5A2DA0EE5D9651803D39DF9DA47FF4C8ED35287024B8DCC73D05D8B1881
                    B705B9C58DA8ACEB428FF415FBCCC5BCB26E271C4C94AF817740B2ABEEB3C366
                    B7E3B7AF6D83DFFD7FC0CD53FF8CE19399966C45AFC16AE7EDD629CB71FBE4E5
                    1832F1050C9FBE04DF7DE50416EDACC55C66146038C32059905830B31724B2B4
                    6E05E69898DACB8CA0F812FCDE94861571C7B0963979630E6045EC7EAC8A4DC5
                    2BD1C7111EBF1FAB4D87B136E1289608E486C71DC20A79DFDAA88F702CB744DD
                    38B91D3DEA5C621E10879BD5D506F73C723B7BD0E3D9647A551BE66C3A8BC713
                    AA057809B5BEB334783DBDC620BF0AFC3CAA04D3DE4E3320D517BCF6CB645BEF
                    E4C876F3319D052CDE398D29EF9DC5B48DD998F0FA19FCEF6B4750A5F8BF1D6E
                    7B873A0686C4C066C47B531A78B5B4B4B4B42E29A7BAD48A7881A5074866EB5B
                    BB056CAB15EC1246E9EDCC310BF895B72A23F0FA4EE175E546A0CC91EDA9985B
                    8274450BCC8D3654B6BB51D0D0A5E0D6575A326666E06035863EE4CA67F87995
                    F24CDAEA6B3F03B1FC72965036B235645BDA9057DA86ECA266B5AEB9D380147A
                    CFD88706F80E2EA87CD6A4CA50B819D02AE761791BFEF37F9661E8A4D518F230
                    6379FBA62433ECF6A9ABF039015FBFFB9FC59D8B22303FA91A41C9154665349F
                    20D74F4B14F08B2F5590E84FE84D606803C1B71C4F25E6E04FF1A7B12A46A037
                    DA88D75D159D8A75D127B03C89B97A0F6079E4012C8D3B8255DB4E62E9C68F10
                    B9FB043A6DF4EECA7963EBF4002F6F3A39F06C70CF23B7B35D951C76ABF85EE0
                    D54315F8F1D642042697AB5463BE8CB1BD84DDE0A42ACC89B7E2BBEF6563CA3B
                    6731E9BD7E0C4CBB98A970885C4C5A5F8049EF67C8B64F61E25BC73173430E1E
                    595F8871ABCF62E349E626A667578E416E2C6DFC43653306E7511A78B5B4B4B4
                    B42E295E38D46595175881B6AE1E278ACA1B915E62643720EC2A8FAE5900CFD2
                    8CEC9246E49A3FF9F87F20E61D605620F3AC8C565CD5AE3CBC4502BC17843278
                    8C610E0C7920EC1656B69D1BA4E66DEF609B82683307AFC9BC9AB688B521B3B8
                    06A5958DE8F10CB652B1BC32C71843ADFEAB47CE45A7A30B2EB791A66CF3CE33
                    F01B19865BA7FF45CC7748C32D02BD374F5C8ADB7FB00AB3238A11BAAD0AFECC
                    C490D0BF58DD8B9A00F43C0FF0AA785E16A250DE5E56302BC53309B90817E85D
                    137D18AB63F7199918628FE2A5B88FB08EF976230E634DCA293C1FB5077F89DA
                    25E74F9B3A46953A8C374C720A19E321AF02F00AEE7260A0D361844B98E59E62
                    514C2666C514C3573803CD005F0B82936BF193885215CAF0F08634658309BC93
                    D767E121B1FB37C8FCFB5998FE763A66BE9525FBCBC2C31B2D78F4954338EA49
                    53C6DF974276CFD8034A03AF96969696D625C5CBAA935759971D6EA703F58DED
                    02B50D48B7741AD915C47215E8352BD0CD1610368077F06265B3CA0CEF6C5159
                    33F2CD0DC8B734A2A4BE1BA56D461E5E05BA02B8DE32C3F4FA96355F58648231
                    B6465BBD83D68C108C811A61975EDD5C6957A1558EBDB456F651837CABECCBDA
                    20905D8DFAE676D5976E97538C03D914B168F557AE6E815E373A1C3C3B5DE098
                    A599A17F86DF849770EB0C0FE0328C414D8DE5E132F5BBF78F78F0C53D2A9481
                    601A2CA016122BE0E60B5CFB69DC5680A7BC2E333E040B101A03D9CC98956841
                    98A9184B6233B026EE3056C5EC4578DC5EAC62AC6EFC7EBC2210FC97D8E3581E
                    7F18CF476EC3F623192A7CC32E379A6EA66393F386B0AB322AB80D281D4C39B8
                    4D016BF514C26E00F596DC26FC3CBAF01CE0CE5366C0BC5AE640B5242B1E8FB6
                    E0BB1B7231E59D0C9589E1E1F78D8A6A3E01F60A8DA111D3DE49C7D477CEE2A1
                    0D5998B8211FD3DFCD97E51C3590EDC1F7B231E6CF27F1DCF662B4A96E61FE66
                    42EFF9DF99065E2D2D2D2DAD4B8A6C66978B1FCBBCB675095C56305C815ED776
                    15CE6040246192F3346F2E5B02E185E0DA2F93EDE75B9B555843816C975E5E7A
                    6A5940C2DAEA845980B7A449E0B79995D78C79B3185392310D99F2EC7A8097D3
                    1C666990F60F96D1AB9B5BDA22C0CF016C047FD9173DC904EB6A0E94AB414965
                    831A3DCE5006E640651105ADFECBE1E8515E7322998395C2447B33EA71F3DD21
                    183A650D864E5B8ADB66BC8CE10F87E3F38F2C557977FD1E78095FFEE13AF8C7
                    08E46EAB56C01B1A5F26C02BE0D6075A0762CCC33B2F51E665FB0AAA19E22070
                    48F89D6BA247D482671273116E3A8675311F634DF4C702BBC7F072E221AC88DC
                    8775F127B024E223BC12BF07D5AD86079B831C194E448F259D960A73E5E669D0
                    8157DD90318734CF5345D5286B6BC7B2DDC5782CBE1C8F271460419C19417115
                    989D548940C6ED269422785B15BEBF310F53DF6441891C3C24603AF9FDC10B69
                    50C0FB6EBA40AE6C7F433626BDCBB0096681C812B096D7379CC4FDEF9B31E3AD
                    4CEC29A2475C6ECEDD3D2AD699E2EF4E03AF96969696D6A5E5E0C596A10D6E58
                    EB5936B8C688D32D6D1620ED0DB5E7BD9E8306BB6204EA42AB00A54CF364BBCC
                    954B2F2DC1B7BCA107E5CCD2D0D48592165AB7006F17CA04788B6B3B54810966
                    77A087374B4C15B420F0B2ED836AD25699E6F5599F2B6D4D2FAB4576692DEA5B
                    6C9E27AC2E7531D6EABF1C8C2527043AE5E641B0467A563DC29EFDCC1BF01BF9
                    2C6E796425864E7F05B74D5A835B27FF0143A6ACC490894B30F5859D08DD5587
                    B90902A402BB61320D8C1B5CE035CCF01A7BCDBB9EE11373047CE7A514E34F89
                    69F873EC01AC8BDE87A502B94C4DB62CFA0056C4A762C9873BF0D1E97C75AC7C
                    2A70ADA46EC86872976B84DF886C5D38985B8F597125F8D9B60284459B111A5B
                    8D2708BC71460CEF132C3241CFEB3BE99828C03BF91DC6DCA60990FA06D8FE18
                    A1570D8253F1BC0C7130A684EA87DF3B8E87DE2CC47DAFE7637152265AED7236
                    7477AB9CC3148F4503AF96969696D6A7887E34A0B1C3A9BC9619C51CA4254057
                    7675E2617D193DC8DEF85B2FF0D28A2BDB60A137B7A507C502BAC502BD9C2FAD
                    17D865210BF90C81D75B6C82007C7580D7B7D19B9C555E87F4922A945434A2D3
                    E6BD041B7DAAD53F11711D4E565DA3DBDC051B8B5388CE1437E0F3137FAFBCB9
                    7E53D6E0F66FAFC3F089E118FAD0F3F846C0BB088DB12068670D66998CC7F141
                    A632CCEB05A457DBE8E99D2BD380640B9E31E56059DC49BCCC0A6CB1FBB05C40
                    7755FC112CD9BC1B6F251D44EB39E7ED353C577867AB266E954DC43BB8B259BA
                    77C5C7C5F889A908B3936A116CE200BD6204C75B11B8AD0ADFDE90AE3CB093DF
                    21F46662DA7B399824F0EB0B5C07DBA60AF08EDB7C1A8FBC928169EF1460ECAB
                    7B119356CFFB4AB156D57E0DBC5A5A5A5A5A972107BAEC0E98AB5A915D626421
                    C8664AAE72165BF09DB560B08DD92072CC8C8DAD13E0650C2E07A0D52AE82EAE
                    6B57906BF6843394B5D85058DD2AB05B67843308E87ABDBC7902CB6A6A21345F
                    65634CB3B45B954C1660CF2EA94185B4D5AEF225690D44DD0E3EEA77C1CDA70F
                    622E27E1CC88D87C61532A6EBAE70F18FAE83AF84D0BC7B0896B70DBF4E7F0C3
                    570EE2C95D0D7842A07376721902E2651A5D28F0592620DA27D3C25532C6F112
                    7899B92148E67F9B908395A663F873CC4E2C8B3FA18077CDD69D382BE7B60A58
                    70F4C83FF45D5F1B29EF2E8C01964EB99160E9706F0ABD8CCA0E0444E7E127C9
                    75F08FCF47685C2E4212EBF0F3480BA6BC791A53DE49C3A40D19982836EDFD6C
                    015E7A607D43EAA09A00EFFD1F64E0BBEBB3F0C8FA1C8C7F271F8FBE7902B52C
                    21E768516DE720360DBC5A5A5A5A5A97142F77354DEDC81668CC2A6D15886B43
                    96CABF5B0723FFEED536230FAF7799F0CBFCBF2A07B0C02CE37B998FD7D26257
                    D5D5CCF5DD0A32BDB04BC83D37708D1E5E022F334A5C03638C6F76A9B4B38265
                    97D9EE3AB4760B9C799E166BF54F8C27674E63978B15B5A433E5247539BAE515
                    3B72E4C66CC2137F81DFFD7FC44D53C2E1F77038C63EB5158B129931C1AA6097
                    658483195A9068C6EC24E68FA5C7F7EA1B3337300D9A7F7C05E69A2AB030B114
                    CF259CC5BAB88FB03CFE24966CDA89D8FD67D0EE700AA4C97131D6FB1A863410
                    7209BC2A5C4496D5BC0A1AB62B3FF386E30DF8C1966C042415A9C1777313AAF0
                    C8DB5998F16E96C067BA2AFF3BF93D23DC60EABBD99EB0031F903A88A6E27BDF
                    4AC3C31B05B8DF4EC7F4F5E5B8E3CFA7B0E2B051998ED231BC5A5A5A5A5A9FAA
                    4E9B0BC5150C65A842A6405B769900A40A69F01D7E70358CF1BBBD978D417286
                    650BD81656B719B02B964F4FB4AC23D81274CF8532789639EF2BFCE0EA98B4AF
                    58C09BE58655B5B85A586BDBE0302A2768F55774DEA9220C04427A780575552A
                    2D954516AF461FC117EEFF2D863EB40C7FF3DF2FE3476F9DC6FCA40AF89BCC08
                    48B1C23FC18C5081CFF92915989D58EC33FCE06A18D393053233445CB9B4A14A
                    C0B10CBF4CC8C18AB8A3581175087F89F958CE15C3BBAB0E92E069047E5F5331
                    04C01BCE40E03562CE6D6086B48571199893548C60E9CFFF892CC6E4D73231E3
                    BD5C4C56DE5D015E01DFC96F6760DA7A59778D80F71101DDFB379EC5E477D231
                    E38D22DCB7B9140FFE650F0A1AD411F01F0DBC5A5A5A5A5A9756657D17B20AAB
                    04166B912D17E30C4B2D72ADEDC82C1008F540E7D5B69C528636D0C36B2C739E
                    31BDB4CC126997402C4B0833F76EA6C5486146B8652843969990CE3CBC46F18A
                    BC0A034639C0EC6A1B07B3155A5A90616E4256459BB44D8EA5A0129DADD7CE6B
                    F77F52C2B66EA7130E573B6CCE1ED805CA1C02684E858A9DA8133E7B78EE06F8
                    DDF12CC6FE2A024F7FD40AFF382B8293AD7822BE0421029F61B16601CF12CC4B
                    E2C02BDF803AD8E62F90C85086453116040AF03E9E588105A6028427A463E9A6
                    5D48389603FAA98D8C0C0CD3F0E2DAB59143DD3418C0AB06AD11B83DFDEAEE61
                    1E60607D4613FE27225BA0B70E533FC810B8652A327A73D30478CF60D2BB6764
                    394B80374F01EFD53781DE77CF62CA0759982AA03DE5AD6C3CF4411EC6BF7A14
                    2FEC28E351F180FEFA80975FBCFA12E8EA57262BC4B8CAC5DA2B0C5C973B673E
                    E1B0C917A36E503C2531B5B4B4B4B42EAD73173A112F74B61E166E6840516D1B
                    F26ADA9157DD85C29A6EE457B6C15CD781FCEA36145C672BAE694549750BCCB5
                    ED28A914C814E02D2C93365B991757E6FB5AB98F7557C10AAC752816C82D2A13
                    AB6C4191B4335FDA55686942B1C548A5A535C8E2759FB19BA2ED67F2F195C9BF
                    40E0961A3C115B8D9FC614E36731856245D7C7A20BF1D3D862FC4420FB422BC5
                    0F622D7827761F9A55EE5B222F075BF56617C2CCF5349153DAE6EC04334AFF3A
                    B90ED3DECAC3A4D70EE0BE37B230EEB52C4C783D1BF7BD9987FB65FD036F17E0
                    DE37736439EB1A58B6EC3B0D0FBC9383B1AF67E19E37B89C8307DFCAC77D6B8E
                    2231B34AF9FDFF6A3DBCFC434C373F1378D3DB6F9C163DE869A805BABA15E8F2
                    3E85EBDD1A78B5B4B4B42E4BFCDB4AE0557F63C55871A9AEA307654D5D286F71
                    C2D2EA82B9D9890A99B736DA541EDCEB6B0E585B6CD2361B0AAA5A90515283B4
                    022B4EE796E16C4105D20B2B91769D8CFB3E9357818CE21A9C2DAAC6E97C592E
                    A8427ABE1525D6264F8F6B0DB6E8F9E5D5BFBECB8EF752D29192DD8198AC06C4
                    6437202AB3F1BA5A5C7A1D12D26B6012E3F4DC7C86AC3F62C61BA653D8B02B0F
                    EBA5DDEF6FCBC086941C7CB02D5F2C4B2CFBBAD97B3BF2F0EEF65C9966E3D5C4
                    0CBCBEBB042B77E6217C673656EF4EC7DA8F32D594B66A571A56EC3823D3B358
                    B333EDAADB6AB175B2AF152927B16637DB9189553BD2F1CA9E2CAC4C3A8E8493
                    A5E8B0FFB5C6F07A6E36F84799A9D01954AD1E0EB537A2B5A0008EBA46B90B71
                    2BE065D2612652D6D2D2D2D2BA3CF5F6F2D27BD06E77C1DAD0A98A399436DB51
                    DC6054312B6DE892A95D605896AF9359C4CCD286D2C61EA409EC9E14983C5358
                    859379569C12C03C9D5F735DED94C0F7D9A20A9C2CA896F97A01DE6A64165BD1
                    DC459F93D6A04BF8804E2E9793591C9CCA29C93399B460CCDDB82AAEEAC1779E
                    FA00FFFC930DF8D6E39B306ED67A8C99FD36BEF5C4067C63EE66B14DD7CDBEE9
                    BF11FF3E47DA316723EE7B221C59E64664149460E7F17CEC39721A074FA563DF
                    F1B33870324D2C1D1F1FE5BA0CEC3D796DECE0C9B3D8937A1AFB4FE760F7C94C
                    EC399D89DD27CE60D789D328696A9793E2AF312D196197210C326353C0EB9479
                    39A9DD0ED82CC568CFCC84BDC42CF0DB2E7FA75D2A19750FDDBD5A5A5A5A5A97
                    25AF77D72B8EAF6AE814B06DEC546049E865395F6645286559DFEB6C25CD3DC8
                    AE6AC6F1BC729C2AACC0D9E26A9C96E9294226A1F33AD9C9BC1A694B154E1496
                    E1389715F056C15CD7247D4A00D31A74117855E6862ED8ED1D804380C14D6868
                    15630CAA402F97AF9319D462FB84A9B2196E3B361E2CC39D21C9F856F04E4C58
                    908211211118B9301623C3A2AFA3C5E0CEB028DCB52809FFF2D866ACDC7A5675
                    75736D05B6EF3D8DF87D27B0ED581A9253CF22E5886109074F62FBD1346C3F7C
                    5AECCCD5B554B1FDA7B0FDA0EC2F3553DA9181EDC733A55DC77034B7507AD726
                    DCD8F35708BC3C57C514F0AA9C7B7212C98138DA5AD0999305776E2E1C39D970
                    5557CA9B6CCACB2BEFD0D2D2D2D2FA149DF3EAF61157773BDC286F6C47517D07
                    8A0532F3EB3A606E759CCB8C70BDCC226D286DB021ADB44E80B2126945B53853
                    48EF6A9558AD80E7F535B6E964BEC077611D8E669721BBA41A1D760EB6629CA6
                    D6A04B6ED458BA99577E9ECF4E0EE8115EA0FBCBED16F0519E5EE3F9EF7531A7
                    D3C81DECEC6BF2B2BB0155EDC04FFE94806FCE7A1F630530EF0ADB8C098B6330
                    21544CC0F3BA98ECFBBE45F1B863CE7BB837E04D34A83F136E39143B4EE45521
                    65EF59EC3C90865D0733B0737F9A9ADF79201D3B0E09741ECE86E9D0D535EE63
                    DBA10C6C13E04D3A9C25C09D85D88F8E21E5D029D474F077C64C1E8EBFDE185E
                    3965C4E4C46542E6F636749494A23B3703C8CF813B3B13B6C25CB9A153F92878
                    FE6B696969697D8A2E0865109DF3F2D2E32BAB9B3A05329BBA50C4D086563B8A
                    991541ACF47A99002FBDCD59A58D38955B89B302BA67722B7036B70A9985B538
                    5B50AD420838ED3B7F4DAC50F629D07BB6A01EA7F22A91515486FA560EF991BE
                    1658D0BA3A92B3580D5C178E448F4C3BED0EF4487F3389199FF85E4FB38BA9E2
                    0E9F30C13247876AFF995C2BA62CDA806F2E48C03DCF246164C8FB18B1F8438C
                    5824E69DF69DBF6AB649EDE7AE8551F8D6ACD710772857B5D1E576A85B87A6F6
                    66EC38711609874F22F9C869241D3985A4D493B22E5DC0F32476A69EB826B643
                    F6BD3DF5B480EF296C174BFEE810F24B98A181F718724648FFFE1502AF9C180A
                    767982C82D91C30E575D2D3AB273D0939F0DE464C29D95899EEC2C745594AB01
                    172A69B29CF4724E7937A1E6B91DEF2A2D2D2DADCFBA08B8BE80974FD21C420F
                    9D0E372A5B3A51D2D0014B9B0B05F58CE96575B36B610CA330009BCB0C65B0C8
                    7C515D074EE755E18C00655A410D4E665B712647E052E6CFAA18DE0A81CD0A35
                    E5A031DAF9E5C1B5538C1BF66CDB98B70AF4D60BC0D4E3649619A59535B07110
                    B57A4C79BE9FB5064FBCAA335C84D5EC98A68CBDEC74D9E55C66BF33AC808EB2
                    EB68F25B5240E2C36C6C232BC8C9CFEEB76FECC6BFCED982518B9231362C0A63
                    434D32356174480CEE992FF3A1F1181312AFD60D96DD23362A54203B2C16E3C2
                    643A3F4596A33156F6F7AD595B31EFE5BD6852DEE826B96173C2C6B2CEB021DB
                    5C85A47DC7B1F3483AB61F4EC336B1EDA9694839744600F8EC35B1E423679028
                    C0CBB08AA4FDC770F854263ABB8D9B4A22205BFA5707BC3C7D9D72D2AA3FC3FC
                    A7BD033DC545B067A5A33B3F07CE1C81DECC4CB8320578F3F3D0D1522F074A30
                    36EEF6D4E7E49CE27965977FD8095A5A5A5A5A171707073BD4DF5E37DA3ABB51
                    D5D8012B07AD35BA54FCAC4FEFEBA09A006FA343CCAE06CB991B7A50DE22D6D4
                    8D4CB3277CA1A05A4CC0574D9911A10A69453562C63CED8C40F099825A0151C3
                    DB3B98C6EDD38B6B2CD7A879B5CFA23A9CC8AD1200B7A2B98D03A97801E6A375
                    EDE1D5BA506E05C51CCCE84076652B1E0E7C0F7707C561C442426E14EE591885
                    51211B317E712446876EC598B048DCB3207AF06C7E34463F65C2B8059B303658
                    F627B07DE7FCF704BA233171DE467C7CCA0A9EC1F257404E62F9AB20A73059CA
                    26B6E7D049A408F4A610788F66C1B49F31BCE9D826E0BBEDC8553681DC1DC7B2
                    9020809DCC98DE03C7505C56EDE953457D4A7F75C06BC4EEF2CFAFFC6773C051
                    5D8B9EDC7CB8B232D19D97035B7626DCD959706765A143D675945BE4DB309225
                    7BEFAD14F9CA17C43FDE32D1D2D2D2D2BA8478CDF05E386CF2F7B3B6B51B45F5
                    EDB0B4C2F0B6FA84D4C1B41E9519A2B4C9094B931DE6C61E585B9986AC1927F2
                    2C3893EF1B4019527096A9C104407B43EFE97C82AF01C78365E761D730865730
                    ACE194B4ED448E15E6EA2638543FF2F12A615703AFD685E260BB6E3B87B019E7
                    C6CB9B4FE05F7FF236463E998231A184DB1801DD088C25FCCAFC5801541AE707
                    C5E6C760C4822D6A3A2644B6FF643C462D8CC53766BF8B675E3B08B9C7443733
                    DABABB04A0849EE47F56B7234795543422F9E3A3CAAB9B7CF82C520442099F3E
                    0175B04D0D96CB40F2A1D348DA7F1447CEE6A0B58B379517EAAF0E7889BA36F5
                    AF13AEE62674E617C09E930B308481C0CB816B39D902BDD9E8494B47576E1E5C
                    B575F249A62953E320E5A432BE28C2AFF1275C4B4B4B4BEBA2528FE1654A6093
                    498BCD81E2C67694B40A8836D9542CEF5535816AEF20B5E2862E958AACA4BE0B
                    E9C58457EB4580D70BBB1CC86600A801BD9CAF53F37D3F3310F36E8FE07B32B7
                    42CD739F27732CC82CA9425BB7F13C516510F00CAAD2D2EA2D6650ED10EB965F
                    99B3BB5181E4C4059BF0CDA03805B9A3426804D3785926FC46624C9801BF8363
                    B1B83B6C03C6872563ACCC8F5CB8052383E3F0C0FC0F70C26AC4173B1C02BB72
                    FEBA6C2EC3BBEBEE512103CC9A959A9E87E4032791422FEBD174240980A60890
                    265F6553702DC0ABF67BE0182AEB9B55DF514E9593D9D05FA1879726FFDA7B60
                    B398D19991A63233B8B30576F3F2E0CCCF5383D69C59197029F0CD8523BF10AE
                    AE0E38E5AEDA2E7F640CE0555B39D7295A5A5A5A5ABEA512F9137679A193BF9D
                    7CE85AD36E435143074A0448AFB61178E9E9F5C6EE96B73890636DC2B1EC3264
                    945C1C5E8D420FD7167839F502EF4981DF53B9665437B629BC65DC23AF3A1CDD
                    AEC6966869F592DBEE64BD5874F3698ABD59E61C883C64C55D73DEC52881DBB1
                    617118B72011E31726E3EEC0088C5F1C83710B6307CDCB4B881EFF8B488C666C
                    F0C2388C5E14893B7FFE36DE4AC9564FC805A484206972D326A7B2831CE5B69D
                    83CA4AB909DE71E894025D7A7709A204DEAB6EB29FA4A31930ED3B86B3B945D2
                    2EB7B48F7FAB3826E1FCEFECAF2F86D7FB47B7A11EF6BC1C38323314F0DA056E
                    1D32750AF43A72B361CF4E872B374B81B03D53DE575D23B7209DF2A7869D205F
                    9D7402BF22FD27474B4B4BEBD222E4AAA1C20A788D31141CC056D124C0DBD437
                    FCE0EA58716397806FA78ADDA57737ADA456850A7841B6377C7ACD3B80EC2C33
                    36C8FBB88EC07BA660708197DBEA1BD2403B915B893C7335BAD4E01EFA69F838
                    D80927FBD01322A2A5E5156378ED4EA114D2251D73726B59DFE5C0C29777E2EB
                    B3DEC584C57118131A8F7BE62708E8466374D826E5F9F505AFFD3201DE910BA2
                    307A4184006F2CEEF4DF8247176D4483CAA0278D7273F09F1D4ED540B6578052
                    C51DF36F8353FE26B8D40D5EF2C15302BCA77D871F5C1563968874EC92695D73
                    9BA76D0EE947A39D5EFDD501AF528F1D9D252502B584DD2C3560AD2B8F709B2F
                    F3D9E891795B413A6CB919706665C295958B9EA212F90BCD7430BCB376C897C3
                    4118BCD7D6D2D2D2D2BA94886B4C42C4510F845E5EE898F6A9A9DD8E42861708
                    901AB1BC86A9AC0A7D80F572CD1B13ACB6716E9EAF75C12CB05BC6816A967A9C
                    10903D5348A8BD38B81A591908BC06EC32A697F1BBCCCF3B5831BC5E70265413
                    7A0DF0ADC259950FB80E9502E9AAE704089C0E8E2761FFE92B8FD627D5E3EA92
                    DF97984DA0D7CED006528A03DBCF5661C4A258DC35EF4323A34228431C08A51F
                    0AA8328ED707BC7E8AF98EFF8DC6DD02D3639FDA84BB4322F09F3F8D40446AAD
                    D138679B0A5D60E55A1B6B1C387BE49CB6C1A5C644716A57056A2A5ABA8C6210
                    C7329074E8CC27BCB184D3F3D6175C2F6DC6368CC216DE6DD0BBCBD7A2F79F45
                    5A699511FDAC46D3D984C3E536BDD74FED86055ED5484F223D7632EB9028AF39
                    73E93554A12D371B10B8457A261C5919E82ECA82233747159DA0875719E7C518
                    DAC0F7D8AD65F2B7C608B0A68F827F73F4DF1D2D2D2DAD4B8BBE483550987302
                    BB5EEFA453FE3E5B9B1853DBA90A409434127EEDB0B408A0F6037A09B88CD3F5
                    4EB9CDE2C66E05BCE6C62E54B63B5158DD227029205BC0BCBBBE3DAB5E338097
                    83D798ADA156193DBC869777B08097D32AA4E797E1645E058EB1E04461238E67
                    97A1B4BCC173C135FACC488D65F4A696565FA954ABEAA692E70AF1C73857E8A8
                    FCF59BBBF1EFFE9B948777DCA2388C0E136855C01B75C5C0CBD85F8642D0BC31
                    C05E001EBF2052A0773DBE317B139E782E099D36A34D0E7A71A53986579726ED
                    54E733DBED12F895654F6843B1B50A5B767E8C5DA7B2B0EBF009EC14DB75F834
                    76A69E41228B431CC942F291740FB4FA86DBBEA66059007A572A333F30C76F16
                    120FA763FB094E4F61CFFE43E8B61983FDE86DF6DE54AA2EF4E8C6055E365201
                    AE1B76697C374F025976B5B7A1D35C80AEEC2C2097F1BA02B9D919E8CCCB10B8
                    CD8153A0D7C9A9679E10CCD00667563A3A0BF3E16A6D35B62F7D6144F16A6969
                    6969F5570D9D0E94332FAF806969B353A50F33370BB0D2D3EB036A2F691E8F2E
                    2197A606A9C994E05B2E106D6EE84446690D4EE6960B6432D7EDF978595FE685
                    61026F6F23040F56480353A09D916DA5175A15FC9E2A6A506584D3F32BD0DCA2
                    ABA9690D8EB2ACED7860D1668C5AB40D63436330664134462FDC0AA612632842
                    5FA8BD941172BDB04BF8F5AE5383E0645BA316C8768337E0E3AC46B56FA7C0A3
                    2A587711D181A8626509693269EDEAC1C727D310BFFFA8825C1682A0ED10C84D
                    3E9C21B09B836495AEEC0A81F7F019B5BD6D87D26112704E26F41E3885B87DC7
                    51565EEE698D218633786FCCBDBA6181979CEE0D36B609F0AA4742F61ED82BAC
                    B06566C2969125204B98A507370BF6EC4CE5D555C0DBCB14F0E66403F27AB74C
                    3BCB2C404F0FF15925A5BEB03BB4B4B4B4B42E57FCFBD9E574A346C0CE4CE8F5
                    7A671B09BCF4F6F6D3E81DEE05BF9C56B439905FD924106BC5C93C02AFC0EEB9
                    10824F82686FEB0DB7BDA1B7F77BFA6BDEDCBFE9F975325F8733C5F5389E530E
                    4B7593D149FA2AA3356019B4B92EEE38FED97F23C6842661C2C2288C5994A0B2
                    2928E8ED03B59F6604DC51214C716678760D4F6F34EE0A4EC01D0111F8D3FBFB
                    D0C5F14EB2EFAEEEAE4B9EC5E4290597CAB36A705545532B62761F40526AA680
                    69A6006B2612599042A62C4CA152977940F6726DDB9133D8C1B46702BC090765
                    FE58264C7B8FE2E0995C383DBCE81D40D7377E97BA818197770CEC4669B8A274
                    279CCD4DE8CECF57610CCEAC2C554DAD476097504B6F2FC3177C01AF2A4621EF
                    75C87BDB65DEDDD0207F838CA213DAC7ABA5A5A5D53FA9BFCF62ED3617CA9BBA
                    54D841A90A3F3080D7678AB14B9940AECAC820E04CEB0DC1A5B2ED0C731D4EE6
                    5B71BA5020B3A806A7647AB6C8F70034EFBADE531A61D7086DF8E467FA67B25D
                    4EF308BCB5CAE39C51588E760E50535718E302ACA5D56F7160186C68B5B931F1
                    99287C73DE56DC1BB61523586D4D01EC9501AF177039E5B2D7BB3B6E512C4684
                    C463CA5389482F174E4217ECB62EE5E16598C0C564C0A680AE8AEF772A00EE91
                    5547D3F311BBFF2C920E6721F9582E120E6528CF2E3339308598AF146397B214
                    015E7A79930476B731EFEEC193D823EBCAEB5A543BC88C045E42B7177CB9CEAB
                    1B1878EDAAC16C2BBB128E1EF49499D19D910E08EC32D72E61D646CBA11737D7
                    A7875741AF80AE535E435E0EBAD3D3E0309BE5DCE95620ADFF1469696969F557
                    1C14E2548355EADB0552EB3B558EDC3235C8CC0869B86CF37874695E0F2F8DE1
                    0C656D4EE49437E21461D7E351A56797A0995654EF135EBD70DBFBB5AB03BC34
                    8656705FD2A61C33CAAA8D47C11CD1AE81576BC0128874D898A60CD8B4D782FF
                    9CF52AC6076DC6D8850902BCB102AD5706BC045CDAF84571CA08BB4668432CEE
                    78E24DAC8B159652376B6D70386C8AC12E09BCEA253A29099BF2F7C0CE6C0EF2
                    37A1A10349074E296F6CF2D11C24A6662145807777EA69ECE847CA327A781906
                    E1CDEF9BF0D1119CCD2D46B727DE427997C508B95ED0559E678F6E58E0659908
                    0640AB1B1B514F5323BA7332E1C83C0B7B2EC319B2E1CACB15CB5399196CD984
                    5DDFC0CB94655D7946460708303BB2657D6D2D5C0EE32BD5D2D2D2D2EA8FE462
                    E2E2F33837DA857ACB99A5A1A10B65CD02BF1E60F542AC119F2BD67B5D2FE37B
                    19B3CB7963A09AF179C22ECB179F2D62C5B2724F91090E5623BCD2BBEBBB6A9A
                    17687D01AF1784BDE67DFD534DBD578C6D50EDF0AEAFC649597F3AAF0C05966A
                    74DB1422C0E564B5A7F3175C2DADFE4AA553757683F54B1E5F62C27FCE790FA3
                    823D31BC5E98F5C4F27EDA20B6B11E8FAE7759C5EECABA3BE66DC1777EF91EAC
                    2DC639EBE8EA50C0D8D6C9A213173F8FBD4C69002FD381C98D9EB4D36177E26C
                    4E21B61D388E6486361CCDC6F623E902BC8CE73580D757BCEEC5ED0C520E1BB0
                    9BB8FF38F61E4D436D53DBB9FD7BD5DBABDB5B372EF0BA8C9412EAE658A6ED16
                    0BBAD3CE08C0A6A1AB200B3D02B00C6BA067D746E0CDCBF70C54EB03BDB2CE9E
                    978DD63C826E3AC0D7D332D0556286A3D31850C0CEE21F6CD5696A814B5A5A5A
                    5A5A9716FF6EDAE0703A40B4ABEB722A2FAF597978CF83AC177C996D81DEDC4B
                    41AFF7BD045D7A77B99C5E568F532C222160793ED3420DD28B1B7032F7E2C0EA
                    0B767BBFDEFB355FEB2F30790F3DCA6ADF6A5D2F60667AB4220E9EB3A0AED9A8
                    48A54646F31AE6892DD4D2EAAF5892DA41165231B56EECCF6DC5B7C258023802
                    E3171831B8DEF084F3D38BE7E7F586308C09313CBB1C0037463EF7CF3F7E17F1
                    27AD6A9F4CFFCA44073C7B0D2FE9A5CF637A79553003DBC8F79339C55ADB5AB1
                    EF284BFE9EC2B6E339483A7C16DB0580B7A51A29CB7C81AD2A58E14937766E3E
                    95610D6791C4417047D361FA2815B92595AA552EFED67C348F71BCDED006EAC6
                    055E3B5371B0C7A4D1B5B5E8CA4817B8CD802B2FAB4F16060FE0E65CC4C32BEF
                    E37B6C059970666700593970E7E6A15DB6D35559023707B0C96E980542A500E1
                    592567D7F92ED2D2D2D2D2BA98D45F69157BC61CE73DA86C6945414B378A045A
                    CD4C4F26D3220E3C6B71A2A8C981A216C745815779769BBB50D6625771C0F414
                    17D77429D0F50E4E33E0D4B0CB02D55EE605549AD7D3EBF5F6FA7AFF0526EF39
                    59588B13CCE35B28DB10C03D995F2E9F65F10B01F1AC4A98ADF5B009E0F20AC2
                    47BBEA4272694ED0D2BA0CF169819C570612A1B9BB1B2F7DF031BE151085B18B
                    4C02AD5B15E08E5D10859102B3131645626C085396F9005E01DB510B6370BF7C
                    EE8180088C5B108B3B9F8EC537FD37E0A7CF7EA4B66F540494BDD2F9A760D798
                    EFAFF24B2B91F4F131EC389681844302BEA9A7CF01AD2FF3566AE33CA72A8441
                    C5FC9E45B2C06EC2C7C771F878263ABB543A034136C6CB7F7AFB6E600FAFDC29
                    B0B33B3B612B29852D3D43E035130E2FF0F605DB4B1881D72E9FE5E75DEAB3B9
                    E8CC66718A3CB89B5BE5DB65110A265297B38977E3F25D7BCE2B2D2D2D2DAD4B
                    C8005E5E208D78D5866E81D4A62E81DB2E585A0DE825C872305A49931D2502BE
                    3E81F75CDC2F07BFF5A0A2CDA5A65996069C2DB84C28BD4CEB0BBCDE757DDF77
                    81C9EBA708C762A758C042D69D66BBF26439AF1A3902E00D2D5D6A6C88C3E589
                    DD65E7E88B89D680451E12B073D283CA6729C009733BA63FBD0523426330723E
                    4B0CC7634C58A4006D1446046DC2BD4F9ACE797B7B1BD78D7F3201630492EF15
                    F01DB33009DF0A92CF07BC857D059D6ADB5ED0F5C6C27AE7AF5C845017DAE46F
                    C2C1D3598817E8DD792C0B49072E0DBCDEB2C4DE79EF72B218E13771EF51145B
                    EBD44F8B8E4A55EDEDAF1978D557EA74C0515D8DEE2C815C666620F032A7EE95
                    022FBDBFB20DE5E995655B5E0EEC0C8720449795C36DF3A429E35D0DFB4CEEA4
                    F4DF282D2D2DAD4F97BACC28D79371D1E976B951D9DA8D92460E60630E5D862A
                    7419D04BB015E055A10B327FE1A035BE66BC9756D9EE46614D3B4EE6B33CF0E0
                    C12EADF7F62E1B7AF3C58AE475668710D0555919F21B703AA70E67726A505ED9
                    0CE6E867527EBB835730E913768BBE98680D58029E3CAF84895CAE0E59EC4697
                    AC5D177508FF316B03C63EB50D778744638200ECF830A61A8B15084E10C0F535
                    982D1AA3059247CFDF8A518B2230224C80F7B14DF8E33B4760E0AE212FE8F6B6
                    2B17619465C380B2DA7AC4EF3E8C1D8733B0ED70A60A6D6048832F23D85E30EF
                    59DE26D3C4BDC770F094B09CDABAE09ADC04D8991DC2F84B7449DDB0C0ABEE8F
                    5B9A60CF2F84536566604882E1AD55A9C62ED38C90876CB8B38CCFB104718F40
                    B33B271748CF1298CE81AB81A5F38C138A7FB35D0E96A4A0C7424B4B4B4BEB52
                    3AEFF9312E39CCD8D0D6E3407973074A999B57A0B7B485DE5D815E81DA73E9C7
                    38ED6D7C4DDE6B6E362099DE5DA6213B915BAE06A8F984D0019AD7D3CB794E3F
                    0D784F155A15F0B234F1D982469CCDADC3C9AC4A6415D5A2BB9BC02FD72DE515
                    2320104E3EFD22ACA5F5E9A2134ECE27858E1CDF44DC75A3B6C38669BFD8823B
                    033763EC9309181B1A857B8237E1A167B6E1CE903805B79F045E81DD6081E2C5
                    B118F1742CEE0C8AC4CCB048E49431B597117FEEF5EC0E5CCCE2D20DA74A5506
                    1C399B03D3AE546C4FCD413273F1324481507B999674F014B6ED3F81B23A23C7
                    B5CD2E302DDCA63CDF6ACDA575E38634F4F4A0BBB4549504763376578524089C
                    665F3CFD982FE37B5DB9B9B28D3C95C981DE5DE6EE750BF822271BF6CC34F414
                    15C0DD25F736FC46E4AF35B343B80C1FB396969696D625E42DE149710804C78F
                    70104943BB406E23A1B71316862A107C056C2F16BF4BE37BCC02C71699CFB136
                    E1548155AC12A7AF02F0FAAAC2C6E58B42AF1AACC678DD1A9CCAAD455A7E03CE
                    E4727D392A1ADB8D0EA027CC03B90406A793AE1B0DBD5A0394FCC6F8D89EC8EB
                    6048034388D4283660D79906FCE7FF2CC5080E3C5B6CC2FD8BA23026648B006D
                    D285191C3CC60C0E131618C0FB1F327FD7ECD7F04EFC69B52DB8BD03F9CF9FB3
                    9CEF3F00F3C6CFE9F91D000D2D9DD871F03812F69F56E5812F59692D5560F8B0
                    11C74B53210D074EE2544EA9BAA9E60D80D3D5A3C25F59DAF87274C302AFB3AE
                    199D39B902B8E902AC67D12DE614D87565F60F785DB9F92A7D99332F4F01AF2D
                    2F13F6FC2CD9FE59B4679C454763BD0778C5F8057BBE782D2D2D2DAD8B8B1734
                    755194795E83D5B5522E426D3D4E94B11C705327CA9A05761BBB14CC1AE10B1E
                    E8656883679EEB19C36B6EED41717D27CE1657E3445E19CEB0C88400E725BDAF
                    FDB0DEC0CBCC0FDEF98BED87D91958CE9883E54EE6C867F2EB713AB71C192566
                    74BAE920F1D2BE010986D1EB7B7917632DAD8B8AE792FCA67A5C02795CE46925
                    66E479069E783E12FFE6BF01773D693206AC0571C05A9C01BC1EE81D7B01F07E
                    8891F363F1F57989F8D1F3F1B03430C7AFE0B4B13975EE7AE585DDDEEBAE44F2
                    5115F1C481706C7B7A9119A6FD4791A2D292798097658695C9324DD6F58EDDE5
                    72E2A1D3D8733C0B35F2F784BF28BB8301181C282BDBBDCC2729D71578E5CF24
                    BF47F5778237C1744AAB2E912FD5915F60E4D65595D43260CB353CBCDEB0065F
                    70EBCBCEBF574059E5EACD55797999CBD7C6D086BC6C558CA2BDB000AE8E3669
                    81DC953BA45DBD52596869696969F9D639B853F3C63ACED8E522D4D8E580A5B1
                    13250DDD02BE324FA8A5D7D75382F8BC67D700DFB216794F931DD9658D389927
                    7029B0AB0A4C0C32ECD27A6FD3EBE1A5795FF35AEFF7A7CBEB0CAF3895473096
                    F57966D436B5A8EB86BAAAB303F8FFB98EE0A5D93BAFA5D54FF1F7A562559D20
                    DB310108C71A194F57ECD8975B8391211FE09B0111B86F412CC6866DC4C8855B
                    317281C9A8C4363F0AE3E61B991C462F88C62881DEBBE79B7057C0066C3D5428
                    67A8D0B3A35D6D9BEA0BBCFD855DCAE5E129A7CBA6F8AEA1A31B7B8FA563FB81
                    33D895CACA6B4C4FC6C2149ED085A3E902BA84DC0C241C3CED29452CEF397012
                    39C556E3F8B95D95A28DD428C66EB80CDD18C0ABEE54D87436DC067B733D9C99
                    1902A79E785DCF2035C2EB95C0AED77A7FEE5CF961D9A643CCCDE2151959E896
                    FDD96BCAD5FE99F34EDD416969696969F5532E743A9CA86CEA46513D0B51B860
                    16A03537B42BE05525840576596C82B0CB0A6DE52D4E14577729C024E81240AF
                    16F07ACDBB6D7A7969DE7DFADCAF2C33EFEFA90223B638BFACC6F364F932AFB8
                    5A5A832D57A78ABC7DF2ED23F8D6131F08D8260AD44660C4E20F318295D816C6
                    6274C816DC13B645950EBE67711CEE5EB80D5F9FF5011E7F7E135AD5461C02A5
                    5D029304B2C115EB29A892C3B0A9FF7AE4F7925D68C5B6BDA7B0FDE059A41C3D
                    8B84D4D34812E04D4A654AB2346C13204E4E4D97E5746C3B2AE0FBF1111C3E95
                    85C6D6DEC3EAAE5CD71578A51B54B262F631F373ABECB75D1DE82C281020BD72
                    B0BD5223FCB25A9B9BF09B9181EEFC3C816D968474A96A265A5A5A5A5AFD945C
                    E45C2E3B5ABA5DB00ACC96347A52927961D703BA0A765B1D02BB0E9436F420AB
                    B4518126E1F3642E43087A01E75530EECBEBD9F502EFC5009BED39C5D7D8BE02
                    2B9ABB8C67C07CACAAA5755DA4AAF90119150D98FAE4667CC33F16639F4CC6E8
                    B00F543189F18B62307E6114C689DD151AA14219BE353F19DFF8E92BC8B470A0
                    1AC0C2800E429883F96C07590AEEE8DBB5292F2F7D89AD9D4E1C389985F87DC7
                    046E3354B8C2B6A302B787CE629B40F0F6E399301D388D9DC7B3D5BA64015E73
                    05930B0C4CD71778E92A97698FFC4BFE87C306778515B6B4749F803AD8A6BCBD
                    791C08972DB71CD9B06764C266B600F66ED5262D2D2D2DADFE49E50B75DB6117
                    16AC65EC6E7D178A047A8B5AA18097904BD865BA32ABCCB3C8447E65ABC0E685
                    45262E069F8365DEED7BA1D73BEDBB5FA34DCCCE20AFE796C15CD5A4C236F864
                    D2E9D48F04B5AE8F1C7CC6EF6895B3D08D57E2CEE2AEA0288C989F847BE76FC5
                    B8F911181BB615F72E66FC6EB42A4A3176B109FFFCF8BBF8F55B87D4E7DD3D9D
                    68971FA9AA86ADB23F0CAE8C7003DE10CA0D303397705154525D87A443C7917C
                    F8145252D3B0E3482676A6A663F7217A7A8D9CBB84E04481E2E3E979E8B40DFC
                    37767D07AD79805730573AC209774B33BA054291CDB85DDF903AD8C6FDD8B332
                    811C0E60639EDE5C38EBEBA545FA8E5D4B4B4BABBF628C1D07D5F0095E4B9713
                    5656516BE84121C3169A987A8C610E3D2AFD98F2EE0A10679632B7AD01B9F4A6
                    5E4B2F6FEF655FD0AB80B7508057DA9355604547B772D3C871CA75EC728308B5
                    B406592A0AC1297791EE56989B9CF8F1F349F8C6131F08E4C6AA308631611118
                    19BA55603712F73E9D80BB833661F293EF21BD42E0566E4ADDCE4EB9717329E0
                    F516B5184C19D91DD84886B03296976CE54697A0EFB1CC3C983E3E8A6D8CE53D
                    948EED87D3B0F3D01905BCDB59956DDF096C3B740255F546E0059DA403D17506
                    5E156E6CC4F27675C3515E869ECC0CB8F333547CAD2F401D4C635C2F3338A82A
                    6CB95900D76566A3A7B814E8F0A499D1D2D2D2D2BA62315590AAADFFFFDBBBB3
                    E7A8D2F38EE37F45AE72918BA49CD895D8AEF822C96D6E52959B54AEB2547261
                    BB5C8E9DB8729BB2C79E01090904839DD819676C27C000420B121ACDB0A305B4
                    B10831DA100231121292582584B6EE734EF72FCFF31EF50C050C631092A0E7FB
                    81477DBAB51D1D759FFEF5AB77B1ED6C9CD7DD87598DDD5FD2C8AC055F6FE17D
                    10857EBB5E37AC2E8FCF58B04C5B76BD3CE83EAB7BC1CBAE42D02E5C7F3CF4A6
                    FD7A6FA96768425377E6C2CF954B3CD41376B181FCEE17826BDA3D61DFB1017D
                    E35BEFEA8FBE5BABAFFDCB01FDE90FEAF495EF54EAEBBEAADA77F6E80FFFE11D
                    BDD3703E2C5C11BA1DC5CB16426325B1BF807BD9F765FB8AE185AF87DD34F4E6
                    127B11BC324DD9ED99390BB8DD6A6CED51436BAF3EF0B9794F9F0F61F7B0B7EE
                    B69E53F7D0689886CC7FD0FC2AFF92B2C181578AED2087CDD987CAF40F59F0EC
                    5574A547C9E0E574B0DA1A57CEBFCF95012DDAF7CDD965AEAF5F199FFE6C6A3A
                    EC1700E0F979434626E72335EC69CEDECC2F279A9859D0D8ECA2055F0FBF1674
                    67238DCFC6BA61DBBDD76F59C81DB7A079DB42A607CEDB3A3B386161339D1161
                    BDCA83AEB72C87E0EB817B7865C6060BBCE7AFD8FBAE4E2BE3CFD73E62DE9ECC
                    FD892CACD2096C04BB0B2E2C64ECF1B6ACBCAFC266FEF687B5FADD6FD7EAEBDF
                    ABD557FFAD415FF96E8DFEE2DF0FE98FFFF9BFF5D73F3AA1ABB717EC5E9BB1CF
                    F017A391A28C37F065B5B0CA16D4A7F3C7898FD7B2C7487895E87DFB33E1C5A2
                    EBE81E56C3C94BFAB073488D1674EBDBBB74C42EEB5ACEE970C7254DCDF94AB8
                    F66346B6B7617A8A17B7218137FC09C80EC0821D083F6FE41FCE2B3B3CACC802
                    6866684873C3838A2E7FB48E65213B946D0FA5B765FBBBD3D1B77EA46D27D391
                    86FEEAC40E3E5338007845F8F9B4307550A10AB76D5879AB67FA974BFB9F5594
                    5FB0D3685673CB916E4CCDE99A855E5F7D6DE4DEA226E6120D8EDF5767EF98FA
                    AE59E01CFED86A34D4A5AB639F6CAF475DB2BA78E5866DDFD2C0D53BFA687052
                    3DFDD3EABD76575D16C07B7B47B4F8303C6B856E78FE045168C1C28BB37B883D
                    BFDA86BD8848FB7EDBDDC7EE47E9ACB378169FF920DCFD3CA3E43DB8E674F5AE
                    F4B5BFD9A62F59D8FDF3EFECD29FF940B57F3DA62F7FF35D1D3D3D143E2F24E5
                    90C0FCF2D1F2DB5E663DFEB557B67D309B59585ED6A98E4E7DD0D2A123A72FE9
                    78EBA0EA5B065477B24BC363E3F6112BF7097FF1BCCA3CBEB183D66CEF4313F5
                    D4B4727D83525F7F183CE6DD19D47F59F97528FFBE4FADDE01CD4E4E289F4D87
                    AF2D59FA5D8CB3F63BF279F05679D401E025783CE416B65F099FEC46644FC191
                    3D6DD939D49EE4EECE663532E7B3346435B1280DDF9AD7055FCC61E8A67CC9DE
                    EEA17B1B5797AD2CE85EB83EAE8F46A63470FDB67A86C675E9DAA4CE5E19D7D8
                    F86D4561744FE178DB4FB5F2E759BC381FC1EF47D5177CCAE567FD8EED4738DC
                    6FF06C71DE5B4BED90F97CB77EFC2C4C3EB088B2F9979DFABDBFFF3F7DE3FBFB
                    F427DF3BA03FF8E74A7DB3F4A4EEA77F9E087973232BF6D7C4DE88687B33383A
                    A143CD5D7ABFA3570D5D57D478A65FADDD9735BBE4F9CB3EC25F5CDAFFD54E86
                    B2612DBCE95AE3161EE71F287BED8AE2BE3EE5FAFB140FF80A6897150DAC570D
                    2ADBFFB41AD0F2150BDE3377EC60475AB67DF54ED63E2AD75F79E2C53DFA24FD
                    6801783E85C74E21ECA6E7D695E0EBEFDFC0B2536538CFE7ECFC99E4D349E73D
                    2B2E2C266166065F8C62E2614E7D37EEA96B705C3D23B775E1EAB4BA87EF6C68
                    9D1FBEA5AE6B137679531F59D0EDBD3AA90BFDA3BA7465520FE72D2CF80F676F
                    7C2A326FDD658686D54BFF1C6F47D5FB44FB4C011E6EFCF812783F5792F8F2BA
                    7619EE9A8905E074AEDAE1EBF3FACBEF57EBF7BFBD4B5FFA41BDBEFE8FBFB417
                    95DEE5C1674BC83C1140D7BBFC379B0D39D05B7923B57F7459D52D675573AE4F
                    475B2FEADACDBB7E37B0F7FB5BBB2F247E5EB3CD55D890C05B38192BCA289EB6
                    93C840AF055D9F25C102EF60BF323E90EC4A9FB2EB5143BD4FADCC509F74E9A2
                    F2A3235266C94F6F7637497F39A17B83FD12A817A9F409F96905E0F9141E3B8F
                    06DFC2757F446D648573A5EF873FE6ADFCAC1FDE676FA6E6628DDE59D495C919
                    5DBCE673DBDE54CF351F2C76D3AE8F5B4D6C508DEB82ED43F7B57BB67D37F4E9
                    EDB7ED4B0337353EB918F6DDA5E731EFCAE0FD11576EC40B8BBD85D7436EBC60
                    75CF2A1B8E3581F7F3E5E3B43B88CFDAE58FB228B1C09BF3FEAED23BF583FAF2
                    B7F6EB77FE6E8FFEE39DE3F6D1DE9520E39F641FE3077CE32AF68176BE3F9177
                    57487463E2A60EB5B4E8607B973A2F0E6821F2F3869D35EC67F3C79BF7015E65
                    DEDDE0416B330F2C585E53E6628FF2BDFD52AF055E9F0BB77740715FB7D5C535
                    AFA4BFC782F6A5A794ED537F9F967C69E3DBB7EC7E62BF24FB1F1E7FB19FC4FD
                    44473D7FF941F43B70FA04FD6801783EFE24109E081E791C15AE6F346FE14DEC
                    C92A94A5991079C33EE6346BCFC71377E675696854170646D4337443172E8FDA
                    A505DECB3ECFED06962F1BDC3FA5EE8149BB3EA5F3FD3734FCF15D2D2EDA0F62
                    FC67F00535569E0CEC7AB819ABE02D93D28285A04165F39D167226ECBA1F6F0E
                    EEE709ADE27627CC8480E8C7CCEE97B1CFC11069ECDEA2FEEA0755FAEA3FFDAF
                    AE3DF4F7F9E0367B31E19F18DE6E54151E43BE9DFE85248E62F55C1E52F587C7
                    74EBBE2F0066FC24E2E79195B06B3F617AFB0BDA90C01B4591A238D6F2EC8C16
                    6E8E2BB24A26C7144D8C2A3B79530B9353CA8C8F6B7962ED6BE9C68DCFAEA931
                    CD8E8F69EEF66DE532DE31DC5F3DC5A14B43FACA9E7AFE4A032F80D549C3E3A7
                    E52D8D7E6ECD64325A5A5ADAF85A5EB6B27D59CE6AD96B2963974B560BF6FE58
                    33B30B9A9CBEA79B5EB7EE6B6CFABE266ECD697C7A636B72FA81A627EE6BCAF6
                    E9A63DF18EDDBAA5D9F9B910DAC3B8933068390DBC7E4E2394AD9EDD7DED8D1D
                    CFC4B240D26FC966261CD6703B9EC943609264ADBC2FAF85593F17F8B10B2F22
                    A4BAE601FDE2608F1ED8D5253B37CCDAE372C6F2CCDC8657A4FB765E7860E72C
                    BF9CB7C03E72E3BEBA7B6F869F2AF00BDB6F3FBF255EAB7CAC6D5C9706DB6FFF
                    45A5331E14527E9AF8EDD76597AF824F4F66FE3649F28AED8497B654F8898F7A
                    9102B07A7E1EF5691DBDF5E3D16E0D5EAF86F43C1FF6C62F7D233CFE57CE018F
                    ED667877BAF9CAB0A36ACF02695F529F6D223D7FF95E7A98F000EC97AFDA5EBF
                    7E423B8857E8C7B05C38BCE9DD05CF14EEA316747D919730C7AD1D34EF231B87
                    7341CE82645687DB7BB5F7688F761FEED4BE63EDDA7BA253BB8F9FB5EA7AACCE
                    6AD7B14EABAE35AE4EED397156BF3ED2AE3DCD17F41BBB7CEF48A7EA8F77EB4E
                    984ED81E5B7E5F28DC2F4C9ABD566763BB34000000E0E5B2D0EBC1D75D1EBFAD
                    4D7B8EE8C707DA5452D962D5A4CD4FAD666DDA7F4A9B6C7B4D6B7F93DE3A7052
                    9B0FB6E88DFDAD76BD595B767FA8639D83857CBB2608BC00000045C6FBF44659
                    5F5E42AA6ABAA01FEF3EAE929A2E6DAD6B57C5C1334F565D9BB6D9E57A5479D5
                    29551CEA504975BBB6549FD1FF34766A7A6E49850529D60281170000A0C88431
                    33795FC8230EF3EFBE6D21F3AD9AB3DA5267A1B7F6B4CA1F2F0BA26535AD2AB3
                    ED352DFB1E6FD779E83DADAD07BB545AD9A4CE91DBA153AB125F3C636D107801
                    00008A88F7E50F7344FB80B66C1A224F0F8CEACD7D4D2AAD6DB7A079E6A9B5CD
                    5B79D7A12A0E5A59F82DD97D54FB9B2EEA7E944BA72ACB3D0CFBBA1608BC0000
                    0045256FFF13C5619AC25C68E5BDB310E957473AB5A5AAF9A9DD0C4259087DEA
                    ED2FB54EABB4E68C2AEADBB5B3F2B086A7EE850169B9B0AF6BD78B97C00B0000
                    505472CAE762657C7629BB96F72588EDF2DC95516DAB6E5259CD696DAD6D7DA4
                    FCFA5AD619AB4FBF5FE9A1B3FAE1DE63AA6F3D9BCE731247CA453EE38C5F591B
                    045E000080A2E231F291A901C3765ED9CC92F69DE8B2C0DB6CC1B74DE5D51DDA
                    5AD3A1F2BA33DA5473EA29ADB12F5A1E72DBC200B96D75CDDA5A7D4A3B0F9ED5
                    8E9A73F67DDB556E01B864EF61DD5C8CC3D46A49E42BC0F974640C5A030000C0
                    6FA9B0D47861F9EB3047773EA7E13BF32ADF77583F6B38A72DB51E76BB2CA0B6
                    697B83B7C23E2DBCBE48F920381F0C67A1BAF6A47DDD53AAA8B5A05D6901F860
                    874AF77CA8537D63611AB27865709D2F9CE1C17CAD10780100008A4C61219AC2
                    C23405DE86DAD8DEA74D7B3E50797D9B4A2CEC6EA96ED1DBDEDDC0C2EACB29EF
                    0BDCA6AD351E784F695B7DABB6D478CB6EA736579FD26F1A9B3493F5455DA428
                    F6D6DD282CA4E32BC5AD15022F000040917A34F41682EF6C36A76DFB1A545A73
                    526587DAC274613BAB5BC3D4642FA7D2C05B5163DBDEA5A1AEC52E3B428B6F69
                    D511F58C8CDA5EF83E79EBAE2FD31D85D5D5D6B00B2F81170000A0D83C1A700B
                    A137EDDE90DED6D437A24DBB0E59184D674CD8E17D6EBDEFAD05D6D59705DE5A
                    0BBBD51E7E5BB4B9BA493B1BCEA964CF5155B69CD7C36C647937B6FDF2F6E642
                    18F7958469E1050000C06FC9C36D927C3ACD5721547AA78638C96826CEE937EF
                    B7A97CDF71F9C21365167C3DA43E6D6A329F69E1F1DB3EAFB6D6D8D7B4C05B76
                    D05B8E5BB5F5C019FDC26E1B9ABC17F647B934DC7A06F72D5F2823C7A0350000
                    003C8F420BAF2B746B4892457B474619BBAD77ECBEB6579E50594D8BB634B487
                    901AC26A984AECD32ADCF668A0FDBCF2965E9F8DC1C3EEF6F73BF5C6BB1FE870
                    C7B0966C9742D6B58A2DDFFA666237E4BD43432EACB7B62608BC0000005F14C9
                    CA20310B990FA244352D1755B6F74808A965D52DE1B2DC97185ED97EF1C09B2E
                    57BCADAE5D65552DFACF9A139A9AF398ED3E0DE2EB85C00B0000F005E16DA949
                    1CD9465EDE9EDA3F7E573BAB4F58A07D2CB05AE8DDD9D0A9EDF5ED21003FFABE
                    DFA67CE05A496DBA8C70E9DEA33ADE732D0C4ACBF992C7045E000000AC95D8B2
                    66264A6747F02587176DF3FDAE41BDB5E768E886B0ADAE4D3B2CE856D8656955
                    73B86DFB219F61E17906B4F91CBC67545AD7A537DF3BAE5FD4B7E87EC682B6EF
                    80CFB7BB864B087F16022F0000C017C4722E0DBDA16B43BC18FACE4E2DC4FAAF
                    DA93DA7CA03904DB92034D21E47AF8F5397AFDD26F7F72FAB1A757DA9DC102B3
                    B7F0569D50F7C854F8DEA14F71E241DBDB7AD71781170000E00BC2A3A6E7DD9C
                    2FE79BCB86D911DCF9C16BFAD1EE63A10B83F7D7F516DE1D167ABD6BC3F3F6DF
                    2DD4E6BDC754DBDAADF9287C4725D965453E526D031078010000BE20F21E70E3
                    5CE84B9B58E5565A5BE32852C507175572A0591516567758F02D3DD0F449787D
                    56E8F5F715AA70BDCCFB001F6C52DFF89DF0F5BD35D9437626C9CBFEAF3B022F
                    0000C01784AF68E6F3828536D795A9CA0AD397758FDD55C9EE4695D6B6ABFC60
                    87B65B78ADA83E1D564C0B8B493C12720B555ED5145A827D65B5ED751DDA72A0
                    453B1BCEAA6CDF711DEBB8A005FF76DE7122C95A45B66DFF56BEDF7A22F00200
                    0040F3CB59ED3D75416FEE6F5649D519FDB4DE42AC87DD9A360BB44F065E6FC9
                    DD5E67A1D7A731AB391D3EAEC242EF760BCB6F579DD4E49D3BA10B85CF069106
                    6C5F5D2DB25AFF6E0D045E00000004D7EF3ED0CEEA16951E38A5ED87DA545E77
                    3AAC96E6ABB03D311B83DD56517F260C72DBD6D0691FD7A6ADD516967737EAF4
                    D0CDF0F5B2967813AF7C4EF910787D45358FC1EB8BC00B000000591AD5522C9D
                    387F45E5EF1D518585DDD2BA566DB14B0FB74FCCC8E0B7D5B5A8CCA730B3E05B
                    D1D0A14D7B1AF56E63B31EE43DE4E615AD749F88E334EC7AA5EDBDEB8BC00B00
                    0000E54277834493F7E6F5CB9A666DA93CA92D1664B758E8F5C0FB440B6F08BD
                    CDDADED0A9121FA856DDACF2BD8DBA707D7C25E466C3A0B8B42B43DA57D807CA
                    1178010000B021622D5BEACD84607AE6A3519559E02DF739780FB6842E0D9FF4
                    DFF5D91856666428AB3AA9EDF56DAAA8B7D0BBEFB8F69D3CAB85D8BB2CACB4E6
                    862E0C1E72D30172858172EB8DC00B000000653DF0E6172C9BC69AB7ACBAD342
                    6E495553E8DA10FAF0AEB4F2A6C1379D86EC671676CB0E34E9ADFD4DA1FFEEE0
                    F47CFAC562FB3AF948499CAEACE603D5D26E0D69E85D6F045E0000005848CD86
                    60EA83CBDCD5D1077A6BD7516DA9B5505B734A5B6B9AB4CD6A479D07DF76BBBD
                    4BE555C7F576E3796DDA7B4A272F8E845919B2F1A2927421E157068117000000
                    1676734A4297069F48CCA729932A5B2E69D3FEA361B6861D0D1DA155B7A4B249
                    65552DAAA8EB0CB3339454B6E8E7F6FED13B0BFE55AC2265C3E0B45707811700
                    0000E99CB9DEE756565136DCD67F635A3FAD3BA94D55A72DF4B6ABBCB64365DE
                    A5C1B6B75637A9B4FE827EB2E7A8DA86C6ED732DEC264BFE556C7BFDBB2D3C0B
                    81170000003ECCCCA26ADE02AFFDCB2EDB2D792DE5627D70BE4F6FBC77CCC26E
                    9B2A0E9D0F5D1CC2CA6AB5CDFAC9BED37AA7B15DF77C3E335F5022B7AC24C92A
                    F2C9775F21045E000000289724CA86D06B61D55B6BA3748DB4EBF766F4EB0F3B
                    545E7942E507DB5556DBA16DF5EDDA5ED7AA377FD5A881F199F0F9F9F0D9F635
                    A2581B302EED9908BC0000000883D67CDEDC28E7B32A58E0CD268AE248197B57
                    E7C0C7DAB9FF4395D7B6686BBD07DE36FD64FF711D3876D642AEC967EDF3622D
                    FBA7F998375A78010000F0CA49D255D072BE3A9AE7550BAF8529C46ECDCEA9F2
                    589B4A2B4FA9A4EE9C361D685279E5118D4DAFB4EE5AD88DADBC4D38F1CF8BD3
                    991E5E15045E0000003C4368C3D5C0E8B4DEDA754C25F51743F06DECEC09B7BF
                    0E08BC000000F86C3E2F6F3E276FB3DD7DFCBCDED875543F3FD4AAD17B69EBEE
                    EB80C00B000080CFE6813797CECD3B72FBA12ADEAB5773CF50E8BEF0BA20F002
                    0000E019BC5FAFC5DB7C1442EEB9A18F35393BA79C4F62E683DB5E03045E0000
                    007C261FB696846E0D915D465AB41B96731682C38A6C045E000000BCE67CEE86
                    D8676B489695CF67422BEF722EB1F09B2E4EF13A20F0020000E03379A40D3D17
                    D2372BD7EDF235E9CEE008BC000000286A045E0000001435022F0000008A1A81
                    17000000458DC00B000080A246E0050000405123F0020000A0A8117801000050
                    D408BC000000286A045E0000001435022F0000008A1A8117000000458DC00B00
                    0080A246E0050000405123F0020000A0A8117801000050D408BC000000286A04
                    5E0000001435022F0000008A1A8117000000458DC00B000080A246E005000040
                    5123F0020000A0A8117801000050D408BC000000286A045E0000001435022F00
                    00008A1A8117000000458DC00B000080A246E0050000405123F0020000A0A811
                    7801000050D408BC000000286A045E0000001435022F0000008A1A8117000000
                    458DC00B000080A246E0050000405123F0020000A0A8117801000050D408BC00
                    0000286A045E0000001435022F0000008A1A8117000000458DC00B000080A246
                    E0050000401193FE1F074A30F5F85750860000000049454E44AE426082}
                  Stretch = True
                  Transparent = True
                  ExplicitLeft = 258
                end
                object cxLabelMensagem: TcxLabel
                  Left = 2
                  Top = 2
                  Align = alClient
                  Caption = 'Atualizar Participante...'
                  ParentColor = False
                  ParentFont = False
                  Style.BorderStyle = ebsNone
                  Style.Color = clWindow
                  Style.Font.Charset = DEFAULT_CHARSET
                  Style.Font.Color = clWindowText
                  Style.Font.Height = -21
                  Style.Font.Name = 'Tahoma'
                  Style.Font.Style = []
                  Style.Shadow = False
                  Style.IsFontAssigned = True
                  Properties.Alignment.Vert = taVCenter
                  Properties.LabelStyle = cxlsRaised
                  Properties.WordWrap = True
                  Transparent = True
                  Width = 346
                  AnchorY = 88
                end
              end
              object pnlShowLog: TPanel
                Left = 0
                Top = 0
                Width = 1145
                Height = 543
                Align = alClient
                TabOrder = 2
                Visible = False
                object cxGrid3: TcxGrid
                  Left = 1
                  Top = 42
                  Width = 1143
                  Height = 459
                  Align = alClient
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'Arial'
                  Font.Style = [fsBold]
                  ParentFont = False
                  TabOrder = 0
                  object cxGrid3DBTableView1: TcxGridDBTableView
                    Navigator.Buttons.CustomButtons = <>
                    DataController.DataSource = dsErroImport
                    DataController.Summary.DefaultGroupSummaryItems = <>
                    DataController.Summary.FooterSummaryItems = <>
                    DataController.Summary.SummaryGroups = <>
                    OptionsData.CancelOnExit = False
                    OptionsData.Deleting = False
                    OptionsData.DeletingConfirmation = False
                    OptionsData.Editing = False
                    OptionsData.Inserting = False
                    OptionsView.GroupByBox = False
                    OptionsView.Indicator = True
                    object cxGrid3DBTableView1TRE_ERRO_IMPORTACAO_ID: TcxGridDBColumn
                      Caption = 'ID'
                      DataBinding.FieldName = 'TRE_ERRO_IMPORTACAO_ID'
                      Width = 36
                    end
                    object cxGrid3DBTableView1TRE_TREINAMENTO_ID: TcxGridDBColumn
                      Caption = 'Treinamento ID'
                      DataBinding.FieldName = 'TRE_TREINAMENTO_ID'
                      Width = 94
                    end
                    object cxGrid3DBTableView1CAMPO: TcxGridDBColumn
                      Caption = 'Campo da Planilha'
                      DataBinding.FieldName = 'CAMPO'
                      Width = 114
                    end
                    object cxGrid3DBTableView1MOTIVO: TcxGridDBColumn
                      Caption = 'Motivo do Erro'
                      DataBinding.FieldName = 'MOTIVO'
                      Width = 520
                    end
                    object cxGrid3DBTableView1DATA_IMPORTACAO: TcxGridDBColumn
                      Caption = 'Data da Importa'#231#227'o'
                      DataBinding.FieldName = 'DATA_IMPORTACAO'
                      Width = 123
                    end
                  end
                  object cxGrid3Level1: TcxGridLevel
                    GridView = cxGrid3DBTableView1
                  end
                end
                object Panel19: TPanel
                  Left = 1
                  Top = 501
                  Width = 1143
                  Height = 41
                  Align = alBottom
                  Color = clInfoBk
                  ParentBackground = False
                  TabOrder = 1
                  object BitBtn1: TBitBtn
                    Left = 3
                    Top = 6
                    Width = 179
                    Height = 25
                    Caption = 'Apagar log deste treinamento'
                    Font.Charset = ANSI_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'Arial'
                    Font.Style = [fsBold]
                    ParentFont = False
                    TabOrder = 0
                    OnClick = BitBtn1Click
                  end
                  object BitBtn2: TBitBtn
                    Left = 183
                    Top = 6
                    Width = 225
                    Height = 25
                    Caption = 'Apagar logs de todos os treinamentos'
                    Font.Charset = ANSI_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'Arial'
                    Font.Style = [fsBold]
                    ParentFont = False
                    TabOrder = 1
                    OnClick = BitBtn2Click
                  end
                  object Fechar: TBitBtn
                    Left = 840
                    Top = 6
                    Width = 75
                    Height = 25
                    Caption = 'Fechar'
                    TabOrder = 2
                    OnClick = FecharClick
                  end
                end
                object Panel18: TPanel
                  Left = 1
                  Top = 1
                  Width = 1143
                  Height = 41
                  Align = alTop
                  Caption = 'Log de Eventos'
                  Color = 4194304
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clWhite
                  Font.Height = -11
                  Font.Name = 'Arial'
                  Font.Style = [fsBold]
                  ParentBackground = False
                  ParentFont = False
                  TabOrder = 2
                end
              end
            end
            object tsbEdicao: TcxTabSheet
              Caption = 'Edi'#231#227'o'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ImageIndex = 1
              ParentFont = False
              TabVisible = False
              object Panel13: TPanel
                Tag = -1
                Left = 2
                Top = 3
                Width = 907
                Height = 27
                Alignment = taLeftJustify
                BevelInner = bvLowered
                Caption = '  Nome do Participante'
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 0
                object EditBuscaParticipante: TEditBusca
                  Left = 143
                  Top = 3
                  Width = 708
                  Height = 22
                  TabOrder = 0
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
                object cxButton5: TcxButton
                  Left = 876
                  Top = 2
                  Width = 26
                  Height = 23
                  Hint = 'Limpar campo Treinamento'
                  OptionsImage.Glyph.Data = {
                    F6000000424DF600000000000000760000002800000010000000100000000100
                    0400000000008000000000000000000000001000000000000000000000000000
                    80000080000000808000800000008000800080800000C0C0C000808080000000
                    FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
                    7777777777777777777777000000077777777077777700777777707777770307
                    77777077777703307777770FBFBFB03307777770FBFBFB03307777770FBFBFB0
                    3307777770FBFBFB03077777770FBFBFB00777777770FBFBFB07777777770000
                    0077777777777777777777777777777777777777777777777777}
                  ParentShowHint = False
                  ShowHint = True
                  TabOrder = 1
                  OnClick = cxButton5Click
                end
              end
              object Panel15: TPanel
                Tag = -1
                Left = 2
                Top = 34
                Width = 907
                Height = 122
                Alignment = taLeftJustify
                BevelInner = bvLowered
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 1
                object cxGroupBox1: TcxGroupBox
                  Left = 24
                  Top = 10
                  Caption = ' Avalia'#231#227'o'
                  TabOrder = 0
                  Height = 105
                  Width = 297
                  object Panel16: TPanel
                    Tag = -1
                    Left = 16
                    Top = 24
                    Width = 263
                    Height = 65
                    Alignment = taLeftJustify
                    BevelInner = bvLowered
                    Font.Charset = ANSI_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'Arial'
                    Font.Style = [fsBold]
                    ParentFont = False
                    TabOrder = 0
                    object Label1: TLabel
                      Left = 42
                      Top = 24
                      Width = 42
                      Height = 18
                      Caption = 'Score'
                      Font.Charset = ANSI_CHARSET
                      Font.Color = clWindowText
                      Font.Height = -16
                      Font.Name = 'Arial'
                      Font.Style = []
                      ParentFont = False
                    end
                    object ediScore: TrsSuperEdit
                      Left = 101
                      Top = 22
                      Width = 121
                      Height = 22
                      Alignment = taRightJustify
                      Format = foReal
                      CT_NumFields = 0
                      CT_RetField1 = 0
                      CT_RetField2 = 0
                      CT_Test = False
                      CT_ConsTab = False
                      CT_Search = False
                      CustomMask = '0,00'
                      Text = ''
                      Font.Charset = ANSI_CHARSET
                      Font.Color = clBlack
                      Font.Height = -11
                      Font.Name = 'Arial'
                      Font.Style = [fsBold]
                      ParentFont = False
                      TabOrder = 0
                      OnExit = ediScoreExit
                    end
                    object spbLimpaScore: TcxButton
                      Left = 228
                      Top = 22
                      Width = 26
                      Height = 23
                      Hint = 'Limpar campo Score'
                      OptionsImage.Glyph.Data = {
                        F6000000424DF600000000000000760000002800000010000000100000000100
                        0400000000008000000000000000000000001000000000000000000000000000
                        80000080000000808000800000008000800080800000C0C0C000808080000000
                        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
                        7777777777777777777777000000077777777077777700777777707777770307
                        77777077777703307777770FBFBFB03307777770FBFBFB03307777770FBFBFB0
                        3307777770FBFBFB03077777770FBFBFB00777777770FBFBFB07777777770000
                        0077777777777777777777777777777777777777777777777777}
                      ParentShowHint = False
                      ShowHint = True
                      TabOrder = 1
                      OnClick = spbLimpaScoreClick
                    end
                  end
                end
                object pnlAprovado: TPanel
                  Left = 368
                  Top = 36
                  Width = 185
                  Height = 41
                  Caption = 'APROVADO'
                  Color = 4227072
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clWhite
                  Font.Height = -19
                  Font.Name = 'Arial'
                  Font.Style = [fsBold]
                  ParentBackground = False
                  ParentFont = False
                  TabOrder = 1
                  Visible = False
                end
                object pnlReprovado: TPanel
                  Left = 368
                  Top = 36
                  Width = 185
                  Height = 41
                  Caption = 'REPROVADO'
                  Color = clRed
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clWhite
                  Font.Height = -19
                  Font.Name = 'Arial'
                  Font.Style = [fsBold]
                  ParentBackground = False
                  ParentFont = False
                  TabOrder = 2
                  Visible = False
                end
              end
            end
          end
        end
      end
      object TabAnexar: TcxTabSheet
        Caption = 'Anexar Documentos'
        ImageIndex = 2
        object Panel12: TPanel
          Tag = -1
          Left = 0
          Top = 27
          Width = 1239
          Height = 549
          Align = alClient
          BevelInner = bvLowered
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -10
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          object cxGrid2: TcxGrid
            Left = 2
            Top = 2
            Width = 1235
            Height = 545
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -10
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            object cxGridDBTableView1: TcxGridDBTableView
              Navigator.Buttons.CustomButtons = <>
              DataController.DataSource = dsArquivo
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Inserting = False
              OptionsView.GroupByBox = False
              object cxGrid1DBTableView1CAMINHO: TcxGridDBColumn
                Caption = 'Caminho'
                DataBinding.FieldName = 'CAMINHO'
                Width = 310
              end
              object cxGrid1DBTableView1NOMEARQUIVO: TcxGridDBColumn
                Caption = 'Nome do Arquivo'
                DataBinding.FieldName = 'NOMEARQUIVO'
                Width = 300
              end
              object cxGrid1DBTableView1DATACADASTRO: TcxGridDBColumn
                Caption = 'Data de Cadastro'
                DataBinding.FieldName = 'DATACADASTRO'
                Width = 114
              end
              object cxGrid1DBTableView1Column1: TcxGridDBColumn
                Caption = 'Visualizar'
                PropertiesClassName = 'TcxButtonEditProperties'
                Properties.Buttons = <
                  item
                    Caption = '...'
                    Default = True
                    Hint = 'Clique p/ Visualizar'
                    Kind = bkText
                    Width = 80
                  end>
                Properties.OnButtonClick = cxGrid1DBTableView1Column1PropertiesButtonClick
                Width = 80
              end
            end
            object cxGridLevel1: TcxGridLevel
              GridView = cxGridDBTableView1
            end
          end
        end
        object Panel17: TPanel
          Tag = -1
          Left = 0
          Top = 0
          Width = 1239
          Height = 27
          Align = alTop
          Alignment = taLeftJustify
          BevelInner = bvLowered
          Caption = ' Anexar Arquivo'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object cxbEditPath: TcxButtonEdit
            Left = 116
            Top = 3
            Properties.Buttons = <
              item
                Default = True
                Kind = bkEllipsis
              end>
            Properties.ReadOnly = True
            TabOrder = 0
            OnClick = cxbEditPathClick
            Width = 426
          end
          object btnSalvaArq: TcxButton
            Left = 548
            Top = 5
            Width = 26
            Height = 23
            Hint = ' Salvar Arquivo'
            OptionsImage.ImageIndex = 1
            OptionsImage.Images = ImageList1
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            OnClick = btnSalvaArqClick
          end
        end
      end
    end
  end
  inherited TimerPerfil: TTimer
    Left = 706
    Top = 490
  end
  object dtsTipoTreinamento: TDataSource
    DataSet = sqlTipoTreinamento
    Left = 916
    Top = 484
  end
  object dsPeriodo: TDataSource
    DataSet = sqlPeriodo
    Left = 828
    Top = 483
  end
  object dsParticipante: TDataSource
    DataSet = sqlParticipante
    Left = 988
    Top = 463
  end
  object qryAux: TFDQuery
    Connection = DB_Conect.SQLConnection
    Left = 782
    Top = 292
  end
  object sqlPeriodo: TFDQuery
    Connection = DB_Conect.SQLConnection
    SQL.Strings = (
      'Select * From TRE_PERIODICIDADE')
    Left = 830
    Top = 284
  end
  object sqlTipoTreinamento: TFDQuery
    Connection = DB_Conect.SQLConnection
    SQL.Strings = (
      'Select * From TRE_TIPOTREINAMENTO')
    Left = 910
    Top = 284
    ParamData = <
      item
        Position = 1
        Name = 'TRE_TREINAMENTO_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object sqlParticipante: TFDQuery
    Connection = DB_Conect.SQLConnection
    SQL.Strings = (
      ''
      'Select '
      'P.TRE_PARTICIPANTES_ID,'
      'P.TRE_TREINAMENTO_ID,'
      'P.FUN_MATRICULA,'
      'C.DESCRICAO AS FUN_CARGO,'
      'FN.FUN_NOME,'
      'F.ALIASEMPRESA,'
      'P.PAR_SCORE,'
      'P.PAR_APROVADO,'
      'F.CODFILIAL'
      ' '
      'from TRE_PARTICIPANTES P'
      
        'left outer join TRE_FUNCIONARIO fn on fn.FUN_MATRICULA = p.FUN_M' +
        'ATRICULA'
      'left outer join TRE_CARGo C on C.TRE_CARGO_ID = P.TRE_CARGO_ID'
      'left outer join Filial f on f.CodFilial = fn.CODFILIAL'
      'where P.TRE_TREINAMENTO_ID = :TRE_TREINAMENTO_ID'
      'order by P.TRE_PARTICIPANTES_ID')
    Left = 990
    Top = 284
    ParamData = <
      item
        Position = 1
        Name = 'TRE_TREINAMENTO_ID'
        DataType = ftInteger
        ADDataType = dtInt32
        ParamType = ptInput
      end>
    object sqlParticipanteTRE_PARTICIPANTES_ID: TFDAutoIncField
      FieldName = 'TRE_PARTICIPANTES_ID'
      Origin = 'TRE_PARTICIPANTES_ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object sqlParticipanteTRE_TREINAMENTO_ID: TIntegerField
      FieldName = 'TRE_TREINAMENTO_ID'
      Origin = 'TRE_TREINAMENTO_ID'
    end
    object sqlParticipanteFUN_MATRICULA: TStringField
      DisplayWidth = 10
      FieldName = 'FUN_MATRICULA'
      Origin = 'FUN_MATRICULA'
      Size = 10
    end
    object sqlParticipanteFUN_CARGO: TStringField
      FieldName = 'FUN_CARGO'
      Origin = 'FUN_CARGO'
      Size = 100
    end
    object sqlParticipanteFUN_NOME: TStringField
      FieldName = 'FUN_NOME'
      Origin = 'FUN_NOME'
      Size = 100
    end
    object sqlParticipanteALIASEMPRESA: TStringField
      FieldName = 'ALIASEMPRESA'
      Origin = 'ALIASEMPRESA'
      Size = 50
    end
    object sqlParticipantePAR_SCORE: TBCDField
      FieldName = 'PAR_SCORE'
      Origin = 'PAR_SCORE'
      Precision = 18
      Size = 2
    end
    object sqlParticipantePAR_APROVADO: TStringField
      FieldName = 'PAR_APROVADO'
      Origin = 'PAR_APROVADO'
      Size = 3
    end
    object sqlParticipanteCODFILIAL: TStringField
      FieldName = 'CODFILIAL'
      Origin = 'CODFILIAL'
      Size = 15
    end
  end
  object SaveDialog: TSaveDialog
    DefaultExt = '*.*'
    Filter = 'Todos os Arquivos|*.*'
    Left = 980
    Top = 351
  end
  object OpenDialog: TOpenDialog
    DefaultExt = '*.*'
    Filter = 'Todos os Arquivos|*.*'
    Left = 836
    Top = 383
  end
  object ImageList1: TImageList
    Left = 514
    Top = 176
    Bitmap = {
      494C0101260027005C0310001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      000000000000360000002800000040000000A0000000010020000000000000A0
      000000000000000000000000000000000000000000000000000096675E009F6F
      60009F6F60009F6F60009F6F60009F6F60009F6F60009F6F60009F6F60009F6F
      60009F6F60009F6F60009F6F6000000000000000000000000000000000000000
      00000000000004490600055B0900066C0C00066C0C00055E0A00044C06000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000099695F00F6E0
      BF00F4DDB800F3DAB400F3D7AD00F2D5A700F0D3A300F0D09E00EECC9900EECA
      9300EDC99000EDC68C009F6F6000000000000000000000000000000000000560
      0900056009000891130009B0180009B31A0009B3190009B11900079614000568
      0C0005680C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009D6C6000F6E3
      C600F6E1C100F4DDBB00F3DCB40000810000F2D5AA00F0D3A400F0CF9F00EFCC
      9900EFCB9500EEC990009F6F60000000000000000000000000000A6A15000A7F
      15000BB61C0009B91A0008B4180007B2160009B3190009B4190009B81A0009B9
      1A0007831000044D060000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A16E6000F7E6
      CE00F6E5C700F4E1C100008100000081000000810000F3D5AB00F0D3A500EFD1
      9F00EFCE9A00EFCB96009F6F600000000000000000000B6A15000F85220016BD
      340011B727000BB21C0007B1160008B1170009B2190009B2190009B2190009B4
      190009BA1A000784100006670C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A6726200F8EA
      D400F7E7CE0000810000307A2A005F924B000081000050883C00F2D5AB00F0D3
      A500F0D0A000EFCF9C009F6F600000000000000000000B6A150020BE49001BBD
      400014B730000AB21F0063CE6D00EEFAEF00DFF5E10028BC360009B2190009B2
      190009B3190009BA1A0006670C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000AB766300FAEE
      DA00FAEBD50000810000EFE2C200F6E2C200A7B883000081000000810000EDD4
      A900F0D4A600F0D1A1009F6F600000000000087210001B9A3A002AC65B001DBB
      45000EB425005BCC6600F7FDF800FFFFFF009ADFA00011B4200009B2190009B2
      190009B2190009B81A0008941300045D09000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B0786400FAF0
      E200FAEEDC00F8EBD500F8E9D000F7E6CA00F6E3C500E6D8B400008100000081
      0000F2D7AD00F2D4A7009F6F600000000000087210002AB65B002CC5650022BD
      4D005CCC6900F6FCF700FDFEFD008EDB950009B21A0009B2190009B2190009B2
      190009B2190009B51A0008AB1700045D09000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B57D6400FCF3
      E700FBF0E300FAEFDD00FAEDD800F7E9D100F8E6CB00F6E3C500F6E1C000F4DE
      BA00F4DAB500F3D7AD009F6F6000000000000F821C0037C26C0033C76C008ADD
      A800F4FCF600FFFFFF00F9FDFA00C7EED200C4EDCC00BFEBC300BFEBC300C0EB
      C400C2ECC60008B4190009B3190005650B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BB806500FCF7
      ED00D5812700D5812700D5812700D5812700D5812700D5812700D5812700D581
      2700D5812700F3DAB6009F6F600000000000138D230058CC830042C97700C9EF
      D800FFFFFF00FFFFFF00FDFFFE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000AB41A0009B31900066D0D000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C0836600FCF8
      F300FCF7EF00FCF4EA00FBF2E500FBEFDE00F8EDD900F8EBD400F8E7CE00F7E3
      C700F6E1C200F4DEBB009F6F6000000000000F911D006FD293005FD38D0044C9
      7700B7EACB00FFFFFF00FBFEFC009AE2B40058CD79005CCE76005CCD76005CCD
      73005BCD720011B82B0008B1190005610A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C4876700FEFB
      F800FEFAF300FEF7EF00FCF4EA00FBF2E600FAEFE000F8EDDA00F8EAD400F7E9
      CF00F7E5C900F6E2C4009F6F6000000000000F911D0067CC83009BE5BA0038C6
      700032C36A00AAE6C100FFFFFF00E9F9EF006AD38E0021BD4D001EBC49001EBC
      47001AB93E0010BA290008A3170005610A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C9896700FEFC
      FB00D5812700D5812700D5812700D5812700D5812700D5812700D5812700D581
      2700D5812700F7E5CA009F6F6000000000000000000037B65000BCEDD20082DB
      A40028C0630031C26800A4E4BD00FFFFFF00F7FDF90045C86E0020BB4A001DBA
      410018B7360014C030000A851700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CC8B6800FFFF
      FF00FFFEFC00FEFCFA00FEFBF400FEF8F000FCF6ED00FCF4E700FAF2E200FAEF
      DC00F8EDD700F8EAD1009F6F6000000000000000000037B6500071D28C00D2F4
      E10080DAA30036C46D0031C36A00AAE6C100BDECCF0035C4690024BE560023BC
      4D001FC1460016AE34000A851700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CF8E6800FFFF
      FF00FFFFFF00FFFFFC00FFFCFA00FEFBF600FEF8F000FCF7EE00FBF4E900FBF2
      E300FBEFDD00F8EDD8009F6F600000000000000000000000000025AE390084D8
      9F00DBF7EA00AFE8C6006BD4930052CC810044C9780049CA7B0048CB780039CB
      6A0021B649000F7C1F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CF8E6800CF8E
      6800CF8E6800CF8E6800CF8E6800CF8E6800CF8E6800CF8E6800CF8E6800CF8E
      6800CF8E6800CF8E6800CF8E68000000000000000000000000000000000066CD
      810066CD8100ADE8C500CCF2DE00BAEDD100A6E7C20091E2B30064D492002FB1
      57002FB157000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000032B74E0052C46F0061CB80005DC87D0043B9640024A342000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C6945A00AD4A2900943110008C632900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6948400C6947B00BD8C7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B5848400B584
      8400B5848400B5848400B5848400B5848400B5848400B5848400B5848400B584
      8400B5848400B5848400B584840000000000000000000000000000000000C694
      5A00CE732900C6634200BD634A00C65A3900C65A4200CE634A00AD4A29007352
      42000000000000000000000000000000000000000000000000000000000084BD
      E700316BCE00316BCE003973CE00397BD6003984DE004294E7004294E7003194
      EF0073BDEF00000000000000000000000000000000000000000000000000C694
      8400D6A58400EFBD9400EFD6AD00E7BD8C00DEB58400A5736B00B5847300AD7B
      7300000000000000000000000000000000000000000000000000C6A59C00FFEF
      D600F7E7C600F7DEBD00F7DEB500EFD6AD00F7D6A500EFCE9C00EFCE9400EFCE
      9400EFCE9400F7D69C00B584840000000000000000000000000000000000C663
      2900BD523100A5522900945A3100AD421000AD421800BD523100C66342008C39
      10006B4A3900000000000000000000000000000000000000000000000000B5EF
      FF004294E70073D6FF008CD6FF008CD6FF008CD6FF00A5E7FF00B5EFFF0094DE
      FF0084CEFF00000000000000000000000000000000000000000000000000DEAD
      8400EFBD8400EFC69C00EFD6BD00EFC69C00E7BD8C007B4A420084525200BD8C
      7300B5847300AD736B0000000000000000000000000000000000C6A59C00FFEF
      D600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600EFCE9C00B58484000000000000000000DE9C4A00AD4208009C39
      0000A53900009C42000021631000A5420000A53900009C3100009C310000B54A
      2900BD5A4A00846B63000000000000000000000000000000000000000000B5EF
      FF004A9CEF0073D6FF008CD6FF008CD6FF008CD6FF008CD6FF008CDEFF0094DE
      FF0084CEFF0000000000000000000000000000000000CEA58C00EFC69400F7C6
      8C00EFBD8400EFC6A500F7E7D600EFD6B500EFCEA5007B4A4A007B4A4A00DEAD
      8400E7BD8C00E7BD8C00B5847300000000000000000000000000C6ADA500FFEF
      E700292929005A524A00D6C6BD00F7DEBD00EFD6AD00EFCE9C00EFCE9C00EFCE
      9C00EFCE9400EFCE9C00B58484000000000000000000B55A10009C390000AD42
      0000AD4A0000B54A0000186300008C520000AD4A0000A54200009C3900009C42
      10009C634A007B422900000000000000000000000000000000000000000084CE
      FF004A94E7004294E70052A5EF0063B5F7006BC6F7006BC6F7005AC6FF003163
      CE007BCEF70000000000000000000000000000000000F7CE9C00FFD69C00F7C6
      8C00EFBD8400F7CEAD00FFEFE700F7DEBD00EFD6B5007B4A42007B4A4A00DEAD
      8400E7BD8C00E7BD8C00B5847300000000000000000000000000C6ADA500FFF7
      E7005A524A004242420052636300D6C6BD00F7DEB500EFD6AD00EFCE9C00EFCE
      9C00EFCE9C00EFCE9400B584840000000000DE9C4A00AD4A0000B5520000C663
      0000CE6300004A730000007B000008730000946B0000BD5A0000B55200007352
      080052632900945229007B5239000000000000000000000000000000000084CE
      FF00428CE7004284DE004A94E7005AADEF0063B5F7006BC6F7005AC6FF003163
      CE0073BDEF0000000000000000000000000000000000FFDEA500F7D69C00F7C6
      8C00EFBD8400F7CEAD00FFFFF700FFEFDE00F7E7CE007B4A42007B4A4A00DEAD
      8400E7BD8C00E7BD8C00B5847300000000000000000000000000CEB5AD00FFFF
      F700C6C6C60052737B00427BAD0018526B008C5A5200C6B5B500C6C6C600C6C6
      C600C6C6C600EFCE9C00B584840000000000DE9C4A00B5520000C65A0000D66B
      0000D66B00004A840000008C000094730000CE6B0000C66300008C630000395A
      000031631800845A31007B42210000000000000000000000000000000000B5EF
      FF004AA5F70073D6FF008CD6FF008CD6FF008CD6FF008CD6FF00B5EFFF0094DE
      FF008CDEFF0000000000000000000000000000000000FFDEA500F7D69C00FFC6
      8C00EFBD8400F7CEAD00FFFFF700FFF7E700FFEFDE007B4242007B4A4200DEAD
      8400E7BD8C00E7BD8C00B5847300000000000000000000000000D6B5AD00FFFF
      FF00FFF7EF0052737B0042739400947B7300C67331008C5A5200D6C6BD00EFD6
      AD00EFD6AD00EFD6AD00B584840000000000DE9C4A00CE630000D66B0000948C
      0000529400008C9400008C940000F78C0000EF8400005A7B0000007B0000006B
      000000630000635A1800844A180000000000000000000000000000000000B5EF
      FF004AA5F70073D6FF008CD6FF008CD6FF008CD6FF00A5E7FF00B5EFFF0094DE
      FF008CD6FF0000000000000000000000000000000000FFDE9C00EFD69C00319C
      FF002994FF00529CEF00F7F7EF00FFF7EF00FFF7EF00FFEFD600FFE7CE00EFCE
      A500E7C69400E7B58C00B5847300000000000000000000000000D6BDB500FFFF
      FF00FFF7F700FFF7EF007B737B00F7BD8400F7AD5A00C67339008C5A5200D6C6
      BD00EFD6AD00EFD6AD00B584840000000000DE9C4A00D66B0000DE73000008A5
      180052A518008CA51800F7A51000FF940000F7940000C6840000298400000873
      000042630000426310008452180000000000000000000000000000000000B5EF
      FF0094BDEF008CADE70094BDEF009CC6EF009CCEF700A5DEFF00A5DEFF0094CE
      FF00A5CEF70000000000000000000000000000000000CED6B5005ABDEF0039AD
      FF00319CFF001884FF005AA5F700FFFFEF00FFF7EF00FFEFDE00F7E7CE00EFD6
      B500EFCEA500E7BD8C00B5847300000000000000000000000000D6BDB500FFFF
      FF00C6C6C600C6C6C600AD7B7300FFD6AD00FFC68C00EFA55A00C67339008C5A
      5200C6B5B500D6C6BD00BD94940000000000DE9C4A00E77B00007B94100021BD
      420021C64A0029C65A0073CE5A00FFC65200FFB53100F7940000CE8C00000884
      0000007300002163000094733900000000000000000000000000000000000000
      0000A5948400736B63000000000000000000000000000000000084847B008C73
      5A0000000000000000000000000000000000429CF70042A5FF0042ADFF0042B5
      FF0042ADFF00319CFF002994FF0063ADFF00FFFFEF00FFF7EF00FFF7E700F7E7
      CE00FFDEBD00847B9400947B8C00000000000000000000000000DEBDB500FFFF
      FF00FFFFFF00FFFFFF00FFF7F700AD7B7300FFD6AD00FFC68C00F7AD5A00C673
      31008C5A5200D6C6BD00C6ADAD0000000000DE9C4A00D67B000052A5210029C6
      520031CE63004AD673004AD67300FFDE7B00FFC65200FF9400009C9400002984
      0000087B0000396B0000AD946B00000000000000000000000000000000000000
      0000A5948400736B6300000000000000000000000000000000008C8484008C73
      5A00000000000000000000000000000000000000000042A5FF0042A5FF0042B5
      FF0042B5FF0031A5FF00319CFF001884FF006BADFF00FFFFEF00FFF7EF00FFEF
      DE009CA5B5007B73940000000000000000000000000000000000DEC6B500FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFF7F700AD7B7300FFD6AD00FFC68C00EFA5
      5A00B56B39008C5A5200C6B5B50000000000000000004ABD4A0021BD420052D6
      7B007BDE8C00B5F7B500C6F7CE00CEEFA50094CE63009CA51800BD9400006B84
      0000087B0000BD9C630000000000000000000000000000000000000000000000
      0000A59484007B737300000000000000000000000000000000009C9C94008C73
      5A00000000000000000000000000000000000000000000000000429CFF0042AD
      FF0042ADFF0042B5FF0039ADFF002994FF00218CFF006BB5FF00CEDEEF00426B
      B500426BB5000000000000000000000000000000000000000000E7C6B500FFFF
      FF00C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600AD7B7300FFD6AD009C94
      A50031ADF7000010AD0000009C0000000000000000004AD67B0031C6520063DE
      7B0084E79400E7FFC600ADF7B50094E7940031CE63008CA51800C6940000D673
      0000397B00000000000000000000000000000000000000000000000000000000
      0000A5948400737373007B634A00000000000000000084736300B5B5B5008C73
      5A000000000000000000000000000000000000000000000000000000000042A5
      FF0042ADFF0042B5FF0042B5FF00319CFF002994FF001884FF002984EF003963
      CE00000000000000000000000000000000000000000000000000E7C6B500FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700AD7B73004A9C
      EF001029D6001029D6000010AD0000009C0000000000000000000000000094CE
      63009CD66B00B5E79400C6DE84004AD67B0031CE63006BA51800EF840000EFA5
      3100000000000000000000000000000000000000000000000000000000000000
      000000000000EFEFEF00ADADAD008C8C8C008C8C8C00C6C6C600CECECE000000
      0000000000000000000000000000000000000000000000000000000000000000
      000042A5FF0042ADFF0042B5FF0039ADFF0039A5FF00101094002131BD000000
      0000000000000000000000000000000000000000000000000000EFCEBD00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E7D6CE000018
      C6006B8CFF00106BFF001029D600000000000000000000000000000000000000
      00004AD67B009CD6730084D67B0052CE5A0029C6520073A52100EFA529000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A5948400E7E7E700EFEFEF00EFEFEF00CECEC6008C735A000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000042A5FF0042ADFF000000000000000000101094002131C6000000
      0000000000000000000000000000000000000000000000000000E7C6B500FFF7
      F700FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00E7CECE00C694
      7B000018C6000018C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000101094002131C6000000
      0000000000000000000000000000000000000000000000000000E7C6B500EFCE
      B500EFCEB500EFCEB500EFCEB500E7C6B500E7C6B500EFCEB500D6BDB500BD84
      7B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000844A4A004A18180000000000000000000000
      0000000000000000000000000000000000000000000000000000A5636B00A563
      6B00A5636B00A5636B00A5636B00A5636B00A5636B00A5636B00A5636B00A563
      6B00A5636B00A5636B00A5636B00000000000000000000000000000000000000
      00000000000000000000000000006B7373006B73730000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CEC6C600B5B5B5007B7B7B000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000844A
      4A00844A4A009C4A4A00B54A4A009C4A4A004A18180000000000000000000000
      00000000000000000000000000000000000000000000000000004A526300FFEF
      C600F7DEB500F7D6AD00F7D6A500EFCE9400EFC68C00EFC68400EFC67B00EFC6
      8400EFC68400F7C68400A5636B00000000000000000000000000000000000000
      000000000000000000006B635A00EFA56300D67B210000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CEC6C600CEC6C600848484000000000000000000000000000000
      0000BDBDBD004A94D60000000000000000000000000000000000844A4A009C4A
      4A00AD4A4A00C64A4A00BD4A4A009C4A4A004A181800844A4A00844A4A00844A
      4A00844A4A00844A4A00844A4A0000000000000000004284B500186BC600636B
      8400F7DEBD00F7D6B500F7D6A500EFCE9C00EFC69400EFC68C00EFBD8400EFBD
      7B00EFBD7B00EFC68400A5636B00000000000000000000000000000000000000
      000000000000000000006B635A00EFA55A00D673180000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B00CECECE00848484000000000000000000000000006BBD
      E7006BADCE004A9CB5004A94D600000000000000000000000000844A4A00CE52
      5A00CE525200CE525200C6525200A54A4A004A18180018BD4A0018BD4A0018BD
      4A0018BD4A00F7B5B500844A4A0000000000000000000000000031A5FF001073
      D6006B6B8400F7DEBD00F7D6B500EFD6AD00EFCE9C00EFC69400EFC68C00EFBD
      8400EFBD7B00EFC68400A5636B00000000000000000084848400A594A500A5A5
      A5008484840000000000736B6300E7944A00D673180000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B00CEC6C600848484000000000000000000000000006BA5
      C6007BCEEF006BCEE7004A94D600000000000000000000000000844A4A00D65A
      5A00CE5A5A00CE525A00CE525200A55252004A18180018BD4A0018BD4A0018BD
      4A0018BD4A00F7B5B500844A4A00000000000000000000000000A5635A0031A5
      FF001073D6005A638400F7DEBD00F7D6B500F7D6A500EFCE9C00EFC69400EFC6
      8C00EFBD8400EFC68400A5636B000000000000000000C6C6C600B5B5B500BDBD
      BD00B5B5B5005A525200736B6300E7944200D673180000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CEC6C600BDBDBD008C8C8C0000000000000000000000000094CE
      E70063BDF7004A9CBD0000000000000000000000000000000000844A4A00DE63
      6300DE636300D65A5A00D65A5A00AD5252004A18180018BD4A0018BD4A0018BD
      4A0018BD4A00F7B5B500844A4A00000000000000000000000000A5736B00FFFF
      F70031A5FF00427BAD008C635A00AD7B730094635A00AD7B6B00CEA58400EFC6
      9400EFC68C00EFC68400A5636B00000000000000000000000000000000006363
      6300BDBDBD00A5A5A500736B6300DE8C3900D6732100948C84009C9C9C009C9C
      9C009C9C9C00949494008C7B8C00000000000000000000000000000000000000
      000000000000A5A5A50094949400848484000000000000000000A5C6DE0063BD
      F70042A5E7000000000000000000000000000000000000000000844A4A00DE63
      6300DE636300DE636300DE636300AD5252004A18180018BD4A0018BD4A0018BD
      4A0018BD4A00F7B5B500844A4A00000000000000000000000000A5736B00FFFF
      FF00FFF7E700AD8C8C00B58C8400DEBDA500EFD6B500D6B59C00B58C7300CEA5
      8400EFC69400F7CE8C00A5636B00000000000000000000000000000000006363
      6300B5B5B500ADADAD00736B6300DE8C3900D6732100A59C9400B5B5B500B5B5
      B500ADADAD00ADADAD00A594A500000000000000000000000000000000000000
      000000000000ADADAD008C8C8C006B73730000000000A5C6DE004A9CC600399C
      DE0052BDEF000000000000000000000000000000000000000000844A4A00E76B
      6B00E76B6B00EFA5A500FFFFFF00AD5A5A004A181800B5EFAD005AD6730042CE
      630042CE6300F7B5B500844A4A00000000000000000000000000BD846B00FFFF
      FF00FFF7F700AD847B00DEC6B500F7E7CE00F7E7C600FFFFF700D6B59C00AD7B
      6B00EFCE9C00F7CE9400A5636B000000000000000000D6D6D600DEDEDE00C6C6
      C600C6C6C6005A5252007B6B5A00DE842900DE73290000000000000000000000
      00000000000000000000000000000000000000000000000000009C9C9C00D6D6
      D600D6D6D600A5ADBD005ABDEF0052BDFF0063C6EF0073D6F7004AADFF0042AD
      E7004A94D6000000000000000000000000000000000000000000844A4A00EF6B
      7300EF6B6B00F7ADAD00FFFFFF00B55A5A004A181800FFFFD600FFFFD600FFFF
      D600DEF7BD00F7B5B500844A4A00000000000000000000000000BD846B00FFFF
      FF00FFFFFF0094636300F7EFE700F7EFDE00F7E7CE00FFFFEF00EFD6B5009463
      5A00F7D6A500F7D6A500A5636B0000000000000000009C9C9C00A5A5A500B5B5
      B500A5A5A5000000000063635A00D67B2100DE73310000000000000000000000
      000000000000000000000000000000000000000000009C9C9C00D6D6D600CEC6
      C600EFEFEF008CBDDE0073D6FF0052B5FF0084EFFF006BCEFF0042A5EF00429C
      DE00000000000000000000000000000000000000000000000000844A4A00F773
      7B00F7737300EF737300EF737300B55A5A004A181800FFFFD600FFFFD600FFFF
      D600FFFFD600F7B5B500844A4A00000000000000000000000000D6946B00FFFF
      FF00FFFFFF00B58C8400DECEC600FFEFE700FFEFDE00FFFFD600DEBDA500AD7B
      7300F7DEB500EFCEA500A5636B00000000000000000000000000000000000000
      000000000000000000007B635200D6731800CE73390000000000000000000000
      000000000000000000000000000000000000000000009C9C9C00DEDEDE00A5A5
      A5007B7B7B007BE7FF005AC6FF0042A5E70073CEDE006BCEFF0042A5FF005A73
      8400000000000000000000000000000000000000000000000000844A4A00F77B
      7B00F77B7B00F7737B00F7737300B55A5A004A181800FFFFD600FFFFD600FFFF
      D600FFFFD600F7B5B500844A4A00000000000000000000000000D6946B00FFFF
      FF00FFFFFF00D6BDBD00BD949400DECEC600F7EFDE00DEC6B500B58C8400B58C
      7B00DECEB500B5AD9400A5636B00000000000000000000000000000000000000
      00000000000000000000635242007B5A4200A563420000000000000000000000
      000000000000000000000000000000000000000000009C9C9C00E7E7E7009494
      9400A5ADAD007BE7FF0042A5FF005A7B9C00637B840094DEFF004AADFF00429C
      DE005A7384000000000000000000000000000000000000000000844A4A00FF84
      8400FF848400FF7B8400FF7B7B00BD6363004A181800FFFFD600FFFFD600FFFF
      D600FFFFD600F7B5B500844A4A00000000000000000000000000DE9C7300FFFF
      FF00FFFFFF00FFFFFF00D6BDBD00B58C840094636300AD847B00CEA59C00A56B
      5A00A56B5A00A56B5A00A5636B00000000000000000000000000000000008C8C
      8C004A636B00000000005A5252006B6B6B005A52520000000000000000000000
      000000000000000000000000000000000000000000009C9C9C00F7F7F700B5B5
      B5008CA5BD00E7F7FF00BDE7FF0052B5FF006BA5B50073737B002184CE004AB5
      F7004A94D6000000000000000000000000000000000000000000844A4A00FF84
      8400FF848400FF848400FF848400BD6363004A181800FFFFD600FFFFD600FFFF
      D600FFFFD600F7B5B500844A4A00000000000000000000000000DE9C7300FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700DEC6BD00A56B
      5A00E79C5200E78C3100B56B4A0000000000000000000000000000000000F7F7
      F700BDADAD005A5252005A525200B5B5B500B5B5B50000000000000000000000
      00000000000000000000000000000000000000000000A5A59C00ADADAD00EFEF
      EF00E7E7E70094C6F700BDE7FF0084D6FF0084EFFF00A58C8C003184CE00429C
      D6004A94D6000000000000000000000000000000000000000000844A4A00AD5A
      5A00D66B7300FF848400FF848400BD6363004A181800FFFFD600FFFFD600FFFF
      D600FFFFD600F7B5B500844A4A00000000000000000000000000E7AD7B00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DEC6C600A56B
      5A00FFB55A00BD7B5A000000000000000000000000000000000063636300BDBD
      BD00636363009C9C9C006B6B6B00B5B5B500BDBDBD00B5B5B5005A5252005A52
      52005A52520000000000000000000000000000000000A5A59C00DEBD9C009C9C
      9C0000000000ADADAD00A5A5A5006BA5C6008C9CA5007B8CA50042A5FF004A94
      D60000000000000000000000000000000000000000000000000000000000844A
      4A00844A4A00B5636300EF7B7B00BD6363004A181800844A4A00844A4A00844A
      4A00844A4A00844A4A00844A4A00000000000000000000000000E7AD7B00FFF7
      F700FFF7EF00FFF7EF00FFF7EF00FFF7EF00F7F7EF00F7F7EF00DEC6C600A56B
      5A00C6846B000000000000000000000000000000000000000000527B8400B5B5
      B50063636300A5A5A5006B6B6B00A5A5A500ADADAD00C6C6C600C6C6C600B5B5
      B5009C9C9C000000000000000000000000000000000000000000A5A59C007B7B
      73006363630073737300737373009C949400BDA5A50094EFEF005AC6FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000844A4A004A18180000000000000000000000
      0000000000000000000000000000000000000000000000000000E7AD7B00D694
      6B00D6946B00D6946B00D6946B00D6946B00D6946B00D6946B00D6946B00A56B
      5A00000000000000000000000000000000000000000000000000000000006363
      6300847B7B00847B7B008484840084848400848484007B7B7B00737373000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A5A59C00A5A59C00A5A59C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008C5A5A008C5A5A008C5A5A008C5A5A008C5A5A008C5A5A008C5A
      5A008C5A5A008C5A5A008C5A5A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000108CBD001894C600006B9400000000000000
      00000000000000000000000000000000000000000000000000006B846300319C
      3100319C3100319C3100319C310052634200636B4A00948C8400000000000000
      0000000000000000000000000000000000000000000000000000188CCE009CDE
      F7009CE7F700A5949400EFDECE00EFE7CE00EFDECE00EFDEC600EFDEC600EFDE
      C600EFDEC600F7E7C6008C5A5A00000000008C5A5A008C5A5A008C5A5A008C5A
      5A008C5A5A008C5A5A008C5A5A008C5A5A008C5A5A0073424200000000000000
      000000000000000000000000000000000000000000000000000000000000188C
      BD00108CBD00006B9C000884B500109CCE00189CCE000873A500086B9C002994
      BD002194BD000000000000000000000000000000000073AD73001084100021A5
      210031A5310039AD390039AD3900319C310031942900319C3100218421000000
      00000000000000000000000000000000000000000000188CCE008CDEF70073E7
      FF0073E7FF009C949400F7DED600F7E7D600EFE7CE00EFDECE00EFDEC600EFDE
      C600EFDEC600F7E7C6008C5A5A00000000008C5A5A00F7EFD600F7E7CE00F7E7
      CE00F7E7C600F7E7C600F7E7C600F7E7C600F7E7CE0073424200000000000000
      000000000000000000000000000000000000000000000000000000000000188C
      BD0021A5D600089CCE00008CBD0008B5EF0029CEF7001894BD0042B5D6004AB5
      D600298CB500000000000000000000000000000000003994390029AD29004ABD
      4A005AC65A0052B5520073B56B004AA54200B5E7A50042BD4200299C29000000
      00000000000000000000000000000000000000000000188CCE0094DEF7007BE7
      FF0073E7FF009C949400F7E7DE00F7DEBD00F7DEBD00F7D6B500F7D6B500F7D6
      B500F7D6B500EFE7C6008C5A5A00000000008C5A5A00F7EFDE00EFE7D600EFE7
      CE00EFDECE00EFDEC600EFDEC600EFDEC600EFDEC60073424200000000000000
      000000000000000000000000000000000000000000001073A5001884AD0031A5
      CE006BD6EF0031ADD60021BDE70008CEFF0021D6FF0042C6EF005AB5D6009CDE
      E70073C6DE000873A5000000000000000000000000008CBD8C00299C29005AC6
      5A006BCE6B0063A56300F7FFEF0084BD7B00B5E7A50052C6520031A531000000
      00000000000000000000000000000000000000000000188CCE009CDEF70084E7
      FF0084EFFF00A59C9C00F7E7DE00F7E7D600F7E7CE00F7DECE00F7DEC600F7DE
      C600EFDEC600F7E7CE008C5A5A0000000000A5635A00F7EFE700F7D6B500F7BD
      8400F7BD8400F7BD8400F7BD7B00F7CEAD00EFE7C60073424200000000000000
      0000000000000000000000000000000000000000000042A5CE00299CC60039AD
      D6007BE7FF0073EFFF0042DEFF0010CEFF0008CEFF0039DEFF005AE7FF0063E7
      FF0029BDEF00189CCE00188CC6000000000000000000000000000000000052B5
      52004A9C4200BDC6C600BDC6C60094B57B007BCE7B0052B55200428439000000
      00000000000000000000000000000000000000000000188CCE00A5E7F7009CEF
      FF0094EFFF00B5A59C00FFEFE700F7F7EF00F7EFE700F7EFE700F7EFE700F7E7
      DE00F7E7D600F7E7D6008C5A5A0000000000A5635A00FFF7EF00F7EFDE00F7E7
      D600F7E7CE00F7DECE00EFDEC600E7D6BD00E7DEC6007B4A4A00000000000000
      00000000000000000000000000000000000000000000087BAD001094CE0031B5
      E70063D6F7007BEFFF0052C6E70042A5BD00319CBD0010B5E70000C6FF0000C6
      FF0000C6FF0000BDF70000A5DE00000000000000000000000000000000004A8C
      420018734A00217BBD00217BBD004284630063BD6300528C4A00000000000000
      00000000000000000000000000000000000000000000188CCE00ADE7F700A5EF
      FF009CEFFF00B5A59C00FFF7EF00FFD6B500FFD6AD00FFD6AD00FFD6AD00FFCE
      A500F7D6AD00F7EFDE008C5A5A0000000000A5736B00FFF7EF00F7D6AD00EFB5
      7300EFB57300F7B57300EFB57300D6B59400CEC6B5007B4A4A00000000000000
      000000000000000000000000000000000000000000000873A500109CD60029AD
      E70052CEF7007BB5C6007B7B7B007B7B7B007B7B7B007B7B7B0029ADCE0000C6
      FF0008C6FF0008C6FF000084BD0000000000000000000000000000000000217B
      BD002994EF003194FF003194FF002994EF00216B9C0000000000000000000000
      00000000000000000000000000000000000000000000188CCE00B5E7F700BDF7
      FF00B5F7FF00C6B5A500FFF7F700FFFFFF00FFFFFF00FFF7F700F7F7EF00F7F7
      EF00F7F7EF00D6CEC6008C5A5A0000000000BD846B00F7F7F700E7D6C600B5A5
      8C00BDAD9C00D6BDA500B5A594007B7363007B736B006B424200000000000000
      00000000000000000000000000000000000000000000087BAD00109CD60018A5
      DE0042C6F7007B7B7B00E7DEDE009C9C9C00948C8C00DEA5A5007B7B7B0039D6
      FF0084EFFF00A5EFFF002184AD00000000000000000000000000000000002994
      EF00399CFF00399CFF00399CFF00399CFF00298CE70000000000000000000000
      00000000000000000000000000000000000000000000188CCE00BDE7F700C6F7
      FF00C6F7FF00CEB5A500FFFFF700FFFFFF00FFFFFF00FFF7F700FFF7EF00F7E7
      E700DECECE00B5ADAD008C5A5A0000000000BD846B00F7F7F7005A73A500946B
      4A00946B4A00A57B52008C6B4200314273003939520052313100000000000000
      000000000000000000000000000000000000000000000873A5000884BD001094
      D60029B5EF007B7B7B00E7DED6009C9C9C00948C8C00D6A5A5007B7B7B0063DE
      FF0094E7F70073BDD600298CB50000000000000000000000000063849C0042A5
      FF004AADFF006BBDFF006BBDFF004AADFF0042A5F70000000000000000000000
      00000000000000000000000000000000000000000000188CCE00BDE7F700DEFF
      FF00D6FFFF00DEBDA500FFFFF700FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6A5
      9400DEA56B00F76B4A000000000000000000D6946B00FFFFFF0042528400849C
      B50084848C00395284006BC6E7005AA5D600428CC60031293900000000007373
      730039393900423939002121210042393900000000000000000000639400108C
      C60021ADE7007B7B7B00E7DED6009C9C9C00948C8C00D6A5A5007B7B7B004ADE
      FF004ABDDE00005A8C00000000000000000000000000000000006BA5C6004AAD
      FF004AB5FF0052B5FF006BBDFF006BBDFF004AADFF0000000000000000000000
      00000000000000000000000000000000000000000000188CCE00BDE7F700E7FF
      FF00E7FFFF00DEBDAD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CEA5
      9C00E79C6300000000000000000000000000DE9C7300FFFFFF009C9CB500BDEF
      F7008CB5CE0073D6EF0039528400395284005294D60018184200181842007373
      7300ADADAD00423939003931310042393900000000000000000000000000086B
      A5000073AD007B7B7B00E7DEDE009C9C9C00948C8C00D6A5A5007B7B7B000884
      B500107BA500000000000000000000000000000000000000000063A5C600298C
      CE003194DE002184C600298CC6002984C6002994CE0000000000000000000000
      00000000000000000000000000000000000000000000188CCE00C6E7F700FFFF
      FF00F7FFFF00E7DED600DED6C600D6D6C600CECEC600C6C6C600BDC6C600BDC6
      C60094DEEF00000000000000000000000000E7AD7B00FFFFFF00FFFFFF00A5A5
      BD0052638C004A6B9C00395284003952840052B5EF004294E7003184DE007373
      7300B5BDBD0042393900524A4A00524A4A000000000000000000000000000000
      0000000000007B7B7B00DEDEDE009C9C9C00948C8C00CEA5A5007B7B7B000000
      000000000000000000000000000000000000000000000000000063849C00428C
      C6004A94C6007BBDEF0063ADF700398CCE00216BA50000000000000000000000
      00000000000000000000000000000000000000000000188CCE00C6E7F700FFFF
      FF00A5DEE7009CDEEF009CDEEF009CDEEF009CDEEF0094DEEF009CDEEF00CEFF
      FF009CEFFF00000000000000000000000000E7AD7B00FFFFFF00FFFFFF00FFFF
      FF00ADADBD007BDEEF004A6B9C0063BDEF0052B5EF004294E7003184DE007373
      7300EFEFEF00423939005A5A5A005A5A5A000000000000000000000000000000
      0000000000007B7B7B009C9C9C008C8C8C00847B7B00948C8C007B7B7B000000
      000000000000000000000000000000000000000000000000000000000000428C
      B5004294C6009CCEE7008CBDE700106B9C000000000000000000000000000000
      00000000000000000000000000000000000000000000188CCE00CEEFF700A594
      8400AD948C00DECECE00DECECE00DECECE00DECECE00D6CEC600B5A59C00EFFF
      FF00A5EFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000039528400ADDEF70052B5EF004294E7003184DE007373
      7300EFEFEF004239390073737300737373000000000000000000000000000000
      0000000000007B7B7B00DED6D600B5B5B5008C8C8C009C8C8C007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006BA5BD00529CBD004A8CAD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000188CCE00D6D6
      D600947B7300EFEFE700FFFFFF00FFFFFF00FFFFFF00BDADA5008C7B7300ADF7
      FF00188CCE000000000000000000000000000000000000000000000000000000
      00000000000000000000000000004A7BAD004A84BD004273B50039528C007373
      7300737373004239390073737300636363000000000000000000000000000000
      0000000000007B7B7B00DEDEDE00E7E7E700ADADAD008C8484007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008C7B6B008C7B6B008C7B6B008C7B6B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007B7B7B007B7B7B007B7B7B007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000003900000039000000390000003900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000006B0000006B0000006B0000006B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      9C0000009C0000008400182194004A52A5004A52A50010106B00000042000000
      4200000039000000000000000000000000000000000000000000000000000010
      C6000008BD000810AD00424AB5007B7BC6007B7BC60031319400000073000000
      730000006B000000000000000000000000000000000000000000847B7B008C84
      7B00B5A594008C7B630000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C64A2900C6421800CE4A
      2100CE4A2900C64A2900C64A290084736B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      A5000008AD00BDBDEF00FFFFFF00FFFFFF00FFFFFF00F7F7FF009CA5CE000000
      4200000031000000000000000000000000000000000000000000000000000008
      C6001829CE00D6D6F700FFFFFF00FFFFFF00FFFFFF00F7F7FF00C6C6E7000808
      73000000630000000000000000000000000000520000EFD6BD00B5ADA500C6B5
      A500FFE7CE00FFDEBD00D6B59C009C8C73008C7B630000000000000000000000
      00000000000000000000000000000000000000000000F7634A00F7634A00FF7B
      6300FF8C6B00EFC69400D66B4200F7634A00D64A290042AD4200218421009CDE
      8C009CDE8C005AD65A0042CE420000000000000000000008C6000000BD00FFFF
      FF00FFFFFF00ADADE7002931A50000006B0000006B0031319C00ADADDE00FFFF
      FF00D6D6EF000000310000004A0000000000000000000021DE000010D600FFFF
      FF00FFFFFF00FFFFFF00B5B5EF005A5ABD005A5ABD00CECEEF00FFFFFF00FFFF
      FF00E7E7F7000000630000007B0000000000005A0000FFEFD600C6BDB500FFF7
      E700FFEFDE00FFE7CE00FFE7C600FFDEB500FFD6AD00FFCE9C00FFCE94008C7B
      63000000000000000000000000000000000000000000F7634A00FF7B6300FF8C
      6B00DE6B4200FFDEAD00DE7B4A00FF8C6B00E75A390052B5520084BD7300B5E7
      A5009CDE8C005AD65A005AD65A0000000000000000000000C6001829D600FFFF
      FF00FFFFFF0000008C0000007B000000730000006B000000630000006B00FFFF
      FF00FFFFFF0000004A000000420000000000000000000018DE003952E700FFFF
      FF00FFFFFF00424ACE000000AD0000009C000000940000009C006363BD00FFFF
      FF00FFFFFF0018187B000000730000000000004A0000FFEFDE00C6BDB500FFF7
      E700FFEFE700524A4200635A4A00C6A58C00FFDEB500FFD6A500FFCE9C008C7B
      63000000000000000000000000000000000000000000D66B4A00EF7B5A00D66B
      4200DE9C8400FFBD8C00E78C5A00FF8C6B00B56B31005AAD5A00EFF7E700A5CE
      A5005AB55A009CDE8C009CDE8C0000000000000000002131DE00FFFFFF009CA5
      EF000008B5000000A500000094000000840000007B000000730000006B000000
      6B00ADADDE00CECEE7000000520000000000000000004A63EF00FFFFFF00EFEF
      FF002139DE000010C6000000BD00FFFFFF00FFFFFF0000009C0000009C004242
      B500FFFFFF00E7E7EF001010840000000000004A0000C6BDB500C6C6BD00FFFF
      F700FFF7EF00ADA59400ADA594008CA56B00C6C68C00FFD6AD00FFD6A5008C7B
      6300000000000000000000000000000000000000000000000000A56342004221
      5A002929940042317300A5524A009463210073D673005AA55A00FFF7E700F7EF
      DE007BAD63009CDE8C005AA55A00000000000008EF00637BF700FFFFFF001829
      DE000008C6000000AD000000A5000000940000008C0000007B00000073000000
      6B0021219400FFFFFF0031318400000052000029F70094A5F700FFFFFF007B8C
      F7000010DE000010CE000000C600FFFFFF00FFFFFF000000A50000009C000000
      9400A5A5DE00FFFFFF006363AD0000008400004A0000A5AD9C00C6C6BD00FFFF
      FF00FFFFF700ADA59C0031632900006B0000005A0000296B1800528439000000
      0000000000000000000000000000000000000000000031313100080808001039
      94001842AD001842AD0010399C000000000000000000187B7B002184D600218C
      DE002184D6005A73730000000000000000000008FF00E7EFFF00FFFFFF000008
      EF000008E700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009CA5DE000000
      7B0000007300FFFFFF00A5A5DE00000042000029FF00EFF7FF00FFFFFF000031
      F7000021EF00F7F7FF00F7F7FF00FFFFFF00FFFFFF00F7F7FF00F7F7FF000000
      9C001018A500FFFFFF00C6C6EF0000007300000000007B9C7B00C6C6C600FFFF
      FF00EFEFEF002963210000730000008400000084000000840000008400000084
      00000084000000730000006B0000004A00000000000018181800081018001852
      BD00185ABD00185ABD001852BD00737B8C0000000000298CE7003194F7003194
      F7003194F7002173A50000000000000000000010FF00F7F7FF00FFFFFF000010
      F7000008EF009CADF700FFFFFF00FFFFFF00FFFFFF00BDC6EF000008A5000000
      840000007B00FFFFFF00ADB5E70000007B000031FF00F7FFFF00FFFFFF000031
      FF000021F700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      A5000810AD00FFFFFF00CECEEF000000A50000000000396B3900C6C6C600FFFF
      FF00C6C6C600005A000000941000008C08000084000000840000008400000084
      0000008400000084000000730000004A0000000000003131310021212100297B
      DE00297BE700297BE700297BDE004A5A84000000000042A5FF0042ADFF0042AD
      FF0042A5FF0039A5FF002973A500000000001839FF00E7EFFF00FFFFFF000018
      FF000010FF000010F7001839F700FFFFFF00FFFFFF000008BD000000B5000000
      A5000810A500FFFFFF00737BD60000008400426BFF00EFF7FF00FFFFFF002152
      FF000029FF000031FF000021F700FFFFFF00FFFFFF000010CE000018CE000000
      BD004A52CE00FFFFFF00A5A5E7000008AD0000000000215221009C9C9C00FFFF
      FF008CB58C0010AD290008A52100089C180000941000008C0800008400000084
      000000840000004A0000004A000000000000000000003939390029292900298C
      F7005AADFF00429CFF00298CF700526B8C00000000004AADFF006BBDFF006BBD
      FF006BBDFF0042A5FF00529CC600000000000010FF00CEDEFF00FFFFFF004263
      FF000010FF000010FF000010F700F7F7FF00425AEF000008CE000008C6000000
      AD00636BCE00FFFFFF002931C600000000000839FF00E7E7FF00FFFFFF008CA5
      FF000021FF000031FF000018FF00FFFFFF00FFFFFF000010D6000018D6000008
      C600B5B5EF00FFFFFF005A63D6000000000000000000084208008C8C8C00EFF7
      EF00085A080010B5390010AD310008A52100089C180000941000008C08000084
      0000007B0000004A00000000000000000000000000004A4A4A004A4A4A005252
      520031314200292994002929940000000000000000006BBDFF0042A5DE004AB5
      F7006BBDFF004AADF7002184BD0000000000000000006B84FF00FFFFFF00FFFF
      FF00CED6FF000010FF000010FF000010FF000010F7000008EF000008DE00EFEF
      FF00FFFFFF004252CE0000009C00000000000000000094ADFF00FFFFFF00FFFF
      FF00DEE7FF000021FF000029FF000839FF000839FF000021EF000010E700F7F7
      FF00FFFFFF00737BDE000000BD000000000000000000004A00005A5A5A00005A
      000018BD4A0018BD4A0018BD4A0010B5390010AD310008A52100089C18000063
      0000004A000000000000000000000000000000000000393939005A5A5A009C9C
      9C00A5A5A5004A4A4A00313131000000000000000000187BB5003994C600429C
      CE003194CE002984BD00106B9C0000000000000000003152FF00CEDEFF00FFFF
      FF00FFFFFF002942FF000010FF000010FF000010FF000010F7003952EF00FFFF
      FF00FFFFFF000008AD000000A50000000000000000006384FF00E7E7FF00FFFF
      FF00FFFFFF006B84FF000839FF000021FF000021FF001839F7008494F700FFFF
      FF00FFFFFF000821CE000010C6000000000000000000004A00005A5A5A00109C
      310018BD4A0018BD4A0018BD4A0018BD420018B5390010AD290008A52100004A
      0000000000000000000000000000000000000000000000000000000000004A4A
      4A00424242007B7B7B000000000000000000000000008CBDD6005AA5D60094C6
      E7007BBDE700529CC600000000000000000000000000000000004263FF00EFF7
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0094A5
      F7000810CE0000000000000000000000000000000000000000007394FF00F7F7
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00BDC6
      F7002139DE000000000000000000000000000000000000000000004A00002142
      290021944200217B4200216B390018A5420029292900109C2900004A00000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009CC6DE0094C6
      DE0084B5D6000000000000000000000000000000000000000000000000005273
      FF00B5C6FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00ADB5FF000008
      D6000000C600000000000000000000000000000000000000000000000000849C
      FF00CED6FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CED6FF000829
      E7000018DE000000000000000000000000000000000000000000000000002131
      210010391000184A1800085A1000088418002142210000520000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000526BFF003152FF00395AFF00294AFF001029F7001029EF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B9CFF006384FF006B84FF005A7BFF00315AF7003152F7000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B0000007B0000007B0000007B0000007B0000007B0000007B00
      00007B0000007B0000007B000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF007B000000000000000000000000000000000000007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B000000000000FFFF000000
      00007B7B7B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF007B000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000000000007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF007B000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF00FFFF
      FF00FFFFFF00000000007B7B7B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B0000007B00
      00007B0000007B0000007B0000007B0000007B0000007B0000007B0000007B00
      00007B0000007B0000007B000000000000000000000000000000FFFFFF0000FF
      FF00FFFFFF00FFFFFF00FFFFFF007B0000007B000000FFFFFF00FFFFFF0000FF
      FF00FFFFFF00000000007B7B7B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B000000FFFF
      FF00FFFFFF007B000000FFFFFF007B0000007B0000007B0000007B0000007B00
      00007B0000007B0000007B000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF0000FFFF00FFFFFF00FFFFFF00FFFFFF0000FFFF00FFFFFF00FFFF
      FF00FFFFFF00000000007B7B7B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B000000FFFF
      FF00FFFFFF007B0000007B0000007B0000007B0000007B0000007B0000007B00
      00007B0000007B0000007B000000000000000000000000000000FFFFFF0000FF
      FF00FFFFFF00FFFFFF00FFFFFF007B0000007B7B7B00FFFFFF00FFFFFF0000FF
      FF00FFFFFF00000000007B7B7B000000000000000000000000007B0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007B00
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF0000FFFF00FFFFFF007B7B7B007B00000000000000FFFFFF00FFFF
      FF00FFFFFF00000000007B7B7B0000000000000000007B0000007B0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B0000007B00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B0000007B0000007B0000007B00
      00007B0000007B0000007B0000007B0000007B0000007B0000007B0000007B00
      0000000000000000000000000000000000000000000000000000FFFFFF0000FF
      FF00FFFFFF00FFFFFF00FFFFFF0000FFFF007B7B7B007B0000007B7B7B0000FF
      FF00FFFFFF00000000007B7B7B00000000007B0000007B0000007B0000007B00
      00007B0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B0000007B0000007B0000007B00
      00007B0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B000000FFFFFF007B000000FFFF
      FF007B0000007B0000007B0000007B0000007B0000007B0000007B0000007B00
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF007B0000007B7B7B00FFFFFF00FFFFFF007B0000007B000000FFFF
      FF00FFFFFF00000000007B7B7B0000000000000000007B0000007B0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B0000007B00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B000000FFFFFF007B0000007B00
      00007B0000007B0000007B0000007B0000007B0000007B0000007B0000007B00
      0000000000000000000000000000000000000000000000000000FFFFFF0000FF
      FF00FFFFFF007B0000007B00000000FFFF00000000007B0000007B00000000FF
      FF00FFFFFF00000000007B7B7B000000000000000000000000007B0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007B000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00000000007B0000007B0000007B0000007B00000000000000FFFF
      FF00FFFFFF00000000007B7B7B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B0000007B0000007B0000007B00
      00007B0000007B0000007B0000007B0000007B0000007B000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF0000FF
      FF00FFFFFF00FFFFFF00FFFFFF0000FFFF00FFFFFF00FFFFFF00FFFFFF0000FF
      FF00FFFFFF00000000007B7B7B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B000000FFFFFF007B0000007B00
      00007B0000007B0000007B0000007B0000007B0000007B000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF0000FFFF00FFFFFF00FFFFFF00FFFFFF0000FFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B0000007B0000007B0000007B00
      00007B0000007B0000007B0000007B0000007B0000007B000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD000000
      0000BDBDBD00000000000000000000000000000000007B0000007B0000007B00
      00007B0000007B0000007B0000007B0000007B0000007B0000007B0000007B00
      00007B0000007B0000000000000000000000000000007B0000007B0000007B00
      00007B0000007B0000007B0000007B0000007B0000007B0000007B0000007B00
      00007B0000007B00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000BDBDBD000000000000000000000000007B000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF007B0000000000000000000000000000007B000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF007B000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF007B00000000000000000000000000000000000000000000000000
      000000000000000000007B7B7B00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD0000FFFF0000FFFF0000FFFF00BDBDBD00BDBD
      BD0000000000000000000000000000000000000000007B000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF007B0000000000000000000000000000007B000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF007B000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF007B00000000000000000000000000000000000000000000000000
      0000000000007B7B7B0000000000000000000000000000000000000000000000
      00007B7B7B0000000000000000000000000000000000BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD007B7B7B007B7B7B007B7B7B00BDBDBD00BDBD
      BD0000000000BDBDBD000000000000000000000000007B000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF007B0000000000000000000000000000007B000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF007B000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF007B00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000BDBDBD00BDBDBD0000000000000000007B0000007B0000007B00
      00007B0000007B0000007B0000007B0000007B0000007B0000007B0000007B00
      00007B0000007B0000000000000000000000000000007B000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF007B000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF007B00000000000000000000000000000000000000000000000000
      00000000000000000000000000007B7B7B000000000000000000000000000000
      00000000000000000000000000000000000000000000BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD000000
      0000BDBDBD0000000000BDBDBD0000000000000000007B000000FFFFFF007B00
      00007B0000007B0000007B0000007B0000007B0000007B0000007B0000007B00
      00007B0000007B0000000000000000000000000000007B000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF007B000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF007B00000000000000000000000000000000000000000000000000
      000000000000000000007B7B7B00000000000000000000000000000000007B7B
      7B00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000BDBD
      BD0000000000BDBDBD000000000000000000000000007B0000007B0000007B00
      00007B0000007B0000007B0000007B0000007B0000007B0000007B0000007B00
      00007B0000007B0000000000000000000000000000007B000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF007B000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF007B00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000BDBDBD0000000000BDBDBD0000000000000000007B000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF007B0000000000000000000000000000007B000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF007B000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF007B00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      000000000000000000000000000000000000000000007B000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF007B0000000000000000000000000000007B000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF007B000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF007B00000000000000000000000000000000000000000000000000
      00000000000000000000000000007B7B7B0000000000000000007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000000000007B000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF007B0000000000000000000000000000007B000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF007B000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF007B00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF000000000000000000000000000000000000000000FFFF
      FF0000000000000000000000000000000000000000007B0000007B0000007B00
      00007B0000007B0000007B0000007B0000007B0000007B0000007B0000007B00
      00007B0000007B0000000000000000000000000000007B0000007B0000007B00
      00007B0000007B0000007B0000007B0000007B0000007B0000007B0000007B00
      00007B0000007B00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000007B000000FFFFFF007B00
      00007B0000007B0000007B0000007B0000007B0000007B0000007B0000007B00
      00007B0000007B0000000000000000000000000000007B000000FFFFFF007B00
      00007B0000007B0000007B0000007B000000FFFFFF007B0000007B0000007B00
      00007B0000007B00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B0000007B0000007B00
      00007B0000007B0000007B0000007B0000007B0000007B0000007B0000007B00
      00007B0000007B0000000000000000000000000000007B0000007B0000007B00
      00007B0000007B0000007B0000007B0000007B0000007B0000007B0000007B00
      00007B0000007B00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B0000007B0000007B0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B0000007B0000007B0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B0000007B0000007B0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000007B7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B0000007B0000007B0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B7B7B0000000000000000000000
      0000000000000000000000000000000000007B0000007B0000007B0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007B7B7B00000000000000000000000000000000000000
      0000000000000000000000000000000000007B0000007B0000007B0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000007B7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B7B000000
      0000000000000000000000000000000000007B0000007B0000007B0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B0000007B0000007B0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B0000007B0000007B0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      7B0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      7B0000007B0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      7B0000007B0000007B0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      7B0000007B0000007B000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      7B0000007B0000007B000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      7B0000007B0000007B000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      7B0000007B0000007B000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      7B0000007B0000007B000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      7B0000007B0000007B000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      7B0000007B0000007B0000FFFF000000000000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      7B0000007B0000007B000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      7B0000007B0000007B000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      7B00FFFF000000007B000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      7B00FFFF0000FFFF00000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000007B7B00007B
      7B00000000000000000000000000000000000000000000000000000000000000
      000000000000007B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000007B7B00007B
      7B00000000000000000000000000000000000000000000000000000000000000
      000000000000007B7B0000000000000000000000000000000000007B7B00007B
      7B00007B7B00007B7B00007B7B00007B7B00007B7B00007B7B00007B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000007B7B00007B
      7B00000000000000000000000000000000000000000000000000000000000000
      000000000000007B7B0000000000000000000000000000FFFF0000000000007B
      7B00007B7B00007B7B00007B7B00007B7B00007B7B00007B7B00007B7B00007B
      7B000000000000000000000000000000000000000000000000000000000000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF0000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000007B7B00007B
      7B00000000000000000000000000000000000000000000000000000000000000
      000000000000007B7B00000000000000000000000000FFFFFF0000FFFF00FFFF
      FF00007B7B00007B7B00007B7B00007B7B00007B7B00007B7B00007B7B00007B
      7B00007B7B00000000000000000000000000000000000000000000000000FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFF
      FF0000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000007B7B00007B
      7B00007B7B00007B7B00007B7B00007B7B00007B7B00007B7B00007B7B00007B
      7B00007B7B00007B7B0000000000000000000000000000FFFF00FFFFFF0000FF
      FF0000000000007B7B00007B7B00007B7B00007B7B00007B7B00007B7B00007B
      7B00007B7B00007B7B00000000000000000000000000000000000000000000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF0000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000007B7B00007B
      7B00000000000000000000000000000000000000000000000000000000000000
      0000007B7B00007B7B00000000000000000000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFF
      FF0000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000007B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000007B7B0000000000000000000000000000FFFF00FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF0000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000007B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000007B7B00000000000000000000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF00000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFF
      FF0000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000007B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000007B7B0000000000000000000000000000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000007B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000007B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000FFFF00FFFFFF0000FFFF000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000007B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B00000000000000000000000000000000007B7B7B0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000007B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000A00000000100010000000000000500000000000000000000
      000000000000000000000000FFFFFF00C001F81F00000000C001E00700000000
      C001C00300000000C001800100000000C001800100000000C001000000000000
      C001000000000000C001000000000000C001000000000000C001000000000000
      C001000000000000C001800100000000C001800100000000C001C00300000000
      C001E00700000000FFFFF81F00000000FC3FFFFFF8FFC001E00FE007E00FC001
      E007E007E003C0018003E0078001C0018003E0078001C0010001E0078001C001
      0001E0078001C0010001E0078001C0010001E0078001C0010001F3CF0001C001
      0001F3CF8003C0018003F3CFC007C0018007F18FE00FC000E00FF81FF01FC001
      F01FF81FF99FC003FFFFFFFFFF9FC00FFE7FC001FE7FF8FFE07FC001FC7FF8F3
      C0018001FC7FF8E1C001C001847FF8E1C001C001807FF8E3C001C001E001F8C7
      C001C001E001F887C001C001807FC007C001C001847F800FC001C001FC7F800F
      C001C001FC7F8007C001C001E47F8007C001C001E07F8007C001C003C007880F
      E001C007C007C01FFE7FC00FE01FF1FFFFFFF801FFFFFE3FC03FC001003FE007
      801F8001003FE007801F8001003F8003801F8001003F8001E01F8001003F8001
      E03F8001003F8001E07F8001003F8001E07F8001003F8001C07F80030020C003
      C07F80070000E007C07F80070000F81FC07F80070000F81FE0FF8007FC00F81F
      F1FFC007FE00F81FFFFFF87FFFFFFC3FFFFFFC3FFC3FFFFFFFFFE007E007C3FF
      80FFE007E007007F800180018001000F800180018001000F800180018001000F
      C00100000000001F818300000000800080830000000080008081000000008001
      80810001000180038181800180018007818180018001800FE383C007C007C01F
      FFC7E007E007E03FFFFFF81FF81FFFFFFFFFFFEFFFFFFFFFF801FFCFFEFFFEFF
      F801E007FFFFFFFFF801C003C27FC27FF8018001FFFFFFFFC0018001C200C200
      C0018001FFFFFFFFC0018001DE07DE07C00F80419E07CE07000F800107FF07FF
      000F80019E00CE00000F8081DE00DE00003F8421FFFFFFFF003F8001C200C200
      003F8003FFFFFFFF003FC007FEFFFEFFFFFFFFFFFFFFFFFFFFFFC007FFFFFFFF
      F183800380038003FBC7000180038003F9C7000180038003F807000180038003
      FD8F000080038003FC8F000080038003FC8F800080038003FE1FC00080038003
      FE1FE00180038003FE1FE00780038003FF3FF00780038003FF7FF00380038003
      FFFFF80380038003FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      1FFFE00FFFFFFFFF1803FFFFFFFFFFFF1FFFFA3FE1CFE07FFFFFF99FF38FF8FF
      FFFFFB9FF38FF8FF1FFFFF1FF30FFC7F1803FE3FF20FFC7F1FFFF8FFF20FFE3F
      FFFFF9DFF04FFE3FFFFFF99FF0CFFF1F1FFFFC5FE087FE0F1803FFFFFFFFFFFF
      1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC007FFFFFFFFFFFFC007FFFFFFFFFFFF
      C007E003FFFFE003C007FFFFC007FFFFC007FC03FFFFFC1FC007FFFFC03FFFFF
      C007E003FFFFE003C007FFFFC007FFFFC007FC03FFFFF80FC007FFFFC03FFFFF
      C007E003FFFFE003C007FFFFC007FFFFC007FC03FFFFFC1FC007FFFFC03FFFFF
      C007FFFFFFFFFFFFC007FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC001FFFFFFFF
      C0078031001FFFFFC0078031000FE007C00780310007C007C00780010003C007
      C00780010001C007C00780010000C007C0078FF1001FC007C0078FF1001FC007
      C0078FF1001FC00FC0078FF18FF1E07FC00F8FF1FFF9E07FC01F8FF5FF75FFFF
      C03F8001FF8FFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object sqlArquivo: TFDQuery
    Connection = DB_Conect.SQLConnection
    SQL.Strings = (
      
        'SELECT CAMINHO, NOMEARQUIVO, DATACADASTRO FROM TRE_TREINAMENTO_A' +
        'RQ Where TRE_TREINAMENTO_ID = :TRE_TREINAMENTO_ID')
    Left = 474
    Top = 236
    ParamData = <
      item
        Name = 'TRE_TREINAMENTO_ID'
        DataType = ftInteger
        ADDataType = dtInt32
        ParamType = ptInput
      end>
    object sqlArquivoCAMINHO: TStringField
      FieldName = 'CAMINHO'
      Origin = 'CAMINHO'
      Size = 100
    end
    object sqlArquivoNOMEARQUIVO: TStringField
      FieldName = 'NOMEARQUIVO'
      Origin = 'NOMEARQUIVO'
      Size = 100
    end
    object sqlArquivoDATACADASTRO: TSQLTimeStampField
      FieldName = 'DATACADASTRO'
      Origin = 'DATACADASTRO'
    end
  end
  object dsArquivo: TDataSource
    DataSet = sqlArquivo
    Left = 402
    Top = 252
  end
  object sqlErroImport: TFDQuery
    Connection = DB_Conect.SQLConnection
    SQL.Strings = (
      'Select * From TRE_ERRO_IMPORTACAO'
      'where TRE_TREINAMENTO_ID = :TRE_TREINAMENTO_ID'
      'order by DATA_IMPORTACAO desc')
    Left = 260
    Top = 263
    ParamData = <
      item
        Name = 'TRE_TREINAMENTO_ID'
        DataType = ftInteger
        ADDataType = dtUInt32
        ParamType = ptInput
      end>
    object sqlErroImportTRE_ERRO_IMPORTACAO_ID: TFDAutoIncField
      FieldName = 'TRE_ERRO_IMPORTACAO_ID'
      Origin = 'TRE_ERRO_IMPORTACAO_ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object sqlErroImportTRE_TREINAMENTO_ID: TIntegerField
      FieldName = 'TRE_TREINAMENTO_ID'
      Origin = 'TRE_TREINAMENTO_ID'
    end
    object sqlErroImportCAMPO: TStringField
      FieldName = 'CAMPO'
      Origin = 'CAMPO'
      Size = 40
    end
    object sqlErroImportMOTIVO: TStringField
      FieldName = 'MOTIVO'
      Origin = 'MOTIVO'
      Size = 100
    end
    object sqlErroImportDATA_IMPORTACAO: TSQLTimeStampField
      FieldName = 'DATA_IMPORTACAO'
      Origin = 'DATA_IMPORTACAO'
    end
  end
  object dsErroImport: TDataSource
    DataSet = sqlErroImport
    Left = 260
    Top = 319
  end
end
