#!/bin/bash
set -euo pipefail

# 本ファイルのあるディレクトリの１つ上のディレクトリに移動
cd $(dirname $0)/..

REPLACE_USERNAME=$(echo $USER |sed 's/\./_/g')

# ホストのユーザー名がrootの場合、REPLACE_USERNAME="developer"に指定
if [ "$USER" = "root" ]; then
  REPLACE_USERNAME="developer"
fi

# .envファイルがない場合、下記内容の環境変数ファイルを作成
if [ ! -f .env ]; then
    cat <<EOT > .env

COMPOSE_PROJECT_NAME=clam_${REPLACE_USERNAME}
USERNAME=$REPLACE_USERNAME
HOST_UID=`id -u`
HOST_GID=`id -g`
EOT
fi
