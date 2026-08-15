-- Plugin-free port of craftzdog/solarized-osaka.nvim (dark style).
--
-- The palette and highlight groups below are lifted verbatim from the plugin's
-- colors.lua / groups/editor.lua / groups/syntax.lua / groups/treesitter.lua so
-- the result is identical to the original setup:
--     transparent = true, sidebars = "transparent", floats = "dark" (default)
--
-- The HSL values were resolved to hex at port time.

local c = {
  none = "NONE",

  base04 = "#001419",
  base03 = "#002c38",
  base02 = "#063540",
  base01 = "#576d74",
  base00 = "#637981",
  base0 = "#9eabac",
  base1 = "#adb7b7",
  base2 = "#ede7d3",
  base3 = "#fdf5e2",
  base4 = "#ffffff",

  yellow = "#b28500",
  yellow300 = "#ffbf00",
  yellow500 = "#b28500",
  yellow700 = "#664c00",
  yellow900 = "#332700",

  orange = "#c94c16",
  orange300 = "#f74f0c",
  orange500 = "#c94c16",
  orange700 = "#a13c10",

  red = "#db302d",
  red100 = "#ff9a99",
  red300 = "#f55350",
  red500 = "#db302d",
  red700 = "#b7211f",
  red900 = "#570f0e",
  red950 = "#380605",

  magenta = "#d23681",
  magenta500 = "#d23681",
  magenta700 = "#af2668",
  magenta900 = "#541131",

  violet = "#6d71c4",
  violet500 = "#6d71c4",
  violet900 = "#24275a",

  blue = "#268bd3",
  blue500 = "#268bd3",
  blue700 = "#1a6397",
  blue900 = "#0f3856",

  cyan = "#29a298",
  cyan300 = "#2aeddd",
  cyan500 = "#29a298",
  cyan700 = "#1a6265",
  cyan900 = "#103a3c",

  green = "#849900",
  green500 = "#849900",
  green700 = "#586600",
  green900 = "#2c3300",
  green950 = "#191d00",

  bg = "#001419",
  bg_highlight = "#002c38",
  fg = "#839395",
  black = "#001014",
  border = "#001014",
}
c.error = c.red500
c.warning = c.yellow500
c.info = c.blue500
c.hint = c.cyan500
c.todo = c.violet500

-- transparent = true (matches the original setup)
local transparent = true
local normal_bg = transparent and c.none or c.bg

local function set(group, val)
  if type(val) == "string" then
    vim.api.nvim_set_hl(0, group, { link = val })
  else
    vim.api.nvim_set_hl(0, group, val)
  end
end

-- terminal palette
vim.g.terminal_color_0 = c.black
vim.g.terminal_color_8 = c.black
vim.g.terminal_color_7 = c.fg
vim.g.terminal_color_15 = c.fg
vim.g.terminal_color_1 = c.red
vim.g.terminal_color_9 = c.red
vim.g.terminal_color_2 = c.green
vim.g.terminal_color_10 = c.green
vim.g.terminal_color_3 = c.yellow
vim.g.terminal_color_11 = c.yellow
vim.g.terminal_color_4 = c.blue
vim.g.terminal_color_12 = c.blue
vim.g.terminal_color_5 = c.magenta
vim.g.terminal_color_13 = c.magenta
vim.g.terminal_color_6 = c.cyan
vim.g.terminal_color_14 = c.cyan

