# Fix environment
export PS1='[\u@\h \W]\$ '
export PATH=~/bin:$PATH
export PAGER=less
export EDITOR=vi
export MAIL=/var/mail/$USER

# Useful aliases
alias ls="ls -v"
alias ssh="ssh -A"
alias bc="bc -lq"
alias ipcalc="ipcalc -n"

# Place prompt at start of new line, force xterm title & cursor blink
PROMPT_COMMAND='printf "\\%$((COLUMNS-1))s\\r\033]2;Terminal\a\eP\e[?12h\e\\"'

# Disable permanent shell history
unset HISTFILE
rm -f ~/.bash_history

# macOS fixes
if uname -s | grep -q Darwin; then

	# Disable macOS zsh warning
	export BASH_SILENCE_DEPRECATION_WARNING=1

	# Fix md5sum
	[ -x /sbin/md5 ] && alias md5sum=md5

# WSL fixes
elif uname -r | grep -q Microsoft; then

	# Assume local X11 server
	export DISPLAY=:0.0
	export LIBGL_ALWAYS_INDIRECT=1

	# Fix ssh-agent
	export SSH_AGENT_ENV=~/.ssh/ssh-agent.env
	pgrep -U $UID ssh-agent >/dev/null || ssh-agent -s > $SSH_AGENT_ENV
	. $SSH_AGENT_ENV >/dev/null

	# Fix screen
	export SCREENDIR=~/.screen
	[ -d $SCREENDIR ] || mkdir -p -m 700 $SCREENDIR
	screen -wipe >/dev/null

	# Change to $HOME
	cd

# Debian fixes
elif test -f /etc/debian_version; then

	# Fix TERM
	export TERM=xterm

	# Fix vi
	[ -x /usr/bin/vim.tiny ] && alias vi=vim.tiny
fi

