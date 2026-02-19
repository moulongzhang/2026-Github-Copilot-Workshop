author: Your Name
summary: GitHub Copilot ワークショップ
id: github-copilot-workshop
categories: AI, Development
environments: Web
status: Published
feedback link: https://example.com/feedback

# GitHub Copilot ワークショップ

## ワークショップについて
Duration: 5

GitHub Copilotワークショップへようこそ！このワークショップでは、GitHub Copilot を使ってコードの解説や改善を行う方法を学びます。
GitHub Copilot Chat は Chat 体験を通じて AI との対話を行うことができます。 ぜひ、このワークショップを通じて GitHub Copilot の使い方を学んでみましょう。

![GitHub Copilot Logo](github-copilot-workshop/img/octocat_copilot.png)

### 本日のゴール
- GitHub Copilotの各種機能を理解する
- エージェントモードを使って、新規にアプリケーションを開発する

### 前提条件
- Visual Studio Code がインストールされていること
- GitHub Copilotのライセンスがあること
- GitHubアカウントを持っていること

## プロジェクトのセットアップ
Duration: 15

このワークショップでは、以下のGitHubリポジトリを使用します：

**プロジェクトURL**: https://github.com/moulongzhang/2025-Github-Copilot-Workshop-Python

### ステップ1: リポジトリをフォークする

まず、上記のプロジェクトURLをブラウザで開き、リポジトリをフォークします：

1. プロジェクトURL（https://github.com/moulongzhang/2025-Github-Copilot-Workshop-Python）をブラウザで開く
2. 右上の **Fork** ボタンをクリック

![Fork ボタンをクリック](github-copilot-workshop/img/fork-step1.png)

3. フォーク作成画面で **Create fork** ボタンをクリック

![Create fork ボタンをクリック](github-copilot-workshop/img/fork-step2.png)

フォークが完成すると、あなたのGitHubアカウントにリポジトリのコピーが作成されます。

### ステップ2: 開発環境のセットアップ

フォークしたリポジトリを使って、GitHub Codespacesで開発環境を準備します：

1. フォークしたリポジトリのページで（`https://github.com/[あなたのユーザー名]/2025-Github-Copilot-Workshop-Python`）
2. 緑色の **Code** ボタンをクリック
3. **Codespaces** タブを選択
4. **Create codespace on main** をクリック

![Codespaces Setup](github-copilot-workshop/img/github-codespaces.png)

> aside positive
>
> **ヒント**: Codespacesを使用すると、ブラウザ上でVS Codeと同じ環境が立ち上がり、すぐに開発を始められます。このプロジェクトには `.devcontainer/devcontainer.json` ファイルが含まれており、Codespaces起動時に以下が自動的に設定されます：
> - **Python 3.11 環境**: 開発に必要なPython環境
> - **GitHub Copilot 拡張機能**: AIによるコード補完とチャット機能
> - **CodeTour 拡張機能**: プロジェクトのガイドツアー機能

## コード補完を使ってみる
Duration: 20

### 設定確認

VS Codeでサインインが完了していることを確認してください。

### 1. コード補完でFibonacci関数を作成

新しいPythonファイルを作成して、以下のコメントを入力してみましょう：

```python
# Fibonacci数列を計算する関数
def fibonacci(n):
```

Copilotが自動的にコードを提案してくれることを確認してください。

> aside positive
>
> **ヒント**: `Tab`キーで提案を受け入れ、`Alt+]`で次の提案を見ることができます。

### 2. Next Edit Suggestionsで座標関数を2次元から3次元に拡張

プロジェクトに含まれている `point.py` ファイルを開いてください。このファイルには、二次元空間の点を表すクラスが含まれています：

```python
import math

class Point2D:
    def __init__(self, x, y):
        self.x = x
        self.y = y
    
    def distance_to(self, other):
        dx = self.x - other.x
        dy = self.y - other.y
        return math.sqrt(dx * dx + dy * dy)
    
    def __str__(self):
        return f"Point2D({self.x}, {self.y})"
```

今、このクラスを三次元空間の点を表すクラスに拡張したいと考えています。

**ステップ1**: クラス名を手動で `Point2D` から `Point3D` に変更してみましょう。

**ステップ2**: 少し待つと、GitHub Copilotが次の編集候補を提案してくれます。

> aside positive
>
> **重要**: Next Edit Suggestionの提案が表示されるまでに、少し時間がかかることがあります。焦らず待ってみてください。

#### 期待される最終結果

Point2DクラスをPoint3Dに拡張する作業を続けると、以下のようなコードになるはずです：

