alias gpom="git push origin main"
alias gpo="git push origin"
alias gs="git status"
alias ga="git add"

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
