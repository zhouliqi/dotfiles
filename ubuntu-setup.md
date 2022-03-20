# ubuntu 系统设置

## 准备

- 常用的工具

```bash
sudo apt update
sudo apt install snapd

sudo apt update
sudo apt install vim git zsh curl tmux htop tldr make cmake g++ python3 ripgrep

# ubuntu 18.04 中，ripgrep 可能不能用 apt-get 安装，那么用 snap 安装
sudo snap install ripgrep --classic
```



- Ubuntu 下安装 **v2ray** 客户端，科学上网

```bash
cd ~
mkdir v2ray && cd v2ray
mkdir v2ray-linux-64
```

> 将 [v2ray](https://github.com/v2ray/v2ray-core/releases/tag/v4.28.2) 的内核文件下载到 `v2ray-linux-64` 目录下；将 [Qv2ray](https://github.com/Qv2ray/Qv2ray/releases/tag/v2.7.0) 客户端下载到 `v2ray` 目录下

```bash
chmod +x Qv2ray-v2.7.0-linux-x64.AppImage

# 创建它的桌面图表
sudo vim /usr/share/applications/Qv2ray.desktop

# 添加下面内容
[Desktop Entry]
Name=Qv2ray
Exec=/home/zhouliqi/v2ray/Qv2ray-v2.7.0-linux-x64.AppImage
Icon=/home/zhouliqi/v2ray/v2ray.png
Type=Application
StartupNotify=true

# 然后打开 Qv2ray 客户端，首选项 -> 内核设置 -> v2ray 核心可执行文件路径
/home/zhouliqi/v2ray/v2ray-linux-64/v2ray
# 首选项 -> 内核设置 -> v2ray 资源目录
/home/zhouliqi/v2ray/v2ray-linux-64

# 倒入 vmess 链接，启动系统代理 
```



- 设置 git 和 github

```bash
# 设置你自己的名字和邮箱
git config --global user.name "zhouliqi"
git config --global user.email zhouliqi1204@gmail.com

# 生成 ssh 的密钥，按回车三次
ssh-keygen -t rsa -b 4096 -C "zhouliqi1204@gmail.com"

# 将下面显示的东西添加到你的 github -> setting -> SSH keys 中
cat ~/.ssh/id_rsa.pub
ssh -T git@github.com # 测试
```





## 运行一键迁移脚本

```bash
cd ~
git clone git@github.com:zhouliqi/dotfiles.git
cd dotfiles

# 记得设置终端走代理，不然下载插件的时候可能会失败(和 Qv2ray 中的端口对应)
export http_proxy=http://127.0.0.1:8889
export https_proxy=http://127.0.0.1:8889

./bootstrap.sh

# 如果 on-my-zsh 没安装，则先回安装 on-my-zsh，然后再执行一遍 bootstrap.sh 脚本

source .zshrc
```



```bash
# 如果会出现: /usr/bin/env: ‘python’: No such file or directory 
whereis python3
#Then we create a symlink to it:
sudo ln -s /usr/bin/python3 /usr/bin/python
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
# 或者
sudo apt install ./<package_file>.deb

# To uninstall a .deb file, remove it using Adept, or type:
sudo apt-get remove <package_name>
```



### 常用软件

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

