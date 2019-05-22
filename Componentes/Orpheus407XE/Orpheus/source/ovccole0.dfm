object OvcfrmCollEditor: TOvcfrmCollEditor
  Left = 460
  Top = 561
  Width = 238
  Height = 161
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'Default'
  Font.Style = []
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ListBox1: TListBox
    Left = 0
    Top = 0
    Width = 194
    Height = 134
    Align = alClient
    ItemHeight = 13
    MultiSelect = True
    TabOrder = 0
    OnClick = ListBox1Click
    OnKeyDown = ListBox1KeyDown
  end
  object Panel1: TPanel
    Left = 194
    Top = 0
    Width = 36
    Height = 134
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 1
    object btnAdd: TOvcSpeedButton
      Left = 7
      Top = 6
      Width = 25
      Height = 25
      Hint = 'Add Item'
      AutoRepeat = False
      Flat = False
      Glyph.Data = {
        DE000000424DDE0000000000000076000000280000000D0000000D0000000100
        0400000000006800000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3000333300000333300033330AAA0333300033330AAA0333300030000AAA0000
        300030AAAAAAAAA0300030AAAAAAAAA0300030AAAAAAAAA0300030000AAA0000
        300033330AAA0333300033330AAA033330003333000003333000333333333333
        3000}
      GrayedInactive = True
      Layout = blGlyphTop
      Margin = -1
      NumGlyphs = 1
      RepeatDelay = 500
      RepeatInterval = 100
      Spacing = 1
      Style = bsAutoDetect
      Transparent = False
      WordWrap = False
      ParentShowHint = False
      ShowHint = True
      OnClick = btnAddClick
    end
    object btnDelete: TOvcSpeedButton
      Left = 7
      Top = 39
      Width = 25
      Height = 25
      Hint = 'Remove item'
      AutoRepeat = False
      Flat = False
      Glyph.Data = {
        DE000000424DDE0000000000000076000000280000000D0000000D0000000100
        0400000000006800000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3000333333333333300033333333333330003333333333333000300000000000
        3000309999999990300030999999999030003099999999903000300000000000
        3000333333333333300033333333333330003333333333333000333333333333
        3000}
      GrayedInactive = True
      Layout = blGlyphTop
      Margin = -1
      NumGlyphs = 1
      RepeatDelay = 500
      RepeatInterval = 100
      Spacing = 1
      Style = bsAutoDetect
      Transparent = False
      WordWrap = False
      ParentShowHint = False
      ShowHint = True
      OnClick = btnDeleteClick
    end
    object btnMoveUp: TOvcSpeedButton
      Left = 7
      Top = 72
      Width = 25
      Height = 25
      Hint = 'Move item up'
      AutoRepeat = True
      Flat = False
      Glyph.Data = {
        DE000000424DDE0000000000000076000000280000000D0000000D0000000100
        0400000000006800000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3000333333333333300033330000033330003333066603333000333306660333
        3000333306660333300030000666000030003306666666033000333066666033
        3000333306660333300033333060333330003333330333333000333333333333
        3000}
      GrayedInactive = True
      Layout = blGlyphTop
      Margin = -1
      NumGlyphs = 1
      RepeatDelay = 500
      RepeatInterval = 100
      Spacing = 1
      Style = bsAutoDetect
      Transparent = False
      WordWrap = False
      ParentShowHint = False
      ShowHint = True
      OnClick = btnMoveUpClick
    end
    object btnMoveDown: TOvcSpeedButton
      Left = 7
      Top = 104
      Width = 25
      Height = 25
      Hint = 'Move item down'
      AutoRepeat = True
      Flat = False
      Glyph.Data = {
        DE000000424DDE0000000000000076000000280000000D0000000D0000000100
        0400000000006800000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3000333333333333300033333303333330003333306033333000333306660333
        3000333066666033300033066666660330003000066600003000333306660333
        3000333306660333300033330666033330003333000003333000333333333333
        3000}
      GrayedInactive = True
      Layout = blGlyphTop
      Margin = -1
      NumGlyphs = 1
      RepeatDelay = 500
      RepeatInterval = 100
      Spacing = 1
      Style = bsAutoDetect
      Transparent = False
      WordWrap = False
      ParentShowHint = False
      ShowHint = True
      OnClick = btnMoveDownClick
    end
  end
end
