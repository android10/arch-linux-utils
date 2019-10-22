# ~/.bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

# Fancy Terminal Prompt----------------------------------------------------------
txtcyn=$'\e[0;36m'  # Cyan
txtred=$'\e[0;31m'  # Red
txtwht=$'\e[0;37m'  # White
txtrst=$'\e[0m'     # Text Reset

function parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\[\033[01;33m\]@\u \[\033[01;34m\]\W\[$txtcyn\]\$(parse_git_branch) \[$txtrst\]\$ "
#--------------------------------------------------------------------------------


# ASDF for managing programming languages versions-------------------------------
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

asdf_update_java_home() {
  local current
  if current=$(asdf current java); then
    local version=$(echo $current | cut -d ' ' -f 1)
    export JAVA_HOME=$(asdf where java $version)
  else
    echo "No java version set. Type `asdf list-all java` for all versions."
  fi
}
asdf_update_java_home
#--------------------------------------------------------------------------------


# ANDROID DEVELOPMENT------------------------------------------------------------
export ANDROID_SDK_ROOT=/home/fernando/dev/sdk/android
export PATH=$PATH:$ANDROID_SDK_ROOT/tools
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
#--------------------------------------------------------------------------------


# MAN COLOR----------------------------------------------------------------------
man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}
#--------------------------------------------------------------------------------


# OWN SCRIPTS--------------------------------------------------------------------
export VPN_SCRIPT=/home/fernando/dev/config/vpn/vpn.sh
export PATH=$PATH:$VPN_SCRIPT
alias vpn="sudo sh $VPN_SCRIPT"
#--------------------------------------------------------------------------------


# OWN FUNCTIONS------------------------------------------------------------------
function open () {
  xdg-open "$@">/dev/null 2>&1
}
#--------------------------------------------------------------------------------


# LOCAL BIN----------------------------------------------------------------------
export PATH=~/.local/bin:$PATH
#--------------------------------------------------------------------------------
