#!/bin/bash

echo "🍜 start"

cd ~ || exit

# macの場合、xcodeのデベロッパーツールをインストールする
xcode-select --install

# homebrewのinstall
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo "✅ brew is successfully installed"

# gitがなかったらinstall
if type git > /dev/null 2>&1; then
  echo "✅ git is already installed"
else
  brew install git
  echo "✅ git is successfully installed"
fi

# git configの設定
git config --global user.name "yagijin"
git config --global user.email "yagijin_dev@ymail.ne.jp"

# ghqをインストール
brew install ghq

# ghq用のgit configの設定
git config --global ghq.root "$HOME/src"
git config --global ghq.user "yagijin"

echo "✅ ghq is successfully installed"

# dotfilesを持ってくる
ghq get -p git@github.com:yagijin/setting_files.git
cd "$(ghq root)/github.com/yagijin/setting_files" || exit

#.zshrcがすでにあるかどうか確認する
if [ -f "$HOME/.zshrc" ]; then
  echo "⚠️ .zshrc already exists"
  cat ~/.zshrc
  rm ~/.zshrc
  echo "⚠️ .zshrc has been removed"
fi

# .zshrcのシンボリックリンクを貼る
ln -s .zshrc ~/.zshrc

# brewのパッケージのインストール
echo "⚠️ Installing brew packages... this may take a while."
brew bundle
echo "✅ brew packages are successfully installed"

# vscodeのインストール
# todo: Brewfileに追加する
echo "⚠️ Installing vscode... this may take a while."
brew install --cask visual-studio-code

if [ -f "$HOME/Library/Application Support/Code/User/settings.json" ]; then
  # macの場合
  ln -s .vscode/settings.json "$HOME/Library/Application Support/Code/User"
elif [ -f "$HOME/.config/Code/User/settings.json" ]; then
  # linuxの場合
  ln -s .vscode/settings.json "$HOME/.config/Code/User"
fi

# vscode拡張のインストール
cd .vscode && ./install_extensions.sh
echo "✅ vscode is successfully installed & settings are configured"

echo "🍜 finish"
