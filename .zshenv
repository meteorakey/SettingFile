# 言語の設定
export LANG=ja_JP.UTF-8

# Homebrew用path
export PATH=/usr/local/bin:$PATH:/usr/sbin:/sbin:/usr/local/share

# path for pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH=$PYENV_ROOT/bin:$PATH
export XDG_CONFIG_HOME=~/.config

# initilize for pyenv
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# man pathの指定
manpath=(/usr/*/man(N-/) /usr/local/*/man(N-/) /var/*/man(N-/))
export MANPATH
typeset -U path manpath

# JAVA HOME
export JAVA_HOME=/Library/Java/Home

# Go Path
export GOPATH=$HOME/dev/go_workspace

# リモートから起動するコマンド用の環境変数
export RSYNC_RSH=ssh
export CVS_RSH=ssh

# less コマンドで日本語を読めるようにする
export JLESSCHARSET=japanese

# コアダンプファイルを作成しない
limit coredumpsize 0

