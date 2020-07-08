# Custom shortcuts
alias me="cd c:/Users/SysAdmin"
alias desktop="cd c:/Users/SysAdmin/Desktop"
alias n="c:/Program\ Files/Notepad++/notepad++.exe"
alias repos="cd c:/git/radformation"
alias reload="source ~/.bashrc"
alias cls="clear"
alias master="git checkout master && git fetch && git pull origin master"
alias latest="~/.bash/scripts/latest.sh"

# Theming
THEME=$HOME/.bash/themes/git_bash_windows_powerline/theme.bash
if [ -f $THEME ] ; then
   . $THEME
fi
unset THEME

# Start the ssh-agent every time
env=~/.ssh/agent.env

agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }

agent_start () {
    (umask 077; ssh-agent >| "$env")
    . "$env" >| /dev/null ; }

agent_load_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2= agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
    ssh-add ~/.ssh/radformation_bitbucket
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
    ssh-add ~/.ssh/radformation_bitbucket
fi

unset env