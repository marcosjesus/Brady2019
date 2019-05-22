object ConnectDlg: TConnectDlg
  Left = 268
  Top = 141
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsToolWindow
  Caption = 'QRXP Client Test'
  ClientHeight = 221
  ClientWidth = 505
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = reportMenu
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 5
    Top = 30
    Width = 493
    Height = 190
    TabOrder = 0
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 505
    Height = 31
    ButtonHeight = 21
    Caption = 'ToolBar1'
    EdgeBorders = []
    TabOrder = 1
    object SpeedButton2: TSpeedButton
      Left = 0
      Top = 2
      Width = 96
      Height = 21
      Caption = 'Connect to Server'
      Flat = True
      OnClick = SpeedButton2Click
    end
    object Panel2: TPanel
      Left = 96
      Top = 2
      Width = 48
      Height = 21
      BevelOuter = bvNone
      Caption = 'User ID'
      TabOrder = 3
    end
    object Edit1: TEdit
      Left = 144
      Top = 2
      Width = 91
      Height = 21
      BevelEdges = [beLeft, beTop]
      BevelInner = bvNone
      BevelOuter = bvNone
      TabOrder = 1
      Text = 'ABC123'
    end
    object Panel1: TPanel
      Left = 235
      Top = 2
      Width = 62
      Height = 21
      BevelOuter = bvNone
      Caption = 'Auth Code'
      TabOrder = 2
    end
    object Edit2: TEdit
      Left = 297
      Top = 2
      Width = 82
      Height = 21
      BevelEdges = []
      BevelInner = bvNone
      TabOrder = 0
    end
    object SpeedButton3: TSpeedButton
      Left = 379
      Top = 2
      Width = 72
      Height = 21
      Caption = 'Disconnect'
      Flat = True
      OnClick = SpeedButton3Click
    end
    object SpeedButton1: TSpeedButton
      Left = 451
      Top = 2
      Width = 47
      Height = 21
      Caption = 'Close'
      Flat = True
      OnClick = SpeedButton1Click
    end
  end
  object IdTCPClient1: TIdTCPClient
    MaxLineAction = maException
    ReadTimeout = 0
    Host = '127.0.0.1'
    OnConnected = IdTCPClient1Connected
    Port = 7345
    Left = 195
    Top = 23
  end
  object reportMenu: TMainMenu
    Left = 2
    Top = 35
    object Reports1: TMenuItem
      Caption = '&Reports'
    end
  end
end
