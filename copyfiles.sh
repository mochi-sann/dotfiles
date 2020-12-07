cp ../.vimrc .
cp ../.tmux.conf .
cp ../.zshrc .
cp ../.gitconfig .
cp ../.zprofile .

cp -r ../iTerm_setting .
cp -r ../.zsh .
rm -rf .zsh/zsh-syntax-highlighting/.git
rm -rf .zsh/zsh-autosuggestions/.git
cp -r ../.oh-my-zsh .
cp ../.vimrc .
rm -rf Brewfile
brew bundle dump  