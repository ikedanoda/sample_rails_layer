# sample_rails_layer
09/18勉強会用

formオブジェクトまわりはもうちょい調整入れてからgem化してして公開予定。

## 環境構築
docker環境のみ用意してます

```shell script
$ docker-compose up
$ docker-compose exec app bin/rake db:create
$ docker-compose exec app bin/rake db:migrate
$ docker-compose exec app bin/rails c 

# 以下rails c上
User.create!(email: 'hogehoge@example.com')
```

サンプルでは作成した `hogehoge@example.com` でメアド登録して認証URLを踏んだ後の

- プロフィール登録
- 住所登録

というシナリオを想定しています。
