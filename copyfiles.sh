cp ../.vimrc .
cp ../.tmux.conf .
cp ../.zshrc .
cp ../.gitconfig .
# cp ../.zprofile .

cp -r ../iTerm_setting .
cp -r ../.zsh .
rm -rf .zsh/zsh-syntax-highlighting/.git
rm -rf .zsh/zsh-autosuggestions/.git
rm -rf .zsh/**/.git
cp -r ../.oh-my-zsh .
cp ../.vimrc .
rm -rf Brewfile

cp -r ../.config/fish ./.config/fish/
cp -r ../.config/neofetch ./.config/neofetch
cp -r ../.config/nvim  ./.config/nvim
rm -rf  ./.config/nvim/dein/*

rm -rf  ./.config/nvim/dein/.cache
rm -rf  ./.config/nvim/.git
brew bundle dump  
