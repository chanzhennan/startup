#FROM nvidia/cuda:11.6.1-devel-ubuntu20.04
#FROM nvidia/cuda:11.7.1-cudnn8-devel-ubuntu22.04
FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu20.04
#FROM nvidia/cuda:11.3.0-cudnn8-devel-ubuntu20.04  
#FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu20.04
#FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu18.04
#FROM nvidia/cuda:9.2-cudnn7-devel-ubuntu18.04
#FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04 
ENV DEBIAN_FRONTEND=noninteractive 
ENV HTTP_PROXY=http://127.0.0.1:8118
ENV HTTPS_PROXY=http://127.0.0.1:8118


RUN apt-get update && apt-get install vim git build-essential wget git-lfs -y
RUN apt-get install python3 python3-pip -y

RUN git config --global user.email "chanzhennan@163.com" && git config --global user.name "chanzhennan"

WORKDIR /tmp

COPY cmake-3.29.1-linux-x86_64.sh /tmp/cmake-install.sh 

# install cmake 3.29  use upper copy install download
#RUN wget https://github.com/Kitware/CMake/releases/download/v3.29.1/cmake-3.29.1-linux-x86_64.sh \
#      -O /tmp/cmake-install.sh \

RUN chmod u+x /tmp/cmake-install.sh \
#      && mv /usr/bin/cmake /usr/bin/cmake_old \
      && mkdir /usr/bin/cmake \
      && /tmp/cmake-install.sh --skip-license --prefix=/usr/bin/cmake \
      && rm /tmp/cmake-install.sh

ENV PATH="/usr/bin/cmake/bin:${PATH}"


#RUN pip3 install pre-commit && pip3 install clang-format

# Install miniconda
ENV CONDA_DIR /opt/conda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
     /bin/bash ~/miniconda.sh -b -p /opt/conda

# Put conda in path so we can use conda activate
ENV PATH=$CONDA_DIR/bin:$PATH

#RUN /opt/conda/bin/conda install -y -c pytorch torchvision cudatoolkit=11.8 -c conda-forge -c defaults

