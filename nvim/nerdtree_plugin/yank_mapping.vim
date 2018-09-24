" ============================================================================
" File:        yank_mapping.vim
" Description: Allows User to Copy File Path to Clipboard
"
" ============================================================================

" don't load multiple times
if exists('g:loaded_nerdtree_yank_status')
    finish
endif
let g:loaded_nerdtree_yank_status = 1

" add the new menu item via NERD_Tree's API

call NERDTreeAddKeyMap({
    \ 'scope': 'Node',
    \ 'key': 'yy',
    \ 'callback': 'NERDTreeYankCurrentNode',
    \ 'quickhelpText': 'Copy node full path into default register'
    \ })

" TODO: YankAbsolutePath
" TODO: YankRelativePath
" TODO: YankName

" FIXME: Utilize function argument

function! NERDTreeYankCurrentNode(params)
    " echo a:params['path'].str()
    let n = g:NERDTreeFileNode.GetSelected()
    if n != {}
        call setreg('"', n.path.str())
    endif
endfunction