```python
import math

class Point3D:
    def __init__(self, x, y, z):
        self.x = x
        self.y = y
        self.z = z
    
    def distance_to(self, other):
        dx = self.x - other.x
        dy = self.y - other.y
        dz = self.z - other.z
        return math.sqrt(dx * dx + dy * dy + dz * dz)
    
    def __str__(self):
        return f"Point3D({self.x}, {self.y}, {self.z})"
```

> aside positive
>
> **ヒント：Next Edit Suggestが機能しない場合は**
> 
> メニューから
> - **Windows/Linux**: `File` → `Preferences` → `Settings`
> - **macOS**: `Code` → `Settings...` → `Settings`
> 
> 以下の設定を検索し、有効化してください。
> ```
> github.copilot.nextEditSuggestions.enabled
> ```

## コードを解説してもらう
Duration: 15

プロジェクトに含まれている `delivery_manager.py` ファイルを開いてください。

### Copilot Chat を開く

1. VS Codeのサイドバーで **Chat** アイコン（チャットバブルのアイコン）をクリックして、Copilot Chat を開きます
2. または `Ctrl+Alt+I` (macOSでは `Ctrl+Cmd+I`) でChatパネルを開く

### チャットモードの確認

チャットのモードが「質問」になっていることを確認します（「エージェント」モードは後ほど紹介します）。

### ファイルの解説を依頼

1. チャット欄に `#delivery_manager.py` と入力します
2. 「このファイル全体について説明してください」とプロンプトを入力します。
3. Enterを押すと、Copilot Chat が `delivery_manager.py` ファイル全体を解説してくれます

> aside positive
>
> **ヒント**: ファイル名の前に `#` を付けることで、そのファイル全体をコンテキストとして含めることができます。

## コードの改善箇所を尋ねる
Duration: 15

### エクササイズ

Copilot Chat にこのコードの悪い部分を尋ねてみましょう。

### 1. クラス全体の問題を聞く

まずは、クラス全体としてこのコードはどのような問題を抱えているか聞いてみましょう。

Copilot Chatに以下のように質問してみてください：

```
このDeliveryManagerクラス全体を見て、どのような問題や改善点がありますか？設計パターン、コードの品質、保守性の観点から教えてください。
```

### 2. 具体的なメソッドに絞って改善点を聞く

その後、`deliver_recipe()` メソッドに絞って、このメソッドを改善するためにはどのような方法があるか聞いてみましょう。

#### 手順：
1. チャット欄に `#deliver_recipe` と入力します
2. コードの要素（関数、クラス、変数など）の候補が表示されます
3. `deliver_recipe` メソッドを選択します
4. 以下の質問を入力してください：

```
このdeliver_recipeメソッドを改善するためにはどのような方法がありますか？可読性、パフォーマンス、エラーハンドリングの観点から提案してください。
```

> aside positive
>
> **ヒント**: `#` を使うことで、特定のコードの要素に対してピンポイントで質問することができます。これにより、より具体的で有用な改善提案を得ることができます。

### コードレビュー機能

現在のコードを改善するために、Copilot Chatに以下のように質問してみましょう：

```
このPythonコードを改善してください。パフォーマンス、可読性、エラーハンドリングの観点から提案をお願いします。
```

### セキュリティの観点から確認

```
このコードにセキュリティ上の問題はありますか？
```

### ベストプラクティスの確認

```
Pythonのベストプラクティスに従っているか確認してください。
```

## エージェントモードを使ってみよう
Duration: 10

ここまでは「質問」モードでCopilot Chatを使ってきましたが、次は「エージェント」モードを使ってみましょう。エージェントは、ユーザーの意図を理解し、より自律的にタスクを実行することができます。実例を通して、エージェントがどのように機能するかを学びます。

### エージェントモードへの切り替え

まず `delivery_manager.py` ファイルを開いている状態で、Copilot Chatのモード選択から「エージェント」を選択します。

<div align="center">
  <img src="github-copilot-workshop/img/agent_mode2.png" alt="エージェントモード選択2" width="600" />
  
  <div style="height: 24;"></div>
  
  <img src="github-copilot-workshop/img/agent_mode.png" alt="エージェントモード選択" width="600" />
</div>

### 問題点の洗い出し

その後、以下のプロンプトを入力してみましょう。

```
DeliveryManagerクラスに存在する問題点を列挙してください。そして、それぞれの問題点を解決するための改善案を提示してください。
```

![GPT-4.1による問題点分析](github-copilot-workshop/img/agent_GPT4.1.png)

すると、複数の改善点を提案してくれるはずです。

### モデルを変えて試してみてください

同じ質問を異なるモデルで試すことで、各モデルの特徴を比較できます。

