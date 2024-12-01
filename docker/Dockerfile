# ベースイメージ
FROM ubuntu:22.04 AS base
# GPUの場合(Nvidia)
# FROM nvidia/cuda:12.1.0-devel-ubuntu22.04 AS base

# 時刻設定(東京)
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# システムパッケージ更新とbuild-essential, python3.10関連パッケージ
# 及び、OpenSlide, OpenCV関連パッケージのインストール
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y build-essential python3.10 python3.10-distutils python3-pip libopenslide-dev libgl1 git

# GPUの場合(CUDA関連追加設定)
# CUDAホームディレクトリを環境変数CUDA_HOMEに設定
# ENV CUDA_HOME=/usr/local/cuda
# CUDAの実行可能ファイル（例: nvcc）ディレクトリを環境変数PATHに追加。これにより、nvccなどをコマンドとして直接実行可能に
# ENV PATH=$CUDA_HOME/bin:$PATH
# CUDAライブラリ（例:cuDNN）があるディレクトリを動的ライブラリの検索パスに追加。これにより、アプリケーションがCUDAライブラリをロード可能。
# ENV LD_LIBRARY_PATH=$CUDA_HOME/lib64:$LD_LIBRARY_PATH
# Pytorchで使用するGPUアーキテクチャを指定
# ENV TORCH_CUDA_ARCH_LIST="6.0;6.1;7.0;7.5;8.0;8.6"

# CLAMのenv.ymlに合わせてpipパッケージをインストール
RUN pip install --upgrade pip &&\
    pip install ipykernel &&\
    pip install pandas pyyaml opencv-python matplotlib scikit-learn scipy tqdm &&\
    pip install timm==0.9.8 torch torchvision tensorboardx &&\
    pip install openslide-python &&\
    pip install h5py &&\
    pip install git+https://github.com/oval-group/smooth-topk.git

# 言語設定(日本語)
RUN apt update && apt install -y language-pack-ja && update-locale LANG=ja_JP.UTF-8
RUN apt install -y fonts-takao fonts-takao-gothic fonts-takao-pgothic fonts-takao-mincho
ENV LANG jp_JP.UTF-8
ENV XMODIFIERS @im=fcitx
ENV GTK_IM_MODULE fcitx
ENV QT_IM_MODULE fcitx
ENV LC_CTYPE ja_JP.UTF-8

# dev(開発用)
FROM base AS dev

# 開発などで良く用いられるLinuxツール+nodejs(markdownlintインストール用)
RUN apt update && apt install -y \
    curl \
    gnupg \
    sudo \
    nano \
    vim \
    wget \
    && apt purge -y nodejs \
    && curl -sL https://deb.nodesource.com/setup_22.x | bash - \
    && apt install -y nodejs \
    && apt clean && rm -rf /var/lib/apt/lists/*

# コードの書式等チェック用linter, formatter, testerインストール
RUN pip install \
    codespell==2.3.0 \
    pytest==8.2.1 \
    ruff

# マークダウンファイル(README.mdなど)の書式チェック用
RUN npm install -g --save-dev markdownlint-cli2@0.13.0

# シンボリックリンク作成("python OOO.py"でコマンド実行用)
RUN ln -s /usr/bin/python3 /usr/bin/python

# ipykernelの設定(jupyter notebook等を用いる場合、別途インストールが必要)
RUN python -m ipykernel install --user --name=sysmtem-python --display-name "Python(system)"

# 開発用ユーザー追加
ARG USERNAME=developer
ARG USER_UID
ARG USER_GID

# ホストのユーザーID,グループIDをコンテナ内のIDに割り当てるが、
# コンテナ環境で既存のグループID、ユーザーIDの場合は、
# ユーザーID=1000, グループID=1000を割り当て
RUN USER_GID=$(getent group $USER_GID >/dev/null && echo 1000 || echo $USER_GID) \
    && USER_UID=$(getent passwd $USER_UID >/dev/null && echo 1000 || echo $USER_UID) \
    && groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo "$USERNAME ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# 指定したユーザー名でコンテナをビルド
USER $USERNAME

CMD ["usr/bin/bash"]
