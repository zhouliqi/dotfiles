# Config your git information (Optional)
config_your_git() {
    printf "\n=================================================\n"
    printf "\n\t Ready to config git.\n"
    printf "\n=================================================\n"

    cd ~
    printf "\nDo you want to config git now? [Y/n] " && read flag
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

create_qv2ray_icon() {
    printf "\n=================================================\n"
    printf "\n\t Create qv2ray icon.\n"
    printf "\n=================================================\n"

    printf "\nDo you want to create qv2ray icon? [Y/n] " && read flag
    if [ "$flag" == "Y" ] || [ "$flag" == 'y' ]; then
        

        icon_file="/usr/share/applications/Qv2ray.desktop"
        sudo touch "$clash_file"
        sudo echo '[Desktop Entry]' > $icon_file
        sudo echo 'Name=Qv2ray' >> $icon_file
        sudo echo 'Exec=$HOME/v2ray/Qv2ray-v2.7.0-linux-x64.AppImage' >> $icon_file
        sudo echo 'Icon=$HOME/v2ray/qv2ray.png' >> $icon_file
        sudo echo 'Type=Application >>' $icon_file
        sudo echo 'StartupNotify=true' >> $icon_file
    fi
}

printf "\n Update apt\n"
sudo apt update
sudo apt upgrade

printf "\n Install vim and git \n"
sudo apt install vim git

config_your_git

create_qv2ray_icon


printf "\n=================================================\n"
printf "\n\t Preparation has finished.\n"
printf "\n=================================================\n"