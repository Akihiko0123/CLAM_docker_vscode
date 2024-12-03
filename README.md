# CLAM
## 環境構築

`Docker`コンテナでの使用を想定した手順です

### 1. リポジトリを取得

```console
git clone https://github.com/mahmoodlab/CLAM.git
```

### 2. `.env`ファイルの作成

ホストの`UID`及び`GID`を使用するために、`.env`ファイルを作成します

```console
./docker/init_env.sh
```

### 3. Dockerイメージのビルド及びコンテナの起動

下記２つの方法があります。(`VSCode`推奨)  

**[`VSCode`の拡張機能(`Dev Container`)を用いた方法]**  

下記を実施することで、VSCodeのDev Containerを使用し環境構築を行うことができます

・`VSCode`でプロジェクトのルートディレクトリを開く  
  
・`Ctrl`と`Shift`を押しながら`P`を押してコマンドパレットを開く  

・コマンドパレットから`Reopen in Container(コンテナーで再度開く)`を選択する  

・コンテナ内の環境が開く

**[`Docker compose`を用いた方法]**  

```console
docker compose build dev
docker compose run dev
```

上記実行後に、別のウインドウ又はタブからコンテナに入ります  

```console
docker exec -it コンテナ名 /bin/bash
```
