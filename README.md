# setting_files
setting files for my tools

## .zshrc
oh my zshやstarshipは使わない方針

## .vscode

`code --list-extensions > .extensions`で拡張機能一覧を.extensionsに出力．   
.extensionsと同じディレクトリでinstall_extensions.shを実行して拡張機能をインストール．    
~/Library/Application Support/Code/User/setting.jsonをシンボリックリンクにする．  

## prettier と eslint の環境構築

### npm install
`npm install eslint --save-dev`  
`npm install --save-dev --save-exact prettier`  
`npm install --save-dev eslint-config-prettier`

### vscode に拡張機能を入れる
eslint  
prettier

### その他できること
Git にはコミット前に指定のスクリプトを実行できる pre-commit フックと言う仕組みがあるため，それを利用して commite 前にコードを検査，整形することもできる．

### 参考サイト
https://prettier.io/docs/en/integrating-with-linters.html  
https://qiita.com/soarflat/items/06377f3b96964964a65d

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




