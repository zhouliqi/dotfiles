# ubuntu 系统设置

## 准备工作

### 常用的工具

```bash
sudo apt update
sudo apt upgrade
sudo apt install vim git

# ubuntu 18.04 中，ripgrep 可能不能用 apt-get 安装，那么用 snap 安装
sudo snap install ripgrep --classic
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

# 测试是否可以连接到你的 github 账户
ssh -T git@github.com

# 删除/添加 github 仓库地址
git remote rm origin
git remote add origin [address]
```



### 科学上网

- 先在 [vultr](https://my.vultr.com/) 上购买一个 VPS，然后登录这个 VPS 安装 Trojan 协议

```bash
# 搭建 Trojan 服务，安装 Trojan web 管理面板，一键更改 Trojan-Panel 面板端口并设置伪装站点(必须将域名解析到你的 VPS 的 IP 上)

# 1. 安装 Curl 支持环境
apt -y install curl  # Debian
yum -y install curl  # CentOS

# 一键安装 / 更新 Trojan
source <(curl -sL https://git.io/trojan-install)

# 卸载 Trojan
source <(curl -sL https://git.io/trojan-install) --remove
```

- Ubuntu 下安装 **v2ray / Trojan** 客户端（推荐）

```bash
mkdir ~/v2ray && cd ~/v2ray
mkdir v2ray-linux-64
```

> 将 [v2ray](https://github.com/v2ray/v2ray-core/releases/tag/v4.28.2) 的内核文件下载到 `v2ray-linux-64` 目录下；将 [Qv2ray](https://github.com/Qv2ray/Qv2ray/releases/tag/v2.7.0) 客户端下载到 `v2ray` 目录下；下载 [qv2ray 桌面图标](https://raw.githubusercontent.com/Qv2ray/Qv2ray/master/assets/icons/qv2ray.png)

```bash
chmod +x Qv2ray-v2.7.0-linux-x64.AppImage

# 创建它的桌面图表
sudo vim /usr/share/applications/Qv2ray.desktop

# 添加下面内容（v2ray 前面一部分替换成自己的目录）
[Desktop Entry]
Name=Qv2ray
Exec=/home/zhouliqi/v2ray/Qv2ray-v2.7.0-linux-x64.AppImage
Icon=/home/zhouliqi/v2ray/qv2ray.png
Type=Application
StartupNotify=true

# 然后打开 Qv2ray 客户端，首选项 -> 内核设置 -> v2ray 核心可执行文件路径
~/v2ray/v2ray-linux-64/v2ray
# 首选项 -> 内核设置 -> v2ray 资源目录
~/v2ray/v2ray-linux-64

# 1. 如果使用 vmess 协议，则可以直接导入 vmess 链接，启动系统代理

# 2. 如果使用 Trojan 协议，那么
# 首先前往: https://github.com/Qv2ray/QvPlugin-Trojan/releases/tag/v3.0.0 下载 linux 下的插件放到顶级 v2ray 目录下，再运行
cd ~/v2ray
cp QvPlugin-Trojan.v3.0.0.linux-x64.so ~/.config/qv2ray/plugins

# 重启后就可以在插件下面看到支持 Trojan 协议了，然后再导入 Trojan 链接
```

- Ubuntu 下安装 **Clash for windows** 科学上网，[参考这里](https://v2xtls.org/clash-for-windows%E9%85%8D%E7%BD%AEtrojan%E6%95%99%E7%A8%8B/)

> 1. 首先前往 [clash_for_windows_pkg](https://github.com/Fndroid/clash_for_windows_pkg) 下载后缀是 [linux.tar.gz](https://github.com/Fndroid/clash_for_windows_pkg/releases/download/0.19.27/Clash.for.Windows-0.19.27-x64-linux.tar.gz) 的包（根据处理器的架构下载对应的包，我的电脑是 x86_64 架构的）
> 2. 将这个包解压到 `~/Clash` 下，运行 `./cfw` 可以看到最上方有一只小猫，然后点击它打开客户端进行配置
> 3. 点击 https://v2xtls.org/clash_template2.yaml 下载模板配置文件，然后修改其中的字段。例如我使用的协议是 trojan，我就在其中修改 server 和 password 这两个字段。最后将这个文件拖到 Clash 的 Profiles，选中这个配置文件
> 4. 代理模式的**绝大多数情况建议使用 Rule**
> 5. 在 General 中打开 Allow LAN，Mixin 以及 Start with Linux
> 6. 在主机的 setting -> Network 中的 Network Proxy 选择 Manual，设置 Http 和 Https 的端口号为 Clash 主界面 Port 项的端口，一般是 7890
> 7. 重启 Clash 后应该就可以科学上网了

```bash
# 给 Clash for windows 制作桌面图标
# 首先前往 https://zh.m.wikipedia.org/zh/File:Clash_Logo.png 保存 Clash 图标

# 然后运行
sudo vim /usr/share/applications/Clash.desktop

# 写入下面内容，Exec 和 Icon 填入相应的路径，然后保存即可
[Desktop Entry]
Name=Clash
Exec=/home/zhouliqi/Clash/cfw
Icon=/home/zhouliqi/Clash/Clash.png
Type=Application
StartupNotify=true
```



## 运行一键迁移脚本

```bash
# 记得设置终端走代理，不然下载插件的时候可能会失败 (和 Clash 中的端口对应)
export http_proxy=http://127.0.0.1:8889
export https_proxy=http://127.0.0.1:8889

cd ~
git clone git@github.com:zhouliqi/dotfiles.git
cd dotfiles

./bootstrap.sh

# 如果 oh-my-zsh 没安装，则先会安装 oh-my-zsh，然后再执行一遍 bootstrap.sh 脚本

# 最后执行
source ~/.zshrc
```

```bash
# 如果会出现: /usr/bin/env: ‘python’: No such file or directory 
whereis python3

# 那么创建 python3 的符号链接
sudo ln -s /usr/bin/python3 /usr/bin/python
```



## Ubuntu 常用的软件

### 安装中文输入法

> 在 ubuntu 20.04 以及 ubuntu 22.04 下测试有效，[参考这里](https://blog.csdn.net/a805607966/article/details/105874756)。
>
> 首先在终端运行 `sudo apt-get install fcitx-googlepinyin`
>
> 安装完成后打开菜单栏，在应用程序中搜索 language support 并打开。将 Keyboard input method system 切换为 fctix 然后重启电脑。
>
> 启动 Fcitx，然后在顶部的状态栏中点击键盘图标，选择 Configure 进入配置界面。点击输入方法设置左下角的 `+` 号，进入添加输入方法界面。取消“只显示当前语言”选项的勾选，输入 pinyin 搜索到系统现有的拼音输入法。选择 Google Pinyin 并点击 OK 确认。
>
> 关闭设置，谷歌输入法配置完成。可以点击右上角状态栏的键盘图片切换到谷歌输入法，切换输入法的快捷键是 ctrl+space，可以在刚关闭的输入方法设置界面里第二项 Global Config 里修改快捷键。



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



### 常用工具

- 安装 **Google Chrome**

```bash
cd ~

# use wget to download the latest Google Chrome .deb package
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

# installing Google Chrome
sudo apt install ./google-chrome-stable_current_amd64.deb

# update Chrome in Ubuntu 20.04
sudo apt-get update
sudo apt-get --only-upgrade install google-chrome-stable

# restart Chrome
```

- 安装 **Visual Studio Code**

```bash
# 1. use apt to install vscode
sudo apt update
sudo apt install software-properties-common apt-transport-https wget
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt update
sudo apt install code
```

- 安装 **Sublime Text 4**

```bash
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null

echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

sudo apt-get update
sudo apt-get install sublime-text
```

Sublime Text 4 的无限用户许可：前往 https://hexed.it/；打开文件 `/opt/sublime_text/sublime_text`，在右边的搜索栏查找 ` 80 78 05 00 0F 94 C1`，将它们替换为 `C6 40 05 01 48 85 C9`，然后导出这个文件 `sublime_text`；打开终端，输入以下命令

```bash
# 保留旧的 sublime_text 文件
sudo mv /opt/sublime_text/sublime_text /opt/sublime_text/sublime_text.old
# 进入上一步导出的 sublime_text 的目录
cd ~/Downloads/
chmod 755 sublime_text && sudo chown root sublime_text && sudo chgrp root sublime_text
sudo mv sublime_text /opt/sublime_text/
```

- 安装 Go 语言环境

```bash
# download: https://go.dev/dl/
cd ~/Downloads
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.23.0.linux-amd64.tar.gz

vim ~/.zshrc

# 添加 go 的环境变量
export GOROOT=/usr/local/go
export PATH=$GOROOT/bin:$PATH
source ~/.zshrc
```

- 安装 GoLand

```bash
# 前往 JetBrains 官网下载 GoLand 保存的 ~ 目录
cd ~
sudo tar xzf goland-2020.1.4.tar.gz -C /opt
```

- 截图工具 **FlameShot** 和录屏工具 **kazam**

```bash
sudo apt install flameshot kazam

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



### 终端工具

- `tmux` 配置

```bash
# To install Tmux Resurrect, it is recommended to install Tmux Plugin Manager first
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

#================== Then we add new plugin to ~/.tmux.conf ==================
# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'tmux-plugins/tmux-resurrect'

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run -b '~/.tmux/plugins/tpm/tpm'
#============================================================================

# type this in terminal if tmux is already running
tmux source ~/.tmux.conf

# Final Press prefix + I (capital i, as in Install) to fetch the plugin.
```

> ​	在 tmux 终端输入 `prefix` + `Ctrl` + `s` 保存当前的 tmux 的环境，如果保存成功会在 tmux 底部弹出 `Tmux environment saved!`  的提示。
>
> ​	当主机重启之后，在 tmux 终端输入 `prefix` + `Ctrl` + `r` 可以恢复上一次保存的 tmux 的环境，如果恢复成功会在 tmux 底部弹出 `Tmux restore complete!`  的提示。
>
> 参考资料：
>
> - [Tmux Tutorial - Lei Mao](https://leimao.github.io/blog/Tmux-Tutorial/)
> - [Writing Your tmux Config: a Detailed Guide](https://thevaluable.dev/tmux-config-mouseless/)

- `dstat` 工具

```bash
cd ~
sudo apt-get install dstat

# -c: for CPU stats
# -t: for timestamp
# -d: for disk stats
# --disk-util: for disk utilization
# --disk-tps: for disk transactions (I/O requests) per second
# number: The display is updated every  second

# e.g. nvme0n1p2 is SSD name
dstat -ctdD nvme0n1p2 --disk-tps 2
```

- 代码行数统计工具

```bash
# install cloc command
sudo apt update
sudo apt install cloc

cloc . --exclude-dir=path1,[path2] --by-file
```

```bash
# install loc (require rust environment)
cargo install loc
```

