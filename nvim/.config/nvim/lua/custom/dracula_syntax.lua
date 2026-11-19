-- Syntax highlighting for dracula.nvim laid out the way tokyonight does it.
--
-- tokyonight tells apart more kinds of tokens (fields, parameters, types, builtins)
-- than dracula.nvim. The group list below is tokyonight-moon's: every group keeps
-- its tokyonight colour role, and each role is mapped to a Dracula palette colour.
-- To recolour a kind of token, change one line in `roles`.
local M = {}

--- Mix `color` into `base`: 0 gives `base`, 1 gives `color`.
---@param color string '#rrggbb'
---@param base string '#rrggbb'
---@param amount number
---@return string
local function blend(color, base, amount)
  local function channel(i)
    local from = tonumber(base:sub(i, i + 1), 16)
    local to = tonumber(color:sub(i, i + 1), 16)
    return math.floor(from + (to - from) * amount + 0.5)
  end
  return string.format('#%02x%02x%02x', channel(2), channel(4), channel(6))
end

---@param c Palette dracula.nvim palette
local function roles(c)
  return {
    fg = c.fg, -- variables
    fg_dark = c.white, -- brackets
    comment = c.comment,
    green = c.green, -- strings
    yellow = c.yellow, -- parameters
    yellow_light = c.bright_yellow, -- builtin parameters
    orange = c.orange, -- constants, numbers, booleans
    red = c.red, -- builtin variables (self, this), JSX tags
    magenta = c.purple, -- if / for / return-like statements, constructors
    purple = c.pink, -- other keywords
    -- Dracula has no blue or teal, so these take the closest free colours:
    blue = c.cyan, -- functions, methods
    blue1 = c.bright_blue, -- types, classes
    cyan = c.bright_cyan, -- imports, preprocessor
    blue5 = c.bright_cyan, -- operators, punctuation
    teal = c.bright_green, -- properties, fields
  }
end

