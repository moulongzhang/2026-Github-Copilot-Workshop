# GitHub Copilot ワークショップ

このリポジトリは、GitHub Copilotのワークショップ用のCodelabsコンテンツを管理しています。

## 🌐 アクセス方法

ワークショップコンテンツは以下のURLからアクセスできます：

https://moulongzhang.github.io/2026-Github-Copilot-Workshop/github-copilot-workshop


## 📚 概要

GitHub Copilotの機能を学ぶためのハンズオンワークショップです。エージェントモードを使った新規アプリケーション開発など、実践的な内容を含んでいます。

## 🛠️ ワークショップコンテンツの編集方法

このワークショップは[Google Codelabs](https://github.com/googlecodelabs/tools)形式で作成されています。

### 必要なツール

- **Go** (1.24以降): claat の実行に必要です
- **claat** (Codelabs as a Thing): Markdownファイルから Codelabs 形式のHTMLを生成するツール（`go.mod` の `tool` ディレクティブでバージョン固定済み）

### claatの利用方法

```bash
go tool claat --help
```

## 📝 ワークショップの編集と生成

### 1. コンテンツの編集

`workshop.md` ファイルを編集します。Codelabs形式のMarkdownで記述してください。

ソースファイルは複数あります：

| ソース | 内容 | 出力 |
|--------|------|------|
| `workshop.md` | 標準版（Codespaces + Python/Flask） | `versions/v1.0.0`〜`v1.0.3` |
| `workshop-beginner.md` | 入門版（ローカル + GitHub Copilot app） | `versions/v1.0.4` |
| `workshop-<NAME>.md` | 顧客別カスタム版（nri / denso / bns） | `custom/<NAME>/` |

ファイルの先頭には以下のようなメタデータが必要です：

```markdown
author: Your Name
summary: GitHub Copilot ワークショップ
id: github-copilot-workshop
categories: AI, Development
environments: Web
status: Published
feedback link: https://example.com/feedback
```

> **注意**: `id` は必ず `github-copilot-workshop` にしてください。Makefile が claat の出力先ディレクトリ名（`id` に一致）を決め打ちで参照しています。

### 2. HTMLの生成

Makefile 経由で生成します：

```bash
# 最新バージョンを再生成
make export

# バージョンを指定
make export VERSION=v1.0.5

# ソースファイルを指定（既定は workshop.md）
make export VERSION=v1.0.4 SRC=workshop-beginner.md

# カスタム版
make export-custom NAME=nri
```

claat を直接使うこともできます：

```bash
# 基本的な生成
go tool claat export workshop.md

# 出力ディレクトリを指定して生成
go tool claat export -o github-copilot-workshop workshop.md
```

生成されたHTMLは `github-copilot-workshop/` ディレクトリに出力されます。

### 3. プレビュー

生成されたコンテンツをローカルでプレビューできます：

```bash
go tool claat serve
```

ブラウザで `http://localhost:9090` を開くと、生成されたワークショップを確認できます。

### 4. よく使うコマンド

```bash
# ヘルプを表示
go tool claat help

# 特定のフォーマットで生成
go tool claat export -f html workshop.md

# 既存のコンテンツを更新
go tool claat update workshop.md

# 複数のファイルを一括生成
go tool claat export *.md
```

## 📂 ディレクトリ構造

```
.
├── README.md                    # このファイル
├── Makefile                     # エクスポート用タスク
├── workshop.md                  # 標準版のソースファイル
├── workshop-beginner.md         # 入門版（Copilot app）のソースファイル
├── workshop-nri.md              # カスタム版のソースファイル
├── github-copilot-workshop/     # 生成されたCodelabsコンテンツ
│   ├── index.html               # バージョンセレクタ（編集禁止）
│   ├── versions.json            # バージョン定義
│   ├── versions/<VERSION>/      # バージョン別の生成物（直接編集禁止）
│   ├── custom/<NAME>/           # カスタム版の生成物（直接編集禁止）
│   └── img/                     # 画像ファイル（全バージョン共有）
├── assets/                      # その他のアセット
└── registrations/               # 登録情報
```

## 🔀 バージョンについて

`versions/` には 2 つの異なるトラックが含まれます。

| バージョン | ソース | 内容 |
|-----------|--------|------|
| v1.0.0 〜 v1.0.3 | `workshop.md` | Codespaces + Python/Flask でポモドーロタイマーを作成 |
| v1.0.4 (beginner) | `workshop-beginner.md` | ローカル環境 + GitHub Copilot app で Tailspin Toys (Astro) を開発 |

v1.0.4 は v1.0.3 の新しいスナップショットではなく **別トラックの教材** です。そのため `defaultVersion` は `v1.0.3` のまま据え置いています。入門版へは `?version=v1.0.4` を付けたURLで誘導してください。

https://moulongzhang.github.io/2026-Github-Copilot-Workshop/github-copilot-workshop/?version=v1.0.4

v1.0.4 は [github-samples/copilot-workshops](https://github.com/github-samples/copilot-workshops)（MIT License）の日本語版コンテンツをベースにしています。

## 🚀 デプロイ

生成された `github-copilot-workshop/` ディレクトリの内容を、GitHub Pages や任意のWebサーバーにデプロイできます。

### GitHub Pagesへのデプロイ例

```bash
# github-copilot-workshop/ ディレクトリの内容をgh-pagesブランチにプッシュ
git subtree push --prefix github-copilot-workshop origin gh-pages
```

## 📖 参考リンク

- [Google Codelabs Tools](https://github.com/googlecodelabs/tools)
- [Codelabs Formatting Guide](https://github.com/googlecodelabs/tools/blob/main/FORMAT-GUIDE.md)
- [GitHub Copilot Documentation](https://docs.github.com/ja/copilot)

## 📄 ライセンス

このワークショップコンテンツのライセンスについては、リポジトリのLICENSEファイルを参照してください。

サードパーティ由来のコンテンツ（v1.0.4 beginner 版）のライセンス表記は [THIRD-PARTY-NOTICES.md](THIRD-PARTY-NOTICES.md) を参照してください。

## 🤝 コントリビューション

ワークショップの改善提案や修正は、Issueやプルリクエストで受け付けています。
