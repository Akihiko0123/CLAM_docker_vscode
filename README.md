# CLAM
## 環境構築

Dockerコンテナでの使用を想定した手順です

### 1. `git clone`でリポジトリを取得

```console
git clone https://github.com/mahmoodlab/CLAM.git
```

### 2. 環境変数を保存した`.env`ファイルの作成

ホストのUID及びGIDを使用するために、`.env`ファイルを作成します

```console
./docker/init_env.sh
```

### 3. Dockerイメージのビルド及びコンテナの起動

２つの方法があります。(VSCode推奨)  

**VSCodeの拡張機能(Dev Container)を用いた方法**

下記を実施することで、VSCodeのDev Containerを使用し環境構築を行うことができます

・VSCodeでプロジェクトのルートディレクトリを開く  
・`Ctrl`と`Shift`を押しながら`P`を押してコマンドパレットを開く  
・コマンドパレットから`Reopen in Container(コンテナーで再度開く)`を選択する  

**Docker composeを用いた方法**

```console
docker compose build dev
docker compose run dev
```

上記実行後に、別のウインドウ又はタブからコンテナに入ります

```console
docker exec -it コンテナ名 /bin/bash
```
