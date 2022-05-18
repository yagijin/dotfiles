#!/bin/bash

cd ~ || exit

mkdir temp

cd temp || exit

# homebrewのinstall
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

git clone https://github.com/yagijin/setting_files.git

cd setting_files || exit

brew bundle

# 途中
