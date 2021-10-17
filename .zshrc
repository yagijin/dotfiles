
# .zshrc.localに切り出したPC固有の処理を読み込む
if [ -f ~/src/github.com/yagijin/setting_files/.zshrc.local ]; then
    source ~/src/github.com/yagijin/setting_files/.zshrc.local
fi

# 各エイリアス
#ls時にフォルダとファイルを色分けしてわかりやすくする
alias ls="ls -Fh -G"
alias la="ls -a"
#alias rm="echo 'use mv instead of rm'"

# git関連のエイリアス（.gitconfigにも記載がある）
alias g="git"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
alias gs="git status"
alias gst="git stash -u"
alias ga="git add ."
alias gc="git commit -m"
alias gca="git commit --amend"
alias gco="git checkout"


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

# go（ghqに使う）の設定
export GOPATH=$HOME
export PATH=$PATH:$GOPATH/bin

# ghqの管理フォルダをfzfで簡単にcdしたり、codeで開けるようにする
alias gcd='cd $(ghq root)/$(ghq list | fzf --preview "bat --color=always --style=numbers --line-range=:100 $(ghq root)/{}/README.*")'
alias gcode='code $(ghq root)/$(ghq list | fzf --preview "bat --color=always --style=numbers --line-range=:100 $(ghq root)/{}/README.*") && exit'

# batでプレビューしながらfzfで検索
alias fzc="fzf --preview 'bat --color=always --style=numbers --line-range=:100 {}'"

# gitのブランチを一覧から選んでチェックアウト
fbr() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# fzf検索 + cd
fd() {
  local dir
  dir=$(find . -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# fzfの基本設定
#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--height 100% --reverse --border'

# tabでコマンドのオプションやファイル名を保管してくれる
autoload -U compinit
compinit -u

# ディレクトリ名だけでcdできる
setopt auto_cd
# cd実行時、ディレクトリスタックにpush
setopt auto_pushd
# ディレクトリスタックに重複するパスのうち古い方を削除
setopt pushd_ignore_dups
# 直前と同じコマンドを履歴に追加しない
setopt hist_ignore_dups
# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

#thefuckの読み込み
eval $(thefuck --alias)

# manコマンドの設定：batを使用してmanコマンドに色を付ける
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# gitの情報を表示する
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{magenta}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{yellow}+"
zstyle ':vcs_info:*' formats "%F{cyan}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { 
  vcs_info
  print "" #add new line after command
}

# プロンプトをカスタマイズ
setopt prompt_subst #PROMPT変数内で変数展開する
PROMPT='🐏%F{green}%c%f 🐐$vcs_info_msg_0_
%F{green}$%f '

## コマンドに!をつけたもので自分のデフォルトのオプションを使うようにする
# 改行と空白を無視する
alias 'diff!'='diff -Bw'