![Claude 4.0による問題点分析](github-copilot-workshop/img/agent_Calude4.0.png)

### 改善案の実装

では、実際に提案してもらった改善案を実装してもらいましょう。

```
提示してくれたすべての改善案を実装してください。
```

すると、Copilotはエディタで開かれているコードに対して直接コードの変更を行います。しかし、これはまだ提案の段階であり、この変更を受け入れるかどうかはユーザーが決定します。受け入れるかどうかは、チャット欄の上にある「保持」もしくは「元に戻す」ボタンをクリックすることで行います。

### エージェントの自律性

ここで、エージェントが返してくれたコメントを確認してみましょう。エージェントは単に指示に従ってコードを変更しただけでなく、コードを変更後にエラーが発生していることを確認し、そのエラーも修正しようとする場合があります。適切な環境下では、エージェントはコードの変更後に発生したエラーを自動的に検出し、修正を試みます。このように、エージェントはユーザーの意図を理解し、より自律的にタスクを実行することができます。

### コマンド実行の確認

エージェントモードを使っていると、Copilotがコマンドを実行して良いかどうかを尋ねてくることがあります。これは、Copilotが何かのコマンドを実行する前に、必ずユーザーに確認を求めるためです。コマンドの内容を確認し、実行しても問題ない場合は「Allow this time」をクリックします。これにより、Copilotはそのコマンドを実行し、必要な変更を行います。

> aside positive
>
> **重要**: エージェントモードでは、Copilotがより自律的に動作するため、提案される変更内容をよく確認してから受け入れるようにしましょう。

## カスタムエージェントを使ってみよう（オプション）
Duration: 15

**カスタムエージェント**は、**Copilot コーディングエージェント**の特殊なバージョンであり、独自のワークフロー、コーディング規則、ユースケースに合わせて調整できます。

### BeastModeへの切り替え

Copilot Chatのモード選択から「**beastmode3.1**」を選択します。

### BeastModeを体験してみよう

以下のプロンプトを入力して、エージェントの挙動の違いを確認してください：

```
このコードをプロダクション品質にアップグレードしてください。
以下を全て実行してください：

- セキュリティ脆弱性（SQLインジェクションなど）を調査して修正
- 最新のPythonベストプラクティスを調べて適用
- 型安全性を強化（typing、Protocol、TypedDictなど）
- テスタビリティを改善（依存性注入、モック可能な設計）
- パフォーマンスの問題を特定して最適化
- 包括的なユニットテストを作成
- 全てのテストが通ることを確認

完了するまで自律的に作業を続けてください。
```

> aside positive
>
> **重要**: このプロジェクトには `.github/agents/beastmode3.1.agent.md` というファイルが含まれており、BeastModeの動作を定義しています。

### BeastModeとは？

BeastModeは、オープンナレッジとしてコミュニティ駆動で発展している取り組みです。以下のような課題を解決します：

| 課題 | Beast Modeの特徴 |
|------|------------------|
| 途切れる | ✅ **完全自律実行** - タスク完了まで止まらない |
| 知識が古い | ✅ **強制的なWeb調査** - 最新情報を必ず検索 |
| 中途半端 | ✅ **徹底した品質基準** - テスト通過まで継続 |

### VS Code設定での有効化

BeastModeの考えはすでにGitHub Copilotの実装にも取り込まれており、VS Codeの設定でも利用できます：

1. VS Codeの設定を開く
2. 以下の設定を有効化：
   ```
   github.copilot.chat.alternategptprompt.enable
   ```

これにより、標準のCopilotエージェントでもBeastModeと同様の自律的な動作が可能になります。

