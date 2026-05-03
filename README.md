# role_sample

[Railsのロール管理パターン](https://techracho.bpsinc.jp/hachi8833/2026_04_23/157554)の記事を元にしたサンプルアプリ。

gem に頼らず vanilla Rails で、グローバル・クラス・インスタンスの3レベルのロール管理を実装する。

## ロール設計

`Role` レコードの `name` / `resource_type` / `resource_id` の組み合わせで権限のスコープを表現する。

| name | resource_type | resource_id | 意味 |
|---|---|---|---|
| developer | NULL | NULL | アプリ全体の developer |
| admin | NULL | NULL | アプリ全体の admin |
| manager | Campaign | NULL | 全 Campaign を管理できる |
| manager | Customer | 1 | Customer id=1 を管理できる |
| member | Customer | 1 | Customer id=1 のメンバー |

## セットアップ

```bash
bin/setup
bin/rails db:seed
bin/dev
```

## 動作確認

```bash
bin/rails console
```

```ruby
alice = User.find(1)
alice.developer?          # => true
alice.admin?              # => true
alice.campaign_manager?   # => true

bob = User.find(2)
bob.member_of?(Customer.find(1))  # => true
bob.manager_of?(Customer.find(1)) # => false
```

## 開発

```bash
bin/rails test   # テスト実行
bin/rubocop      # Lint
bin/ci           # CI全工程
```

## 技術スタック

- Ruby 4.0.2 / Rails 8.1
- SQLite3
- Hotwire（Turbo + Stimulus）
- Solid Queue / Solid Cache / Solid Cable