---@param c Palette dracula.nvim palette
---@return table<string, vim.api.keyset.highlight>
function M.overrides(c)
  local t = roles(c)
  return {
    ['@annotation'] = { link = 'PreProc' },
    ['@attribute'] = { link = 'PreProc' },
    ['@attribute.builtin'] = { link = 'Special' },
    ['@boolean'] = { link = 'Boolean' },
    ['@character'] = { link = 'Character' },
    ['@character.printf'] = { link = 'SpecialChar' },
    ['@character.special'] = { link = 'SpecialChar' },
    ['@comment'] = { link = 'Comment' },
    ['@comment.error'] = { fg = t.red },
    ['@comment.hint'] = { fg = t.teal },
    ['@comment.info'] = { fg = t.blue },
    ['@comment.note'] = { fg = t.teal },
    ['@comment.todo'] = { fg = t.blue },
    ['@comment.warning'] = { fg = t.yellow },
    ['@constant'] = { link = 'Constant' },
    ['@constant.builtin'] = { link = 'Special' },
    ['@constant.macro'] = { link = 'Define' },
    ['@constructor'] = { fg = t.magenta },
    ['@constructor.tsx'] = { fg = t.blue1 },
    ['@function'] = { link = 'Function' },
    ['@function.builtin'] = { link = 'Special' },
    ['@function.call'] = { link = '@function' },
    ['@function.macro'] = { link = 'Macro' },
    ['@function.method'] = { link = 'Function' },
    ['@function.method.call'] = { link = '@function.method' },
    ['@keyword'] = { fg = t.purple, italic = true },
    ['@keyword.conditional'] = { link = 'Conditional' },
    ['@keyword.coroutine'] = { link = '@keyword' },
    ['@keyword.debug'] = { link = 'Debug' },
    ['@keyword.directive'] = { link = 'PreProc' },
    ['@keyword.directive.define'] = { link = 'Define' },
    ['@keyword.exception'] = { link = 'Exception' },
    ['@keyword.function'] = { fg = t.magenta },
    ['@keyword.import'] = { link = 'Include' },
    ['@keyword.operator'] = { link = '@operator' },
    ['@keyword.repeat'] = { link = 'Repeat' },
    ['@keyword.return'] = { link = '@keyword' },
    ['@keyword.storage'] = { link = 'StorageClass' },
    ['@label'] = { fg = t.blue },
    ['@lsp.mod.deprecated'] = { link = 'DiagnosticDeprecated' },
    ['@lsp.type.boolean'] = { link = '@boolean' },
    ['@lsp.type.builtinType'] = { link = '@type.builtin' },
    ['@lsp.type.class'] = { link = '@type' },
    ['@lsp.type.comment'] = { link = '@comment' },
    ['@lsp.type.decorator'] = { link = '@attribute' },
    ['@lsp.type.deriveHelper'] = { link = '@attribute' },
    ['@lsp.type.enum'] = { link = '@type' },
    ['@lsp.type.enumMember'] = { link = '@constant' },
    ['@lsp.type.escapeSequence'] = { link = '@string.escape' },
    ['@lsp.type.event'] = { link = '@type' },
    ['@lsp.type.formatSpecifier'] = { link = '@markup.list' },
    ['@lsp.type.function'] = { link = '@function' },
    ['@lsp.type.generic'] = { link = '@variable' },
    ['@lsp.type.interface'] = { fg = t.blue1 },
    ['@lsp.type.keyword'] = { link = '@keyword' },
    ['@lsp.type.lifetime'] = { link = '@keyword.storage' },
    ['@lsp.type.macro'] = { link = '@constant.macro' },
    ['@lsp.type.method'] = { link = '@function.method' },
    ['@lsp.type.modifier'] = { link = '@type.qualifier' },
    ['@lsp.type.namespace'] = { link = '@module' },
    ['@lsp.type.namespace.python'] = { link = '@variable' },
    ['@lsp.type.number'] = { link = '@number' },
    ['@lsp.type.operator'] = { link = '@operator' },
    ['@lsp.type.parameter'] = { link = '@variable.parameter' },
    ['@lsp.type.property'] = { link = '@property' },
    ['@lsp.type.regexp'] = { link = '@string.regexp' },
    ['@lsp.type.selfKeyword'] = { link = '@variable.builtin' },
    ['@lsp.type.selfTypeKeyword'] = { link = '@variable.builtin' },
    ['@lsp.type.string'] = { link = '@string' },
    ['@lsp.type.struct'] = { link = '@type' },
    ['@lsp.type.type'] = { link = '@type' },
    ['@lsp.type.typeAlias'] = { link = '@type.definition' },
    ['@lsp.type.typeParameter'] = { link = '@type.definition' },
    ['@lsp.type.unresolvedReference'] = { undercurl = true },
    ['@lsp.type.variable'] = {},
    ['@lsp.typemod.class.defaultLibrary'] = { link = '@type.builtin' },
    ['@lsp.typemod.enum.defaultLibrary'] = { link = '@type.builtin' },
    ['@lsp.typemod.enumMember.defaultLibrary'] = { link = '@constant.builtin' },
    ['@lsp.typemod.function.defaultLibrary'] = { link = '@function.builtin' },
    ['@lsp.typemod.keyword.async'] = { link = '@keyword.coroutine' },
    ['@lsp.typemod.keyword.injected'] = { link = '@keyword' },
    ['@lsp.typemod.macro.defaultLibrary'] = { link = '@function.builtin' },
    ['@lsp.typemod.method.defaultLibrary'] = { link = '@function.builtin' },
    ['@lsp.typemod.operator.injected'] = { link = '@operator' },
    ['@lsp.typemod.string.injected'] = { link = '@string' },
    ['@lsp.typemod.struct.defaultLibrary'] = { link = '@type.builtin' },
    ['@lsp.typemod.type.defaultLibrary'] = { fg = t.blue1 },
    ['@lsp.typemod.typeAlias.defaultLibrary'] = { fg = t.blue1 },
    ['@lsp.typemod.variable.callable'] = { link = '@function' },
    ['@lsp.typemod.variable.defaultLibrary'] = { link = '@variable.builtin' },
    ['@lsp.typemod.variable.injected'] = { link = '@variable' },
    ['@lsp.typemod.variable.static'] = { link = '@constant' },
    ['@markup'] = { link = '@none' },
    ['@markup.emphasis'] = { italic = true },
    ['@markup.environment'] = { link = 'Macro' },
    ['@markup.environment.name'] = { link = 'Type' },
    ['@markup.heading'] = { link = 'Title' },
    ['@markup.heading.1.delimiter.vimdoc'] = {},
    ['@markup.heading.1.markdown'] = { fg = t.blue, bold = true },
    ['@markup.heading.2.delimiter.vimdoc'] = { underline = true },
    ['@markup.heading.2.markdown'] = { fg = t.yellow, bold = true },
    ['@markup.heading.3.markdown'] = { fg = t.green, bold = true },
    ['@markup.heading.4.markdown'] = { fg = t.teal, bold = true },
    ['@markup.heading.5.markdown'] = { fg = t.magenta, bold = true },
    ['@markup.heading.6.markdown'] = { fg = t.purple, bold = true },
    ['@markup.heading.7.markdown'] = { fg = t.orange, bold = true },
    ['@markup.heading.8.markdown'] = { fg = t.red, bold = true },
    ['@markup.italic'] = { italic = true },
    ['@markup.link'] = { fg = t.teal },
    ['@markup.link.label'] = { link = 'SpecialChar' },
    ['@markup.link.label.symbol'] = { link = 'Identifier' },
    ['@markup.link.url'] = { link = 'Underlined' },
    ['@markup.list'] = { fg = t.blue5 },
    ['@markup.list.checked'] = { fg = t.teal },
    ['@markup.list.markdown'] = { fg = t.orange, bold = true },
    ['@markup.list.unchecked'] = { fg = t.blue },
    ['@markup.math'] = { link = 'Special' },
    ['@markup.raw'] = { link = 'String' },
    ['@markup.raw.markdown_inline'] = { fg = t.blue },
    ['@markup.strikethrough'] = { strikethrough = true },
    ['@markup.strong'] = { bold = true },
    ['@markup.underline'] = { underline = true },
    ['@module'] = { link = 'Include' },
    ['@module.builtin'] = { fg = t.red },
    ['@namespace.builtin'] = { link = '@variable.builtin' },
    ['@none'] = {},
    ['@number'] = { link = 'Number' },
    ['@number.float'] = { link = 'Float' },
    ['@operator'] = { fg = t.blue5 },
    ['@property'] = { fg = t.teal },
    ['@punctuation'] = { link = 'Delimiter' },
    ['@punctuation.bracket'] = { fg = t.fg_dark },
    ['@punctuation.delimiter'] = { fg = t.blue5 },
    ['@punctuation.special'] = { fg = t.blue5 },
    ['@punctuation.special.markdown'] = { fg = t.orange },
    ['@string'] = { link = 'String' },
    ['@string.documentation'] = { fg = t.yellow },
    ['@string.escape'] = { fg = t.magenta },
    ['@string.regexp'] = { fg = t.blue5 },
    ['@string.special'] = { link = 'SpecialChar' },
    ['@string.special.url'] = { link = 'Underlined' },
    ['@tag'] = { link = 'Label' },
    ['@tag.attribute'] = { link = '@property' },
    ['@tag.builtin'] = { link = 'Special' },
    ['@tag.delimiter'] = { link = 'Delimiter' },
    ['@tag.delimiter.tsx'] = { fg = t.comment },
    ['@tag.javascript'] = { fg = t.red },
    ['@tag.tsx'] = { fg = t.red },
    ['@type'] = { link = 'Type' },
    ['@type.builtin'] = { fg = t.blue1 },
    ['@type.definition'] = { link = 'Typedef' },
    ['@type.qualifier'] = { link = '@keyword' },
    ['@variable'] = { fg = t.fg },
    ['@variable.builtin'] = { fg = t.red },
    ['@variable.member'] = { fg = t.teal },
    ['@variable.parameter'] = { fg = t.yellow },
    ['@variable.parameter.builtin'] = { fg = t.yellow_light },
    Boolean = { link = 'Constant' },
    Character = { fg = t.green },
    Conditional = { link = 'Statement' },
    Constant = { fg = t.orange },
    Debug = { fg = t.orange },
    Define = { link = 'PreProc' },
    Delimiter = { link = 'Special' },
    Exception = { link = 'Statement' },
    Float = { link = 'Number' },
    Function = { fg = t.blue },
    Identifier = { fg = t.magenta },
    Include = { link = 'PreProc' },
    Keyword = { fg = t.cyan, italic = true },
    Label = { link = 'Statement' },
    Macro = { link = 'PreProc' },
    Number = { link = 'Constant' },
    Operator = { fg = t.blue5 },
    PreCondit = { link = 'PreProc' },
    PreProc = { fg = t.cyan },
    Repeat = { link = 'Statement' },
    Special = { fg = t.blue1 },
    SpecialChar = { link = 'Special' },
    SpecialComment = { link = 'Special' },
    Statement = { fg = t.magenta },
    StorageClass = { link = 'Type' },
    String = { fg = t.green },
    Structure = { link = 'Type' },
    Tag = { link = 'Special' },
    Title = { fg = t.blue, bold = true },
    Type = { fg = t.blue1 },
    Typedef = { link = 'Type' },

    -- Occurrences of the symbol under the cursor (LSP document highlight):
    -- keep the token's own colour and mark it with a background, as tokyonight
    -- does. dracula.nvim recolours the text orange instead.
    LspReferenceText = { bg = c.selection },
    LspReferenceRead = { bg = c.selection },
    LspReferenceWrite = { bg = c.selection },

    -- Diffs (diffview, vimdiff): tint the line background and keep syntax colours,
    -- as tokyonight does. dracula.nvim colours the text of the whole line instead.
    DiffAdd = { bg = blend(c.green, c.bg, 0.2) },
    DiffDelete = { bg = blend(c.red, c.bg, 0.25) },
    DiffChange = { bg = blend(c.orange, c.bg, 0.15) },
    DiffText = { bg = blend(c.orange, c.bg, 0.4) }, -- the changed part of a changed line
  }
end

return M
