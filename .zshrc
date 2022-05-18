## zsh自体の設定

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

# gitの情報を表示する
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{magenta}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{yellow}+"
zstyle ':vcs_info:*' formats "%F{cyan}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'

# プロンプトをカスタマイズ
setopt prompt_subst #PROMPT変数内で変数展開する
PROMPT='🐏%F{green}%c%f 🐐$vcs_info_msg_0_
%F{green}$%f '

## その他設定

# .zshrc.localに切り出したPC固有の処理を読み込む
if [ -f "$(ghq root)/github.com/yagijin/setting_files/.zshrc.local" ]; then
    source "$(ghq root)/github.com/yagijin/setting_files/.zshrc.local"
fi

# アップデート方法：brew upgrade nodenv node-build
eval "$(nodenv init -)"
eval "$(rbenv init -)"

# manコマンドの設定：batを使用してmanコマンドに色を付ける
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# go（ghqに使う）の設定
export GOPATH=$HOME
export PATH=$PATH:$GOPATH/bin

# fzfの基本設定
#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--height 100% --reverse --border'

## エイリアス

#ls時にフォルダとファイルを色分けしてわかりやすくする
alias ls="ls -Fh -G"
alias la="ls -a"
alias sl="ls"
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

## コマンドに!をつけたもので自分のデフォルトのオプションを使うようにする
# 改行と空白を無視する
alias 'diff!'='diff -Bw'
# manをマニュアルではなく用例集にする
alias 'man!'='tldr'

# kubectlのエイリアス
alias 'k'='kubectl'

#ipの確認
alias gip="curl http://ipecho.net/plain; echo"
alias lip="ifconfig en0 | awk '/inet / { print \$2 }'"

# ファイルの特定行をclipする
alias 'clip'='(){cat -n $1 | sed -n $2,$3p}'

# ghqの管理フォルダをfzfで簡単にcdしたり、codeで開けるようにする
alias gcd='cd $(ghq root)/$(ghq list | fzf --preview "bat --color=always --style=numbers --line-range=:100 $(ghq root)/{}/README.*")'
alias gcode='code $(ghq root)/$(ghq list | fzf --preview "bat --color=always --style=numbers --line-range=:100 $(ghq root)/{}/README.*") && exit'

# batでプレビューしながらfzfで検索
alias fzc="fzf --preview 'bat --color=always --style=numbers --line-range=:100 {}'"

## 独自関数

# リポジトリのrootにcd
root() {
  git_dir="$(git rev-parse --show-toplevel 2> /dev/null)"
    if [ -z $git_dir ]
    then
      cd ..
    else
      cd "$git_dir"
    fi
}

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

# cd後にlaするためのトリガー
cdla () {
  # on or off
  export CDLA_STATE=$1
  echo "CDLA_STATE: $1"
}

## zshのhook関数

# before show command-prompt
precmd () { 
  vcs_info
  print "" #add new line after command
}

## when current directry changed
chpwd() {
  # ls -aする
  if [ "$CDLA_STATE" = "on" ]; then;
    la
  fi
}
