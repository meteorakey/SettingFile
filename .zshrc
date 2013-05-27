###
# set shell variable
# WORDCHARS=$WORDCHARS:s,/,,
export LANG=ja_JP.UTF-8
export JAVA_HOME=/Library/Java/Home

HISTSIZE=200 HISTFILE=~/.zhistory SAVEHIST=180

# プロンプト表示設定
setopt prompt_subst
PROMPT='[%n@%m]{%D %*} %#'
RPROMPT=$'%{\e[37m%}[%~]%{\e[m%}'
#RPROMPT='[%d]'

#色分け表示を行う
autoload colors
colors
eval `tset -sQ rxvt-256color`

# emacs binding keys
bindkey -e

# ディレクトリ名だけでcd
setopt auto_cd

# tab連打で補完候補表示
setopt auto_menu

# 補完時に日本語を正しく表示
setopt print_eight_bit

#補完候補でカーソル移動できるようにする
zstyle ':completion:*:default' menu select=2

#カーソル位置を保持する
#setopt always_last_prompt

#一時ファイルやバックアップファイル、オブジェクトファイルを補完しない
zstyle ':completion:*:*files' ignored-patterns '*?.o' '*?~' '*¥#'

# 過去ディレクトリにジャンプ
setopt auto_pushd pushd_ignore_dups
setopt auto_remove_slash auto_name_dirs
setopt extended_history hist_ignore_dups hist_ignore_space prompt_subst
setopt extended_glob list_types no_beep always_last_prompt
setopt cdable_vars sh_word_split auto_param_keys

##############################
#            補完            #
##############################

# 補完システム
zstyle ':completion:*' format '%BCompleting %d%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}'
autoload -U compinit && compinit

# 補完にも色付け
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

#補完のグルーピング
zstyle ':completion:*' verbose yes
#zstyle ':completion:*' completer _expand _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format "%{${fg[yellow]}%}%d%{${reset_color}%}"
zstyle ':completion:*:warnings' format "%{${fg[red]}%}No matches for:%{${fg[yellow]}%} %d%{${reset_color}%}"
zstyle ':completion:*:descriptions' format "%{${fg[yellow]}%}completing %B%d%b%{${reset_color}%}"
zstyle ':completion:*:corrections' format "%{${fg[yellow]}%}%B%d %{${fg[red]}%}(errors: %e)%b%{${reset_color}%}"
zstyle ':completion:*:options' description 'yes'

# グループ名に空文字列を指定すると，マッチ対象のタグ名がグループ名に使われる。
# したがって，すべての マッチ種別を別々に表示させたいなら以下のようにする
zstyle ':completion:*' group-name ''
#zstyle 'completion:*:complete:-command-::' group-order current_dir_files command local-directories users named-directories path-directories


##############################
#             ssh            #
##############################
agusa_ssh() {
    ssh -p 22222 -D 9999 toda@chanko.agusa.i.is.nagoya-u.ac.jp
}


##############################
#           alias            #
##############################
alias copy='cp -ip'
alias del='rm -i'
alias move='mv -i'
alias fullreset='echo "\ec\ec"'
alias ja='LANG=ja_JP.ecuJP XMODIFIERS=@im=kinput2'
alias ls='ls -F' la='ls -a' ll='ls -la'
alias pu=pushd
alias po=popd
alias dirs='dirs -v'
alias lessn='less -N'
alias opena='open -a Preview'
alias javac='javac -J-Dfile.encoding=UTF8'

alias -s pdf=open
alias -s dvi=xdvi
alias -s key=open
alias -s tex=emacs
alias -s {tgz,lzh,zip,arc}=open
alias -s app=open -a
alias -s txt=emacs
alias -s scala=emacs
alias -s xml=emacs
alias -s jar=java -jar
alias -s py=emacs

h () {history $* | less}
mdcd () {mkdir -p "$@" && cd "$*[-1]"}
