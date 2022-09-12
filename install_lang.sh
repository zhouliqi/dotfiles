#!/bin/bash


install_rust() {

	printf "\n=================================================\n"
    printf "\n\t Ready to install rust.\n"
    printf "\n=================================================\n"

    printf "\nDo you want install rust?[Y/n] "
    read flag
    if [ "$flag" == "Y" ] || [ "$flag" == 'y' ]; then
        cd ~
        # 如果 rust 未安装，则安装它
		if [ ! -d "$HOME/.cargo" ]; then
			echo "rust is not installed, now install it."
		    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
		else
			echo "rust has been installed."
		fi
    fi
}


install_golang() {
	printf "\n=================================================\n"
    printf "\n\t Ready to install golang.\n"
    printf "\n=================================================\n"

    printf "\nDo you want install golang?[Y/n] "
    read flag
    if [ "$flag" == "Y" ] || [ "$flag" == 'y' ]; then
        cd $HOME/Downloads
    	echo "installing golang"
        # 如果运行的时候一直不动，则可能是网络问题，建议手动下载 go 的安装包
		sudo wget https://golang.org/dl/go1.15.5.linux-amd64.tar.gz
        # 删除之前安装过的 go 版本，然后将 go 安装包解压到 /usr/local
		sudo rm -rf /usr/local/go && tar -C /usr/local -xzf go1.15.5.linux-amd64.tar.gz
    fi
}


install_rust

install_golang
