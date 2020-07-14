#!/bin/bash
set -e

#source: http://stackoverflow.com/questions/40128751/how-to-install-opencv-2-4-13-for-python-2-7-on-ubuntu-16-04

################################################################################
###                       OpenCV2 Installation Script                        ###
################################################################################
#            Source code at https://github.com/arthurbeggs/scripts             #
################################################################################
#                                                                              #
#     Feel free to copy and modify this file. Giving me credit for it is your  #
# choice, but please keep references to other people's work, which I don't     #
# have ownership and thus cannot decide what to do with the licenses.          #
#                                                                              #
################################################################################


### Single line script will download and run this script automatically:
# curl -s "https://raw.githubusercontent.com/arthurbeggs/scripts/master/install_apps/install_opencv2.sh" | bash


## ref
# [Installation in Linux — OpenCV 2.4.13.7 documentation](https://docs.opencv.org/2.4/doc/tutorials/introduction/linux_install/linux_install.html)
# [Ubuntu 16.04下编译OpenCV 2.4.13支持FFmpeg以及CUDA 8加速图像处理 | blueyi's notes](http://notes.maxwi.com/2017/03/01/ubuntu-compile-opencv2-with-cuda-and-ffmpeg/)
# [To install opencv 2.4.13 in ubuntu 16.04](https://gist.github.com/jayant-yadav/809723151f2f72a93b2ee1040c337427)
sudo apt-get update
sudo apt-get upgrade -y

sudo apt-get install -y build-essential cmake libgtk2.0-dev pkg-config \
                        python-numpy python-dev libavcodec-dev libavformat-dev \
                        libswscale-dev libjpeg-dev libpng12-dev libtiff5-dev \
                        libjasper-dev libopencv-dev checkinstall pkg-config \
                        yasm libjpeg-dev libjasper-dev libavcodec-dev \
                        libavformat-dev libswscale-dev libdc1394-22-dev \
                        libxine2 libgstreamer0.10-dev  libv4l-dev \
                        libgstreamer-plugins-base0.10-dev python-dev \
                        python-numpy libtbb-dev libqt4-dev libgtk2.0-dev \
                        libmp3lame-dev libopencore-amrnb-dev \
                        libopencore-amrwb-dev libtheora-dev libvorbis-dev \
                        libxvidcore-dev x264 v4l-utils

sudo apt-get install build-essential -y
sudo apt-get install cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev

echo "multiproccessing library"
sudo apt-get install libtbb-dev -y

echo "GUI and openGL extensions"
sudo apt-get install qt4-default libqt4-opengl-dev libvtk5-qt4-dev libgtk2.0-dev libgtkglext1 libgtkglext1-dev -y

echo "image manipulation libraries"
sudo apt-get install libpng3 pngtools libpng12-dev libpng12-0 libpng++-dev -y
sudo apt-get install libjpeg-dev libjpeg9 libjpeg9-dbg libjpeg-progs libtiff5-dev libtiff5 libtiffxx5 libtiff-tools libjasper-dev libjasper1  libjasper-runtime zlib1g zlib1g-dbg zlib1g-dev -y

echo "video manipulation libraries"
sudo apt-get install libavformat-dev libavutil-ffmpeg54 libavutil-dev libxine2-dev libxine2 libswscale-dev libswscale-ffmpeg3 libdc1394-22 libdc1394-22-dev libdc1394-utils -y

echo "codecs"
sudo apt-get install libavcodec-dev -y
sudo apt-get install libfaac-dev libmp3lame-dev -y
sudo apt-get install libopencore-amrnb-dev libopencore-amrwb-dev -y
sudo apt-get install libtheora-dev libvorbis-dev libxvidcore-dev -y
sudo apt-get install ffmpeg x264 libx264-dev -y
sudo apt-get install libv4l-dev v4l-utils -y

echo "multiproccessing library"
sudo apt-get install libtbb-dev -y

echo "finally download and install opencv"
## 避免由于OpenCV版对最新CUDA的不兼容
# git clone https://github.com/opencv/opencv.git 
# cd opencv
# git checkout 2.4.13.7
# mkdir release
# cd release
# cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local ..
# make
# sudo make install
mkdir -p /tmp/opencv
cd /tmp/opencv
#wget http://downloads.sourceforge.net/project/opencvlibrary/opencv-unix/2.4.13/opencv-2.4.13.zip
#unzip opencv-2.4.13.zip

cd opencv-2.4.13
mkdir -p build
cd build

### Compile and install
cmake -G "Unix Makefiles" -DCMAKE_CXX_COMPILER=/usr/bin/g++ CMAKE_C_COMPILER=/usr/bin/gcc -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_INSTALL_PREFIX=/usr/local -DWITH_TBB=ON -DBUILD_NEW_PYTHON_SUPPORT=ON -DWITH_V4L=ON -DINSTALL_C_EXAMPLES=ON -DINSTALL_PYTHON_EXAMPLES=ON -DBUILD_EXAMPLES=ON -DWITH_QT=ON -DWITH_OPENGL=ON -DBUILD_FAT_JAVA_LIB=ON -DINSTALL_TO_MANGLED_PATHS=ON -DINSTALL_CREATE_DISTRIB=ON -DINSTALL_TESTS=ON -DENABLE_FAST_MATH=ON -DWITH_IMAGEIO=ON -DBUILD_SHARED_LIBS=OFF -DWITH_GSTREAMER=ON ..
make all -j$(nproc) # Uses all machine cores
sudo make install

echo "making and installing"
make -j$(nproc)
sudo make install

echo "finishing off installation"
sudo /bin/bash -c 'echo "/usr/local/lib" > /etc/ld.so.conf.d/opencv.conf'
sudo ldconfig

echo "Congratulations! You have just installed OpenCV. And that's all, folks! :P"

### Echoes OpenCV installed version if installation process was successful
# sudo gedit /etc/bash.bashrc
# 末尾加入
# PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig
# export PKG_CONFIG_PATH
# 保存退出
# sudo source /etc/bash.bashrc  #使配置生效
# （该步骤可能会报错找不到命令，原因是source为root命令
# su（进入root权限）
# 输入密码
# source /etc/bash.bashrc
# Ctrl+d（推迟root）
# sudo updatedb #更新database


echo -e "OpenCV version:"
pkg-config --modversion opencv
