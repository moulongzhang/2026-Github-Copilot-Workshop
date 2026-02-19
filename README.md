# GitHub Copilot ワークショップ

このリポジトリは、GitHub Copilotのワークショップ用のCodelabsコンテンツを管理しています。

## 🌐 アクセス方法

ワークショップコンテンツは以下のURLからアクセスできます：

https://moulongzhang.github.io/2025-Github-Copilot-Workshop/github-copilot-workshop


## 📚 概要

GitHub Copilotの機能を学ぶためのハンズオンワークショップです。エージェントモードを使った新規アプリケーション開発など、実践的な内容を含んでいます。

## 🛠️ ワークショップコンテンツの編集方法

このワークショップは[Google Codelabs](https://github.com/googlecodelabs/tools)形式で作成されています。

### 必要なツール

- **claat** (Codelabs as a Thing): Markdownファイルから Codelabs 形式のHTMLを生成するツール

### clatのインストール

#### macOSの場合

**方法: Homebrewを使用（推奨）**

```bash
brew install claat
```

### インストールの確認

```bash
claat version
```

## 📝 ワークショップの編集と生成

### 1. コンテンツの編集

`workshop.md` ファイルを編集します。Codelabs形式のMarkdownで記述してください。

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

### 2. HTMLの生成

Markdownファイルから Codelabs 形式のHTMLを生成します：

```bash
# 基本的な生成
claat export workshop.md

# 出力ディレクトリを指定して生成
claat export -o github-copilot-workshop workshop.md
```

生成されたHTMLは `github-copilot-workshop/` ディレクトリに出力されます。

### 3. プレビュー

生成されたコンテンツをローカルでプレビューできます：

```bash
claat serve
```

ブラウザで `http://localhost:9090` を開くと、生成されたワークショップを確認できます。

### 4. よく使うコマンド

```bash
# ヘルプを表示
claat help

# 特定のフォーマットで生成
claat export -f html workshop.md

# 既存のコンテンツを更新
claat update workshop.md

# 複数のファイルを一括生成
claat export *.md
```

## 📂 ディレクトリ構造

```
.
├── README.md                    # このファイル
├── workshop.md                  # ワークショップのソースファイル
├── github-copilot-workshop/     # 生成されたCodelabsコンテンツ
│   ├── index.html
│   ├── codelab.json
│   └── img/                     # 画像ファイル
├── assets/                      # その他のアセット
└── registrations/               # 登録情報
```

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

## 🤝 コントリビューション

ワークショップの改善提案や修正は、Issueやプルリクエストで受け付けています。
