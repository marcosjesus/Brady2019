object OvcfrmTransfer: TOvcfrmTransfer
  Left = 493
  Top = 296
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Generate Transfer Routines'
  ClientHeight = 344
  ClientWidth = 543
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'Default'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object btnClose: TBitBtn
    Left = 450
    Top = 312
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&Close'
    DoubleBuffered = True
    ModalResult = 2
    ParentDoubleBuffered = False
    Spacing = -1
    TabOrder = 2
    IsControl = True
  end
  object NB: TOvcNotebook
    Left = 19
    Top = 17
    Width = 513
    Height = 289
    Hint = 'Copy all to clipboard'
    ActiveTabFont.Charset = DEFAULT_CHARSET
    ActiveTabFont.Color = clWindowText
    ActiveTabFont.Height = -11
    ActiveTabFont.Name = 'Default'
    ActiveTabFont.Style = []
    TabAutoHeight = False
    TabHeight = 17
    OnPageChanged = NBPageChanged
    Controller = OvcController1
    TabOrder = 0
    object Page0: TOvcTabPage
      Hint = 'Copy all to clipboard'
      Caption = 'Com&ponent Selection'
      object TLabel
        Left = 15
        Top = 8
        Width = 106
        Height = 13
        Caption = 'Available Components'
      end
      object gbGenerate: TGroupBox
        Left = 296
        Top = 24
        Width = 185
        Height = 105
        Caption = 'Generate &Options'
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 0
        object cbTransfer: TCheckBox
          Left = 16
          Top = 24
          Width = 161
          Height = 17
          Caption = 'Transfer record'
          Checked = True
          State = cbChecked
          TabOrder = 0
          OnClick = SelectionChange
        end
        object cbInitialize: TCheckBox
          Left = 16
          Top = 48
          Width = 161
          Height = 17
          Caption = 'Initialization method'
          Checked = True
          State = cbChecked
          TabOrder = 1
          OnClick = SelectionChange
        end
        object cbSample: TCheckBox
          Left = 16
          Top = 72
          Width = 161
          Height = 17
          Caption = 'Sample transfer calls'
          Checked = True
          State = cbChecked
          TabOrder = 2
          OnClick = SelectionChange
        end
      end
      object btnClearAll: TButton
        Left = 152
        Top = 216
        Width = 75
        Height = 25
        Caption = 'Clear all'
        TabOrder = 1
        OnClick = btnClearAllClick
      end
      object btnSelectAll: TButton
        Left = 48
        Top = 216
        Width = 75
        Height = 25
        Caption = 'Select all'
        TabOrder = 2
        OnClick = btnSelectAllClick
      end
      object btnGenerate: TBitBtn
        Left = 296
        Top = 152
        Width = 185
        Height = 25
        Caption = '&Generate source code'
        DoubleBuffered = True
        Enabled = False
        ParentDoubleBuffered = False
        TabOrder = 3
        OnClick = btnGenerateClick
      end
      object lbAllComponents: TOvcListBox
        Left = 8
        Top = 24
        Width = 265
        Height = 183
        Controller = OvcController1
        Ctl3D = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Default'
        Font.Pitch = fpFixed
        Font.Style = []
        ItemHeight = 13
        MultiSelect = True
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 4
        OnClick = SelectionChange
      end
    end
    object Page1: TOvcTabPage
      Hint = 'Copy transfer record to clipboard'
      Caption = '&Transfer Record'
      Enabled = False
      object Label1: TLabel
        Left = 8
        Top = 8
        Width = 473
        Height = 33
        AutoSize = False
        Caption = 
          'Copy this declaration to the interface section,  prior to the fo' +
          'rms class definition.'
      end
      object memoTransfer: TMemo
        Left = 0
        Top = 67
        Width = 510
        Height = 200
        Align = alBottom
        Ctl3D = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 0
        ExplicitTop = -200
        ExplicitWidth = 0
      end
    end
    object Page2: TOvcTabPage
      Hint = 'Copy initialization method to clipboard'
      Caption = '&Initialization Method'
      Enabled = False
      object Label2: TLabel
        Left = 8
        Top = 8
        Width = 473
        Height = 33
        AutoSize = False
        Caption = 
          'Copy the method header to the form'#39's "private" section and place' +
          ' the method declaration in the implementation section.'
      end
      object memoInitialize: TMemo
        Left = 0
        Top = 67
        Width = 510
        Height = 200
        Align = alBottom
        Ctl3D = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 0
        ExplicitTop = -200
        ExplicitWidth = 0
      end
    end
    object Page3: TOvcTabPage
      Hint = 'Copy sample calls to clipboard'
      Caption = '&Sample Transfer Calls'
      Enabled = False
      object Label3: TLabel
        Left = 8
        Top = 8
        Width = 473
        Height = 33
        AutoSize = False
        Caption = 
          'These are sample calls to transfer data to and from the forms co' +
          'mponents. '
      end
      object memoSample: TMemo
        Left = 0
        Top = 67
        Width = 510
        Height = 200
        Align = alBottom
        Ctl3D = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 0
        ExplicitTop = -200
        ExplicitWidth = 0
      end
    end
  end
  object btnCopyToClipboard: TBitBtn
    Left = 16
    Top = 312
    Width = 329
    Height = 25
    Caption = 'Copy all to clipboard'
    DoubleBuffered = True
    Enabled = False
    ParentDoubleBuffered = False
    TabOrder = 1
    OnClick = btnCopyToClipboardClick
  end
  object OvcController1: TOvcController
    EntryCommands.TableList = (
      'Default'
      True
      ())
    Epoch = 1900
  end
end
