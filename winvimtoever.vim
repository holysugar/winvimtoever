" winvimtoever.vim
" vim script, send current buffer to evernote

if !exists("g:winVimToEverUseFilename")
    let g:winVimToEverUseFilename = 0
endif

if !exists("g:winVimToEverPath")
    let g:winVimToEverPath = 'C:\Progra~1\Evernote\Evernote3.5\ENScript.exe'
endif

if !exists("g:winVimToEverNote")
    let g:winVimToEverNote = ""
end

if !exists("g:winVimToEverAttachment")
    let g:winVimToEverAttachment = 0
endif


function! WinVimToEver()

    if g:winVimToEverUseFilename
        let title = expand("%:t")
    else
        let title = getline(1)
    endif

    "let tag = ...
    let tmpdir = tempname()
    call mkdir(tmpdir)

    let bodyfile = fnamemodify(tempname(), ":p:r").'.txt'
    let lines = getline(1, line("$"))
    let body = iconv(join(lines, "\r\n"), &fileencoding, "cp932")

    " for japanese
    if has('iconv')
        let title = iconv(title, &fileencoding, "cp932")
        let body = iconv(body, &fileencoding, "cp932")
    end

    call writefile(split(body, "\r\n", 1), bodyfile, "b")

    let cmd = g:winVimToEverPath.' createNote /s '.shellescape(bodyfile).' /i '.shellescape(title)

    if g:winVimToEverAttachment
        let filename = expand("%:t")
        if filename == ''
            let filename = 'attachment.txt'
        end
        let tmpfile = tmpdir . '\' . filename
        call writefile(split(body, "\r\n", 1), tmpfile, "b")
        let cmd = cmd.' /a '.shellescape(tmpfile)
    end

    if g:winVimToEverNote
        let cmd = cmd.' /n '.shellescape(g:winVimToEverNote)
    endif

    let ret = system(cmd)
    " FIXME!
    call system("rmdir /S /Q ".shellescape(tmpdir))
    call delete(bodyfile)
endfunction
