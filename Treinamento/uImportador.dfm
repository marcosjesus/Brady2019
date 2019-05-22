object frmImportador: TfrmImportador
  Left = 0
  Top = 0
  Caption = 'Importa Documentos XML'
  ClientHeight = 442
  ClientWidth = 987
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 987
    Height = 85
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Panel13: TPanel
      Tag = -2
      Left = 0
      Top = 0
      Width = 987
      Height = 54
      Align = alTop
      Alignment = taLeftJustify
      BevelInner = bvLowered
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object btnLocalizar: TcxButton
        Left = 6
        Top = 4
        Width = 164
        Height = 46
        Hint = 'Localizar XML de CTe/NFe/CCe'
        Caption = 'Localizar XML'
        LookAndFeel.Kind = lfOffice11
        LookAndFeel.NativeStyle = False
        LookAndFeel.SkinName = 'Office2007Blue'
        OptionsImage.Glyph.Data = {
          F6060000424DF606000000000000360000002800000018000000180000000100
          180000000000C0060000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FF25A8D625A8D625A8D658CAE843BCE12DAFDA20A7D61AA3D4FF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FF17A3D3A9DFF0B8FFFF99FEFF96F9FF91F2FD81
          E7F86BD7F055C9E93FBAE129ADD91EA6D518A2D3FF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF12A2D363BFE1CBFEFF8FFB
          FF94FAFF94FAFF95FAFF98FAFF97F9FF90F4FF89EDFC75DFF45FD0ED4AC2E634
          B4DD23A9D71CA5D51BA5D4FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF20A8D6
          40B4DCC5F1F99AFDFF92F9FF93F8FF92F7FF91F6FF90F5FF8FF6FF90F4FF91F5
          FF93F6FF90F3FF8AEEFD81E7FA64D3F12EB0DDFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FF2AACD85AC8E793D5EBB7FFFF8FF9FF93F8FF92F7FF91F6FF90F5FF
          8EF5FF8EF3FF8DF2FE8CF1FE8BF0FE8BF1FE8DF2FF80E7FE59CCF01FA7D6FF00
          FFFF00FFFF00FFFF00FFFF00FF27AAD77EE2F360C4E4CAFAFE90FAFF92F8FF92
          F7FF91F6FF90F5FF8EF5FF8EF3FF8DF2FE8CF1FE8BF0FE8AF0FE8BF0FE78E2FB
          73DDFA3CBBE0FF00FFFF00FFFF00FFFF00FFFF00FF26A9D797F1FB52CBE6B8E6
          F49FFDFF91F8FF92F7FF91F6FF90F5FF8EF5FF8EF3FF8DF2FE8CF1FE8BF0FE8C
          F1FE8BF0FE78E1FB78E1FC66D6EF18A2D3FF00FFFF00FFFF00FFFF00FF26A9D7
          9CF3FC67DFF188CFE8BEFFFF8CF8FF91F7FF91F6FF06770C07760D06760C0674
          0B05700A8BF0FE8AF0FE8BF0FE78E1FB74DEFA8AEEFC28ADD9FF00FFFF00FFFF
          00FFFF00FF26A9D798F0FA8CF8FD4BBBDFCFF4FBA3FDFF93F9FF05700906740C
          0C83160D91190C97180A9015087D0E06770C8BF0FE78E1FB71DCF999F9FF4CC6
          E6FF00FFFF00FFFF00FFFF00FF27A9D797F0FA9BFFFF5AD4EC5FBDE0BAE7F3C1
          F1F9C3F5FCC0F6FDBEFBFF9FF8FF0984120E9E190FA61C098A1305700A78E1FB
          71DCF999F8FF77E2F51CA5D4FF00FFFF00FFFF00FF29AAD79DF2FB96FEFF95FB
          FF64DAEF56CBE857C7E65FC6E566C5E472C6E4BCE8F4B1FAFF06750C0E9D190F
          A81D09871206770C71DCF994F5FF92F4FF36B7DFFF00FFFF00FFFF00FF29AAD7
          9DF3FB95FDFF95FAFF99FDFF97FCFF91F7FF8AF3FE85F1FC61D9F03FB8DEAFDF
          F0C6FBFF0A831311AA200C9D1906770C6BDBF98FF5FF95F9FF5DD3EEFF00FFFF
          00FFFF00FF28AAD79CF3FB96FDFF94FAFF93F9FF93F8FF93F8FF92F7FF91F6FF
          95F9FF7CEAF941BDE17ECAE508770F19A92B12AA2206770CA8EAFCBEFBFFBEFD
          FFABF3FD2DADD9FF00FFFF00FF29ABD79EF4FC96FDFF94FAFF93F9FF93F8FF92
          F7FF91F6FF90F5FF8EF5FF92F6FF8CF2FE5DD5EE06730C23AD3921B83806770C
          6EC5E475C8E57FCCE785CFE931AED9FF00FFFF00FF2BABD8A5F8FD94FDFF94FA
          FF93F9FF93F8FF92F7FF91F6FF8FF6FF8DF6FF05720A05720A05720A08771030
          BB4D2EC24B06770C06770C05720A05710AFF00FFFF00FFFF00FFFF00FF2AAAD7
          B3F4FA96FDFF93FAFF93F9FF93F8FF91F7FF92F7FF9FF3FDA1F2FD05720A21AE
          3534AF513BBB5C44CE6939C75A2DBC4921AE3521AE35047009FF00FFFF00FFFF
          00FFFF00FF16A3D37ACDE8B5FFFF97FEFF95FCFF93FAFF93FBFF85EEFB31B0DA
          30ADD838B2DB05720A2FAA4B5FEB9355DE8348D36F21AE3522A83806730BFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FF21A6D582D5EC94E5F397E8F69EEDF9A7
          F4FB5ACBE814A1D2FF00FFFF00FFFF00FF006B0232AF505EE8915AE58B3ABE5A
          08750EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF19A3D422A6
          D526A7D62AA9D62BAAD71FA6D5FF00FFFF00FFFF00FFFF00FFFF00FF05720B3F
          BF624FD47911811CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FF0C7B1413841FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 0
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnLocalizarClick
      end
      object cxGroupBox2: TcxGroupBox
        Left = 216
        Top = 3
        Caption = 'Localizar na Pasta'
        TabOrder = 1
        Height = 47
        Width = 577
        object edtCaminho: TEdit
          Left = 15
          Top = 17
          Width = 394
          Height = 22
          TabOrder = 0
        end
        object btnCaminho: TBitBtn
          Left = 415
          Top = 15
          Width = 75
          Height = 25
          Caption = 'Selecionar'
          TabOrder = 1
          OnClick = btnCaminhoClick
        end
        object BitBtn1: TBitBtn
          Left = 493
          Top = 15
          Width = 75
          Height = 25
          Caption = 'Limpar'
          TabOrder = 2
          OnClick = BitBtn1Click
        end
      end
    end
    object Panel2: TPanel
      Left = 0
      Top = 54
      Width = 987
      Height = 28
      Align = alTop
      Alignment = taLeftJustify
      BevelInner = bvLowered
      TabOrder = 1
      object lblLocal: TLabel
        Left = 9
        Top = 5
        Width = 32
        Height = 13
        Caption = 'Local:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 401
    Width = 987
    Height = 41
    Align = alBottom
    TabOrder = 1
    object btnImportar: TcxButton
      Left = 78
      Top = 4
      Width = 83
      Height = 33
      Hint = 'Importar XML de Cte'
      Caption = 'Importar'
      LookAndFeel.Kind = lfOffice11
      LookAndFeel.NativeStyle = False
      LookAndFeel.SkinName = 'Office2007Blue'
      OptionsImage.Glyph.Data = {
        F6060000424DF606000000000000360000002800000018000000180000000100
        180000000000C0060000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FF92635DA46769A46769A46769A46769A46769A46769A46769A46769A467
        69A46769A46769A46769A46769A46769A46769A46769A46769A46769FF00FFFF
        00FFFF00FFFF00FFFF00FF93655EFFDCB7FFDAB5FED9B1FED8AFFED7ABFED5A7
        FED4A5FED3A3FED0A0FECF9FFECE9DFECE9AFECC98FECB96FECB96FECB96FECB
        969F6F60FF00FFFF00FFFF00FFFF00FFFF00FF93655FFEDEBCFEDDB8FFDAB5FE
        D9B2FED8AFFED7ABFED5AAFED4A6FED3A4FED0A0FECF9EFECF9DFECE9CFECE99
        FECC97FECB96FECB969F6F60FF00FFFF00FFFF00FFFF00FFFF00FF93655FFFE1
        C1FEE0BDFEDDBAFEDCB6FEDAB2FED8B0FED8ADFED5AAFED4A7FED3A4FED1A300
        8100FECF9DFFCE9CFECE99FECC98FECC979F6F60FF00FFFF00FFFF00FFFF00FF
        FF00FF93655FFFE3C5FEE1C1FFE0BDFFDEBBFEDCB7FEDAB4FED9B1FFD8ADFED5
        ABFED4A9008100008100008100FED09EFECF9DFECC99FECC989F6F60FF00FFFF
        00FFFF00FFFF00FFFF00FF936560FFE5CAFEE3C6D58127D58127D58127D58127
        D58127D58127FED8AF008100327725648E43008100548437FECF9EFECE9CFECE
        9A9F6F60FF00FFFF00FFFF00FFFF00FFFF00FF956660FFE7CEFFE5CBFFE5C7FE
        E2C4FEE0C0FEE0BCFFDDBAFEDCB6FFDAB2008100F6D3A7FFD5AAAFB174008100
        008100F8CE9CFECF9D9F6F60FF00FFFF00FFFF00FFFF00FFFF00FF986963FFEA
        D3FEE9CFFFE6CCFEE5C9FEE3C4FEE1C1FEE0BDFFDEBBFEDCB6FEDAB4FED9B1FE
        D7ADFED5ABEECE9E008100008100FFD09F9F6F60FF00FFFF00FFFF00FFFF00FF
        FF00FF9E6E64FFEBD8FEEBD4FEE9D0FEE6CEFEE5CAFEE3C6FFE1C2FEE0BFFFDE
        BCFEDCB7FEDAB5FED9B1FED7AFFED7ABFED4A9FFD4A5FED1A39F6F60FF00FFFF
        00FFFF00FFFF00FFFF00FFA37266FEEEDCFFEDD8FEEAD4FEE9D1FFE7CEFEE6CB
        FFE3C6FEE2C4FEE1C0FEDEBCFFDDB8008100FED9B2FED9AFFED7ABFED5A9FED4
        A69F6F60FF00FFFF00FFFF00FFFF00FFFF00FFA77568FFF0E0FEEEDDFEEDD9FF
        EBD5FFE9D1FFE7CFFEE6CBFFE3C7FEE3C4FEE1C1008100008100008100FFDAB2
        FED8B0FED8ADFED5AA9F6F62FF00FFFF00FFFF00FFFF00FFFF00FFAC7969FFF2
        E5FFF2E2D58127D58127D58127D58127D58127D58127FFE5C9008100327A2964
        934C00810054893EFEDAB5FED9B1FED7ADA07063FF00FFFF00FFFF00FFFF00FF
        FF00FFB17E6BFFF4E9FFF2E6FFF0E2FEEFE0FFEEDCFFEBD8FFEAD4FEE9D1FEE7
        CC008100F6E0C0FEE2C2AFBA84008100008100F8D9B1FED9B1A07264FF00FFFF
        00FFFF00FFFF00FFFF00FFB6816CFFF7EDFFF4EAFFF3E7FFF2E2FEEFE0FFEEDC
        FFEDD9FFEBD5FEEAD1FFE7CFFEE6CAFFE3C7FFE2C2EED9B5008100008100FEDC
        B69D7065FF00FFFF00FFFF00FFFF00FFFF00FFBB846EFFF8EFFEF7EEFEF6EBFF
        F3E7FEF2E5FFF0E1FFEEDEFFEDD9FEEBD7FEEAD3FEE9CFFEE6CCFFE5C7FEE3C5
        FEE1C1FEE0BDFEDDBB896A63FF00FFFF00FFFF00FFFF00FFFF00FFC0896FFFFA
        F3FFF8F2FFF7EEFFF6EAFFF4E7FEF3E6FFF2E1FFEFDEFFEDDAFFEDD7FFEAD400
        8100FEE7CCFEE5C9FFE3C6FFE1C2FEE1BF806762FF00FFFF00FFFF00FFFF00FF
        FF00FFC58C70FFFCF7FEFAF4FFF8F2FFF7EFFFF6EDFFF4E9FFF3E6FFF0E3FFF0
        DEFEEEDC008100008100008100FFE7CEFFE6CBFEE3C7FFE2C2846964FF00FFFF
        00FFFF00FFFF00FFFF00FFCB9173FFFCFAFFFBF8D58127D58127D58127D58127
        D58127D58127FEF2E3008100327D2E649956008100548F47FFE7CFFFE6CBFFE5
        C7986859FF00FFFF00FFFF00FFFF00FFFF00FFCF9674FFFEFCFFFEFBFFFBF8FF
        FAF6FEFAF3FFF8F0FFF6EEFFF4EBFEF3E7008100F7EEDAFFEFDEAFC497008100
        008100F8E6CBFFE7CBA5686BFF00FFFF00FFFF00FFFF00FFFF00FFD49875FFFE
        FFFFFEFCFFFEFAFFFBF8FFFBF6FFFAF3FFF8F2FFF8EFFFF6EBFFF4E9FFF3E5FF
        F2E2FFEFE0EFE6CF008100008100FEE9D0846964FF00FFFF00FFFF00FFFF00FF
        FF00FFD49875FFFFFFFFFFFFFFFEFEFFFEFBFFFCFAFFFBF7FFFBF4FFF8F2FFF7
        EFFFF6EBFEF4E9FFF3E6FEF2E3FFF0E0FFEFDDFEEDD9FEEBD5846964FF00FFFF
        00FFFF00FFFF00FFFF00FFD49875FFFFFFFFFFFFFFFFFFFFFFFEFFFEFBFEFEFB
        FFFBF8FFFBF4FFF8F3FEF8F0FFF7EEFFF4EAFFF4E7FEF2E5FEF0E1FEEFDDFFED
        DA846964FF00FFFF00FFFF00FFFF00FFFF00FFCF8E68CF8E68CF8E68CF8E68CF
        8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68
        CF8E68CF8E68CF8E68846964FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = btnImportarClick
    end
    object ButSair: TcxButton
      Left = 3
      Top = 4
      Width = 36
      Height = 33
      Hint = 'Voltar (Alt+V)'
      Caption = '   &V'
      OptionsImage.Glyph.Data = {
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
      OptionsImage.Margin = 5
      TabOrder = 1
      OnClick = ButSairClick
    end
    object btnLog: TcxButton
      Left = 162
      Top = 4
      Width = 83
      Height = 33
      Hint = ' Logs'
      Caption = 'Ver Log'
      LookAndFeel.Kind = lfOffice11
      LookAndFeel.NativeStyle = False
      LookAndFeel.SkinName = 'Office2007Blue'
      OptionsImage.Glyph.Data = {
        76060000424D7606000000000000360400002800000018000000180000000100
        08000000000040020000520B0000520B000000010000000000002D2D2D00373C
        3E0018556F0058534E005160610052636B0054777B007C707800D47719008A5B
        520085787C008D787F00AD7B7300AD7B7B0096836700AD847300B5847300A392
        7B00EFA55200FFB55200E7AD6B00F8B26600F7BD6B0000009A000316AC00021E
        AA0029799A000A62A0000018C6000936C9001029D600106BFF00AD738400AD7B
        8400B57B8400FF00FF00299CEF00428CDE006D8AFD004ABDFF009C9C9C00B584
        8400B9858500BD848400BD848C00BEB1A100C68C8C00CE948C00D69C9400C3A8
        8200DEA58C00DEA59400E7B58400CEADA500EFC68C00F9C08600EFCE9400EFCE
        9C00FBCA9500DEC6BD00EFCEA500F7D6A500F7D6AD00FBD3A900E7CEBD00EFD6
        BD00F7D6B500F7DEB500F7DEBD00DEDEDE00E7CEC600EFCEC600EFDEC600E7D6
        CE00E7DECE00F7DEC600F7DECE00E7D6D600EFDED600F7E7C600F7E7CE00F7E7
        D600F7E7DE00F7EFDE00F7EFE700F7EFEF00FFF7EF00FFF7F700FFFFF700FFFF
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
        00000000000000000000000000000000000000000000000000002323230D2929
        29292929292929292929292929292929232323232320484F4443423E3D393938
        3838383838383829232323232320484F4B44423E3E3C39393838383838383829
        2323232323204C504B4B44423E3E3C3939383838383838292323232323205051
        504B4444423E3E3C393938383838382923232323232051452828282800031131
        282828282828382923232323232152535150504B030104050E31393938383829
        2323232323225454535150502D062502090E3139393838292323232323295445
        2828282828061A0B08090E312828382923232323232B55565454535150500737
        1508090E3139382923232323232C57585654545351500A3A371508090E313929
        23232323232E5745282828282828280C3F371508090E312923232323232E5759
        59575654545351500C3F371508090E2923232323232E57595959575654545351
        500C3F371508092923232323232F5745282828282828282828280C3A2A24271B
        23232323232F575959595959575654545351500C242724191723232323305759
        59595959595756545353534A27241D1E181C2323233057452828282828282828
        284E100F0C1C261F1C2323232333575959595959595958575646103414121C1C
        2323232323335759595959595959595958461036161329232323232323335759
        5959595959595959594910361629232323232323233359595959595959595959
        594D10362923232323232323233240414147404040403B3B3B35102923232323
        2323232323232323232323232323232323232323232323232323}
      OptionsImage.Margin = 5
      TabOrder = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = btnLogClick
    end
    object ButCancelar: TcxButton
      Left = 41
      Top = 4
      Width = 36
      Height = 33
      Hint = 'Cancelar (Alt + C)'
      BiDiMode = bdLeftToRight
      Caption = '   &C'
      LookAndFeel.Kind = lfOffice11
      LookAndFeel.NativeStyle = False
      LookAndFeel.SkinName = 'Office2007Blue'
      OptionsImage.Glyph.Data = {
        76060000424D7606000000000000360400002800000018000000180000000100
        08000000000040020000220B0000220B000000010000000000000031DE00FF00
        FF000031FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
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
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010100000101010101010101010101010101010101010101010000
        0001010100000001010101010101010101010101010000000101010100000000
        0101010101010101010101000000000101010101000000000001010101010101
        0101000000000101010101010100000000000101010101010100000000010101
        0101010101010200000000010101010100000000010101010101010101010101
        0000000001010000000000010101010101010101010101010100000000000000
        0000010101010101010101010101010101010000020002000001010101010101
        0101010101010101010101000000020001010101010101010101010101010101
        0101000002000002020101010101010101010101010101010100000200020202
        0002010101010101010101010101010102020200020101020202020101010101
        0101010101010102020002020101010102020202010101010101010101010202
        0202020101010101010102020201010101010101010202020202010101010101
        0101010202020101010101010202020202010101010101010101010101020101
        0101010202020202010101010101010101010101010101010101010202020201
        0101010101010101010101010101010101010102020201010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101}
      OptionsImage.Margin = 5
      ParentBiDiMode = False
      TabOrder = 3
      OnClick = ButCancelarClick
    end
    object cxGroupBox1: TcxGroupBox
      Left = 252
      Top = 4
      TabOrder = 4
      Height = 33
      Width = 461
      object lblTotalReg: TLabel
        Left = 13
        Top = 11
        Width = 64
        Height = 13
        Caption = 'lblTotalReg'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        Visible = False
      end
      object lblTotalImp: TLabel
        Left = 204
        Top = 11
        Width = 64
        Height = 13
        Caption = 'lblTotalReg'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        Visible = False
      end
    end
  end
  object Page: TcxPageControl
    Left = 0
    Top = 85
    Width = 987
    Height = 316
    Align = alClient
    TabOrder = 2
    Properties.ActivePage = TabGrid
    Properties.CustomButtons.Buttons = <>
    OnChange = PageChange
    ClientRectBottom = 312
    ClientRectLeft = 4
    ClientRectRight = 983
    ClientRectTop = 24
    object TabGrid: TcxTabSheet
      Caption = 'Grade'
      ImageIndex = 0
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object tlNFe: TcxTreeList
        Left = 0
        Top = 0
        Width = 978
        Height = 284
        Align = alClient
        Bands = <
          item
          end>
        Navigator.Buttons.CustomButtons = <>
        OptionsData.Editing = False
        OptionsData.Deleting = False
        OptionsSelection.CellSelect = False
        TabOrder = 0
        object cxTreeList1Column1: TcxTreeListColumn
          Caption.Text = 'cCT'
          DataBinding.ValueType = 'String'
          Width = 80
          Position.ColIndex = 0
          Position.RowIndex = 0
          Position.BandIndex = 0
          Summary.FooterSummaryItems = <>
          Summary.GroupFooterSummaryItems = <>
        end
        object cxTreeList1Column2: TcxTreeListColumn
          Caption.Text = 'Emiss'#227'o'
          DataBinding.ValueType = 'String'
          Width = 125
          Position.ColIndex = 1
          Position.RowIndex = 0
          Position.BandIndex = 0
          Summary.FooterSummaryItems = <>
          Summary.GroupFooterSummaryItems = <>
        end
        object cxTreeList1Column3: TcxTreeListColumn
          Caption.Text = 'nCT'
          DataBinding.ValueType = 'String'
          Width = 105
          Position.ColIndex = 2
          Position.RowIndex = 0
          Position.BandIndex = 0
          Summary.FooterSummaryItems = <>
          Summary.GroupFooterSummaryItems = <>
        end
        object cxTreeList1Column4: TcxTreeListColumn
          Caption.Text = 'Chave cCT'
          DataBinding.ValueType = 'String'
          Width = 349
          Position.ColIndex = 3
          Position.RowIndex = 0
          Position.BandIndex = 0
          Summary.FooterSummaryItems = <>
          Summary.GroupFooterSummaryItems = <>
        end
        object cxTreeList1Column5: TcxTreeListColumn
          Caption.Text = 'Arquivo'
          DataBinding.ValueType = 'String'
          Width = 311
          Position.ColIndex = 4
          Position.RowIndex = 0
          Position.BandIndex = 0
          Summary.FooterSummaryItems = <>
          Summary.GroupFooterSummaryItems = <>
        end
        object cxTreeList1Column6: TcxTreeListColumn
          Caption.Text = 'Situa'#231#227'o'
          DataBinding.ValueType = 'String'
          Width = 136
          Position.ColIndex = 5
          Position.RowIndex = 0
          Position.BandIndex = 0
          Summary.FooterSummaryItems = <>
          Summary.GroupFooterSummaryItems = <>
        end
      end
    end
    object TabLog: TcxTabSheet
      Caption = 'Log'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Splitter1: TSplitter
        Left = 796
        Top = 33
        Height = 251
        Align = alRight
        ExplicitLeft = 776
        ExplicitTop = 96
        ExplicitHeight = 100
      end
      object mmVisualizar: TMemo
        Left = 0
        Top = 33
        Width = 796
        Height = 251
        Align = alClient
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object pnTitulo: TPanel
        Left = 0
        Top = 0
        Width = 978
        Height = 33
        Align = alTop
        Color = clNavy
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -10
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 1
      end
      object lstArquivos: TListBox
        Left = 799
        Top = 33
        Width = 179
        Height = 251
        Align = alRight
        ItemHeight = 13
        TabOrder = 2
        OnClick = lstArquivosClick
      end
    end
  end
  object qryInsert: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = DB_Conect.SQLConnection
    Left = 547
    Top = 136
  end
  object qryAux: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = DB_Conect.SQLConnection
    Left = 547
    Top = 192
  end
  object XMLDocument: TXMLDocument
    Left = 408
    Top = 136
    DOMVendorDesc = 'MSXML'
  end
  object OpenDialog: TOpenDialog
    Filter = 'Arquivos XML|*.xml'
    Left = 480
    Top = 88
  end
  object ACBrNFe: TACBrNFe
    Configuracoes.Geral.SSLLib = libNone
    Configuracoes.Geral.SSLCryptLib = cryNone
    Configuracoes.Geral.SSLHttpLib = httpNone
    Configuracoes.Geral.SSLXmlSignLib = xsNone
    Configuracoes.Geral.FormatoAlerta = 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.'
    Configuracoes.Arquivos.OrdenacaoPath = <>
    Configuracoes.WebServices.UF = 'SP'
    Configuracoes.WebServices.AguardarConsultaRet = 0
    Configuracoes.WebServices.QuebradeLinha = '|'
    Left = 280
    Top = 144
  end
  object ACBrCTe: TACBrCTe
    Configuracoes.Geral.SSLLib = libNone
    Configuracoes.Geral.SSLCryptLib = cryNone
    Configuracoes.Geral.SSLHttpLib = httpNone
    Configuracoes.Geral.SSLXmlSignLib = xsNone
    Configuracoes.Geral.FormatoAlerta = 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.'
    Configuracoes.Arquivos.OrdenacaoPath = <>
    Configuracoes.WebServices.UF = 'SP'
    Configuracoes.WebServices.AguardarConsultaRet = 0
    Configuracoes.WebServices.QuebradeLinha = '|'
    Left = 272
    Top = 232
  end
end
