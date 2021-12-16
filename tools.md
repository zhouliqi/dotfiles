## 运行一键迁移脚本

```bash
bash bootstrap.sh
```



## 常用的工具

```bash
sudo apt update
sudo apt install snapd

sudo apt update
sudo apt install vim git zsh curl ripgrep \
    tmux htop tldr make cmake g++

# ubuntu 18.04 中，ripgrep 可能不能用 apt-get 安装，那么用 snap 安装
sudo snap install ripgrep --classic
```





## Ubuntu 常用的软件

### 使用 snap 安装应用

```bash
# search app version
snap info <app name>

# snapd install app name
snap install <app name>
```





### 安装 .dep 文件

```bash
# install a .deb file by opening a terminal and typing:
sudo dpkg -i <package_file>.deb

# To uninstall a .deb file, remove it using Adept, or type:
sudo apt-get remove <package_name>
```





### 常用软件

- Ubuntu 下安装 **v2ray** 客户端

> 参考链接：[Linux 配置 v2ray 代理详细教程（图形界面）](https://zhuanlan.zhihu.com/p/359755946)



- 安装 **Google Chrome**

```bash
cd ~

# Use wget to download the latest Google Chrome .deb package
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

# Installing Google Chrome
sudo apt install ./google-chrome-stable_current_amd64.deb
```



- **Sublime Text**

```bash
sudo snap install sublime-text --classic
```



- 安装 **Visual Studio Code**

```bash
sudo apt update
sudo apt install software-properties-common apt-transport-https wget
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt update
sudo apt install code
```



- 截图工具 **FlameShot**

```bash
sudo apt install flameshot  # Debian, Ubuntu-based distro

# 设置快捷键截图
# Setting -> Devices -> Keyboard -> +
# name : Flameshot
# Commander : flameshot gui
```



- 安装向日葵远程连接后需要配置

```bash
# 安装 LightDM（如果要用向日葵的话）
sudo apt-get update
sudo apt install lightdm
# 在弹出的Configuring lightdm界面，选择lightdm，回车。重新启动服务器，成功显示界面

# 切换回 gdm3: 执行下面命令，选择 gdm3
sudo dpkg-reconfigure lightdm
```

