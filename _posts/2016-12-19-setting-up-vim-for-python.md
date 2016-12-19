---
layout: post
title: "Setting up Vim for Python"
tagline: "Setting up Vim for Python"
description: ""
category: 
tags: [ Linux, Python ]
---
{% include JB/setup %}


The purpose of this document is to set up vim for Python. The following steps has been tested
on Ubuntu 16.04.

## enable ctags
### install ctags

    sudo apt-get install ctags

### install vim-scripts
        
    sudo apt-get install vim-scripts

then run:
    
    vim-addons install taglist

## install pydiction

Download the laster pydiction from http://www.vim.org/scripts/script.php?script_id=850
or use local "pydiction-1.2.3.zip"

    unzip pydiction-1.2.3.zip
    cd pydiction
    mkdir -p ~/.vim/after/ftplugin
    cp after/ftplugin/python_pydiction.vim ~/.vim/after/ftplugin
    cp complete-dict ~/.vim
    cp pydiction.py ~/.vim

## config vim

copy the content  to ~/.vimrc 

    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
    set expandtab
    set autoindent

    let Tlist_Auto_Highlight_Tag=1  
    let Tlist_Auto_Open=1 
    let Tlist_Auto_Update=1  
    let Tlist_Display_Tag_Scope=1  
    let Tlist_Exit_OnlyWindow=1  
    let Tlist_Enable_Dold_Column=1 
    let Tlist_File_Fold_Auto_Close=1  
    let Tlist_Show_One_File=1  
    let Tlist_Use_Right_Window=1  
    let Tlist_Use_SingleClick=1  
    nnoremap <silent> <F8> :TlistToggle<CR>   

    filetype plugin on   
    autocmd FileType python set omnifunc=pythoncomplete#Complete   
    autocmd FileType javascrīpt set omnifunc=javascriptcomplete#CompleteJS   
    autocmd FileType html set omnifunc=htmlcomplete#CompleteTags   
    autocmd FileType css set omnifunc=csscomplete#CompleteCSS   
    autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags   
    autocmd FileType php set omnifunc=phpcomplete#CompletePHP   
    autocmd FileType c set omnifunc=ccomplete#Complete       
    let g:pydiction_location='~/.vim/tools/pydiction/complete-dict' 

Done!!!
