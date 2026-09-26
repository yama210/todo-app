# todo

Rails 8.1 / Ruby 4.0.7 / MySQL 8.4 の開発用 Docker Compose 構成です。
VS Code と Codex はホスト側で使い、Rails と MySQL をコンテナで動かします。

## 起動

Docker Desktop を起動して、プロジェクトのディレクトリで実行します。

```sh
docker compose up --build -d
```

http://localhost:3000 を開きます。初回はイメージの取得・ビルドと gem の導入に時間がかかります。
MySQL の準備完了後に Rails が DB を準備して起動します。

```sh
# 起動状況とログ
docker compose ps
docker compose logs -f web

# 通常の起動（ビルド不要）
docker compose up -d

# 停止（DB と gem は保持）
docker compose down
```

## Rails コマンド

```sh
docker compose exec web bin/rails console
docker compose exec web bin/rails generate model Task title:string completed:boolean
docker compose exec web bin/rails db:migrate
docker compose exec web bin/rails test
```

Gemfile を変更した場合は `docker compose restart web` で不足する gem を導入します。
OS パッケージや Ruby の変更時は `docker compose up --build -d` を実行します。

## MySQL と保存先

- 接続先: `db:3306`（Compose 内部のみ。ホスト側には公開しません）
- 開発 DB: `todo_development`、テスト DB: `todo_test`
- 開発専用ユーザー: `todo`、パスワード: `todo_dev_password`
- 開発専用 root パスワード: `root_dev_password`
- DB は `mysql_data`、gem は `bundle`、Rails の一時キャッシュは `rails_tmp` ボリュームに保存します。
- ソースコードはホストと共有され、編集が反映されます。

`docker compose down -v` は DB を含むボリュームを削除するため、データを残す場合は使わないでください。
`docker/mysql/init.sql` は空の DB ボリュームを初期化するときに実行されます。
既存の SQLite ファイルからのデータ移行は行いません。

## 本番環境

`compose.yaml` と `Dockerfile.dev` はローカル開発用です。
ルートの `Dockerfile` は本番用です。MySQL の接続情報は `DB_HOST`、`DB_PORT`、
`DB_USERNAME`、`DB_PASSWORD` で指定し、開発用パスワードは使用しないでください。
本番では primary / cache / queue / cable の各 DB とアクセス権を別途用意します。
