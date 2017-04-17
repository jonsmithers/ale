" Author: Jon Smithers <mail@jonsmithers.link>
" Description: This file adapts jshint to work with html files

call ale#linter#GetAll(['javascript']) " load 'ale_linters#javascrit#jshint#*' function definitions so we can use them here

function! ale_linters#html#jshint#GetCommand(buffer) abort
    let l:command = ale_linters#javascript#jshint#GetCommand(a:buffer)

    " remove " -" from the end (see ../javascript/jshint.vim)
    let l:command = strpart(l:command, 0, strlen(l:command)-2)

    " adapt jshint for html files
    let l:command .= ' --extract always'

    " put " -" at the end again
    let l:command .= ' -'

    return l:command
endfunction

call ale#linter#Define('html', {
\   'name':                'jshint',
\   'executable_callback': 'ale_linters#javascript#jshint#GetExecutable',
\   'command_callback':    'ale_linters#html#jshint#GetCommand',
\   'callback':            'ale#handlers#HandleUnixFormatAsError',
\})
