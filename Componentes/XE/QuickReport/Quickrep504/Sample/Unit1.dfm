object Form1: TForm1
  Left = 402
  Top = 269
  Caption = 'QR5 Demo'
  ClientHeight = 213
  ClientWidth = 339
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  PixelsPerInch = 96
  TextHeight = 13
  object SpeedButton1: TSpeedButton
    Left = 48
    Top = 24
    Width = 137
    Height = 25
    Caption = 'Preview'
    OnClick = SpeedButton1Click
  end
  object SpeedButton3: TSpeedButton
    Left = 48
    Top = 64
    Width = 137
    Height = 25
    Caption = 'ASCII export'
    OnClick = SpeedButton3Click
  end
  object SpeedButton4: TSpeedButton
    Left = 48
    Top = 103
    Width = 137
    Height = 25
    Caption = 'HTML'
    OnClick = SpeedButton4Click
  end
  object SpeedButton6: TSpeedButton
    Left = 200
    Top = 24
    Width = 121
    Height = 25
    Caption = 'XML Preview'
    OnClick = SpeedButton6Click
  end
  object SpeedButton7: TSpeedButton
    Left = 200
    Top = 64
    Width = 121
    Height = 25
    Caption = 'Unicode Strings report'
    OnClick = SpeedButton7Click
  end
  object QRExcelFilter1: TQRExcelFilter
    TextEncoding = UTF8Encoding
    Left = 88
    Top = 144
  end
  object QRHTMLFilter1: TQRHTMLFilter
    MultiPage = False
    PageLinks = False
    FinalPage = 0
    FirstLastLinks = False
    Concat = False
    ConcatCount = 1
    LinkFontSize = 12
    LinkFontName = 'Arial'
    TextEncoding = UnicodeEncoding
    Left = 8
    Top = 144
  end
  object QRCSVFilter1: TQRCSVFilter
    Separator = ','
    TextEncoding = UTF8Encoding
    Left = 168
    Top = 144
  end
  object QRTextFilter1: TQRTextFilter
    TextEncoding = UTF8Encoding
    Left = 128
    Top = 144
  end
  object QRXMLSFilter2: TQRXMLSFilter
    TextEncoding = UnicodeEncoding
    Left = 48
    Top = 144
  end
end
