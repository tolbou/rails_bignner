## プロジェクトのセットアップ手順

### Dockerを使った環境準備(イメージのビルド)

```
docker compose build
```

### railsサーバーの起動(バックグラウンドでのコンテナの立ち上げとrailsサーバーの起動)

```
docker compose up
*docker compose upを実行しているターミナルとは別に新しくターミナルを立ち上げてください。新しいターミナルにて以下のコマンドを実行してください。
```

### コンテナ内に入る(rails・bundler・yarn関係のコマンドはコンテナ内で実行します)

```
docker compose exec web bash
```

### Gemのインストール(コンテナ内で実行してください)

```bash
bundle install
```

### node_modulesのインストール(コンテナ内で実行してください)

```bash
yarn install
```

### データベースの作成(コンテナ内で実行してください)

```bash
bin/rails db:create
```

### CSS, JS用のサーバー起動(コンテナ内で実行してください・ターミナルで複数のタブを開くとやりやすいでしょう)

```
bin/dev
```
