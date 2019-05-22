object Form1: TForm1
  Left = 402
  Top = 269
  Caption = 'QR5 Demo'
  ClientHeight = 254
  ClientWidth = 407
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object SpeedButton1: TSpeedButton
    Left = 8
    Top = 74
    Width = 137
    Height = 25
    Caption = 'Preview'
    OnClick = SpeedButton1Click
  end
  object SpeedButton3: TSpeedButton
    Left = 8
    Top = 136
    Width = 137
    Height = 25
    Caption = 'ASCII export'
    OnClick = SpeedButton3Click
  end
  object SpeedButton4: TSpeedButton
    Left = 8
    Top = 167
    Width = 137
    Height = 25
    Caption = 'HTML Export'
    OnClick = SpeedButton4Click
  end
  object SpeedButton6: TSpeedButton
    Left = 8
    Top = 105
    Width = 137
    Height = 25
    Caption = 'XML Preview'
    OnClick = SpeedButton6Click
  end
  object SpeedButton7: TSpeedButton
    Left = 168
    Top = 74
    Width = 121
    Height = 25
    Caption = 'Unicode Strings report'
    OnClick = SpeedButton7Click
  end
  object Label1: TLabel
    Left = 110
    Top = 8
    Width = 179
    Height = 16
    Caption = 'QuickReport Demonstration'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 30
    Width = 361
    Height = 16
    Caption = 'This application shows QuickReport with CodeGear Delphi 2009'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 8
    Top = 52
    Width = 108
    Height = 16
    Caption = 'Source is included '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 280
    Top = 230
    Width = 110
    Height = 13
    Caption = '(c) QBS Software 2008'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object biobutton: TSpeedButton
    Left = 168
    Top = 136
    Width = 121
    Height = 25
    Caption = 'Bio report'
    OnClick = biobuttonClick
  end
  object QRExcelFilter1: TQRExcelFilter
    TextEncoding = UTF8Encoding
    Left = 168
    Top = 208
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
    Top = 208
  end
  object QRCSVFilter1: TQRCSVFilter
    Separator = ','
    TextEncoding = UTF8Encoding
    Left = 328
    Top = 176
  end
  object QRTextFilter1: TQRTextFilter
    TextEncoding = UTF8Encoding
    Left = 248
    Top = 176
  end
  object QRXMLSFilter2: TQRXMLSFilter
    TextEncoding = UnicodeEncoding
    Left = 88
    Top = 208
  end
end
