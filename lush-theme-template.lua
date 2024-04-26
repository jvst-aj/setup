-- Disable diagnostics for undefined-global
---@diagnostic disable: undefined-global

-- See realtime theme with :Lushify

-- COLORSCHEME ATTRIBUTES
--
-- <HighlightGroupName> {
--     -- Background color of the highlighted text
--     bg = '#1e2127',
--
--     -- Foreground color of the highlighted text
--     fg = hsl("#c6c6c6"),,
--
--     -- Special color used for underlines, etc.
--     sp = '#61afef',
--
--     -- Graphical enhancements like bold, italic, etc.
--     gui = 'bold,italic',
--
--     -- Applies bold style to the highlighted text
--     bold = true,
--
--     -- Applies italic style to the highlighted text
--     italic = false,
--
--     -- Underlines the highlighted text
--     underline = true,
--
--     -- Enables or disables undercurl (curl underline)
--     undercurl = false,
--
--     -- Strikes through the highlighted text
--     strikethrough = false,
--
--     -- Reverses the foreground and background colors
--     reverse = false,
--
--     -- Inverts the foreground and background colors
--     inverse = false,
--
--     -- Emphasizes the highlighted text
--     standout = false,
--
--     -- Allows combining multiple text formatting attributes
--     nocombine = false,
--
--     -- Resets all text formatting attributes
--     none = false,
--
--     -- Transparency blend for GUI colors (0-100)
--     blend = 10,
--   }

-- LUSH FUNCTIONS
--
-- Lush.hsl (and hsluv) provides a number of convenience functions for:
--
--   Relative adjustment (rotate(), saturate(), desaturate(), lighten(), darken())
--   Absolute adjustment (prefix above with abs_)
--   Combination         (mix())
--   Overrides           (hue(), saturation(), lightness())
--   Access              (.h, .s, .l)
--   Coercion            (tostring(), "Concatination: " .. color)
--   Helpers             (readable())

-- For example, we can adjust our comments to look like desaturate normal text
-- Comment { fg = Normal.bg.desaturate(25).lighten(25).rotate(-10) },

-- LUSH ACCESS AND LINKING
--
-- Lush can access colors of other groups
-- Visual { fg = Normal.bg, bg = Normal.fg }, -- Try pressing v and selecting some text

-- Besides directly using group properties, we can define two relationships
-- between groups, "link" and "inherit".
--
-- Link is natively supported by Neovim (see `:h hl-link`), both groups
-- will appear the same, and changes to the "root" will effect the other.
--
-- Inherit groups behave similarly to link, but the parent group properties
-- are copied to the child, and then any changed properties override the
-- parent.

-- For example, let's "link" CursorColumn to CursorLine.
-- CursorColumn { CursorLine }, -- CursorColumn is linked to CursorLine
-- Or we can make LineNr inherit from Comment, but we'll override the gui
-- LineNr { Comment, gui = "italic" },

-- THE THEME TABLE
--
-- By default, lush() actually returns your theme as a table. You can
-- interact with it in much the same way as you can inside a lush-spec.
--
-- This looks something like:
--
--   local theme = lush(function()
--     -- define a theme
--     return {
--       Normal { fg = hsl(0, 100, 50) },
--       CursorLine { Normal },
--     }
--   end)
--
--   -- behaves the same as above:
--   theme.Normal.fg()                     -- returns table {h = h, s = s, l = l}
--   tostring(theme.Normal.fg)             -- returns "#hexstring"
--   tostring(theme.Normal.fg.lighten(10)) -- you can still modify colors, etc
--
-- This means you can `require('my_lush_file')` in any lua code to access your
-- themes's color information (including outside of neovim).
--
-- Note:
--
-- "Linked" groups do not expose their colors, you can find the key
-- of their linked group via the 'link' key (may require chaining)
--
--   theme.CursorLine.fg() -- This is bad!
--   theme.CursorLine.link -- = "Normal"

-- YOUR CUSTOM THEME
--
-- Require lush and set HSL function to local variable
local lush = require("lush")
local hsl = lush.hsl

