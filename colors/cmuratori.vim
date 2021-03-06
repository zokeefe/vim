" Vim color file - cmuratori
" Colorscheme taken from Casey Muratori's Emacs config
" Generated by http://bytefluent.com/vivify 2016-01-30
set background=dark
if version > 580
	hi clear
	if exists("syntax_on")
		syntax reset
	endif
endif

set t_Co=256
let g:colors_name = "cmuratori"

"hi Title -- no settings --
"hi CTagsMember -- no settings --
"hi CTagsGlobalConstant -- no settings --
"hi Ignore -- no settings --
hi Normal guifg=#cdaa7d guibg=#161616 guisp=#161616 gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
"hi CTagsImport -- no settings --
"hi CTagsGlobalVariable -- no settings --
"hi EnumerationValue -- no settings --
"hi Union -- no settings --
"hi EnumerationName -- no settings --
"hi DefinedName -- no settings --
"hi LocalVariable -- no settings --
"hi CTagsClass -- no settings --
"hi clear -- no settings --
hi IncSearch guifg=#161616 guibg=#D5538B guisp=#D5538B gui=NONE ctermfg=NONE ctermbg=88 cterm=NONE
hi WildMenu guifg=#7f7f7f guibg=#191970 guisp=#191970 gui=NONE ctermfg=8 ctermbg=17 cterm=NONE
hi SignColumn guifg=#192224 guibg=#536991 guisp=#536991 gui=NONE ctermfg=235 ctermbg=60 cterm=NONE
hi SpecialComment guifg=#BD9800 guibg=NONE guisp=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi Typedef guifg=#cdaa7d guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi Folded guifg=#192224 guibg=#A1A6A8 guisp=#A1A6A8 gui=italic ctermfg=235 ctermbg=248 cterm=NONE
hi PreCondit guifg=#cdaa7d guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi Include guifg=#cdaa7d guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi Float guifg=#cdaa7d guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi StatusLineNC guifg=#7f7f7f guibg=#262626 guisp=#262626 gui=NONE ctermfg=8 ctermbg=235 cterm=NONE
hi NonText guifg=#2f4263 guibg=NONE guisp=NONE gui=italic ctermfg=17 ctermbg=NONE cterm=NONE
hi DiffText guifg=NONE guibg=#492224 guisp=#492224 gui=NONE ctermfg=NONE ctermbg=52 cterm=NONE
hi ErrorMsg guifg=#ff0011 guibg=NONE guisp=NONE gui=NONE ctermfg=196 ctermbg=NONE cterm=NONE
hi Debug guifg=#cdaa7d guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi PMenuSbar guifg=#7f7f7f guibg=#7f7f7f guisp=#7f7f7f gui=NONE ctermfg=8 ctermbg=8 cterm=NONE
hi Identifier guifg=#BD9800 guibg=NONE guisp=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi SpecialChar guifg=#BD9800 guibg=NONE guisp=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi Conditional guifg=#BD9800 guibg=NONE guisp=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi StorageClass guifg=#cdaa7d guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi Todo guifg=#ff0000 guibg=NONE guisp=NONE gui=bold,underline ctermfg=196 ctermbg=NONE cterm=bold,underline
hi Special guifg=#6a8e23 guibg=NONE guisp=NONE gui=NONE ctermfg=64 ctermbg=NONE cterm=NONE
hi LineNr guifg=#2f4263 guibg=NONE guisp=NONE gui=NONE ctermfg=17 ctermbg=NONE cterm=NONE
hi StatusLine guifg=#161616 guibg=#7f7f7f guisp=#7f7f7f gui=NONE ctermfg=233 ctermbg=8 cterm=NONE
hi Label guifg=#BD9800 guibg=NONE guisp=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi PMenuSel guifg=#7f7f7f guibg=#191970 guisp=#191970 gui=NONE ctermfg=8 ctermbg=17 cterm=NONE
hi Search guifg=#161616 guibg=#D5538B guisp=#D5538B gui=NONE ctermfg=NONE ctermbg=88 cterm=NONE
hi Delimiter guifg=#BD9800 guibg=NONE guisp=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi Statement guifg=#cd960c guibg=NONE guisp=NONE gui=NONE ctermfg=172 ctermbg=NONE cterm=NONE
hi SpellRare guifg=#F9F9FF guibg=#192224 guisp=#192224 gui=underline ctermfg=189 ctermbg=235 cterm=underline
hi Comment guifg=#7f7f7f guibg=NONE guisp=NONE gui=NONE ctermfg=8 ctermbg=NONE cterm=NONE
hi Character guifg=#A1A6A8 guibg=NONE guisp=NONE gui=NONE ctermfg=248 ctermbg=NONE cterm=NONE
hi TabLineSel guifg=#7f7f7f guibg=#191970 guisp=#191970 gui=bold ctermfg=8 ctermbg=17 cterm=bold
hi Number guifg=#cdaa7d guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi Boolean guifg=#6a8e23 guibg=NONE guisp=NONE gui=NONE ctermfg=64 ctermbg=NONE cterm=NONE
hi Operator guifg=#BD9800 guibg=NONE guisp=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi CursorLine guifg=NONE guibg=#191970 guisp=#191970 gui=NONE ctermfg=NONE ctermbg=17 cterm=NONE
hi TabLineFill guifg=#192224 guibg=#7f7f7f guisp=#7f7f7f gui=bold ctermfg=235 ctermbg=8 cterm=bold
hi Question guifg=#cdaa7d guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi WarningMsg guifg=#A1A6A8 guibg=#912C00 guisp=#912C00 gui=NONE ctermfg=248 ctermbg=88 cterm=NONE
hi VisualNOS guifg=white guibg=#191970 guisp=#191970 gui=underline ctermfg=white ctermbg=17 cterm=underline
hi DiffDelete guifg=NONE guibg=#192224 guisp=#192224 gui=NONE ctermfg=NONE ctermbg=235 cterm=NONE
hi ModeMsg guifg=#7f7f7f guibg=NONE guisp=NONE gui=bold ctermfg=8 ctermbg=NONE cterm=bold
hi CursorColumn guifg=NONE guibg=#222E30 guisp=#222E30 gui=NONE ctermfg=NONE ctermbg=236 cterm=NONE
hi Define guifg=#cdaa7d guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi Function guifg=#cdaa7d guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi FoldColumn guifg=#192224 guibg=#A1A6A8 guisp=#A1A6A8 gui=italic ctermfg=235 ctermbg=248 cterm=NONE
hi PreProc guifg=#cdaa7d guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi Visual guifg=white guibg=#191970 guisp=#191970 gui=NONE ctermfg=white ctermbg=17 cterm=NONE
hi MoreMsg guifg=#BD9800 guibg=NONE guisp=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi SpellCap guifg=#F9F9FF guibg=#192224 guisp=#192224 gui=underline ctermfg=189 ctermbg=235 cterm=underline
hi VertSplit guifg=NONE guibg=#7f7f7f guisp=#7f7f7f gui=bold ctermfg=NONE ctermbg=8 cterm=bold
hi Exception guifg=#BD9800 guibg=NONE guisp=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi Keyword guifg=#BD9800 guibg=NONE guisp=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi Type guifg=#cdaa7d guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi DiffChange guifg=NONE guibg=#492224 guisp=#492224 gui=NONE ctermfg=NONE ctermbg=52 cterm=NONE
hi Cursor guifg=#161616 guibg=#40ff40 guisp=#40ff40 gui=NONE ctermfg=233 ctermbg=83 cterm=NONE
hi SpellLocal guifg=#F9F9FF guibg=#192224 guisp=#192224 gui=underline ctermfg=189 ctermbg=235 cterm=underline
hi Error guifg=#ff0000 guibg=NONE guisp=NONE gui=NONE ctermfg=196 ctermbg=NONE cterm=NONE
hi PMenu guifg=#161616 guibg=#7f7f7f guisp=#7f7f7f gui=NONE ctermfg=233 ctermbg=8 cterm=NONE
hi SpecialKey guifg=#5E6C70 guibg=NONE guisp=NONE gui=italic ctermfg=66 ctermbg=NONE cterm=NONE
hi Constant guifg=#6a8e23 guibg=NONE guisp=NONE gui=NONE ctermfg=64 ctermbg=NONE cterm=NONE
hi Tag guifg=#BD9800 guibg=NONE guisp=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi String guifg=#6a8e23 guibg=NONE guisp=NONE gui=NONE ctermfg=64 ctermbg=NONE cterm=NONE
hi PMenuThumb guifg=NONE guibg=#a4a6a8 guisp=#a4a6a8 gui=NONE ctermfg=NONE ctermbg=248 cterm=NONE
hi MatchParen guifg=#BD9800 guibg=NONE guisp=NONE gui=bold ctermfg=1 ctermbg=NONE cterm=bold
hi Repeat guifg=#BD9800 guibg=NONE guisp=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi SpellBad guifg=#F9F9FF guibg=#192224 guisp=#192224 gui=underline ctermfg=189 ctermbg=235 cterm=underline
hi Directory guifg=#cdaa7d guibg=NONE guisp=NONE gui=bold ctermfg=180 ctermbg=NONE cterm=bold
hi Structure guifg=#cd960c guibg=NONE guisp=NONE gui=NONE ctermfg=172 ctermbg=NONE cterm=NONE
hi Macro guifg=#cdaa7d guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi Underlined guifg=#F9F9FF guibg=#192224 guisp=#192224 gui=underline ctermfg=189 ctermbg=235 cterm=underline
hi DiffAdd guifg=NONE guibg=#193224 guisp=#193224 gui=NONE ctermfg=NONE ctermbg=236 cterm=NONE
hi TabLine guifg=#192224 guibg=#7f7f7f guisp=#7f7f7f gui=bold ctermfg=235 ctermbg=8 cterm=bold
hi cursorim guifg=#192224 guibg=#536991 guisp=#536991 gui=NONE ctermfg=235 ctermbg=60 cterm=NONE
hi ColorColumn guifg=#161616 guibg=NONE ctermfg=88 ctermbg=NONE
hi IncSearch guifg=#161616 guibg=#D5538B guisp=#D5538B gui=NONE ctermfg=NONE ctermbg=88 cterm=NONE
