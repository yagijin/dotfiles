source ~/.nvm/nvm.sh

# 各エイリアス
#ls時にフォルダとファイルを色分けしてわかりやすくする
alias ls="ls -Fh -G"
alias la="ls -a"
alias g="git"
alias rm="echo 'use mv instead of rm'"

#ipの確認
alias gip="curl http://ipecho.net/plain; echo"
alias lip="ifconfig en0 | awk '/inet / { print \$2 }'"

# Google Chromeで検索する
google() {
    local str opt
    if [ $# != 0 ]; then
        for i in $*; do
            str="$str${str:++}$i"
        done
        opt="search?num=100&q=${str}"
    fi
    open -a Google\ Chrome http://www.google.co.jp/$opt
}

# tabでコマンドのオプションやファイル名を保管してくれる
autoload -U compinit
compinit -u

# ディレクトリ名だけでcdできる
setopt auto_cd
# cd実行時、ディレクトリスタックにpush
setopt auto_pushd
# ディレクトリスタックに重複するパスのうち古い方を削除
setopt pushd_ignore_dups

# バックグランドジョブの終了時に通知
setopt no_tify

# 直前と同じコマンドを履歴に追加しない
setopt hist_ignore_dups

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

#starshipの読み込み
eval "$(starship init zsh)"

#thefuckの読み込み
eval $(thefuck --alias)