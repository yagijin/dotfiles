# setting_files
setting files for my tools

## .zshrc
oh my zshやstarshipは使わない方針

## .vscode

`code --list-extensions > .extensions`で拡張機能一覧を.extensionsに出力．   
.extensionsと同じディレクトリでinstall_extensions.shを実行して拡張機能をインストール．    
~/Library/Application Support/Code/User/setting.jsonをシンボリックリンクにする．  

## starship.toml

starshipの設定．
現在は使用していません．

## Homebrew 

### brewfileからインストール
`brew bundle`

### brewfileに一覧を出力
`brew bundle dump`

### brewfileに入っていないファイルを削除
`brew bundle cleanup`

### brewのプログラム

#### ghq
https://github.com/x-motemen/ghq  
https://github.com/Songmu/ghq-handbooks

# その他操作
## 指定したディレクトリにシンボリックリンクを追加する(-fで強制上書きも可能)
`ln -s ファイル名 ディレクトリ`