local groups = {
  -- editor
  ColorColumn = { bg = c.base02 },
  Conceal = { fg = c.blue500 },
  Cursor = { fg = c.base03, bg = c.base0 },
  lCursor = { fg = c.base03, bg = c.base00 },
  CursorIM = { fg = c.base03, bg = c.base0 },
  CursorColumn = { bg = c.base02 },
  CursorLine = { bg = c.base03 },
  Directory = { fg = c.blue500 },
  DiffAdd = { bg = c.cyan900 },
  DiffChange = { bg = c.green950 },
  DiffDelete = { bg = c.red950 },
  DiffText = { bg = c.green900, bold = true },
  EndOfBuffer = { fg = c.base01 },
  ErrorMsg = { fg = c.red500, reverse = true },
  VertSplit = { fg = c.base00 },
  WinSeparator = { fg = c.base02, bold = true },
  Folded = { fg = c.base0, bg = c.base02, bold = true },
  FoldColumn = { fg = c.base0 },
  SignColumn = { fg = c.base0 },
  SignColumnSB = { fg = c.base0 },
  Substitute = { fg = c.base04, bg = c.red500 },
  LineNr = { fg = c.yellow700, bg = normal_bg },
  CursorLineNr = { fg = c.orange500, sp = c.base1 },
  MatchParen = { fg = c.red100, bg = c.red500, bold = true },
  ModeMsg = { fg = c.blue500 },
  MsgArea = { fg = c.base01 },
  MoreMsg = { fg = c.blue500 },
  NonText = { fg = c.base00, bold = true },
  Normal = { fg = c.base0, bg = normal_bg },
  NormalNC = { fg = c.base00, bg = normal_bg },
  NormalSB = { fg = c.base01, bg = c.none },
  NormalFloat = { fg = c.base0, bg = c.base04 },
  FloatBorder = { fg = c.yellow700, bg = c.base04 },
  FloatTitle = { fg = c.base2, bg = c.base04 },
  Pmenu = { fg = c.base0, bg = c.base02 },
  PmenuSel = { fg = c.base01, bg = c.base2, reverse = true },
  PmenuSbar = { fg = c.base02, reverse = true },
  PmenuThumb = { fg = c.base0, reverse = true },
  Question = { fg = c.cyan500, bold = true },
  QuickFixLine = { bg = c.blue700, bold = true },
  Search = { fg = c.yellow500, reverse = true },
  IncSearch = { fg = c.base2, bg = c.orange500 },
  CurSearch = "IncSearch",
  SpecialKey = { fg = c.base00 },
  SpellBad = { sp = c.red500, undercurl = true },
  SpellCap = { sp = c.violet500, undercurl = true },
  SpellLocal = { sp = c.cyan500, undercurl = true },
  SpellRare = { sp = c.yellow500, undercurl = true },
  StatusLine = { fg = c.base1, bg = c.base03 },
  StatusLineNC = { fg = c.base0, bg = c.base04 },
  TabLine = { fg = c.base0, bg = c.base02, sp = c.base0 },
  TabLineFill = { fg = c.base0, bg = c.base02 },
  TabLineSel = { fg = c.yellow500, bg = c.bg },
  Title = { fg = c.orange500, bold = true },
  Visual = { bg = c.base02 },
  VisualNOS = { bg = c.base03, reverse = true },
  WarningMsg = { fg = c.orange500, bold = true },
  Whitespace = { fg = c.base01 },
  WildMenu = { fg = c.base2, bg = c.base02, reverse = true },
  WinBar = "StatusLine",
  WinBarNC = "StatusLineNC",

  -- native LSP
  LspReferenceText = { bg = c.magenta900 },
  LspReferenceRead = { bg = c.magenta900 },
  LspReferenceWrite = { bg = c.magenta900 },
  LspSignatureActiveParameter = { bg = c.base03, bold = true },
  LspCodeLens = { fg = c.base01 },
  LspInlayHint = { bg = c.violet900, fg = c.violet500 },
  LspInfoBorder = { fg = c.base02, bg = c.base04 },

  -- diagnostics
  DiagnosticError = { fg = c.error },
  DiagnosticWarn = { fg = c.warning },
  DiagnosticInfo = { fg = c.info },
  DiagnosticHint = { fg = c.hint },
  DiagnosticUnnecessary = { fg = c.base00 },
  DiagnosticVirtualTextError = { bg = c.red900, fg = c.red500 },
  DiagnosticVirtualTextWarn = { bg = c.yellow900, fg = c.yellow500 },
  DiagnosticVirtualTextInfo = { bg = c.blue900, fg = c.blue500 },
  DiagnosticVirtualTextHint = { bg = c.cyan900, fg = c.cyan500 },
  DiagnosticUnderlineError = { undercurl = true, sp = c.error },
  DiagnosticUnderlineWarn = { undercurl = true, sp = c.warning },
  DiagnosticUnderlineInfo = { undercurl = true, sp = c.info },
  DiagnosticUnderlineHint = { undercurl = true, sp = c.hint },

  healthError = { fg = c.error },
  healthSuccess = { fg = c.cyan },
  healthWarning = { fg = c.warning },

  diffAdded = { fg = c.green500 },
  diffRemoved = { fg = c.red500 },
  diffChanged = { fg = c.yellow500 },
  diffOldFile = { fg = c.violet500 },
  diffNewFile = { fg = c.orange500 },
  diffFile = { fg = c.blue500 },
  diffLine = { fg = c.base01 },
  diffIndexLine = { fg = c.magenta500 },

  -- syntax
  Comment = { fg = c.base01, italic = true },
  Constant = { fg = c.cyan500 },
  String = { fg = c.cyan500 },
  Character = "Constant",
  Identifier = { fg = c.blue500 },
  Function = { fg = c.blue500 },
  Statement = { fg = c.green500 },
  Operator = { fg = c.green500 },
  Keyword = { fg = c.green500, italic = true },
  PreProc = { fg = c.red500 },
  Type = { fg = c.yellow500 },
  Special = { fg = c.orange500 },
  Debug = { fg = c.orange500 },
  htmlH1 = { fg = c.magenta500, bold = true },
  htmlH2 = { fg = c.blue500, bold = true },
  mkdCode = { bg = c.green900 },
  mkdCodeDelimiter = { fg = c.base0, bg = c.green700 },
  mkdCodeStart = { fg = c.orange500, bold = true },
  mkdCodeEnd = { fg = c.orange500, bold = true },
  markdownHeadingDelimiter = { fg = c.orange500, bold = true },
  markdownCode = { fg = c.yellow500, bg = c.green900 },
  markdownCodeBlock = { fg = c.yellow500, bg = c.green900 },
  markdownH1 = { fg = c.magenta500, bold = true },
  markdownH2 = { fg = c.violet500, bold = true },
  markdownLinkText = { fg = c.blue500, underline = true },

  -- treesitter
  ["@annotation"] = "PreProc",
  ["@attribute"] = "PreProc",
  ["@boolean"] = "Boolean",
  ["@character"] = "Character",
  ["@character.special"] = "SpecialChar",
  ["@comment"] = "Comment",
  ["@keyword.conditional"] = "Conditional",
  ["@constant"] = "Constant",
  ["@constant.builtin"] = "Special",
  ["@constant.macro"] = "Define",
  ["@keyword.debug"] = "Debug",
  ["@keyword.directive.define"] = "Define",
  ["@keyword.exception"] = "Exception",
  ["@number.float"] = "Float",
  ["@function"] = "Function",
  ["@function.builtin"] = "Special",
  ["@function.call"] = "@function",
  ["@function.macro"] = "Macro",
  ["@keyword.import"] = "Include",
  ["@keyword.coroutine"] = "@keyword",
  ["@keyword.operator"] = "@operator",
  ["@keyword.return"] = "@keyword",
  ["@function.method"] = "Function",
  ["@function.method.call"] = "@function.method",
  ["@namespace.builtin"] = "@variable.builtin",
  ["@none"] = {},
  ["@number"] = "Number",
  ["@keyword.directive"] = "PreProc",
  ["@keyword.repeat"] = "Repeat",
  ["@keyword.storage"] = "StorageClass",
  ["@string"] = "String",
  ["@markup.link.label"] = "SpecialChar",
  ["@markup.link.label.symbol"] = "Identifier",
  ["@tag"] = "Label",
  ["@tag.attribute"] = "@property",
  ["@tag.delimiter"] = "Delimiter",
  ["@markup"] = "@none",
  ["@markup.environment"] = "Macro",
  ["@markup.environment.name"] = "Type",
  ["@markup.raw"] = "String",
  ["@markup.math"] = "Special",
  ["@markup.strong"] = { bold = true },
  ["@markup.italic"] = { italic = true },
  ["@markup.strikethrough"] = { strikethrough = true },
  ["@markup.underline"] = { underline = true },
  ["@markup.heading"] = "Title",
  ["@comment.note"] = { fg = c.hint },
  ["@comment.error"] = { fg = c.error },
  ["@comment.hint"] = { fg = c.hint },
  ["@comment.info"] = { fg = c.info },
  ["@comment.warning"] = { fg = c.warning },
  ["@comment.todo"] = { fg = c.todo },
  ["@markup.link.url"] = "Underlined",
  ["@type"] = "Type",
  ["@type.definition"] = "Typedef",
  ["@type.qualifier"] = "@keyword",
  ["@punctuation.delimiter"] = { fg = c.green500 },
  ["@punctuation.bracket"] = { fg = c.orange500 },
  ["@punctuation.special"] = { fg = c.orange500 },
  ["@punctuation.special.markdown"] = { fg = c.orange500, bold = true },
  ["@markup.list"] = { fg = c.blue500 },
  ["@markup.list.markdown"] = { fg = c.orange500, bold = true },
  ["@string.documentation"] = { fg = c.cyan500 },
  ["@string.regexp"] = { fg = c.cyan300 },
  ["@string.escape"] = { fg = c.orange700 },
  ["@constructor"] = { fg = c.orange500 },
  ["@variable.parameter"] = { fg = c.orange500 },
  ["@variable.parameter.builtin"] = { fg = c.yellow300 },
  ["@keyword"] = { fg = c.green500, italic = true },
  ["@keyword.function"] = { fg = c.green500 },
  ["@label"] = { fg = c.green500 },
  ["@type.builtin"] = "Type",
  ["@variable.member"] = { fg = c.cyan500 },
  ["@property"] = "Identifier",
  ["@variable"] = { fg = c.base0 },
  ["@variable.builtin"] = { fg = c.orange500 },
  ["@module.builtin"] = { fg = c.orange500 },
  ["@markup.raw.markdown"] = { fg = c.blue },
  ["@markup.raw.markdown_inline"] = { fg = c.yellow500, bg = c.green900 },
  ["@markup.link"] = { fg = c.blue500, underline = true },
  ["@markup.list.unchecked"] = { fg = c.yellow500 },
  ["@markup.list.checked"] = { fg = c.green500 },
  ["@diff.plus"] = "DiffAdd",
  ["@diff.minus"] = "DiffDelete",
  ["@diff.delta"] = "DiffChange",
  ["@module"] = "Include",
  ["@constructor.tsx"] = { fg = c.blue500 },
  ["@tag.delimiter.tsx"] = { fg = c.orange500 },
  ["@tag.tsx"] = { fg = c.yellow500 },
  ["@keyword.return.tsx"] = { fg = c.green500, italic = true },
  ["@keyword.tsx"] = { fg = c.green500, italic = true },
  ["@variable.typescript"] = { fg = c.yellow500 },
  ["@tag.delimiter.vue"] = { fg = c.orange500 },
  ["@tag.delimiter.html"] = { fg = c.orange500 },
  ["@keyword.javascript"] = { fg = c.green500, italic = true },
  ["@keyword.return.javascript"] = { fg = c.green500, italic = true },
  ["@tag.delimiter.javascript"] = { fg = c.orange500 },
  ["@tag.javascript"] = { fg = c.yellow500 },
  ["@variable.javascript"] = { fg = c.yellow500 },
}

if vim.g.colors_name then
  vim.cmd("hi clear")
end
vim.g.colors_name = "solarized-osaka"

for group, val in pairs(groups) do
  set(group, val)
end
