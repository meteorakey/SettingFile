limit coredumpsize 0
# setup command search path
typeset -U path
# (N-/)を付けることで存在しなければ無視してくれる
path=($path /usr/local/bin(N-/) /usr/*/bin(N-/) usr/local/*/bin(N-/) /var/*/bin(N-/))
path=($path /opt/local/sbin(N-/) /opt/local/bin(N-/))
path=($path /Users/tatsuya/bin(N-/))

# リモートから起動するコマンド用の環境変数
export RSYNC_RSH=ssh
export CVS_RSH=ssh
