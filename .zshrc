
# 各エイリアス
#ls時にフォルダとファイルを色分けしてわかりやすくする
alias ls='ls -Fh -G'
alias g='git'

#ipの確認
alias gip="curl http://ipecho.net/plain; echo"
alias lip="ifconfig en0 | awk '/inet / { print \$2 }'"

# tabでコマンドのオプションやファイル名を保管してくれる
autoload -U compinit
compinit -u

#starshipの読み込み
eval "$(starship init zsh)"

#thefuckの読み込み
eval $(thefuck --alias)