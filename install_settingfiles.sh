
cd ~

mkdir temp

cd temp

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

git clone https://github.com/yagijin/setting_files.git

cd setting_files

brew bundle

# 途中
