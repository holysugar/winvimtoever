winvimtoever.vim
================

Vim script for sending buffer to evernote in Windows.

Usage
------------

:call WinVimToEver(), then send buffer to evernote.

This uses first line as title.

License
-------------

MIT License

Configuration
-------------

- g:winVimToEverUseFilename - Use filename as note title.
- g:winVimToEverPath - path to ENScript.exe
- g:winVimToEverNote - Notebook name in which this saves
- g:winVimToEverAttachment - Save as attachment also

example:

    " VimToEver
    let g:winVimToEverNote = 'from vim'
    let g:winVimToEverAttachment = 1
    
    nmap ,n :call WinVimToEver()<CR>

Todo
-------------

- tagging
- for mac ...

