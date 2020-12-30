with import <nixpkgs> {};

vim_configurable.customize {
    name = "vim";
    vimrcConfig.customRC = ''
        filetype plugin indent on
        syntax on
        set ruler
        set showcmd
        set nu
        set incsearch
        set hlsearch
        set wildmenu
        set scrolljump=5
        set scrolloff=3
        set foldenable
        set nowrap
        set expandtab
        set autoindent
        set shiftwidth=4
        set tabstop=4
        set softtabstop=4
        nnoremap j gj
        nnoremap k gk
        map <C-o> :NERDTreeToggle<CR>
        set laststatus=2
        set noshowmode
    '';
    vimrcConfig.vam.knownPlugins = pkgs.vimPlugins;
    vimrcConfig.vam.pluginDictionaries = [
        { names = [
          "lightline-vim"
          "indentLine"
          "vim-multiple-cursors"
          "vim-surround"
          "nerdtree"
          "ale"
          "vim-gitgutter"
          "vimtex"
          "YouCompleteMe"
        ]; }
    ];
}
