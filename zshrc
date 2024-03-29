# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
source ~/.bash_profile
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="ys"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    fzf
    autojump
    zsh-autosuggestions
    zsh-completions
    zsh-history-substring-search
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# ZPlug configuration

if [[ ! -f $HOME/.zplug/init.zsh ]] {
    echo "ZPLUG not installed!!!"
}
source ~/.zplug/init.zsh

OMZPLUGIN=("git" "python" "vi-mode")
OMZCUSPLUGIN=("zsh-syntax-highlighting" "zsh-autosuggestions" "zsh-history-substring-search" "zsh-completions")

for plug in "${OMZPLUGIN[@]}"
do
    zplug "$ZSH/plugins/$plug/$plug.plugin.zsh" , from:local
done
for plug in "${OMZCUSPLUGIN[@]}"
do
    zplug "$ZSH/custom/plugins/$plug/$plug.plugin.zsh" , from:local
done
if ! zplug check --verbose; then
    echo 'Run "zplug install" to install'
fi
# Then, source plugins and add commands to $PATH
zplug load

if [ -f ~/.zshrc_local ]; then
    source ~/.zshrc_local
fi

# Test if ~/.aliases exists and source it
if [ -f ~/.aliases ]; then
    source ~/.aliases
fi

AUTOJUMP="$ZSH/custom/plugins/autojump"
if [[ ! -d ~/.autojump ]] {
    echo "autojump not installed!!!"
}

[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && source ~/.autojump/etc/profile.d/autojump.sh
autoload -U compinit && compinit -u
if [[ ! -d $HOME/.fzf ]] {
    echo "fzf not installed!!!"
}

# export CLICOLOR=1
# export TERM=xterm-256color

bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

setopt no_nomatch

# use proxy
export http_proxy=http://127.0.0.1:8889
export https_proxy=http://127.0.0.1:8889


# go environment
export GOROOT=/usr/local/go
export PATH=$GOROOT/bin:$PATH
export GOPATH=$HOME/Documents/golang


# Rust environment
export PATH=$HOME/.cargo/bin:$PATH

eval "$(zoxide init zsh)"

# Add TeX Live to the PATH, MANPATH, INFOPATH
export PATH=/usr/local/texlive/2022/bin/x86_64-linux:$PATH
export MANPATH=/usr/local/texlive/2022/texmf-dist/doc/man:$MANPATH
export INFOPATH=/usr/local/texlive/2022/texmf-dist/doc/info:$INFOPATH

export CC=/usr/bin/clang
export CXX=/usr/bin/clang++

export PATH=$PATH:/opt/FlameGraph


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#=============================================================================#
# __conda_setup="$('/home/zhouliqi/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/home/zhouliqi/anaconda3/etc/profile.d/conda.sh" ]; then
#         . "/home/zhouliqi/anaconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/home/zhouliqi/anaconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
#=============================================================================#
# <<< conda initialize <<<


# CUDA
# export PATH=/usr/local/cuda-10.2/bin:$PATH
# export LD_LIBRARY_PATH=/usr/local/cuda-10.2/lib64:$LD_LIBRARY_PATH


#================================== ROS ======================================#
# source /opt/ros/noetic/setup.zsh
# source ~/catkin_ws/devel/setup.zsh

# This is necessary to prevent some Qt-related errors (feel free to try to omit it)
# export QT_X11_NO_MITSHM=1

# Setup some more Gazebo-related environment variables
# . ~/PX4-Autopilot/Tools/setup_gazebo.bash ~/PX4-Autopilot ~/PX4-Autopilot/build/px4_sitl_default

# Add the Firmware directory to ROS_PACKAGE_PATH so that ROS can start PX4
# export ROS_PACKAGE_PATH=${ROS_PACKAGE_PATH}:~/PX4-Autopilot

# set gazebo models location
# export GAZEBO_MODEL_PATH=${GAZEBO_MODEL_PATH}:$HOME/PX4-Autopilot/Tools/sitl_gazebo/models
# export GAZEBO_MODEL_PATH=${GAZEBO_MODEL_PATH}:~/catkin_ws/src/avoidance/avoidance/sim/models:~/catkin_ws/src/avoidance/avoidance/sim/worlds

# set ros master ip address
# export ROS_MASTER_URI=http://192.168.3.165:11311
# export ROS_IP=192.168.3.170
#=============================================================================#