> aside positive
>
> **重要**: BeastModeは Sonnet4.5やGemini 3 Proのような大きなモデルで既に実行してくれている挙動の定義が多いです。そのため、規定のPremium Request数を全て消費した後のGPT-4.1やGPT-5miniなどのモデルでのBeastMode利用が有効になるのではないかと思います。
>
> **参考リソース**:
> GitHubが公開しているPromptやAgentのサンプルがまとまっているリポジトリがあります：
> ユースケース別、言語別などさまざまなサンプルがあるので、ぜひご参照ください。
> 
> [GitHub Awesome Copilot](https://github.com/github/awesome-copilot)

## 次のタスクに向けた設定（オプション）
Duration: 20

このセクションは **オプション** です。GitHub Copilotの基本機能を学んだ後で、より高度な機能を試したい場合に実施してください。

### 1. ブランチの準備

#### ステップ1: ステージングされた変更をリセット

現在ステージングエリアにある変更を全てワーキングディレクトリに戻します：

```bash
git restore .
```

#### ステップ2: 新しいブランチを作成

feature/pomodoroブランチを作成して切り替えます：

```bash
git checkout -b feature/pomodoro
```

### 2. GitHub Advanced Security (GHAS) の設定

GitHub Advanced Security の Code Scanning 機能を有効にすることで、コードの脆弱性を自動的に検出できます。

1. フォークしたリポジトリの **Settings** タブをクリック
2. 左サイドバーから **Security** → **Code security** を選択
3. **Code scanning** セクションで **Set up** をクリック

![GHAS Code Scanning Setup](github-copilot-workshop/img/code-scanning-setup.png)

4. **Default** を選択（推奨）

![GHAS Default Configuration](github-copilot-workshop/img/code-scanning-default.png)

5. **Enable CodeQL** をクリック

これにより、プッシュ時やプルリクエスト作成時にコードの自動スキャンが実行されます。

### 3. Copilot 機能の確認

GitHubで利用可能なCopilot機能を確認しましょう。

1. GitHubの右上のプロフィールアイコンをクリック
2. **Your Copilot** を選択

![Your Copilot Menu](github-copilot-workshop/img/your-copilot-menu.png)

以下の機能が有効になっていることを確認してください：

- **Copilot in GitHub.com** - GitHubのWebサイト上でCopilotを使用
- **Copilot coding agent** - より高度なコーディング支援
- **MCP servers in Copilot** - Model Context Protocol サーバーの利用

> aside negative
>
> **プラン制限**: Copilot Code ReviewやCoding Agentなどの高度な機能は、GitHub Copilot Business/Enterprise プランでのみ利用可能です。Freeプランをご利用の場合、これらの機能は利用できません。

### 4. GitHub MCP Server のセットアップ

Model Context Protocol (MCP) サーバーを使用することで、Copilotの機能を拡張できます。

#### ステップ1: MCP サーバーの追加

1. VS Code でコマンドパレットを開く: `Ctrl+Shift+P` (Windows/Linux) / `Cmd+Shift+P` (Mac)
2. `mcp: add server` と入力して選択

![MCP Add Server](github-copilot-workshop/img/mcp-add-server.png)

3. **HTTP** を選択
4. サーバーURL: `https://api.githubcopilot.com/mcp/` を入力
5. Server ID の入力欄で `github-mcp-server` と入力（または Enter でスキップ）
6. 保存先は **このワークスペースに保存** を選択
7. GitHub アカウントで認証を行う

#### ステップ2: MCP サーバーの起動確認

`.vscode/mcp.json` にMCPサーバーの設定が保存されます。

![MCP JSON Config](github-copilot-workshop/img/mcp-json-config.png)

#### ステップ3: ツールの有効化

1. Copilot Chat でツールボタンをクリック

![MCP Tools Button](github-copilot-workshop/img/mcp-tools-button.png)

2. GitHub MCP サーバーがリストに表示されることを確認
3. チェックボックスにチェックを入れて有効化

![MCP Enable Tools](github-copilot-workshop/img/mcp-enable-tools.png)

これで、GitHub の情報を直接 Copilot Chat で参照できるようになります。

> aside positive
>
> **ヒント**: MCP サーバーを使用すると、Copilot がリポジトリの情報、Issues、Pull Requests などに直接アクセスして、より詳細な回答や提案を行うことができます。

## ポモドーロタイマーを作ってみよう
Duration: 30

ここまでで、VS Code上で利用できるGitHub Copilotの基本的な使い方を学びました。次は、実際にアプリケーションを開発してみましょう。

今回のハンズオンでは、ポモドーロタイマーアプリケーションを開発します。このアプリケーションは、作業時間と休憩時間を設定し、タイマーを管理する機能を持っています。

以下のようなUIを持つアプリケーションを作成することを目指します。

![ポモドーロタイマーUI](github-copilot-workshop/img/pomodoro.png)

では、まずVS Code上で、新しいPythonファイルを作成しましょう。今回はWebアプリケーションとして作成したいので、Flaskを使用します。メインファイル名は「app.py」としましょう。

### プロジェクトの概要

ポモドーロテクニック用のWebタイマーアプリケーションを作成します。

### 必要な機能
- 25分の作業タイマー
- 5分の休憩タイマー
- タイマーの開始・停止・リセット
- 進捗表示と統計機能
- ブラウザ通知とサウンド通知
- レスポンシブなWebUI

## ポモドーロタイマーの設計を考える
Duration: 10

まず、いきなり実装を始めるのではなく、どういった方針・設計で進めるかをCopilotに相談してみましょう。ここから先は、すべてエージェントモードで進めていきます。

今回のようにUIを持ったWebアプリケーションを作成するにあたって役に立つのが、Copilot Chatに画像をアップロードする機能です。これを使うことで、アプリケーションのUIイメージをCopilotに理解させることができます。

前ページのUIイメージをまずはプロジェクトのルートに `pomodoro.png` として保存してください。その後、チャット欄の `Add Context` をクリックし、「Image from Clipboard」または「Files & Folders...」を選択します。そして、UIイメージの画像を選択します。

![VS Code Copilot Chat Context Menu](github-copilot-workshop/img/add_context2.png)

![VS Code Copilot Chat Context Menu](github-copilot-workshop/img/add_context3.png)

画像のアップロードができたら、Copilot Chatに画像が表示されます。

その上で、次のプロンプトを入力してみましょう。

```
このプロジェクトでポモドーロタイマーのWebアプリを作成する予定です。添付の画像はそのアプリのUIモックです。FlaskとHTML/CSS/JavaScriptを使用してこのアプリを作成するにあたって、どのような設計で進めるべきか、アーキテクチャの提案をしてください。
```

すると、推奨のWebアプリケーションアーキテクチャを提案してくれます。

このアーキテクチャに対して、もっとこうした方が良いという点や考慮不足の点があれば、それを指摘してみましょう。例えば次のような指摘です。

```
ユニットテストのしやすさという点を考慮して、今のアーキテクチャにもし改善や追加が必要な点があればそれも書き出してください。
```

このやり取りを経て、アーキテクチャの設計が固まったら、一度その内容をファイルに保存してもらいましょう。そうすることで、別のチャットセッションを開いても、同じアーキテクチャの内容を参照することができます。

```
ここまでの会話でアーキテクチャについては固まったので、これまでの会話の内容を踏まえて、プロジェクトのルートにarchitecture.mdというファイルに、Webアプリケーションアーキテクチャ案をまとめてください。
```

> aside positive
>
> Copilot Chatでのやりとりに一区切りがついたら、新しい会話を始めることで、よりCopilotに対して明確な指示を与えることができます。新しい会話を始めるには、チャットウィンドウの上部にある「新しい会話」ボタンをクリックします。その際、今回のアーキテクチャの内容のように、今後のチャットでも参照したい内容は、今回のようにファイルに書き出して保存しておくと便利です。



## やることを洗い出そう
Duration: 10

ここまでで、UIモックとアーキテクチャの設計が固まりました。具体的にどのような機能を実装する必要があるかを検討していきましょう。これもCopilot Chatに相談してみます。その際、pomodoro.pngとarchitecture.mdを添付しましょう。

```
このポモドーロタイマーアプリケーションを作成するにあたって、実装する必要のある機能を洗い出してください。
```

<img src="github-copilot-workshop/img/pomodoro.png" alt="機能一覧の検討" width="400" />

![機能洗い出しの例](github-copilot-workshop/img/10-2.list_features.png)

この内容もCopilotとのチャットを通して、改善していきましょう。内容が固まったら、アーキテクチャの時と同様にこの内容もfeatures.mdというファイルにまとめて保存しておきましょう。

```
ありがとうございます。その内容で良さそうなので、実装する必要のある機能一覧をfeatures.mdというファイルに書いてください。
```

では、ここから実装を始めるわけですが、Copilotを使いこなすコツとしては、一度に大きな機能を実装しようとするのではなく、まずは小さな機能から実装していくことです。これにより、Copilotが提案するコードの精度が上がり、よりスムーズに開発を進めることができます。

今回のアプリケーション開発を、どのような粒度で細分化して実装していくかについても、Copilotに相談してみましょう。ここでは、pomodoro.png、architecture.md、features.mdを添付しましょう。

```
このポモドーロタイマーアプリケーションを段階的に実装していきたいと考えています。添付の画像とアーキテクチャ、機能一覧を踏まえて、どのような粒度で機能を実装していくべきか、段階的な実装計画を提案してください。
```

私が試したところ、6つのステップからなる計画を提案してくれました。この点についても、もっとこうしてほしいなどがあれば、Copilotに指摘してみましょう。そして、この内容も後で参照できるように、plan.mdというファイルにまとめて保存しておきましょう。その際、どういうプロンプトで指示するべきかは、みなさん自身で考えてみてください。

## 実装しよう
Duration: 30

ここまでの準備が整ったので、いよいよ実装に取り掛かりましょう。前のステップで提案された実装計画に従って、段階的に機能を実装していきます。

### プロジェクト構成の準備

まずは、今回のアーキテクチャに従ったプロジェクトのディレクトリ構成を作成しましょう。

まずは、`architecture.md` のようなアーキテクチャを実現するにあたって、現在のプロジェクトのフォルダ構成を修正してください。必要に応じてファイルの移動や、設定ファイルの変更も行ってください。

その後、`pomodoro.png`, `architecture.md`, `plan.md` を添付した上で、次のようにCopilotに指示を出してみましょう。

```
plan.mdのステップ１を実装してください。その際、すでにこのプロジェクトにあるファイルを別のディレクトリに移動する必要があれば、その作業も実行してください。もし追加で考慮が必要なことがあれば、私に質問してください。
```

すると、私のケースでは以下のように検討が必要な質問をしてきました。こういった場合には、必要な情報を提供しましょう。

![Copilotからの質問例](github-copilot-workshop/img/12-0.question_from_copilot.png)

その後、Copilotは、ステップ1の実装を行います。実装が完了したら、Copilotは自らの判断でプロジェクトのビルドを行い、エラーがないかを確認します。エラーが発生した場合は、そのエラーを解決するために追加で修正を行います。このような自律的な動作が、エージェントモードの特徴です。

実装が完了したら、以下の点を確認してみましょう：

1. **ディレクトリ構造**：推奨されたアーキテクチャに沿った構成になっているか
2. **基本ファイル**：必要な基本ファイル（app.py、HTML テンプレート、CSS ファイルなど）が作成されているか
3. **動作確認**：簡単な動作テストを行って、エラーが発生していないか


以下が、私の場合のステップ1の実装結果です。この段階でどのようなアプリケーションになっているかは人によって異なるでしょう。


![ステップ1実装結果例](github-copilot-workshop/img/12-1.completed_timer.png)




## テストを書こう
Duration: 20

このまま実装を続ける前に、実装した機能に対してユニットテストを書いておきましょう。ユニットテストを書くことで、後のステップでの変更が既存の機能に影響を与えないことを確認できます。

もし前ページの段階でユニットテストも実装されている場合は、このページは読み飛ばしてください。

### テストの実装

次のようなプロンプトを実行してみましょう。

```
現在の実装に対して、ユニットテストが全くないので、ユニットテストを実装してください。
```

すると、Copilotエージェントはユニットテスト用の依存関係をインストールするために、コマンドを使って良いかどうかを尋ねてきます。このように、エージェントが何かのコマンドを実行する前には、必ずユーザーに確認を求めます。ここでは、必要なコマンドを実行することを許可するために、「Continue」をクリックします。

![Copilotによるテスト実装確認](github-copilot-workshop/img/13-0.test_for_step1.png)

すると、CopilotはVS Code内のターミナル内で、先ほどのコマンドを実行し、必要な依存関係をインストールします。それ以降も同様に、Copilotが何かのコマンドを実行する前には、必ずユーザーに確認を求めます。もし、そのコマンドを実行してエラーが発生した場合は、そのエラーを解決するために、エージェントは追加の修正を行います。


## 残りの機能を実装しよう（オプション）
Duration: 20

このセクションは **オプション** です。基本的なCopilot機能を学習済みの方で、より高度な実装に挑戦したい場合に実施してください。

ここからは、自由課題として、残りの機能を段階的に実装していきましょう。

いくつか役に立つであろうポイントをここでは紹介します。

### UIに対して指示をしたい場合

UI上の特定の要素に対して指示を出したい場合は、UIのスクリーンショットをCopilotにアップロードすることで、その要素を認識させることができます。その際、スクリーンショットの上に特に指摘したい箇所を丸で囲むなり、矢印を引くなりして、どの要素に対して指示を出したいのかを明確にすると良いでしょう。

または、現状のスクリーンショットと、期待するスクリーンショットを2枚アップロードすることで、その差分を確認してもらい、期待するUIにできるだけ近づくように指示を出すこともできます。

### 毎回同じような指示を出している場合

プロンプトを書いたり、文脈を指定する際に、頻繁に同じような指示を出している場合は、Copilotにその指示を覚えさせることができます。具体的には、プロジェクト内に `.github/copilot-instructions.md` というファイルを作成し、その中に指示を書いておきます。このファイルがあると、Copilotはその指示を自動的に読み込み、以降のチャットでその指示を参照することができます。

以下にカスタム指示のサンプルを示します。

```markdown
このプロジェクトは、ポモドーロタイマーをFlaskで実装するものです。

以下はプロジェクトの重要なファイルです。ユーザーの指示に対して、必要に応じてこれらのファイルを参照してください。
 - `pomodoro.png`: アプリケーションのUIモックです。
 - `architecture.md`: アプリケーションのアーキテクチャドキュメントです。
 - `features.md`: 実装する機能の一覧です。
 - `plan.md`: 段階的な実装計画です。
```

そのほかにも、プロジェクトをビルドするコマンドやテストを実行するコマンドなど、プロジェクトに特有のコマンドを記載しておくと、Copilotはそのコマンドを自動的に使用するようになります。

### なかなか実装が進まなかったり、バグを解決できない場合

このような場合には、以下のアプローチを試してみましょう。

- デバッグ情報を出力するように指示し、その出力をCopilotに分析させる。
- 他のモデルを試してみる。

## GitにコミットしてPushしよう
Duration: 10

作成したコードをGitリポジトリにコミットしてリモートブランチにPushしましょう。ここでは3つの方法を紹介します。

### 方法A: ターミナルでコマンドを使用

従来の方法として、ターミナルでGitコマンドを直接実行する方法です：

```bash
git add .
git commit -m "ポモドーロタイマー機能を追加"
git push origin feature/pomodoro-timer
```

### 方法B: VS Code の Source Control を使用

VS Codeの統合されたGit機能を使用する方法です：

1. **VS Code の Source Control タブ**を開く
2. **変更されたファイル**の横にある **+** ボタンをクリックして、ステージングに追加
3. ✨ボタンをクリックして、Copilotにコミットメッセージを生成させる

![Source Control でのコミット](github-copilot-workshop/img/source-control-commit.png)

4. **Commit** ボタン（青いボタン）をクリックしてリモートブランチにPush

### 方法C: MCP サーバーを使用（設定済みの方向け）

MCPサーバーを設定済みの方は、エージェントモードでCopilotに直接指示できます：

```
機能の作成が完了したので、コードの差分をgitのステージングにあげてください。

その後、適切なコミットメッセージでコミットいただき、リモートブランチに変更をPushしてください。
```

![MCP による Git ワークフロー](github-copilot-workshop/img/mcp-git-workflow.png)


続いて、実装計画をGitHub Issuesとして管理していきます：

```
plan.mdの各ステップをGitHub issuesとして起票してください
```

この指示により、Copilotは以下を実行します：

1. `plan.md` の内容を読み取り
2. 各ステップを個別のIssueとして起票
3. 各Issueには以下が含まれます：
   - ステップのタイトルと詳細説明
   - 実装すべき機能の要件
   - 受け入れ条件
   - 適切なラベルと優先度

これにより、計画的なプロジェクト管理とアジャイル開発が可能になります。

![MCP Issues](github-copilot-workshop/img/mcp-issues.png)

> aside positive
>
> **MCP の利点**: GitHub MCPサーバーを使用することで、Copilotがリポジトリの情報、Issues、Pull Requests、ブランチ情報などのGitHubメタデータに直接アクセスし、より詳細な分析や提案を行うことができます。


## GitHub.com上でのGitHub Copilot
Duration: 15

Pushした後の内容をGitHub.com上でPull Requestを立てて、Copilotのコードレビュー機能を活用しましょう。

### Pull Requestの作成とCopilot Summary

1. GitHub上でフォークしたリポジトリにアクセス
2. **Open a pull request** をクリック
3. Pull Request作成画面で、**Copilotのアイコン** >> **Summary** をクリック

![Pull RequestでのCopilot Summary](github-copilot-workshop/img/pull-request-copilot-summary.png)

Copilotが自動的にPull Requestの概要を生成してくれます。

### Copilotをレビュワーとしてアサイン

**Reviewers** セクションで **Copilot** をアサインすることで、Copilotをレビュワーとしてアサインし、コードのレビューを依頼できます。

> aside positive
>
> **自動アサインの設定**: Settings >> Branches >> Rulesets >> Require a pull request before merging >> Automatically request Copilot code reviewにチェックを入れることで、Pull Requestを開いた時、自動的にCopilotがアサインされるようになります。

![Copilot自動アサインの設定](github-copilot-workshop/img/copilot-auto-assign-settings.png)

### Copilot Code Reviewの結果確認

Pull Requestが開かれた後、Copilot Code Reviewの結果を閲覧できます：

- **Pull Requestのオーバービュー**: コードの変更内容の要約
- **指摘事項**: 潜在的な問題点の指摘
- **改善提案**: コードの品質向上のための具体的な提案

![Copilot Code Reviewの概要](github-copilot-workshop/img/copilot-code-review-overview.png)

### GitHub Advanced Securityによる静的脆弱性スキャン

Pull Requestには、GitHub Advanced Security（GHAS）による静的脆弱性スキャンの結果も表示されます：

#### セキュリティアラートの確認

![GHAS セキュリティアラート](github-copilot-workshop/img/ghas-security-alerts.png)

- **高セキュリティ脆弱性**: 重要度の高いセキュリティ問題
- **Copilot Autofix**: AIによる自動修正提案
- **詳細な説明**: 脆弱性の内容と修正方法

#### チェック結果の詳細

![GHAS チェック結果](github-copilot-workshop/img/ghas-check-results.png)

> aside positive
>
> **Copilot Autofixの活用**: GitHubは検出されたセキュリティ脆弱性に対して、Copilot Autofixによる自動修正提案を提供します。これにより、セキュリティ問題を迅速に解決できます。

## Issueの自動起票とCoding Agent
Duration: 20

GitHub CopilotのWebサイト版を使用して、プロジェクトの改善提案をIssueとして自動生成し、Coding Agentを活用してみましょう。

### GitHub Copilotでのissue自動起票

1. **GitHub.com** にアクセスし、右上の **Copilot** アイコンをクリック
2. Chatのコンテキストに自身のリポジトリが追加されていることを確認
3. 以下のプロンプトを入力します：

```
ポモドーロタイマーのカスタマイズを行うために３つのissueを起票してください。

パターンA: 視覚的フィードバックの強化

円形プログレスバーのアニメーション: 残り時間に応じて滑らかに減少するアニメーション
色の変化: 時間経過に応じて青→黄→赤にグラデーション変化
背景エフェクト: 集中時間中は背景にパーティクルエフェクトや波紋アニメーション
テスト目的: 視覚的な没入感がユーザーの集中力に与える影響を測定

パターンB: カスタマイズ性の向上

時間設定の柔軟化: 25分固定ではなく、15/25/35/45分から選択可能
テーマ切り替え: ダーク/ライト/フォーカスモード（ミニマル）
サウンド設定: 開始音/終了音/tick音のオン/オフ切り替え
休憩時間カスタム: 5/10/15分から選択
テスト目的: 個人の好みに合わせた設定がユーザー継続率に与える影響を測定

パターンC: ゲーミフィケーション要素の追加

経験値システム: 完了したポモドーロに応じてXPとレベルアップ
達成バッジ: 「3日連続」「今週10回完了」などの実績システム
週間/月間統計: より詳細なグラフ表示（完了率、平均集中時間など）
ストリーク表示: 連続日数のカウント表示
テスト目的: ゲーミフィケーション要素がモチベーション維持と継続利用に与える影響を測定
```

![GitHub Copilotでのissue作成](github-copilot-workshop/img/github-copilot-issue-creation.png)

### Issueの作成とCoding Agentのアサイン

1. **Copilotが3つのIssueを自動生成**します
2. 各Issueの内容を確認し、必要に応じて編集
3. **Create** ボタンをクリックして各Issueを作成
4. Issue画面に遷移後、**Assignees** セクションで **Copilot** を選択してCoding Agentをアサイン

![Coding AgentをIssueにアサイン](github-copilot-workshop/img/coding-agent-assignment.png)

### 期待されるPull Requestの結果

Coding Agentがアサインされると、以下のような結果が期待できます：

- **自動的なコード実装**: 各Issueの要件に基づいた機能実装
- **Pull Requestの作成**: 実装完了後の自動PR作成
- **包括的なテスト**: 単体テストとUIテストの両方を含む

#### パターンA: 視覚的フィードバックの強化

![視覚的フィードバック強化のPR結果](github-copilot-workshop/img/pr-result-visual-feedback.png)

#### パターンB: カスタマイズ性の向上

![カスタマイズ性向上のPR結果](github-copilot-workshop/img/pr-result-customization.png)

#### パターンC: ゲーミフィケーション要素の追加

![ゲーミフィケーション要素のPR結果](github-copilot-workshop/img/pr-result-gamification.png)

> aside positive
>
> **MCP Serverの活用**: GitHub MCP ServerとPlaywright MCP Serverが初期設定としてCoding Agentに含まれています。これにより、単体テストだけではなく、スクリーンショットによるUIの自動チェックも行うことができます。Coding Agentは実装した機能が期待通りに動作するかを視覚的に検証し、より品質の高いコードを提供します。

## おめでとうございます 🎉
Duration: 5

### 今日学んだこと

このワークショップでは以下のことを学びました：

- GitHub Copilotの基本的な使い方
- Copilot Chatでのコード解説・改善
- エージェント機能の活用
- 実際のアプリケーション開発でのCopilot活用

### 次のステップ

- 実際のプロジェクトでCopilotを活用してみる
- より複雑なアプリケーション開発に挑戦する
- Copilotの新機能をキャッチアップする

### リソース

- [GitHub Copilot Documentation](https://docs.github.com/copilot)
- [GitHub Copilot ベストプラクティス](https://docs.github.com/copilot/using-github-copilot/best-practices-for-using-github-copilot)

お疲れさまでした！