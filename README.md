# setting_files

dotfilesを管理するためのリポジトリ。


以下のコマンドで設定ができる。
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/yagijin/setting_files/HEAD/install_settingfiles.sh"
```

# .zshrc

重くなるので、oh my zshやstarshipは使わない方針。

# .vscode

vscodeの設定（setting.json）と拡張機能を管理する。
## インストール手順

- 拡張機能を出力
  - `code --list-extensions > .extensions`
- 拡張機能をインストール
  - `cd ./.vscode && ./install_extensions.sh`
- settings.jsonのシンボリックを貼る
  - `ln -s ~/Library/Application Support/Code/User/settings.json ~`

# .prettierrc と .eslintrc

prettierとeslintの設定ファイル。
`.vscode`にvscodeでの自動フォーマットのための設定がある。

- インストール
  - `yarn add eslint prettier eslint-config-prettier --dev`

## todo

pre-commitフックでcommit前にコードを検査、整形する。


# starship.toml

starshipの設定。
現在は使用していません。

# Homebrew

- brewfileに一覧を出力
  - `brew bundle dump`
- brewfileからインストール
  - `brew bundle`
- brewfileに入っていないファイルを削除
  - `brew bundle cleanup`

# brewでインストールされるアプリケーション

## ghq

- https://zuruzurura.men/blog/2021-08-23-ghq%E3%81%AE%E3%82%BB%E3%83%83%E3%83%88%E3%82%A2%E3%83%83%E3%83%97%E3%81%8B%E3%82%89%E4%BD%BF%E3%81%84%E6%96%B9%E3%81%BE%E3%81%A7/
- https://github.com/x-motemen/ghq  
- https://github.com/Songmu/ghq-handbooks

# その他操作

## 指定したディレクトリにシンボリックリンクを追加する(-f で強制上書きも可能)

`ln -s ファイル名 ディレクトリ`
