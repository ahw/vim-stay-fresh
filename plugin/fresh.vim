function! SendRefreshRequest()
    let filename = getreg('%')
    let urlEncodedFileName = s:urlEncode(filename)
    let vimEscapedFileName = substitute(urlEncodedFileName, '%', '\\%', 'g')
    "Make request to the server with the event name and the filename. Not
    "really using the filename at this point, but in the future it might
    "come in handy. We're also not bothing with anything other than the
    "BufWritePost event, but it's nice to keep in general for now in case we
    "want start listening for other events in the future.
    let curlRequest = '"http://localhost:7700/reload?delay=' . s:requestDelayMillis . '&filename=' . vimEscapedFileName . '"'
    execute 'silent !curl ' . curlRequest
    "Clear and redraw the screen
    redraw!
endfunction

" Credit goes to
" https://github.com/tpope/vim-unimpaired/blob/master/plugin/unimpaired.vim#L298
function! s:urlEncode(str)
    return substitute(a:str,'[^A-Za-z0-9_.~-]','\="%".printf("%02X",char2nr(submatch(0)))','g')
endfunction

function! SetDelayTimeMillis(millis)
    let s:requestDelayMillis = a:millis
endfunction

function! StopSendingRefreshRequests()
    "Clear out the autocmds
    au! RefreshGroup BufWritePost
endfunction

function! StartSendingRefreshRequests()
    "Set the delay time to 2 seconds
    call SetDelayTimeMillis(200)

    "Create an autocmd group
    aug RefreshGroup
        "Clear the RefreshGroup augroup. Otherwise Vim will combine them.
        au!
        au BufWritePost * call SendRefreshRequest()
    aug END
endfunction

call StartSendingRefreshRequests()
map <leader>r <esc>:call SendRefreshRequest()<cr>
