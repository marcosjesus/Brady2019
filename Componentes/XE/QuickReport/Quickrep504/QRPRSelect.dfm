object PRSelect: TPRSelect
  Left = 0
  Top = 0
  Caption = 'Select printer'
  ClientHeight = 151
  ClientWidth = 339
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object SpeedButton1: TSpeedButton
    Left = 8
    Top = 112
    Width = 121
    Height = 25
    Caption = 'Cancel'
    OnClick = SpeedButton1Click
  end
  object SpeedButton2: TSpeedButton
    Left = 210
    Top = 112
    Width = 121
    Height = 25
    Caption = 'OK'
    OnClick = SpeedButton2Click
  end
  object ComboBox1: TComboBox
    Left = 8
    Top = 8
    Width = 323
    Height = 21
    Style = csDropDownList
    ItemHeight = 0
    TabOrder = 0
    OnChange = ComboBox1Click
  end
end
