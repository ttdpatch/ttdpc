object frmMain: TfrmMain
  Left = 271
  Top = 125
  Width = 680
  Height = 466
  Caption = 'ttdpc - TTDPatch Configurator, Version 0.22 Beta'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  ShowHint = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 16
  object ButtonPanel: TPanel
    Left = 0
    Top = 0
    Width = 672
    Height = 35
    Align = alTop
    TabOrder = 2
    object btnExit: TToolbarButton97
      Left = 8
      Top = 6
      Width = 23
      Height = 22
      Hint = 'Exit the program'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00330000000000
        03333377777777777F333301BBBBBBBB033333773F3333337F3333011BBBBBBB
        0333337F73F333337F33330111BBBBBB0333337F373F33337F333301110BBBBB
        0333337F337F33337F333301110BBBBB0333337F337F33337F333301110BBBBB
        0333337F337F33337F333301110BBBBB0333337F337F33337F333301110BBBBB
        0333337F337F33337F333301110BBBBB0333337F337FF3337F33330111B0BBBB
        0333337F337733337F333301110BBBBB0333337F337F33337F333301110BBBBB
        0333337F3F7F33337F333301E10BBBBB0333337F7F7F33337F333301EE0BBBBB
        0333337F777FFFFF7F3333000000000003333377777777777333}
      NumGlyphs = 2
      OnClick = btnExitClick
    end
    object btnSaveCanonFormat: TToolbarButton97
      Left = 32
      Top = 6
      Width = 23
      Height = 22
      Hint = 'Save the config file (in normal format)'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333FFFFFFFFFFFFF33000077777770033377777777777773F000007888888
        00037F3337F3FF37F37F00000780088800037F3337F77F37F37F000007800888
        00037F3337F77FF7F37F00000788888800037F3337777777337F000000000000
        00037F3FFFFFFFFFFF7F00000000000000037F77777777777F7F000FFFFFFFFF
        00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
        00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
        00037F7F333333337F7F000FFFFFFFFF07037F7F33333333777F000FFFFFFFFF
        0003737FFFFFFFFF7F7330099999999900333777777777777733}
      NumGlyphs = 2
      OnClick = btnSaveCanonFormatClick
    end
    object btnExpand: TToolbarButton97
      Left = 72
      Top = 6
      Width = 23
      Height = 22
      Hint = 'Expand all caregories'
      Glyph.Data = {
        46030000424D460300000000000036000000280000000E0000000E0000000100
        200000000000100300000000000000000000000000000000000000BFBF0000BF
        BF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BF
        BF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BF
        BF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BF
        BF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BF
        BF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BF
        BF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000000000000000000000
        000000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BF
        BF0000BFBF0000BFBF0000BFBF0000000000FFFFFF000000000000BFBF0000BF
        BF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BF
        BF0000BFBF0000000000FFFFFF000000000000BFBF0000BFBF0000BFBF0000BF
        BF0000BFBF0000BFBF0000BFBF0000BFBF000000000000000000000000000000
        0000FFFFFF000000000000000000000000000000000000BFBF0000BFBF0000BF
        BF0000BFBF0000BFBF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF000000000000BFBF0000BFBF0000BFBF0000BFBF0000BF
        BF0000000000000000000000000000000000FFFFFF0000000000000000000000
        00000000000000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BF
        BF0000BFBF0000000000FFFFFF000000000000BFBF0000BFBF0000BFBF0000BF
        BF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF000000
        0000FFFFFF000000000000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BF
        BF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000000000000000000000
        000000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BF
        BF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BF
        BF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BF
        BF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BF
        BF0000BFBF0000BFBF00}
      OnClick = btnExpandClick
    end
    object btnCollapse: TToolbarButton97
      Left = 96
      Top = 6
      Width = 23
      Height = 22
      Hint = 'Collapse all categories'
      Glyph.Data = {
        46030000424D460300000000000036000000280000000E0000000E0000000100
        200000000000100300000000000000000000000000000000000000BFBF0000BF
        BF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BF
        BF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BF
        BF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BF
        BF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BF
        BF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BF
        BF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BF
        BF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BF
        BF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BF
        BF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BF
        BF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BF
        BF0000BFBF0000BFBF0000BFBF0000BFBF000000000000000000000000000000
        000000000000000000000000000000000000000000000000000000BFBF0000BF
        BF0000BFBF0000BFBF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF000000000000BFBF0000BFBF0000BFBF0000BF
        BF00000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BF
        BF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BF
        BF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BF
        BF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BF
        BF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BF
        BF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BF
        BF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BF
        BF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BF
        BF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000BF
        BF0000BFBF0000BFBF00}
      OnClick = btnCollapseClick
    end
    object btnSaveUserFormat: TToolbarButton97
      Left = 136
      Top = 6
      Width = 23
      Height = 22
      Hint = 'Save the config file (in user format)'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333330070
        7700333333337777777733333333008088003333333377F73377333333330088
        88003333333377FFFF7733333333000000003FFFFFFF77777777000000000000
        000077777777777777770FFFFFFF0FFFFFF07F3333337F3333370FFFFFFF0FFF
        FFF07F3FF3FF7FFFFFF70F00F0080CCC9CC07F773773777777770FFFFFFFF039
        99337F3FFFF3F7F777F30F0000F0F09999937F7777373777777F0FFFFFFFF999
        99997F3FF3FFF77777770F00F000003999337F773777773777F30FFFF0FF0339
        99337F3FF7F3733777F30F08F0F0337999337F7737F73F7777330FFFF0039999
        93337FFFF7737777733300000033333333337777773333333333}
      NumGlyphs = 2
      OnClick = btnSaveUserFormatClick
    end
    object ToolbarButton976: TToolbarButton97
      Left = 160
      Top = 6
      Width = 23
      Height = 22
      Enabled = False
      Visible = False
    end
    object ToolbarButton977: TToolbarButton97
      Left = 184
      Top = 6
      Width = 23
      Height = 22
      Enabled = False
      Visible = False
    end
    object Label2: TLabel
      Left = 270
      Top = 8
      Width = 105
      Height = 16
      Alignment = taRightJustify
      Caption = 'TTDPatch version:'
    end
    object edSwVersion: TEdit
      Left = 383
      Top = 6
      Width = 283
      Height = 24
      Hint = 'The version of TTDPATCH '
      TabStop = False
      Anchors = [akTop, akRight]
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 0
      Text = 'edSwVersion'
    end
  end
  object InfoPanel: TPanel
    Left = 384
    Top = 35
    Width = 288
    Height = 404
    Align = alRight
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 83
      Height = 16
      Caption = 'File comments'
    end
    object lbTextVale: TLabel
      Left = 16
      Top = 223
      Width = 72
      Height = 16
      Caption = 'Switch value'
    end
    object mmDescription: TMemo
      Left = 8
      Top = 24
      Width = 273
      Height = 185
      Hint = 'The description of a switch'
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      Color = clBtnFace
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 3
      OnDblClick = mmDescriptionDblClick
      OnExit = mmDescriptionExit
    end
    object pgEdits: TPageControl
      Left = 14
      Top = 239
      Width = 267
      Height = 57
      ActivePage = tsSmallRange
      Style = tsButtons
      TabOrder = 0
      object tsText: TTabSheet
        Caption = 'tsText'
        TabVisible = False
        object edTextValue: TEdit
          Left = 8
          Top = 10
          Width = 221
          Height = 24
          Hint = 'Enter the switch value'
          TabOrder = 0
          OnChange = edTextValueChange
        end
      end
      object tsBool: TTabSheet
        Caption = 'tsBool'
        ImageIndex = 1
        TabVisible = False
        object GroupBox3: TGroupBox
          Left = 3
          Top = -2
          Width = 255
          Height = 44
          TabOrder = 0
          object rgBoolOff: TRadioButton
            Left = 8
            Top = 17
            Width = 41
            Height = 17
            Hint = 'Turn the switch off'
            Caption = 'o&ff'
            TabOrder = 0
            OnClick = rgBoolOffClick
          end
          object rgBoolOn: TRadioButton
            Left = 68
            Top = 17
            Width = 45
            Height = 17
            Hint = 'Turn the switch on'
            Caption = 'o&n'
            TabOrder = 1
            OnClick = rgBoolOnClick
          end
        end
      end
      object tsSmallRange: TTabSheet
        Caption = 'tsSmallRange'
        ImageIndex = 2
        TabVisible = False
        object GroupBox1: TGroupBox
          Left = 3
          Top = -2
          Width = 255
          Height = 44
          TabOrder = 0
          object edSmallRange: TJvSpinEdit
            Left = 192
            Top = 14
            Width = 57
            Height = 24
            Hint = 'Enter the switch value'
            Enabled = False
            TabOrder = 3
            OnChange = edSmallRangeChange
          end
          object rgSmOff: TRadioButton
            Left = 8
            Top = 17
            Width = 41
            Height = 17
            Hint = 'Turn the switch off'
            Caption = 'o&ff'
            TabOrder = 0
            OnClick = rgSmOffClick
          end
          object rgSmOn: TRadioButton
            Left = 68
            Top = 17
            Width = 45
            Height = 17
            Hint = 'Turn the switch on with the default value'
            Caption = 'o&n'
            TabOrder = 1
            OnClick = rgSmOnClick
          end
          object rgSmValue: TRadioButton
            Left = 128
            Top = 17
            Width = 59
            Height = 17
            Hint = 'Turn the switch on with this value'
            Caption = '&value'
            TabOrder = 2
            OnClick = rgSmValueClick
          end
        end
      end
      object tsLargeRange: TTabSheet
        Caption = 'tsLargeRange'
        ImageIndex = 3
        TabVisible = False
        object GroupBox2: TGroupBox
          Left = 3
          Top = -2
          Width = 255
          Height = 44
          TabOrder = 0
          object edLargeRange: TJvValidateEdit
            Left = 183
            Top = 14
            Width = 65
            Height = 24
            Hint = 'Enter the switch value'
            AllowEmpty = True
            Alignment = taLeftJustify
            CheckChars = '01234567890'
            CriticalPoints.CheckPoints = cpBoth
            DisplayFormat = dfCheckChars
            EditText = '0'
            Enabled = False
            HasMaxValue = True
            HasMinValue = True
            TabOrder = 3
            OnChange = edLargeRangeChange
          end
          object rgLaOff: TRadioButton
            Left = 8
            Top = 17
            Width = 41
            Height = 17
            Hint = 'Turn the switch off'
            Caption = 'o&ff'
            TabOrder = 0
            OnClick = rgLaOffClick
          end
          object rgLaOn: TRadioButton
            Left = 68
            Top = 17
            Width = 45
            Height = 17
            Hint = 'Turn the switch on with the default value'
            Caption = 'o&n'
            TabOrder = 1
            OnClick = rgLaOnClick
          end
          object rgLaValue: TRadioButton
            Left = 128
            Top = 17
            Width = 55
            Height = 17
            Hint = 'Turn the switch on with this value'
            Caption = '&value'
            TabOrder = 2
            OnClick = rgLaValueClick
          end
        end
      end
      object tsBlank: TTabSheet
        Caption = 'tsBlank'
        ImageIndex = 4
        TabVisible = False
      end
    end
    object SearchPanel: TPanel
      Left = 1
      Top = 302
      Width = 286
      Height = 101
      Align = alBottom
      BevelInner = bvLowered
      TabOrder = 2
      object lbSearch: TLabel
        Left = 16
        Top = 8
        Width = 40
        Height = 16
        Caption = '&Search'
        FocusControl = edSearch
      end
      object edSearch: TEdit
        Left = 24
        Top = 32
        Width = 169
        Height = 24
        Hint = 'Text to search for'
        TabOrder = 0
        OnChange = edSearchChange
        OnKeyDown = edSearchKeyDown
      end
      object cbSearchDescription: TCheckBox
        Left = 26
        Top = 67
        Width = 191
        Height = 17
        Hint = 'Search the description instead of the names'
        Caption = 'Search &description'
        TabOrder = 1
      end
      object btnFindFirst: TBitBtn
        Left = 200
        Top = 22
        Width = 75
        Height = 25
        Hint = 'Find the first matching switch'
        Caption = '&First'
        TabOrder = 2
        OnClick = btnFindFirstClick
      end
      object btnFindNext: TBitBtn
        Left = 200
        Top = 50
        Width = 75
        Height = 25
        Hint = 'Find next matching switch'
        Caption = '&Next'
        TabOrder = 3
        OnClick = btnFindNextClick
      end
    end
    object btnUndo: TBitBtn
      Left = 196
      Top = 216
      Width = 75
      Height = 25
      Hint = 'Undo the change'
      Caption = '&Undo'
      Enabled = False
      TabOrder = 1
      TabStop = False
      OnClick = btnUndoClick
    end
  end
  object Outline1: TOutline
    Left = 0
    Top = 35
    Width = 384
    Height = 404
    Hint = 'Double click a Category to see the switches'
    ItemHeight = 16
    Align = alClient
    TabOrder = 0
    OnClick = Outline1Click
    OnKeyUp = Outline1KeyUp
    ItemSeparator = '\'
  end
  object xml1: TJvSimpleXML
    IndentString = '  '
    Left = 233
    Top = 44
  end
  object JvAppEvents1: TJvAppEvents
    OnMessage = JvAppEvents1Message
    Left = 272
    Top = 43
  end
end
