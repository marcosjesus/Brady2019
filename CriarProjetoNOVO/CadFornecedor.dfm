inherited FrmCadFornecedor: TFrmCadFornecedor
  Left = 91
  Top = 68
  Caption = 'Cadastro de Emitente'
  ClientHeight = 659
  ClientWidth = 976
  OldCreateOrder = True
  ExplicitTop = -222
  ExplicitWidth = 992
  ExplicitHeight = 698
  PixelsPerInch = 96
  TextHeight = 13
  inherited PanFundo: TPanel
    Width = 976
    Height = 659
    ExplicitWidth = 976
    ExplicitHeight = 659
    inherited PanTitulo: TPanel
      Width = 972
      TabOrder = 1
      ExplicitWidth = 972
      inherited ImaBarraSup: TImage
        Width = 968
        ExplicitWidth = 827
      end
    end
    inherited StatusBar: TdxStatusBar
      Top = 637
      Width = 972
      ExplicitTop = 637
      ExplicitWidth = 972
    end
    inherited Panel27: TPanel
      Top = 601
      Width = 972
      ExplicitTop = 601
      ExplicitWidth = 972
      inherited ButSalvar: TcxButton
        Top = 0
        ExplicitTop = 0
      end
    end
    object Panel1: TPanel
      Tag = -2
      Left = 2
      Top = 4
      Width = 972
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
        Left = 108
        Top = 2
        Width = 109
        Height = 22
        Hint = 'Clique com o bot'#227'o direito para Pesquisa ou (F1)'
        Alignment = taRightJustify
        Format = foInteger
        TagName = 'CodFornecedor'
        CT_Titulo = 'Localizar Fornecedores'
        CT_TableName = 'fornecedores'
        CT_NumFields = 4
        CT_ColTit = 'C'#243'digo;Fantasia;Raz'#227'o;Endere'#231'o'
        CT_ColField = 'codfornecedor;aliasfornecedor;nome;endereco'
        CT_RetField1 = 0
        CT_RetControl1 = EdiCodigo
        CT_RetField2 = 1
        CT_Test = False
        CT_ConsTab = True
        CT_KeyValue = EdiCodigo
        CT_Search = False
        MaxLength = 10
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
        OnMouseDown = EdiCodigoMouseDown
      end
    end
    object CBXTipo1Int: TComboBox
      Left = 204
      Top = 304
      Width = 145
      Height = 21
      Style = csDropDownList
      TabOrder = 3
      Visible = False
    end
    object CBXTipo2Int: TComboBox
      Left = 400
      Top = 360
      Width = 145
      Height = 21
      Style = csDropDownList
      TabOrder = 4
      Visible = False
    end
    object PgCPrincipal: TcxPageControl
      Tag = -1
      Left = 2
      Top = 31
      Width = 972
      Height = 570
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      Properties.ActivePage = TbSFicha
      Properties.CustomButtons.Buttons = <>
      LookAndFeel.Kind = lfOffice11
      LookAndFeel.NativeStyle = False
      LookAndFeel.SkinName = 'Office2007Blue'
      OnChange = PgCPrincipalChange
      ClientRectBottom = 564
      ClientRectLeft = 3
      ClientRectRight = 966
      ClientRectTop = 26
      object TbSFicha: TcxTabSheet
        Caption = 'Ficha Cadastral'
        ImageIndex = 0
        object Panel2: TPanel
          Tag = -1
          Left = 1
          Top = 4
          Width = 818
          Height = 27
          Alignment = taLeftJustify
          BevelInner = bvLowered
          Caption = 
            '  Raz'#227'o Social                                                  ' +
            '                                                                ' +
            '                                                     Fantasia'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object EdiNome: TrsSuperEdit
            Tag = -1
            Left = 106
            Top = 3
            Width = 359
            Height = 22
            TagName = 'nome'
            CT_NumFields = 0
            CT_RetField1 = 0
            CT_RetField2 = 0
            CT_Test = False
            CT_ConsTab = False
            CT_Search = False
            MaxLength = 100
            Text = ''
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object EdiApelido: TrsSuperEdit
            Tag = -1
            Left = 627
            Top = 3
            Width = 186
            Height = 22
            TagName = 'aliasfornecedor'
            CT_NumFields = 0
            CT_RetField1 = 0
            CT_RetField2 = 0
            CT_Test = False
            CT_ConsTab = False
            CT_Search = False
            MaxLength = 25
            Text = ''
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
        end
        object Panel6: TPanel
          Tag = -1
          Left = 1
          Top = 116
          Width = 818
          Height = 27
          Alignment = taLeftJustify
          BevelInner = bvLowered
          Caption = '  Telefone'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 4
          object EdiTelefone1: TrsSuperEdit
            Tag = -1
            Left = 106
            Top = 3
            Width = 185
            Height = 22
            TagName = 'telefone'
            CT_NumFields = 0
            CT_RetField1 = 0
            CT_RetField2 = 0
            CT_Test = False
            CT_ConsTab = False
            CT_Search = False
            MaxLength = 20
            Text = ''
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
        end
        object Panel10: TPanel
          Tag = -1
          Left = 1
          Top = 32
          Width = 818
          Height = 27
          Alignment = taLeftJustify
          BevelInner = bvLowered
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object lblTipoPessoa: TLabel
            Left = 8
            Top = 8
            Width = 28
            Height = 14
            Caption = 'CNPJ'
          end
          object lblInscricaoRG: TLabel
            Left = 293
            Top = 5
            Width = 50
            Height = 14
            Caption = 'Inscri'#231#227'o'
          end
          object EdtCGC: TrsSuperEdit
            Tag = -1
            Left = 127
            Top = 6
            Width = 0
            Height = 22
            TabStop = False
            TagName = 'cnpj'
            CT_NumFields = 0
            CT_RetField1 = 0
            CT_RetField2 = 0
            CT_Test = False
            CT_ConsTab = False
            CT_Search = False
            MaxLength = 14
            Text = ''
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
          end
          object MEdiCGC: TMaskEdit
            Left = 106
            Top = 4
            Width = 121
            Height = 22
            EditMask = '##\.###\.###\/####\-##;0;_'
            MaxLength = 18
            TabOrder = 0
            Text = ''
          end
          object rsSuperEdit4: TrsSuperEdit
            Tag = -1
            Left = 349
            Top = 3
            Width = 214
            Height = 22
            TagName = 'inscricao'
            CT_NumFields = 0
            CT_RetField1 = 0
            CT_RetField2 = 0
            CT_Test = False
            CT_ConsTab = False
            CT_Search = False
            MaxLength = 20
            Text = ''
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
        end
        object Panel11: TPanel
          Tag = -1
          Left = 1
          Top = 144
          Width = 818
          Height = 27
          Alignment = taLeftJustify
          BevelInner = bvLowered
          Caption = '   E-mail Cobran'#231'a'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 5
          object EdiEmailCob: TrsSuperEdit
            Tag = -1
            Left = 106
            Top = 3
            Width = 707
            Height = 22
            TagName = 'email_cob'
            CT_NumFields = 0
            CT_RetField1 = 0
            CT_RetField2 = 0
            CT_Test = False
            CT_ConsTab = False
            CT_Search = False
            MaxLength = 80
            Text = ''
            CharCase = ecLowerCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
        end
        object Panel4: TPanel
          Tag = -1
          Left = 1
          Top = 60
          Width = 818
          Height = 27
          Alignment = taLeftJustify
          BevelInner = bvLowered
          Caption = 
            '  Cep                                                 Endere'#231'o  ' +
            '                                                                ' +
            '                                                 N'#186'             ' +
            '            Complemento'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          object EdiEnd: TrsSuperEdit
            Tag = -1
            Left = 232
            Top = 3
            Width = 331
            Height = 22
            TagName = 'endereco'
            CT_NumFields = 0
            CT_RetField1 = 0
            CT_RetField2 = 0
            CT_Test = False
            CT_ConsTab = False
            CT_Search = False
            MaxLength = 60
            Text = ''
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
          object EdiComplemento: TrsSuperEdit
            Tag = -1
            Left = 742
            Top = 2
            Width = 72
            Height = 22
            TagName = 'complemento'
            CT_NumFields = 0
            CT_RetField1 = 0
            CT_RetField2 = 0
            CT_Test = False
            CT_ConsTab = False
            CT_Search = False
            MaxLength = 15
            Text = ''
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
          end
          object EdiNum: TrsSuperEdit
            Tag = -1
            Left = 591
            Top = 2
            Width = 62
            Height = 22
            TagName = 'endnum'
            CT_NumFields = 0
            CT_RetField1 = 0
            CT_RetField2 = 0
            CT_Test = False
            CT_ConsTab = False
            CT_Search = False
            MaxLength = 10
            Text = ''
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
          end
          object EdiCEP: TrsSuperEdit
            Tag = -1
            Left = 106
            Top = 2
            Width = 65
            Height = 22
            TabStop = False
            TagName = 'cep'
            CT_NumFields = 0
            CT_RetField1 = 0
            CT_RetField2 = 0
            CT_Test = False
            CT_ConsTab = False
            CT_Search = False
            Text = ''
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
            OnChange = EdiCEPChange
          end
          object mskCEP: TMaskEdit
            Left = 106
            Top = 2
            Width = 65
            Height = 22
            EditMask = '00000\-000;0;_'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            MaxLength = 9
            ParentFont = False
            TabOrder = 0
            Text = ''
            OnExit = mskCEPExit
          end
        end
        object Panel3: TPanel
          Tag = -1
          Left = 1
          Top = 88
          Width = 818
          Height = 27
          Alignment = taLeftJustify
          BevelInner = bvLowered
          Caption = 
            '  Bairro                                                        ' +
            '                             Cidade                             ' +
            '                                                   UF           ' +
            '        '
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          object EdiCidade: TrsSuperEdit
            Tag = -1
            Left = 355
            Top = 4
            Width = 208
            Height = 22
            TagName = 'cidade'
            CT_NumFields = 0
            CT_RetField1 = 0
            CT_RetField2 = 0
            CT_Test = False
            CT_ConsTab = False
            CT_Search = False
            MaxLength = 25
            Text = ''
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
          object EdiUF: TrsSuperEdit
            Tag = -1
            Left = 606
            Top = 3
            Width = 37
            Height = 22
            TabStop = False
            TagName = 'estado'
            CT_NumFields = 0
            CT_RetField1 = 0
            CT_RetField2 = 0
            CT_Test = False
            CT_ConsTab = False
            CT_Search = False
            MaxLength = 50
            Text = ''
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
          end
          object CbxUF: TComboBox
            Tag = -1
            Left = 591
            Top = 3
            Width = 62
            Height = 22
            Style = csDropDownList
            TabOrder = 2
            Items.Strings = (
              'AC'
              'AL'
              'AM'
              'AP'
              'BA'
              'CE'
              'DF'
              'ES'
              'GO'
              'MA'
              'MG'
              'MS'
              'MT'
              'PA'
              'PB'
              'PE'
              'PI'
              'PR'
              'RJ'
              'RN'
              'RO'
              'RR'
              'RS'
              'SC'
              'SE'
              'SP'
              'TO')
          end
          object EdiBairro: TrsSuperEdit
            Tag = -1
            Left = 106
            Top = 3
            Width = 185
            Height = 22
            TagName = 'bairro'
            CT_NumFields = 0
            CT_RetField1 = 0
            CT_RetField2 = 0
            CT_Test = False
            CT_ConsTab = False
            CT_Search = False
            MaxLength = 30
            Text = ''
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
        end
        object Panel5: TPanel
          Tag = -1
          Left = 1
          Top = 174
          Width = 818
          Height = 27
          Alignment = taLeftJustify
          BevelInner = bvLowered
          Caption = 
            '  Site                                                          ' +
            '     '
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 6
          object rsSuperEdit2: TrsSuperEdit
            Tag = -1
            Left = 106
            Top = 3
            Width = 707
            Height = 22
            Hint = '|Duplo-Click para enivar um E-Mail.'
            TagName = 'site'
            CT_NumFields = 0
            CT_RetField1 = 0
            CT_RetField2 = 0
            CT_Test = False
            CT_ConsTab = False
            CT_Search = False
            MaxLength = 40
            Text = ''
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            OnDblClick = EdiEMailDblClick
          end
        end
        object Panel14: TPanel
          Tag = -1
          Left = 1
          Top = 204
          Width = 818
          Height = 27
          Alignment = taLeftJustify
          BevelInner = bvLowered
          Caption = '  Path NFe          '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -10
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 7
          object editPathNfe: TrsSuperEdit
            Left = 106
            Top = 3
            Width = 652
            Height = 22
            Hint = 'Endere'#231'o onde ser'#225' salvo os arquivos XML'
            TagName = 'path_nfe'
            CT_NumFields = 0
            CT_RetField1 = 0
            CT_RetField2 = 0
            CT_Test = False
            CT_ConsTab = False
            CT_Search = False
            MaxLength = 255
            Text = ''
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object EdiFormato: TrsSuperEdit
            Tag = -1
            Left = 656
            Top = 3
            Width = 0
            Height = 22
            TabStop = False
            Options = [soAutoAlign, soShowZero, soShowGray, soAllowspaces, soEnterToTab]
            TagName = 'FormatoDANFE'
            CT_NumFields = 0
            CT_RetField1 = 0
            CT_RetField2 = 0
            CT_Test = False
            CT_ConsTab = False
            CT_Search = False
            Decimals = 0
            Digits = 12
            Text = ''
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            Visible = False
          end
          object cxButton2: TcxButton
            Left = 787
            Top = 1
            Width = 26
            Height = 23
            Hint = 'Configurar pasta para Path NFe'
            OptionsImage.Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000120B0000120B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
              5555555555555555555555555555555555555555555555555555555555555555
              555555555555555555555555555555555555555FFFFFFFFFF555550000000000
              55555577777777775F55500B8B8B8B8B05555775F555555575F550F0B8B8B8B8
              B05557F75F555555575F50BF0B8B8B8B8B0557F575FFFFFFFF7F50FBF0000000
              000557F557777777777550BFBFBFBFB0555557F555555557F55550FBFBFBFBF0
              555557F555555FF7555550BFBFBF00055555575F555577755555550BFBF05555
              55555575FFF75555555555700007555555555557777555555555555555555555
              5555555555555555555555555555555555555555555555555555}
            OptionsImage.NumGlyphs = 2
            TabOrder = 2
            OnClick = cxButton2Click
          end
        end
        object Panel12: TPanel
          Tag = -1
          Left = 0
          Top = 266
          Width = 818
          Height = 27
          Alignment = taLeftJustify
          BevelInner = bvLowered
          Caption = '  Path Inv'#225'lidos'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -10
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 8
          object edipathinvalido: TrsSuperEdit
            Left = 107
            Top = 3
            Width = 652
            Height = 22
            Hint = 'Endere'#231'o onde ser'#225' salvo os arquivos XML'
            TagName = 'path_invalido'
            CT_NumFields = 0
            CT_RetField1 = 0
            CT_RetField2 = 0
            CT_Test = False
            CT_ConsTab = False
            CT_Search = False
            MaxLength = 255
            Text = ''
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object cxButton3: TcxButton
            Left = 788
            Top = 3
            Width = 26
            Height = 23
            Hint = 'Configurar pasta para Path Inv'#225'lidos'
            OptionsImage.Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000120B0000120B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
              5555555555555555555555555555555555555555555555555555555555555555
              555555555555555555555555555555555555555FFFFFFFFFF555550000000000
              55555577777777775F55500B8B8B8B8B05555775F555555575F550F0B8B8B8B8
              B05557F75F555555575F50BF0B8B8B8B8B0557F575FFFFFFFF7F50FBF0000000
              000557F557777777777550BFBFBFBFB0555557F555555557F55550FBFBFBFBF0
              555557F555555FF7555550BFBFBF00055555575F555577755555550BFBF05555
              55555575FFF75555555555700007555555555557777555555555555555555555
              5555555555555555555555555555555555555555555555555555}
            OptionsImage.NumGlyphs = 2
            TabOrder = 1
            OnClick = cxButton3Click
          end
        end
        object GroupBox1: TGroupBox
          Tag = -1
          Left = 1
          Top = 357
          Width = 818
          Height = 106
          Caption = 
            'Configura'#231#227'o Servidor SMTP para recebimento automatico de nfe (x' +
            'ml anexo)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -10
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 9
          object Panel7: TPanel
            Tag = -1
            Left = 4
            Top = 17
            Width = 809
            Height = 27
            Alignment = taLeftJustify
            BevelInner = bvLowered
            Caption = 
              '  Host                                                          ' +
              '                                  Porta                         ' +
              '                Autentica'#231#227'o SSL        (S/N)          '
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object EdiHost: TrsSuperEdit
              Tag = -1
              Left = 98
              Top = 3
              Width = 183
              Height = 22
              Options = [soAutoAlign, soShowZero, soShowGray, soAllowspaces, soEnterToTab]
              TagName = 'host'
              CT_NumFields = 0
              CT_RetField1 = 0
              CT_RetField2 = 0
              CT_Test = False
              CT_ConsTab = False
              CT_MensErro = 'Informe o Host'
              CT_Search = False
              Decimals = 0
              Digits = 12
              Text = ''
              CharCase = ecLowerCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
            end
            object rsSuperEdit9: TrsSuperEdit
              Tag = -1
              Left = 377
              Top = 4
              Width = 49
              Height = 22
              Options = [soAutoAlign, soShowZero, soShowGray, soAllowspaces, soEnterToTab]
              TagName = 'porta'
              CT_NumFields = 0
              CT_RetField1 = 0
              CT_RetField2 = 0
              CT_Test = False
              CT_ConsTab = False
              CT_MensErro = 'Informe a porta de conex'#227'o'
              CT_Search = False
              Decimals = 0
              Digits = 12
              Text = ''
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
            end
            object rsSuperEdit16: TrsSuperEdit
              Tag = -1
              Left = 560
              Top = 3
              Width = 19
              Height = 22
              Options = [soAutoAlign, soShowZero, soShowGray, soAllowspaces, soEnterToTab]
              TagName = 'ssl'
              CT_NumFields = 0
              CT_RetField1 = 0
              CT_RetField2 = 0
              CT_Test = False
              CT_ConsTab = False
              CT_MensErro = 'Informe se a conta usa SSL para autentica'#231#227'o Ex: Google'
              CT_Search = False
              Decimals = 0
              Digits = 12
              MaxLength = 1
              Text = 'N'
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
            end
          end
          object Panel8: TPanel
            Tag = -1
            Left = 5
            Top = 45
            Width = 808
            Height = 27
            Alignment = taLeftJustify
            BevelInner = bvLowered
            Caption = 
              '  E-mail                                                        ' +
              '                                Senha'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            object rsSuperEdit15: TrsSuperEdit
              Tag = -1
              Left = 97
              Top = 5
              Width = 183
              Height = 22
              Options = [soAutoAlign, soShowZero, soShowGray, soAllowspaces, soEnterToTab]
              TagName = 'emailsistema'
              CT_NumFields = 0
              CT_RetField1 = 0
              CT_RetField2 = 0
              CT_Test = False
              CT_ConsTab = False
              CT_MensErro = 'Informe o e-mail padr'#227'o'
              CT_Search = False
              Decimals = 0
              Digits = 12
              Text = ''
              CharCase = ecLowerCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
            end
            object EdiSenha: TrsSuperEdit
              Tag = -1
              Left = 376
              Top = 3
              Width = 78
              Height = 22
              TagName = 'senha'
              CT_NumFields = 0
              CT_RetField1 = 0
              CT_RetField2 = 0
              CT_Test = False
              CT_ConsTab = False
              CT_Search = False
              MaxLength = 20
              Text = ''
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              PasswordChar = '*'
              TabOrder = 1
            end
          end
          object Panel16: TPanel
            Tag = -1
            Left = 5
            Top = 73
            Width = 808
            Height = 27
            Alignment = taLeftJustify
            BevelInner = bvLowered
            Caption = 
              '  Pasta Default                                                 ' +
              '                           Pasta SPAM          '
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 2
            object rsSuperEdit3: TrsSuperEdit
              Tag = -1
              Left = 376
              Top = 3
              Width = 183
              Height = 22
              Options = [soAutoAlign, soShowZero, soShowGray, soAllowspaces, soEnterToTab]
              TagName = 'pastaspam'
              CT_NumFields = 0
              CT_RetField1 = 0
              CT_RetField2 = 0
              CT_Test = False
              CT_ConsTab = False
              CT_MensErro = 'Informe o e-mail padr'#227'o'
              CT_Search = False
              Decimals = 0
              Digits = 12
              Text = ''
              CharCase = ecLowerCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
            end
            object editpastadefault: TrsSuperEdit
              Left = 98
              Top = 3
              Width = 183
              Height = 22
              Options = [soAutoAlign, soShowZero, soShowGray, soAllowspaces, soEnterToTab]
              TagName = 'pastadefault'
              CT_NumFields = 0
              CT_RetField1 = 0
              CT_RetField2 = 0
              CT_Test = False
              CT_ConsTab = False
              CT_MensErro = 'Informe o e-mail padr'#227'o'
              CT_Search = False
              Decimals = 0
              Digits = 12
              Text = ''
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
            end
          end
        end
        object Panel13: TPanel
          Tag = -1
          Left = 0
          Top = 234
          Width = 819
          Height = 27
          Alignment = taLeftJustify
          BevelInner = bvLowered
          Caption = '  Path Importados'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -10
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 10
          object edipathimportado: TrsSuperEdit
            Left = 107
            Top = 3
            Width = 652
            Height = 22
            Hint = 'Endere'#231'o onde ser'#225' salvo os arquivos XML'
            TagName = 'path_importado'
            CT_NumFields = 0
            CT_RetField1 = 0
            CT_RetField2 = 0
            CT_Test = False
            CT_ConsTab = False
            CT_Search = False
            MaxLength = 255
            Text = ''
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object cxButton4: TcxButton
            Left = 787
            Top = 4
            Width = 26
            Height = 23
            Hint = 'Configurar pasta para Path Importados'
            OptionsImage.Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000120B0000120B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
              5555555555555555555555555555555555555555555555555555555555555555
              555555555555555555555555555555555555555FFFFFFFFFF555550000000000
              55555577777777775F55500B8B8B8B8B05555775F555555575F550F0B8B8B8B8
              B05557F75F555555575F50BF0B8B8B8B8B0557F575FFFFFFFF7F50FBF0000000
              000557F557777777777550BFBFBFBFB0555557F555555557F55550FBFBFBFBF0
              555557F555555FF7555550BFBFBF00055555575F555577755555550BFBF05555
              55555575FFF75555555555700007555555555557777555555555555555555555
              5555555555555555555555555555555555555555555555555555}
            OptionsImage.NumGlyphs = 2
            TabOrder = 1
            OnClick = cxButton4Click
          end
        end
        object Panel9: TPanel
          Tag = -1
          Left = 1
          Top = 295
          Width = 818
          Height = 27
          Alignment = taLeftJustify
          BevelInner = bvLowered
          Caption = '  Path Excel(xlsx)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -10
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 11
          object editpathexcel: TrsSuperEdit
            Left = 107
            Top = 3
            Width = 652
            Height = 22
            Hint = 'Endere'#231'o onde ser'#225' salvo os arquivos XLSX'
            TagName = 'path_excel'
            CT_NumFields = 0
            CT_RetField1 = 0
            CT_RetField2 = 0
            CT_Test = False
            CT_ConsTab = False
            CT_Search = False
            MaxLength = 255
            Text = ''
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object cxButton1: TcxButton
            Left = 788
            Top = 3
            Width = 26
            Height = 23
            Hint = 'Configurar pasta para Path Excel'
            OptionsImage.Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000120B0000120B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
              5555555555555555555555555555555555555555555555555555555555555555
              555555555555555555555555555555555555555FFFFFFFFFF555550000000000
              55555577777777775F55500B8B8B8B8B05555775F555555575F550F0B8B8B8B8
              B05557F75F555555575F50BF0B8B8B8B8B0557F575FFFFFFFF7F50FBF0000000
              000557F557777777777550BFBFBFBFB0555557F555555557F55550FBFBFBFBF0
              555557F555555FF7555550BFBFBF00055555575F555577755555550BFBF05555
              55555575FFF75555555555700007555555555557777555555555555555555555
              5555555555555555555555555555555555555555555555555555}
            OptionsImage.NumGlyphs = 2
            TabOrder = 1
            OnClick = cxButton1Click
          end
        end
        object Panel15: TPanel
          Tag = -1
          Left = 1
          Top = 324
          Width = 818
          Height = 27
          Alignment = taLeftJustify
          BevelInner = bvLowered
          Caption = '  Path Temp(xml)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -10
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 12
          object editpathtemp: TrsSuperEdit
            Left = 107
            Top = 3
            Width = 652
            Height = 22
            Hint = 'Endere'#231'o onde ser'#225' salvo os arquivos XLSX'
            TagName = 'path_temp'
            CT_NumFields = 0
            CT_RetField1 = 0
            CT_RetField2 = 0
            CT_Test = False
            CT_ConsTab = False
            CT_Search = False
            MaxLength = 255
            Text = ''
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object cxButton5: TcxButton
            Left = 788
            Top = 3
            Width = 26
            Height = 23
            Hint = 'Configurar pasta para Path Temp (XML)'
            OptionsImage.Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000120B0000120B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
              5555555555555555555555555555555555555555555555555555555555555555
              555555555555555555555555555555555555555FFFFFFFFFF555550000000000
              55555577777777775F55500B8B8B8B8B05555775F555555575F550F0B8B8B8B8
              B05557F75F555555575F50BF0B8B8B8B8B0557F575FFFFFFFF7F50FBF0000000
              000557F557777777777550BFBFBFBFB0555557F555555557F55550FBFBFBFBF0
              555557F555555FF7555550BFBFBF00055555575F555577755555550BFBF05555
              55555575FFF75555555555700007555555555557777555555555555555555555
              5555555555555555555555555555555555555555555555555555}
            OptionsImage.NumGlyphs = 2
            TabOrder = 1
            OnClick = cxButton5Click
          end
        end
      end
      object tbsContatos: TcxTabSheet
        Caption = 'Contatos'
        ImageIndex = 1
        object Panel20: TPanel
          Tag = -1
          Left = 0
          Top = 0
          Width = 963
          Height = 538
          Align = alClient
          BevelInner = bvLowered
          Caption = 'Panel20'
          TabOrder = 0
          object Panel21: TPanel
            Left = 864
            Top = 2
            Width = 97
            Height = 534
            Align = alRight
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 0
            object ButNovoItem: TcxButton
              Left = 4
              Top = 4
              Width = 89
              Height = 25
              Hint = '|Inclui novo contato para esse fornecedor.'
              Caption = '&Novo'
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              OnClick = ButNovoItemClick
            end
            object ButAlterarItem: TcxButton
              Left = 4
              Top = 32
              Width = 89
              Height = 25
              Hint = '|Altera os dados do contato selecionado.'
              Caption = '&Alterar'
              ParentShowHint = False
              ShowHint = True
              TabOrder = 1
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              OnClick = ButAlterarItemClick
            end
            object ButExcluirItem: TcxButton
              Left = 4
              Top = 60
              Width = 89
              Height = 25
              Hint = '|Apaga os dados do contato selecionado.'
              Caption = '&Excluir'
              ParentShowHint = False
              ShowHint = True
              TabOrder = 2
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              OnClick = ButExcluirItemClick
            end
            object ButSalvarItem: TcxButton
              Left = 6
              Top = 99
              Width = 89
              Height = 25
              Hint = '|Confirma Inclus'#227'o/Altera'#231#227'o do contato.'
              Caption = 'Con&firmar'
              Enabled = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 3
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              OnClick = ButSalvarItemClick
            end
            object ButCAncelarItem: TcxButton
              Left = 4
              Top = 130
              Width = 89
              Height = 25
              Hint = '|Ignora Inclus'#227'o/Altera'#231#227'o do contato.'
              Caption = '&Cancelar'
              Enabled = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 4
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              OnClick = ButCAncelarItemClick
            end
          end
          object PageControl: TcxPageControl
            Left = 2
            Top = 2
            Width = 862
            Height = 534
            Align = alClient
            TabOrder = 1
            Properties.ActivePage = TbSGrade
            Properties.CustomButtons.Buttons = <>
            ClientRectBottom = 530
            ClientRectLeft = 4
            ClientRectRight = 858
            ClientRectTop = 4
            object TbSGrade: TcxTabSheet
              Caption = 'TbSGrade'
              TabVisible = False
              object cxGrid2: TcxGrid
                Left = 0
                Top = 0
                Width = 854
                Height = 526
                Align = alClient
                TabOrder = 0
                LookAndFeel.NativeStyle = False
                LookAndFeel.SkinName = 'Blue'
                object DBGContatos: TcxGridDBTableView
                  Navigator.Buttons.CustomButtons = <>
                  DataController.DataSource = DtSContatos
                  DataController.Summary.DefaultGroupSummaryItems = <>
                  DataController.Summary.FooterSummaryItems = <>
                  DataController.Summary.SummaryGroups = <>
                  OptionsBehavior.ColumnHeaderHints = False
                  OptionsCustomize.ColumnFiltering = False
                  OptionsCustomize.ColumnGrouping = False
                  OptionsCustomize.ColumnHidingOnGrouping = False
                  OptionsCustomize.ColumnHorzSizing = False
                  OptionsCustomize.ColumnMoving = False
                  OptionsCustomize.ColumnSorting = False
                  OptionsData.CancelOnExit = False
                  OptionsData.Deleting = False
                  OptionsData.DeletingConfirmation = False
                  OptionsData.Editing = False
                  OptionsData.Inserting = False
                  OptionsSelection.MultiSelect = True
                  OptionsView.GroupByBox = False
                  OptionsView.Indicator = True
                  object cxGrid1DBTableView1ChaveSeq: TcxGridDBColumn
                    DataBinding.FieldName = 'ChaveSeq'
                    Visible = False
                  end
                  object cxGrid1DBTableView1CodCliente: TcxGridDBColumn
                    DataBinding.FieldName = 'CodCliente'
                    Visible = False
                  end
                  object cxGrid1DBTableView1Nome_3: TcxGridDBColumn
                    DataBinding.FieldName = 'Nome'
                    Width = 250
                  end
                  object cxGrid1DBTableView1E_Mail: TcxGridDBColumn
                    Caption = 'E-Mail'
                    DataBinding.FieldName = 'E_Mail'
                    Width = 250
                  end
                  object cxGrid1DBTableView1DescTipo1: TcxGridDBColumn
                    Caption = '...'
                    DataBinding.FieldName = 'DescTipo1'
                    Width = 85
                  end
                  object cxGrid1DBTableView1Numero1_3: TcxGridDBColumn
                    Caption = 'Numero'
                    DataBinding.FieldName = 'Numero1'
                    Width = 100
                  end
                  object cxGrid1DBTableView1DescTipo2: TcxGridDBColumn
                    Caption = '...'
                    DataBinding.FieldName = 'DescTipo2'
                    Width = 85
                  end
                  object cxGrid1DBTableView1Numero2_3: TcxGridDBColumn
                    Caption = 'Numero 2'
                    DataBinding.FieldName = 'Numero2'
                    Width = 100
                  end
                  object cxGrid1DBTableView1DescFuncao: TcxGridDBColumn
                    Caption = 'Cargo'
                    DataBinding.FieldName = 'DescFuncao'
                    Width = 200
                  end
                  object cxGrid1DBTableView1codprofissao: TcxGridDBColumn
                    DataBinding.FieldName = 'codprofissao'
                    Visible = False
                  end
                  object cxGrid1DBTableView1DescProfissao: TcxGridDBColumn
                    Caption = 'Profiss'#227'o'
                    DataBinding.FieldName = 'DescProfissao'
                    Width = 200
                  end
                  object cxGrid1DBTableView1CodFuncao: TcxGridDBColumn
                    DataBinding.FieldName = 'CodFuncao'
                    Visible = False
                  end
                  object cxGrid1DBTableView1Tipo1_3: TcxGridDBColumn
                    DataBinding.FieldName = 'Tipo1'
                    Visible = False
                  end
                  object cxGrid1DBTableView1Tipo2_3: TcxGridDBColumn
                    DataBinding.FieldName = 'Tipo2'
                    Visible = False
                  end
                end
                object cxGridLevel1: TcxGridLevel
                  GridView = DBGContatos
                end
              end
            end
            object TbSEdicao: TcxTabSheet
              Caption = 'TbSEdicao'
              ImageIndex = 1
              TabVisible = False
              object Panel24: TPanel
                Tag = -1
                Left = 0
                Top = 2
                Width = 681
                Height = 27
                Alignment = taLeftJustify
                BevelInner = bvLowered
                Caption = 
                  '  Nome                                                          ' +
                  '                                                         E-mail'
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 0
                object EdiNomeCont: TrsSuperEdit
                  Left = 88
                  Top = 2
                  Width = 278
                  Height = 22
                  CT_NumFields = 0
                  CT_RetField1 = 0
                  CT_RetField2 = 0
                  CT_Test = False
                  CT_ConsTab = False
                  CT_Search = False
                  MaxLength = 50
                  Text = ''
                  CharCase = ecUpperCase
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clBlack
                  Font.Height = -11
                  Font.Name = 'Arial'
                  Font.Style = []
                  ParentFont = False
                  TabOrder = 0
                end
                object EdiMailCont: TrsSuperEdit
                  Left = 437
                  Top = 2
                  Width = 234
                  Height = 22
                  TagName = '0'
                  CT_NumFields = 0
                  CT_RetField1 = 0
                  CT_RetField2 = 0
                  CT_Test = False
                  CT_ConsTab = False
                  CT_Search = False
                  MaxLength = 50
                  Text = ''
                  CharCase = ecLowerCase
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clBlack
                  Font.Height = -11
                  Font.Name = 'Arial'
                  Font.Style = []
                  ParentFont = False
                  TabOrder = 1
                end
              end
              object Panel22: TPanel
                Tag = -1
                Left = 0
                Top = 29
                Width = 681
                Height = 27
                Alignment = taLeftJustify
                BevelInner = bvLowered
                Caption = '  Telefone 1                                                Tipo'
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 1
                object EdiFone1: TrsSuperEdit
                  Left = 88
                  Top = 2
                  Width = 113
                  Height = 22
                  CT_NumFields = 0
                  CT_RetField1 = 0
                  CT_RetField2 = 0
                  CT_Test = False
                  CT_ConsTab = False
                  CT_Search = False
                  MaxLength = 50
                  Text = ''
                  CharCase = ecUpperCase
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'Arial'
                  Font.Style = []
                  ParentFont = False
                  TabOrder = 0
                end
                object Tipo1Cont: TComboBox
                  Tag = 1
                  Left = 239
                  Top = 3
                  Width = 127
                  Height = 22
                  Style = csDropDownList
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'Arial'
                  Font.Style = []
                  ParentFont = False
                  TabOrder = 1
                  Items.Strings = (
                    '1 - Resid'#234'ncial'
                    '2 - Comercial'
                    '3 - Fax'
                    '4 - Celular'
                    '5 - Nextel'
                    '6 - Contato/Recado')
                end
              end
              object Panel17: TPanel
                Tag = -1
                Left = 0
                Top = 56
                Width = 681
                Height = 27
                Alignment = taLeftJustify
                BevelInner = bvLowered
                Caption = '  Telefone 2                                                Tipo'
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 2
                object EdiFone2: TrsSuperEdit
                  Left = 88
                  Top = 2
                  Width = 113
                  Height = 22
                  CT_NumFields = 0
                  CT_RetField1 = 0
                  CT_RetField2 = 0
                  CT_Test = False
                  CT_ConsTab = False
                  CT_Search = False
                  MaxLength = 50
                  Text = ''
                  CharCase = ecUpperCase
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'Arial'
                  Font.Style = []
                  ParentFont = False
                  TabOrder = 0
                end
                object Tipo2Cont: TComboBox
                  Tag = 1
                  Left = 239
                  Top = 2
                  Width = 127
                  Height = 22
                  Style = csDropDownList
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'Arial'
                  Font.Style = []
                  ParentFont = False
                  TabOrder = 1
                  Items.Strings = (
                    '1 - Resid'#234'ncial'
                    '2 - Comercial'
                    '3 - Fax'
                    '4 - Celular'
                    '5 - Nextel'
                    '6 - Contato/Recado')
                end
              end
              object Panel25: TPanel
                Tag = -1
                Left = 0
                Top = 83
                Width = 681
                Height = 27
                Alignment = taLeftJustify
                BevelInner = bvLowered
                Caption = 
                  '  Cargo                                                         ' +
                  '                                                       Profiss'#227'o'
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 3
                object EditCargo: TEditBusca
                  Left = 88
                  Top = 3
                  Width = 278
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
                object EditProfissao: TEditBusca
                  Left = 437
                  Top = 3
                  Width = 234
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
            end
          end
        end
      end
    end
  end
  object dspContatos: TDataSetProvider
    DataSet = QryContatos
    Left = 915
    Top = 308
  end
  object cdsContatos: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspContatos'
    Left = 892
    Top = 343
  end
  object DtSContatos: TDataSource
    AutoEdit = False
    DataSet = cdsContatos
    Left = 892
    Top = 460
  end
  object QryAux: TFDQuery
    Connection = FDConnection
    Left = 893
    Top = 217
  end
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=DB_Loja'
      'User_Name=postgres'
      'Password=123'
      'DriverID=PG')
    Left = 901
    Top = 145
  end
  object QryContatos: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'select  chaveseq, a.codfornecedor, nome, numero1, '
      
        'numero2, e_mail, descfuncao, a.codprofissao, descprofissao, a.co' +
        'dfuncao,  '
      
        'coalesce(tipo1, -1) as tipo1_3, coalesce(tipo2, -1) as tipo2_3, ' +
        '  '
      
        '(select desctpfone from tipofone where codtipofone = tipo1) as d' +
        'esctipo1, '
      
        '(select desctpfone from tipofone where codtipofone = tipo2) as d' +
        'esctipo2 '
      
        'from contatos_fornecedores a left join funcao b on a.codfuncao =' +
        ' b.codfuncao '
      'left join profissao p on a.codprofissao = p.codprofissao '
      'where codfornecedor = 21 order by nome_3')
    Left = 885
    Top = 409
  end
end