-- Set Lush theme
local theme = lush(function(injected_functions)
	local sym = injected_functions.sym

	return {
		-- Highlight groups
		-- See :h highlight-groups

		-- Columns set with 'colorcolumn'
		ColorColumn({}),

		-- Placeholder characters substituted for concealed text (see 'conceallevel')
		Conceal({}),

		-- Character under the cursor
		Cursor({}),

		-- Highlighting a search pattern under the cursor (see 'hlsearch')
		CurSearch({}),

		-- Character under the cursor when |language-mapping| is used (see 'guicursor')
		lCursor({}),

		-- Like Cursor, but used when in IME mode |CursorIM|
		CursorIM({}),

		-- Screen-column at the cursor, when 'cursorcolumn' is set.
		CursorColumn({}),

		-- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guifg) is not set.
		CursorLine({}),

		-- Directory names (and other special names in listings)
		Directory({}),

		-- Diff mode: Added line |diff.txt|
		DiffAdd({}),

		-- Diff mode: Changed line |diff.txt|
		DiffChange({}),

		-- Diff mode: Deleted line |diff.txt|
		DiffDelete({}),

		-- Diff mode: Changed text within a changed line |diff.txt|
		DiffText({}),

		-- Filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|.
		EndOfBuffer({}),

		-- Cursor in a focused terminal
		TermCursor({}),

		-- Cursor in an unfocused terminal
		TermCursorNC({}),

		-- Error messages on the command line
		ErrorMsg({}),

		-- Column separating vertically split windows
		VertSplit({}),

		-- Line used for closed folds
		Folded({}),

		-- 'foldcolumn'
		FoldColumn({}),

		-- Column where |signs| are displayed
		SignColumn({}),

		-- 'incsearch' highlighting; also used for the text replaced with ":s///c"
		IncSearch({}),

		-- |:substitute| replacement text highlighting
		Substitute({}),

		-- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
		LineNr({}),

		-- Line number for when the 'relativenumber' option is set, above the cursor line
		LineNrAbove({}),

		-- Line number for when the 'relativenumber' option is set, below the cursor line
		LineNrBelow({}),

		-- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
		CursorLineNr({}),

		-- Like FoldColumn when 'cursorline' is set for the cursor line
		CursorLineFold({}),

		-- Like SignColumn when 'cursorline' is set for the cursor line
		CursorLineSign({}),

		-- Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
		MatchParen({}),

		-- 'showmode' message (e.g., "-- INSERT -- ")
		ModeMsg({}),

		-- Area for messages and cmdline
		MsgArea({}),

		-- Separator for scrolled messages, `msgsep` flag of 'display'
		MsgSeparator({}),

		-- |more-prompt|
		MoreMsg({}),

		-- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
		NonText({}),

		-- Normal text
		Normal({}),

		-- Normal text in floating windows.
		NormalFloat({}),

		-- Border of floating windows.
		FloatBorder({}),

		-- Title of floating windows.
		FloatTitle({}),

		-- normal text in non-current windows
		NormalNC({}),

		-- Popup menu: Normal item.
		Pmenu({}),

		-- Popup menu: Selected item.
		PmenuSel({}),

		-- Popup menu: Normal item "kind"
		PmenuKind({}),

		-- Popup menu: Selected item "kind"
		PmenuKindSel({}),

		-- Popup menu: Normal item "extra text"
		PmenuExtra({}),

		-- Popup menu: Selected item "extra text"
		PmenuExtraSel({}),

		-- Popup menu: Scrollbar.
		PmenuSbar({}),

		-- Popup menu: Thumb of the scrollbar.
		PmenuThumb({}),

		-- |hit-enter| prompt and yes/no questions
		Question({}),

		-- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
		QuickFixLine({}),

		-- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
		Search({}),

		-- Unprintable characters: text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|
		SpecialKey({}),

		-- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
		SpellBad({}),

		-- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
		SpellCap({}),

		-- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
		SpellLocal({}),

		-- Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.
		SpellRare({}),

		-- Status line of current window
		StatusLine({}),

		-- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
		StatusLineNC({}),

		-- Tab pages line, not active tab page label
		TabLine({}),

		-- Tab pages line, where there are no labels
		TabLineFill({}),

		-- Tab pages line, active tab page label
		TabLineSel({}),

		-- Titles for output from ":set all", ":autocmd" etc.
		Title({}),

		-- Visual mode selection
		Visual({}),

		-- Visual mode selection when vim is "Not Owning the Selection".
		VisualNOS({}),

		-- Warning messages
		WarningMsg({}),

		-- "nbsp", "space", "tab" and "trail" in 'listchars'
		Whitespace({}),

		-- Separator between window splits. Inherts from |hl-VertSplit| by default, which it will replace eventually.
		Winseparator({}),

		-- Current match in 'wildmenu' completion
		WildMenu({}),

		-- Window bar of current window
		WinBar({}),

		-- Window bar of not-current windows
		WinBarNC({}),

		-- Common vim syntax groups used for all kinds of code and markup.
		-- See :h group-name

		-- Any comment
		Comment({}),
		-- (*) Any constant
		Constant({}),
		-- A string constant: "this is a string"
		String({}),
		-- A character constant: 'c', '\n'
		Character({}),
		-- A number constant: 234, 0xff
		Number({}),
		-- A boolean constant: TRUE, false
		Boolean({}),
		-- A floating point constant: 2.3e10
		Float({}),

		-- (*) Any variable name
		Identifier({}),
		-- Function name (also: methods for classes)
		Function({}),

		-- (*) Any statement
		Statement({}),
		-- if, then, else, endif, switch, etc.
		Conditional({}),
		-- for, do, while, etc.
		Repeat({}),
		-- case, default, etc.
		Label({}),
		-- "sizeof", "+", "*", etc.
		Operator({}),
		-- any other keyword
		Keyword({}),
		-- try, catch, throw
		Exception({}),

		-- (*) Generic Preprocessor
		PreProc({}),
		-- Preprocessor #include
		Include({}),
		-- Preprocessor #define
		Define({}),
		-- Same as Define
		Macro({}),
		-- Preprocessor #if, #else, #endif, etc.
		PreCondit({}),

		-- Type           { }, -- (*) int, long, char, etc.
		-- StorageClass   { }, --   static, register, volatile, etc.
		-- Structure      { }, --   struct, union, enum, etc.
		-- Typedef        { }, --   A typedef

		-- Special        { }, -- (*) Any special symbol
		-- SpecialChar    { }, --   Special character in a constant
		-- Tag            { }, --   You can use CTRL-] on this
		-- Delimiter      { }, --   Character that needs attention
		-- SpecialComment { }, --   Special things inside a comment (e.g. '\n')
		-- Debug          { }, --   Debugging statements

		-- Underlined     { gui = "underline" }, -- Text that stands out, HTML links
		-- Ignore         { }, -- Left blank, hidden |hl-Ignore| (NOTE: May be invisible here in template)
		-- Error          { }, -- Any erroneous construct
		-- Todo           { }, -- Anything that needs extra attention; mostly the keywords TODO FIXME and XXX

		-- (*) int, long, char, etc.
		Type({}),
		-- static, register, volatile, etc.
		StorageClass({}),
		-- struct, union, enum, etc.
		Structure({}),
		-- A typedef
		Typedef({}),

		-- (*) Any special symbol
		Special({}),
		-- Special character in a constant
		SpecialChar({}),
		-- You can use CTRL-] on this
		Tag({}),
		-- Character that needs attention
		Delimiter({}),
		-- Special things inside a comment (e.g. '\n')
		SpecialComment({}),
		-- Debugging statements
		Debug({}),

		-- Text that stands out, HTML links
		Underlined({ gui = "underline" }),
		-- Left blank, hidden |hl-Ignore| (NOTE: May be invisible here in template)
		Ignore({}),
		-- Any erroneous construct
		Error({}),
		-- Anything that needs extra attention; mostly the keywords TODO FIXME and XXX
		Todo({}),

		-- These groups are for the native LSP client and diagnostic system. Some
		-- other LSP clients may use these groups, or use their own. Consult your
		-- LSP client's documentation.

		-- See :h lsp-highlight, some groups may not be listed, submit a PR fix to lush-template!

		-- Used for highlighting "text" references
		-- LspReferenceText({}),
		-- Used for highlighting "read" references
		-- LspReferenceRead({}),
		-- Used for highlighting "write" references
		-- LspReferenceWrite({}),
		-- Used to color the virtual text of the codelens. See |nvim_buf_set_extmark()|.
		-- LspCodeLens({}),
		-- Used to color the separator between two or more code lens.
		-- LspCodeLensSeparator({}),
		-- Used to highlight the active parameter in the signature help. See |vim.lsp.handlers.signature_help()|.
		-- LspSignatureActiveParameter({}),

		-- See :h diagnostic-highlights, some groups may not be listed, submit a PR fix to lush-template!
		--
		-- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
		DiagnosticError({}),
		-- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
		DiagnosticWarn({}),
		-- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
		DiagnosticInfo({}),
		-- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
		DiagnosticHint({}),
		-- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
		DiagnosticOk({}),
		-- Used for "Error" diagnostic virtual text.
		DiagnosticVirtualTextError({}),
		-- Used for "Warn" diagnostic virtual text.
		DiagnosticVirtualTextWarn({}),
		-- Used for "Info" diagnostic virtual text.
		DiagnosticVirtualTextInfo({}),
		-- Used for "Hint" diagnostic virtual text.
		DiagnosticVirtualTextHint({}),
		-- Used for "Ok" diagnostic virtual text.
		DiagnosticVirtualTextOk({}),
		-- Used to underline "Error" diagnostics.
		DiagnosticUnderlineError({}),
		-- Used to underline "Warn" diagnostics.
		DiagnosticUnderlineWarn({}),
		-- Used to underline "Info" diagnostics.
		DiagnosticUnderlineInfo({}),
		-- Used to underline "Hint" diagnostics.
		DiagnosticUnderlineHint({}),
		-- Used to underline "Ok" diagnostics.
		DiagnosticUnderlineOk({}),
		-- Used to color "Error" diagnostic messages in diagnostics float. See |vim.diagnostic.open_float()|
		DiagnosticFloatingError({}),
		-- Used to color "Warn" diagnostic messages in diagnostics float.
		DiagnosticFloatingWarn({}),
		-- Used to color "Info" diagnostic messages in diagnostics float.
		DiagnosticFloatingInfo({}),
		-- Used to color "Hint" diagnostic messages in diagnostics float.
		DiagnosticFloatingHint({}),
		-- Used to color "Ok" diagnostic messages in diagnostics float.
		DiagnosticFloatingOk({}),
		-- Used for "Error" signs in sign column.
		DiagnosticSignError({}),
		-- Used for "Warn" signs in sign column.
		DiagnosticSignWarn({}),
		-- Used for "Info" signs in sign column.
		DiagnosticSignInfo({}),
		-- Used for "Hint" signs in sign column.
		DiagnosticSignHint({}),
		-- Used for "Ok" signs in sign column.
		DiagnosticSignOk({}),

		-- Tree-Sitter syntax groups.
		--
		-- See :h treesitter-highlight-groups, some groups may not be listed,
		-- submit a PR fix to lush-template!
		--
		-- Tree-Sitter groups are defined with an "@" symbol, which must be
		-- specially handled to be valid lua code, we do this via the special
		-- sym function. The following are all valid ways to call the sym function,
		-- for more details see https://www.lua.org/pil/5.html
		--
		-- sym("@text.literal")
		-- sym('@text.literal')
		-- sym"@text.literal"
		-- sym'@text.literal'
		--
		-- For more information see https://github.com/rktjmp/lush.nvim/issues/109

		sym("@text.literal")({}), -- Comment
		sym("@text.reference")({}), -- Identifier
		sym("@text.title")({}), -- Title
		sym("@text.uri")({}), -- Underlined
		sym("@text.underline")({}), -- Underlined
		sym("@text.todo")({}), -- Todo
		sym("@comment")({}), -- Comment
		sym("@punctuation")({}), -- Delimiter
		sym("@constant")({}), -- Constant
		sym("@constant.builtin")({}), -- Special
		sym("@constant.macro")({}), -- Define
		sym("@define")({}), -- Define
		sym("@macro")({}), -- Macro
		sym("@string")({}), -- String
		sym("@string.escape")({}), -- SpecialChar
		sym("@string.special")({}), -- SpecialChar
		sym("@character")({}), -- Character
		sym("@character.special")({}), -- SpecialChar
		sym("@number")({}), -- Number
		sym("@boolean")({}), -- Boolean
		sym("@float")({}), -- Float
		sym("@function")({}), -- Function
		sym("@function.builtin")({}), -- Special
		sym("@function.macro")({}), -- Macro
		sym("@parameter")({}), -- Identifier
		sym("@method")({}), -- Function
		sym("@field")({}), -- Identifier
		sym("@property")({}), -- Identifier
		sym("@constructor")({}), -- Special
		sym("@conditional")({}), -- Conditional
		sym("@repeat")({}), -- Repeat
		sym("@label")({}), -- Label
		sym("@operator")({}), -- Operator
		sym("@keyword")({}), -- Keyword
		sym("@exception")({}), -- Exception
		sym("@variable")({}), -- Identifier
		sym("@type")({}), -- Type
		sym("@type.definition")({}), -- Typedef
		sym("@storageclass")({}), -- StorageClass
		sym("@structure")({}), -- Structure
		sym("@namespace")({}), -- Identifier
		sym("@include")({}), -- Include
		sym("@preproc")({}), -- PreProc
		sym("@debug")({}), -- Debug
		sym("@tag")({}), -- Tag
	}
end)

-- Return our parsed theme for extension or use elsewhere.
return theme
