# 
#  _______     ________       _       ______     ____    ____  ________  
# |_   __ \   |_   __  |     / \     |_   _ `.  |_   \  /   _||_   __  | 
#   | |__) |    | |_ \_|    / _ \      | | `. \   |   \/   |    | |_ \_| 
#   |  __ /     |  _| _    / ___ \     | |  | |   | |\  /| |    |  _| _  
#  _| |  \ \_  _| |__/ | _/ /   \ \_  _| |_.' /  _| |_\/_| |_  _| |__/ | 
# |____| |___||________||____| |____||______.'  |_____||_____||________| 
#                                                                        
# 
# Note
# You don't have to copy this file over to the home directory. Just make a symlink with:
# 
# ln -s path/to/this/repo/file ~/.zshrc
# 

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
alias gpom="git push origin main"
alias gpo="git push origin"
alias gs="git status"
alias ga="git add"
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'


function gre() {
	echo $#
	# Check there's only 1 argument
	if [[ $# -gt 1 ]]; then
		echo "Command only takes 1 argument."
		return 1;
	fi
	# Check that first arg is a number
	if ! [[ $1 =~ ^[0-9]+$ ]]; then
		echo "Command only takes numbers."
		return 1;
	fi
	# If no argument is provided, default reset is 1 commit 
	if [[ -z "$1" ]]; then
		git reset HEAD~1
		return 1;
	fi

  local response
  read -r -q "?Confirm you want to reset $1 commits from HEAD [y/n]: " response
  echo
	case "$response" in
    [yY])
			git reset HEAD~$1  # Confirmation: Yes
      ;;
    *)
			echo "Command canceled."  # Confirmation: No or invalid input
      ;;
  esac

}

# Custom scripts
alias leetcode="~/repositories/dotfiles/macOS/scripts/new-leetcode.sh"
alias gc="~/repositories/dotfiles/macOS/scripts/gc.sh"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
