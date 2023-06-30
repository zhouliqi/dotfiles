#!/bin/bash


install_command() {
    printf "\n=================================================\n"
    printf "\n\t Ready to install useful command.\n"
    printf "\n=================================================\n"

    cd ~
    sudo apt update
    sudo apt install vim git zsh curl tmux htop tldr make cmake g++ python3 ripgrep net-tools dstat tree cloc zoxide 
    sudo ln -s /usr/bin/python3 /usr/bin/python

    sudo snap install procs

    # use apt install some command line tool on Ubuntu 22.04
    version=$(uname -a)
    if [ "$version" == .*"22\.04".* ]; then
        sudo apt install exa duf
    fi

    # cd ~/Downloads
    # curl -LO https://github.com/ClementTsang/bottom/releases/download/0.6.8/bottom_0.6.8_amd64.deb
    # sudo dpkg -i bottom_0.6.8_amd64.deb
    # cd -
}


install_clash() {
    printf "\n=================================================\n"
    printf "\n\t Ready to install Clash for windows.\n"
    printf "\n=================================================\n"

    cd ~

    wget wget https://github.com/Fndroid/clash_for_windows_pkg/releases/download/0.19.27/Clash.for.Windows-0.19.27-x64-linux.tar.gz Clash.tar.gz

    tar xzf Clash.for.Windows-0.19.27-x64-linux.tar.gz

    mv 'Clash for Windows-0.19.27-x64-linux' Clash && cd Clash

    wget https://upload.wikimedia.org/wikipedia/commons/0/0b/Clash_Logo.png

    clash_file="/usr/share/applications/Clash.desktop"
    sudo touch "$clash_file"
    echo [Desktop Entry] > $clash_file
    echo Name=Clash >> $clash_file
    echo Exec=$HOME/Clash/cfw >> $clash_file
    echo Icon=$HOME/Clash/Clash.png >> $clash_file
    echo Type=Application >> $clash_file
    echo StartupNotify=true >> $clash_file
}



install_chrome() {
    printf "\n=================================================\n"
    printf "\n\t Ready to install Chrome.\n"
    printf "\n=================================================\n"

    printf "\nDo you want install chrome? [Y/n] "
    read flag
    if [ "$flag" == "Y" ] || [ "$flag" == 'y' ]; then
        printf "\ninstalling chrome\n"

        cd $HOME/Downloads
        
        # use wget to download the latest Google Chrome .deb package
        wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

        # installing Google Chrome
        sudo apt install ./google-chrome-stable_current_amd64.deb
    fi
}



install_app() {
    printf "\n=================================================\n"
    printf "\n\t Ready to install app.\n"
    printf "\n=================================================\n"

    printf "\nDo you want install sublime-text? [Y/n] "
    read flag
    if [ "$flag" == "Y" ] || [ "$flag" == 'y' ]; then
        printf "\ninstalling sublime-text\n"
        sudo snap install sublime-text --classic
    fi

    printf "\nDo you want install vs-code? [Y/n] "
    read flag
    if [ "$flag" == "Y" ] || [ "$flag" == 'y' ]; then
        printf "\ninstalling vs-code\n"
        sudo snap install --classic code
    fi
}



config_git() {
    printf "\n=================================================\n"
    printf "\n\t Ready to config git.\n"
    printf "\n=================================================\n"

    cd ~
    printf "\nDo you want config git? [Y/n] "
    read flag
    if [ "$flag" == "Y" ] || [ "$flag" == 'y' ]; then
        # 设置你自己的名字和邮箱
        git config --global user.name "zhouliqi"
        git config --global user.email zhouliqi1204@gmail.com

        # 生成 ssh 的密钥，按回车三次
        ssh-keygen -t rsa -b 4096 -C "zhouliqi1204@gmail.com"

        # 将下面显示的东西添加到你的 github -> setting -> SSH keys 中
        cat ~/.ssh/id_rsa.pub
    fi
}



install_command

# 如果 Clash 未安装，则安装它
if [ ! -d "$HOME/Clash" ]; then
    install_clash
fi

# Clash 安装完成之后，确保能够科学上网，然后启动它，设置终端代理 (和 Clash 中的端口对应)
export "http_proxy=http://127.0.0.1:7890"
export "https_proxy=http://127.0.0.1:7890"

install_chrome

install_app

config_git
