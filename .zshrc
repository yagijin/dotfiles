
# .zshrc.localに切り出したPC固有の処理を読み込む
if [ -f ~/src/github.com/yagijin/setting_files/.zshrc.local ]; then
    source ~/src/github.com/yagijin/setting_files/.zshrc.local
fi

# 各エイリアス
#ls時にフォルダとファイルを色分けしてわかりやすくする
alias ls="ls -Fh -G"
alias la="ls -a"
alias g="git"
alias gl="git log"
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gca="git commit --amend"
alias gpl="git pull"
alias gps="git push"
alias gco="git checkout"
alias ggl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
#alias rm="echo 'use mv instead of rm'"

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

# ghq + pecoの設定
export GOPATH=$HOME
export PATH=$PATH:$GOPATH/bin

function peco-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

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

fbr() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
