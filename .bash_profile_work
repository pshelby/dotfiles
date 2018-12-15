# Set shell key mapping
set -o vi

# Set SVN_EDITOR for SVN merging/committing
export SVN_EDITOR=vim

# Set shell prompt
#export PS1="\`if [ \$? = 0 ]; then echo ✅'  '; else echo 💥'  '; fi\`\[\e[44m\]\u@\h:\w \[\e[43m\]>\[\e[0m\] "
#. ~/.shell_prompt_airline.sh
. ~/.shell_prompt_airline_git.sh

# Source Python virtualenvwrapper tool
export WORKON_HOME=$HOME/.virtualenvs
#export PROJECT_HOME=$HOME/Devel
#. /usr/local/bin/virtualenvwrapper.sh
source /usr/local/bin/virtualenvwrapper.sh

# Export proxy settings to use cntlm
export http_proxy=http://localhost:3128
export https_proxy=https://localhost:3128

alias uprepos="time find $HOME/Documents/svn_repos -noleaf -maxdepth 1 -type d -exec svn up {} \;"
alias egrep="egrep --directories=recurse"

# functions
svn_merge_usage() {
	echo "Usage: svn_merge <repo> <src branch> <dst branch> <revision> [file] [ticket] [module]"
}

svn_merge() {
	REPO=$1
	SRC_BRANCH=$2
	DST_BRANCH=$3
	REV=$4
	FILE=$5
	TICKET=$6
	MODULE=$7
	TICKETSTR=''

	REPOS_ROOT=~/Documents/svn_repos
	REVIEW_DEFAULT=Y

	# Validate arguments
	[[ $REPO == '' ]] && svn_merge_usage && return 1
	[[ $SRC_BRANCH == '' ]] && svn_merge_usage && return 1
	[[ $DST_BRANCH == '' ]] && svn_merge_usage && return 1
	[[ $REV == '' ]] && svn_merge_usage && return 1
	[[ $MODULE == '' ]] && [[ $FILE == '' ]] && MODULE=$REPO
	[[ $MODULE == '' ]] && MODULE=$FILE
	[[ $TICKET != '' ]] && TICKETSTR="$TICKET / "

	# Test REPO
	if [[ ! -d $REPOS_ROOT/$REPO ]]; then
		echo "ERROR	: Cannot find repo '$REPOS_ROOT/$REPO'!"
		return 1
	fi

	# Test SRC_BRANCH
	if [[ -d $REPOS_ROOT/$REPO/$SRC_BRANCH ]]; then
		SRC_BRANCH=$SRC_BRANCH
	elif [[ -d $REPOS_ROOT/$REPO/branches/$SRC_BRANCH ]]; then
		SRC_BRANCH="branches/$SRC_BRANCH"
	else
		echo "ERROR	: Cannot find source branch '$SRC_BRANCH'!"
		return 1
	fi

	# Test DST_BRANCH
	if [[ -d $REPOS_ROOT/$REPO/$DST_BRANCH ]]; then
		DST_BRANCH=$DST_BRANCH
	elif [[ -d $REPOS_ROOT/$REPO/branches/$DST_BRANCH ]]; then
		DST_BRANCH="branches/$DST_BRANCH"
	else
		echo "ERROR	: Cannot find destination branch '$DST_BRANCH'!"
		return 1
	fi

	svn up $REPOS_ROOT/$REPO &&
	svn merge -c $REV $REPOS_ROOT/$REPO/$SRC_BRANCH/$FILE $REPOS_ROOT/$REPO/$DST_BRANCH/$FILE &&
	svn diff $REPOS_ROOT/$REPO/$DST_BRANCH/$FILE &&
	echo &&
	read -p "Continue with merge? [$REVIEW_DEFAULT/n]: " REVIEW_ANSWER &&
	REVIEW_ANSWER=${REVIEW_ANSWER:-$REVIEW_DEFAULT} &&
	if [[ $REVIEW_ANSWER == 'y' || $REVIEW_ANSWER == 'Y' ]]; then
	svn ci $REPOS_ROOT/$REPO/$DST_BRANCH/$FILE -m "${TICKETSTR}merged $REV for $MODULE"
	fi
}
