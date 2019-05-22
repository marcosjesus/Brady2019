object OvcfrmAliasDlg: TOvcfrmAliasDlg
  Left = 360
  Top = 206
  Width = 255
  Height = 279
  Caption = 'Alias Dialog'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Default'
  Font.Style = []
  OldCreateOrder = True
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object TPanel
    Left = 0
    Top = 214
    Width = 247
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object btnHelp: TButton
      Left = 4
      Top = 4
      Width = 75
      Height = 25
      Caption = 'Help'
      TabOrder = 0
    end
    object TPanel
      Left = 82
      Top = 0
      Width = 165
      Height = 31
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 1
      object btnOK: TButton
        Left = 6
        Top = 4
        Width = 75
        Height = 25
        Caption = 'OK'
        Default = True
        ModalResult = 1
        TabOrder = 0
      end
      object btnCancel: TButton
        Left = 88
        Top = 4
        Width = 75
        Height = 25
        Cancel = True
        Caption = 'Cancel'
        ModalResult = 2
        TabOrder = 1
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 247
    Height = 214
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 7
      Top = 180
      Width = 22
      Height = 13
      Caption = 'Alias'
    end
    object Label2: TLabel
      Left = 7
      Top = 43
      Width = 32
      Height = 13
      Caption = 'Tables'
    end
    object Label3: TLabel
      Left = 7
      Top = 4
      Width = 68
      Height = 13
      Caption = 'Selected table'
    end
    object edTableName: TEdit
      Left = 7
      Top = 17
      Width = 143
      Height = 21
      TabOrder = 0
      Text = '*.db;*.dbf'
      OnChange = edTableNameChange
    end
    object cbAliasList: TComboBox
      Left = 7
      Top = 193
      Width = 232
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      Sorted = True
      TabOrder = 1
      OnChange = cbAliasListChange
    end
    object FileListBox1: TFileListBox
      Left = 7
      Top = 56
      Width = 231
      Height = 118
      ItemHeight = 13
      Mask = '*.db;*.dbf'
      TabOrder = 2
      OnChange = FileListBox1Change
      OnClick = FileListBox1Change
      OnDblClick = FileListBox1DblClick
    end
    object btnBrowse: TButton
      Left = 161
      Top = 15
      Width = 75
      Height = 25
      Caption = 'Browse'
      TabOrder = 3
      OnClick = btnBrowseClick
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'db'
    Filter = 'Tables (*.db, *.dbf)|*.db;*.dbf|All Files (*.*)|*.*'
    Title = 'Select Table'
    Left = 200
    Top = 64
  end
end
