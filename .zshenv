# 言語の設定
export LANG=ja_JP.UTF-8

# Homebrew用path
export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/share:/usr/local/share/python:$PATH

# TeXLive用PATH指定
export PATH=$PATH:/usr/local/texlive/2012/bin/x86_64-darwin

typeset -U path

# man pathの指定
manpath=(/usr/*/man(N-/) /usr/local/*/man(N-/) /var/*/man(N-/))
export MANPATH


# javaのpath
export JAVA_HOME=/Library/Java/Home

# リモートから起動するコマンド用の環境変数
export RSYNC_RSH=ssh
export CVS_RSH=ssh

# less コマンドで日本語を読めるようにする
export JLESSCHARSET=japanese

limit coredumpsize 0
