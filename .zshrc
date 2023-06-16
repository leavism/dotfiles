# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"

# For nvm - node version manager.
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# For pyenv - python version manager.
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# source antidote
source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh
export STARSHIP_CONFIG=~/repositories/dotfiles/macOS/.config/starship.toml
antidote load

# Common commands
alias ls="exa -1 --icons"
alias ll="exa -lGFh --git"
alias lt="exa --tree --level=2"
alias re="source ~/.zshrc"

source ~/.config/zsh/git_aliases.zsh


# Custom scripts
alias leetcode="~/repositories/dotfiles/macOS/scripts/new-leetcode.sh"
alias gc="~/repositories/dotfiles/macOS/scripts/gc.sh"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
