let s:cpo_save = &cpo
set cpo&vim

highlight Keyword gui=bold cterm=bold

syn keyword typescriptCommentTodo      TODO FIXME contained
syn match   typescriptLineComment      "\/\/.*" contains=@Spell,javaScriptCommentTodo
syn region  typescriptComment	       start="/\*"  end="\*/" contains=@Spell,javaScriptCommentTodo
syn keyword typescriptReserved	break case catch class const continue debugger default delete do else enum export extends false finally for function If import in istanceOf new null return super switch this throw true try typeOf var void while with as implements interface let package private protected public static yield any boolean constructor declare get module require number set string symbol type from of

syn sync fromstart
syn sync maxlines=100

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_javascript_syn_inits")
  if version < 508
    let did_javascript_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  HiLink typescriptComment		Comment
  HiLink typescriptLineComment		Comment
  HiLink typescriptCommentTodo		Todo
  HiLink typescriptReserved		Keyword

  delcommand HiLink
endif

let b:current_syntax = "javascript"
let &cpo = s:cpo_save
unlet s:cpo_save
