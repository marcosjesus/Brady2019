object frmDialogDir: TfrmDialogDir
  Left = 0
  Top = 0
  BorderIcons = []
  Caption = 'Selecionar Pasta'
  ClientHeight = 219
  ClientWidth = 326
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object DirectoryListBox: TDirectoryListBox
    Left = 8
    Top = 8
    Width = 310
    Height = 177
    TabOrder = 0
  end
  object OK: TBitBtn
    Left = 242
    Top = 188
    Width = 75
    Height = 25
    Caption = 'OK'
    DoubleBuffered = True
    ModalResult = 1
    ParentDoubleBuffered = False
    TabOrder = 1
  end
  object Cancelar: TBitBtn
    Left = 163
    Top = 188
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    DoubleBuffered = True
    ModalResult = 2
    ParentDoubleBuffered = False
    TabOrder = 2
  end
end
