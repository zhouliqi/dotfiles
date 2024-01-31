# 深度学习

## 编译工具

- 安装 clang

```bash
sudo apt-get -y install clang
```

- 设置

```bash
# 将 clang/clang++ 加入到编译器类型中
sudo update-alternatives --install /usr/bin/cc cc /usr/bin/clang 100
sudo update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++ 100

# 手动选择编译器类型（gcc/g++ or clang/clang++）
sudo update-alternatives --config cc
sudo update-alternatives --config c++
```

## 环境配置

### 安装显卡驱动

自己完成

### 安装 CUDA

1. 如果是 Ubuntu 22.04 或者 Ubuntu 22.04 需要降低 `gcc` 和 `g++` 的版本

```bash
# 在 /etc/apt/sources.list 文件的最后添加源
sudo vim /etc/apt/sources.list

# 添加 deb [arch=amd64] http://archive.ubuntu.com/ubuntu focal main universe
sudo apt update
sudo apt-get -y install gcc-7 g++-7
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 50
sudo update-alternatives  --install /usr/bin/g++ g++ /usr/bin/g++-7 50

sudo update-alternatives --display gcc
sudo update-alternatives --display g++
```

2. 前往 [CUDA Toolkit Archive](https://developer.nvidia.com/cuda-toolkit-archive) 下载对应版本的 `.run` 文件，例如下载 `10.2` 版本

```bash
wget https://developer.download.nvidia.com/compute/cuda/10.2/Prod/local_installers/cuda_10.2.89_440.33.01_linux.run
sudo sh cuda_10.2.89_440.33.01_linux.run
```

执行脚本后，先选择 continue，然后在 CUDA Installer 中取消选中的 Driver，最后输入 accept。

3. 配置环境变量

```bash
sudo vim ~/.zshrc
# 添加
export PATH=/usr/local/cuda-10.2/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-10.2/lib64:$LD_LIBRARY_PATH

source ~/.zshrc
```

4. 查看是否安装成功

```bash
cat /usr/local/cuda/version.txt

cd /usr/local/cuda-10.2/samples/1_Utilities/deviceQuery
sudo make
./deviceQuery
# 出现相关输出，则 CUDA 安装成功
```

### 安装 cuDNN

1. 前往 [cuDNN Download](https://developer.nvidia.com/rdp/cudnn-download) 下载对应的版本
2. 解压下载的压缩包为 `cuda`，然后运行下面命令

```bash
cd ~/Downloads
sudo cp cuda/include/cudnn*.h /usr/local/cuda-10.2/include
sudo cp cuda/lib/libcudnn* /usr/local/cuda-10.2/lib64

sudo chmod a+r /usr/local/cuda-10.2/include/cudnn*.h
sudo chmod a+r /usr/local/cuda-10.2/lib64/libcudnn*

# 查看 cuDNN 版本
cat /usr/local/cuda-10.2/include/cudnn_version.h | grep CUDNN_MAJOR -A 2
```

至此 CUDN + cuDNN 安装完成，可以执行相关训练文件查看是否有 GPU 信息输出，或监控一下 GPU 状态

```bash
watch -n 1 nvidia-smi
```

### PyTorch 配置


