#!/usr/bin/env zsh

echo "Securing zsh compinit directories"
compaudit | xargs chmod go-w

echo "Setting up asdf"
source "$(brew --prefix asdf)/asdf.sh"
source "$(brew --prefix asdf)/etc/bash_completion.d/asdf.bash"

echo "Setting Ruby compilation vars"
source "$HOME/.ruby-build-vars"

echo "Adding ASDF plugins"
asdf plugin-add elixir
asdf plugin-add erlang
asdf plugin-add java
asdf plugin-add nodejs
asdf plugin-add postgres
asdf plugin-add python
asdf plugin-add ruby
asdf plugin-add ruby

echo "Adding NodeJS GPG keys"
bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring

echo "Installing ASDF versions"
asdf install

echo "Post-install: Ruby"
gem ctags
number_of_cores=$(sysctl -n hw.ncpu)
bundle config --global jobs "$((number_of_cores - 1))"

echo "Post-install: Python"
echo "Installing pynvim for system python3"
/usr/local/bin/python3 -m pip install pynvim jedi

echo "Installing pynvim for system python2"
curl https://bootstrap.pypa.io/pip/2.7/get-pip.py -o ~/Desktop/get-pip.py
/usr/bin/python2 ~/Desktop/get-pip.py
/usr/bin/python2 -m pip install pynvim jedi
