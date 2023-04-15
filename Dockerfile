FROM pytorch/pytorch:1.7.1-cuda11.0-cudnn8-devel

# software installation
RUN apt-key del A4B469963BF863CC && apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/3bf863cc.pub
RUN apt update

# basic
RUN apt install -y --no-install-recommends \
    vim tmux wget iputils-ping git g++ net-tools curl zip unzip ffmpeg


RUN apt install -y --no-install-recommends \
    bzip2 \
    ca-certificates \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender1 \
    mercurial \
    openssh-client \
    procps \
    subversion

# jupterlab 
RUN apt install -y nodejs

# @option: SSH server
RUN apt install -y --no-install-recommends openssh-server

# limit password quality
RUN apt install -y libpam-pwquality

RUN echo 'PASS_MIN_LEN 8' >> /etc/login.defs
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config

RUN apt clean
RUN rm -rf /var/lib/apt/lists/*

WORKDIR /root/dev


# tmux configure
ADD .tmux.conf /root/.tmux.conf
RUN echo "tmux source-file ~/.tmux.conf" >> /root/.bashrc
RUN echo "cd /data/wlsgur4011" >> /root/.bashrc
RUN echo "alias kpip='pip install -i http://ftp.daumkakao.com/pypi/simple --trusted-host ftp.daumkakao.com'" >> /root/.bashrc


