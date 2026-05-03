# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## このアプリについて

[Railsのロール管理パターン](https://techracho.bpsinc.jp/hachi8833/2026_04_23/157554)の記事を元にしたサンプルアプリ。
`User` / `Role` / `UserRole` の3モデルで、グローバル・クラス・インスタンスの3レベルのロール管理を実装する。

## 技術スタック

- Ruby 4.0.3 / Rails 8.1
- SQLite3（開発・テスト）
- Hotwire（Turbo + Stimulus）、Propshaft、importmap-rails
- Solid Queue（バックグラウンドジョブ）、Solid Cache、Solid Cable

## よく使うコマンド

```bash
bin/dev                          # 開発サーバー起動
bin/rails console                # コンソール
bin/rails test                   # テスト全件
bin/rails test test/models/user_test.rb  # 単一ファイルのテスト
bin/rails test test/models/user_test.rb:12  # 単一テストケース
bin/rubocop                      # Lintチェック
bin/rubocop -a                   # 自動修正
bin/ci                           # CI全工程（setup/lint/audit/test）
bin/rails db:migrate             # マイグレーション
bin/rails db:seed                # シードデータ投入
```

## ロール設計

```
Role#resource_type / resource_id の組み合わせでレベルを区別:
  グローバル    : resource_type = nil,        resource_id = nil
  クラスレベル  : resource_type = "Campaign",  resource_id = nil
  インスタンス  : resource_type = "Customer",  resource_id = 1
```

`User` モデルに `developer?` / `admin?` / `manager_of?(resource)` などの述語メソッドを実装し、ポリシー層から呼び出す設計。

## コーディング規約

- rubocop-rails-omakase を使用（`.rubocop.yml` 参照）
- Railsの慣習を優先し、gem に頼る前に vanilla Rails で実装を試みる
- Controller は薄く、ロジックはモデル / concern / PORO に寄せる
