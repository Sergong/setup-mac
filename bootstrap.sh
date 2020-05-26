#!/bin/zsh

# Install HomeBrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Install pyenv to get Python 3 installed
brew install pyenv

# Use PyEnv to install Python 3 of the latest available version for pyenv, disregard beta versions
PYVER=$(pyenv install --list | grep -o '^\s*\d\.\d\.\d$' | grep -o '\d\.\d\.\d$' | tail -1)
pyenv install $PYVER

# Activate it globally
pyenv global $PYVER

# Give pyenv control of the shell's path
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.zshrc

# Install Ansible
pip install ansible

# Enable tab completion
# First enable zsh's bash compat mode
echo -e '\nautoload -U bashcompinit\nbashcompinit ' >> ~/.zshrc
# load zshrc to activate it
source ~/.zshrc
# install argcomplete
pip install argcomplete
# Activate argcomplete
activate-global-python-argcomplete

# Set sudoers
ansible local -b -m copy -a "content='sergemeeuwsen ALL=(ALL) NOPASSWD: ALL' dest=/etc/sudoers.d/sergemeeuwsen"
