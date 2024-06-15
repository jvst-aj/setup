#! /bin/bash

# NOTE: Update
sudo apt update

# NOTE: Install and configure Zsh
sudo apt install -y zsh
# Set Zsh as default terminal
sudo chsh -s $(which zsh)
# Setup .zshrc file
sudo cp .zshrc ~/.zshrc
# Install Starship
sudo curl -sS https://starship.rs/install.sh | sh
# Set Custom Prompt
# Copy startship.toml to ~/.config/starship.toml
starship preset pure-preset -o ~/.config/starship.toml

# NOTE: Install ssh
sudo apt install -y ssh

# NOTE: Install http clients
sudo apt install -y curl wget httpie

# NOTE: Install Git CLI
sudo apt install -y git

# NOTE: Install Lazy Git
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*') &&
	curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" &&
	tar xf lazygit.tar.gz lazygit &&
	sudo install lazygit /usr/local/bin

# NOTE: Install GitHub CLI
sudo mkdir -p -m 755 /etc/apt/keyrings &&
	wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg >/dev/null &&
	sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg &&
	echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null &&
	sudo apt update &&
	sudo apt install -y gh

# NOTE: Install Neovim
sudo apt install -y neovim

# NOTE: Install Python
sudo add-apt-repository ppa:deadsnakes/ppa -y
sudo apt update
sudo apt install -y python3.11
sudo ln -s /usr/bin/python3.11 /usr/bin/python

# NOTE: Install NodeJS & NVM (Node Version Manager)
sudo curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
# Download and install NodeJS
sudo nvm install 22

# NOTE: Install Mongosh CLI
sudo curl -o mongosh.deb https://downloads.mongodb.com/compass/mongodb-mongosh_2.2.5_amd64.deb
sudo apt install -y ./mongosh.deb
sudo rm ./mongosh.deb

# NOTE: Install Atlas CLI
sudo curl -o atlas.deb https://fastdl.mongodb.org/mongocli/mongodb-atlas-cli_1.20.0_linux_x86_64.deb
sudo apt install -y ./atlas.deb
sudo rm ./atlas.deb
