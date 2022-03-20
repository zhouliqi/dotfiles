#!/bin/bash

# ==========================================================================================
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
# ==========================================================================================

# Variables

# install all the submodules

install_zsh () {
    # Test to see if zshell is installed.  If it is:
    if [ -f /bin/zsh ] || [ -f /usr/bin/zsh ]; then
    	echo "zsh having been installed!!!"
        # Install on-my-zsh
    	if [ ! -d "$HOME/.oh-my-zsh" ]; then
    		echo "install oh-my-zsh!!!"
    		sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    	fi
        # Set the default shell to zsh if it isn't currently set to zsh
        if [ ! "$SHELL" == "$(which zsh)" ]; then
            chsh -s "$(which zsh)"
        fi
    else
        # If zsh isn't installed, get the platform of the current machine
        platform=$(uname);
        # If the platform is Linux, try an apt-get to install zsh and then recurse
    	echo "installing zsh!!!"
        if [[ $platform == 'Linux' ]]; then
            if [[ -f /etc/redhat-release ]]; then
                sudo yum install zsh
                install_zsh
            fi
            if [[ -f /etc/debian_version ]]; then
                sudo apt-get install zsh
                install_zsh
            fi
        # If the platform is OS X, tell the user to install zsh :)
        elif [[ $platform == 'Darwin' ]]; then
            echo "Please install zsh, then re-run this script!"
            exit
        fi
    fi
}

printf "\n==============================================================================================================\n"
printf "\n\t\t Ready to install zsh, on-my-zsh and change shell to zsh if necessary.\n"
printf "\n==============================================================================================================\n"

install_zsh


dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"           # dotfiles directory
olddir=~/dotfiles_old      # old dotfiles backup directory
echo "$dir"

printf "\n==============================================================================================================\n"
printf "\n\t\t Ready to install plugins.\n"
printf "\n==============================================================================================================\n"

ZSH_CUSTOM_PLUG="oh-my-zsh/custom/plugins"
ZSH_PLUG="$ZSH_CUSTOM_PLUG/autojump $ZSH_CUSTOM_PLUG/zsh-autosuggestions $ZSH_CUSTOM_PLUG/zsh-completions $ZSH_CUSTOM_PLUG/zsh-syntax-highlighting $ZSH_CUSTOM_PLUG/zsh-history-substring-search $ZSH_CUSTOM_PLUG/zsh-git-prompt "
submodules="zplug fzf "$ZSH_PLUG

for file in $submodules; do
	echo $file
	git submodule update --init $file
    printf "\n"
done


files="bashrc bash_profile vimrc vim zshrc gitconfig gitignore_global tmux.conf aliases zplug fzf "$ZSH_PLUG 


# create dotfiles_old in homedir
printf "\n==============================================================================================================\n"
printf "\n\t\t Creating $olddir for backup of any existing dotfiles in ~ ...\n"
printf "\n==============================================================================================================\n"
mkdir -p $olddir
printf "done\n\n"


# change to the dotfiles directory
printf "\n==============================================================================================================\n"
printf "\n\t\t Changing to the $dir directory ...\n"
printf "\n==============================================================================================================\n"
cd "$dir" || exit
printf "done\n\n"


printf "\n==============================================================================================================\n"
printf "\n\t\t move any existing dotfiles in $HOME to dotfiles_old directory, then create \n"
printf "\n\t\t symlinks from the $HOME to any files in the ~/dotfiles directory specified in files.\n"
printf "\n==============================================================================================================\n"
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/."$file" ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -fns "$dir"/"$file" ~/."$file"
    printf "\n"
done

printf "\n==============================================================================================================\n"
printf "\n\t\t Changing to the $ZSH_CUSTOM_PLUG/autojump directory and install.\n"
printf "\n==============================================================================================================\n"
cd "$ZSH_CUSTOM_PLUG/autojump" || exit 
python3 ./install.py

printf "\n==============================================================================================================\n"
printf "\n\t\t Now, Install fzf plugin\n"
printf "\n==============================================================================================================\n"
~/.fzf/install


rm ~/.zcompdump*
rm ~/.zplug/zcompdump*

printf "\n finished!"