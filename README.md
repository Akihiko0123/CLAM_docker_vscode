# CLAM
## 環境構築

本プロジェクトはDockerコンテナでの使用を想定しています

### 1. リポジトリを取得

```console
git clone https://github.com/mahmoodlab/CLAM.git
```

### 2. `.env`ファイルの作成

ホストのUID及びGIDを使用するために、`.env`ファイルを作成します

```console
./docker/init_env.sh
```

### 3. Dockerイメージのビルド及びコンテナの起動

**オプション１：Docker composeを使用**

```console
docker compose build dev
docker compose run dev
```

上記実行後に、別のウインドウ又はタブからコンテナに入ります

```console
docker exec -it コンテナ名 /bin/bash
```

**オプション２：VSCodeの拡張機能(Dev Container)を使用**

下記を実施することで、VSCodeのDev Containerを使用して環境構築を行うことができます

・VSCodeでプロジェクトのルートディレクトリを開く
・ウインドウ左下の`><`アイコンをクリックし、
　コマンドパレットから`Reopen in Container(コンテナーで再度開く)`を選択する

