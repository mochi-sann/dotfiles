cp ../.vimrc .
cp ../.tmux.conf .
cp ../.zshrc .
cp ../.gitconfig .
cp ../.zprofile .

cp -r ../iTerm_setting .
cp -r ../.zsh .
cp -r ../.oh-my-zsh .
cp -r ../zsh-syntax-highlighting .
cp ../.vimrc .
rm -rf Brewfile
brew bundle dump  