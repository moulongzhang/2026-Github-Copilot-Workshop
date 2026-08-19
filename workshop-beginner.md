author: GitHub
summary: GitHub Copilot app 入門ワークショップ (beginner)
id: github-copilot-workshop
categories: AI, Development
environments: Web
status: Published
feedback link: https://example.com/feedback

# GitHub Copilot app 入門ワークショップ

## ワークショップについて
Duration: 5

GitHub Copilot app 入門ワークショップへようこそ！

[**GitHub Copilot app**](https://docs.github.com/copilot/concepts/agents/github-copilot-app) は Copilot CLI を基盤とするデスクトップアプリケーションで、エージェント主導の開発を単一の作業用ワークスペースで実現します。並列エージェントセッション、切り替え可能なセッションモード、共有キャンバス、GitHub Issue と pull request のネイティブ管理機能を備えています。さらに、リベース、レビューのフィードバック、CI の修正、マージまで pull request を導く **Agent Merge** も利用できます。

![GitHub Copilot Logo](github-copilot-workshop/img/octocat_copilot.png)

### 本日のゴール

一連のレッスンでは、アプリをインストールしてプロジェクトを設定した後、アプリのワークスペースと、テンプレートによって用意されたバックログを確認します。まず、星評価を追加する小さな変更に取り組みます。次に、Issue に基づいてカスタム指示の標準を追加し、分離されたエージェントセッションでフィルター機能を構築して、再利用可能なスキルで検証します。段階的にマージの自動化を進め、**Agent Merge** で pull request をマージします。最後に、1 つの機能を複数の層に分割し、**Stacked Pull Requests** としてまとめてマージします。アイデアから機能のマージまで、開発の一連の流れを体験できます。

### レッスンの構成

| レッスン | トピック | 説明 |
|--------|-------|-------------|
| 0. 前提条件 | セットアップ | Node.js をインストールし、Tailspin Toys プロジェクトの自分用コピーを作成します |
| 1. Copilot app のインストール | セットアップ | アプリをインストールしてプロジェクトを接続し、ワークスペースを確認します |
| 2. 最初のエージェントセッションの実行 | 最初の変更 | セッションを開始し、最初の pull request として小さな変更をリリースします |
| 3. カスタム指示による Copilot のガイド | コンテキスト | Issue に基づいてドキュメント標準を追加し、マージします |
| 4. Autopilot による機能の構築 | コア機能 | Plan と Autopilot を使ってフィルター機能を構築し、スキルで検証します |
| 5. Agent Merge によるマージ | マージ | Agent Merge でフィルター機能の pull request を修正してマージします |
| 6. Stacked Pull Requests | 分割と統合 | 1 つの機能を 3 層に分割し、積み重ねた pull request をまとめてマージします |
| 7. 振り返りと次のステップ | まとめ | ベストプラクティスを振り返り、次に学ぶ内容を確認します |

### 前提条件

このワークショップに参加する前に、次のものを用意してください。

- 有効な **Copilot Student、Pro、Pro+、Business、Enterprise** のいずれかのプランが設定された GitHub アカウント
- **macOS、Linux、Windows** のいずれかを実行するコンピューター
- コンピューターに[インストールされた Git](https://github.com/git-guides/install-git)

> aside positive
> 有料プランを利用していない場合、認証済みの学生は [GitHub Education](https://github.com/education/students) を通じて GitHub Copilot を無料で利用できます。**Copilot Student** プランには、このワークショップで使用するエージェント、MCP、コードレビュー、Copilot CLI の各機能が含まれているため、すべてのレッスンを完了できます。

> aside negative
> **Copilot app は codespace ではなく自分のコンピューターで実行します。**レッスン 0 では、アプリをインストールする前に Node.js をインストールし、プロジェクトの自分用コピーを作成します。また、Copilot Business または Copilot Enterprise を使用している場合、アプリを使用するには管理者が **Copilot CLI** ポリシーを有効にする必要があります。

### 出典とライセンス

このワークショップは [github-samples/copilot-workshops](https://github.com/github-samples/copilot-workshops) の [GitHub Copilot app ワークショップ](https://github-samples.github.io/copilot-workshops/app/)（日本語版 `docs/ja-jp/app`）をベースに、Google Codelab 形式へ再構成したものです。

このワークショップで使用するサンプルアプリは [github-samples/tailspin-toys](https://github.com/github-samples/tailspin-toys) を日本語化した [moulongzhang/Tailspin-Toys-JA](https://github.com/moulongzhang/Tailspin-Toys-JA) です。アプリケーションのソースコードは原典のままで、ドキュメント・指示ファイル・スキル・Issue のみを日本語化しています。

いずれも **MIT License** で公開されています。

> MIT License
>
> Copyright (c) 2023 GitHub
>
> Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
>
> The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
>
> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## レッスン 0: 前提条件
Duration: 15

GitHub Copilot app は、Copilot と GitHub の両方を一元的に扱うデスクトップアプリです。Issue や pull request にすばやくアクセスでき、もちろん GitHub Copilot を使った開発も可能です。このワークショップでは、Astro で構築された Tailspin Toys アプリと GitHub Copilot app を使い、ローカル環境で作業します。始める前に、Node.js がローカルにインストールされていることを確認してから、Copilot app をインストールします。

このレッスンでは、次の内容を学習します。

- プロジェクトのテストを実行できるよう Node.js をインストールする。
- テンプレートから Tailspin Toys プロジェクトの自分用コピーを作成する。

### Node.js をインストールする

いくつかのレッスンでは、エージェントに機能を構築させ、Tailspin Toys のテストスイートをローカルで実行します。そのためには [**Node.js**](https://nodejs.org/) (プロジェクトに必要な唯一のランタイム) が必要です。バージョン **22 以降**をインストールしてください。現在の **LTS** リリースを選ぶと安心です。

どのプラットフォームでも、公式インストーラーを使うのが最も簡単です。

1. Windows Terminal、macOS のターミナル、または普段使用しているターミナルを開きます。
2. 次のコマンドを実行し、Node.js 22 以降がインストールされていることを確認します。

    ```shell
    node --version
    ```

3. `v22` 以上のバージョン番号が表示された場合は、次のセクションに進めます。

> aside positive
> Node.js がインストールされていない場合、または更新が必要な場合にのみ、以降の手順を実行してください。

4. [Node.js のダウンロードページ](https://nodejs.org/en/download)を開きます。
5. 使用しているオペレーティングシステム向けの **LTS** ビルドをダウンロードします。
6. インストーラーを実行し、既定の設定を選択します。Windows では、**Add to PATH** を選択したままにします。
7. インストールが完了したら、新しいターミナルを開きます。
8. 新しいターミナルで次のコマンドを実行し、インストールを確認します。

    ```bash
    node --version
    ```

9. `v22.x.x` 以上が表示されることを確認します。

> aside positive
> コンテナーを使用する場合、[**Docker**](https://www.docker.com/products/docker-desktop/) があれば、Node.js をローカルにインストールする代わりにリポジトリの [dev container](https://code.visualstudio.com/docs/devcontainers/containers) を使用できます。dev container には Node.js が含まれているため、両方を用意する必要はありません。

### ラボ用リポジトリを設定する

Tailspin Toys プロジェクトの自分用コピーを使って作業します。[テンプレートリポジトリ](https://docs.github.com/repositories/creating-and-managing-repositories/creating-a-template-repository)からコピーを作成してください。新しいリポジトリにはラボに必要なすべてのファイルが含まれています。次のレッスンで、このリポジトリをアプリに接続します。

1. 新しいブラウザーウィンドウで、このラボの GitHub リポジトリ `https://github.com/moulongzhang/Tailspin-Toys-JA` を開きます。
2. ラボ用リポジトリのページで **Use this template** ボタンを選択し、**Create a new repository** を選択して、リポジトリの自分用コピーを作成します。

    ![Use this template ボタンのドロップダウンで Create a new repository が選択されている画面](github-copilot-workshop/img/app-0-use-template.png)

3. GitHub または Microsoft が主催するイベントの一環としてワークショップに参加している場合は、メンターの指示に従ってください。それ以外の場合は、GitHub Copilot を利用できる Organization に新しいリポジトリを作成できます。

    ![テンプレートが設定され、リポジトリ名が入力された Create a new repository フォーム](github-copilot-workshop/img/app-0-create-repository.png)

> aside positive
> リポジトリ名は `tailspin-toys` にすることをおすすめします。以降のレッスンではこの名前で説明しますが、別の名前でも問題なく進められます。同じ名前のリポジトリがすでにある場合は、`tailspin-toys-ja` などに変更してください。

4. 作成したリポジトリのパス (**organization-or-user-name/repository-name**) を記録します。このラボで後ほど使用します。

> aside positive
> テンプレートからリポジトリを作成すると、GitHub Issue のバックログが自動的に作成されます。ワークショップ全体を通してこれらの Issue を使用するため、自分で作成する必要はありません。Issue が表示されるまで 1 分ほどかかる場合があります。

### まとめと次のステップ

準備が整いました。プロジェクトをコンピューター上でビルドしてテストできるように Node.js をインストールし、テンプレートから Tailspin Toys リポジトリの自分用コピーを作成しました。

次は GitHub Copilot app をインストールし、作成したリポジトリを接続して、ワークスペースを確認します。レッスン 1「GitHub Copilot app のインストール」に進んでください。

### リソース

- [Node.js のダウンロード](https://nodejs.org/en/download)
- [テンプレートからのリポジトリの作成](https://docs.github.com/repositories/creating-and-managing-repositories/creating-a-template-repository)
- [GitHub Copilot app について](https://docs.github.com/copilot/concepts/agents/github-copilot-app)

## レッスン 1: GitHub Copilot app のインストール
Duration: 15

[**GitHub Copilot app**](https://docs.github.com/copilot/concepts/agents/github-copilot-app) は、エージェント主導の開発に使用するデスクトップアプリケーションです。GitHub Copilot CLI を基盤とし、GitHub とネイティブに統合されているため、リポジトリ、ブランチ、CI パイプラインをすぐに利用できます。すべての作業を自分で行うのではなく、複数のエージェントをそれぞれ分離されたワークスペースで並列に指示し、繰り返し発生するタスクを自動化するワークフロー向けに設計されています。Node.js のインストールとプロジェクトのコピーが完了したので、次はアプリをインストールして、そのリポジトリを接続します。

このレッスンでは、次の内容を学習します。

- GitHub Copilot app をインストールしてサインインする。
- GitHub リポジトリからプロジェクトをアプリに追加する。
- テンプレートによって用意されたバックログを含め、ワークスペースを確認する。
- クイックチャットを試して、アプリ自体について学ぶ。

### シナリオ

チームは、増え続けるバックログに対応するために AI エージェントを導入しています。Copilot app では、Issue の選択、エージェントの実行、変更のレビュー、pull request のマージを一か所から指示できます。このレッスンでは、アプリをインストールして接続し、プロジェクトについての会話を始められるようにします。

> aside positive
> 対象となる Copilot プランが必要です。Copilot Student またはいずれかの有料プラン (Pro、Pro+、Business、Enterprise) を利用してください。Copilot Business または Copilot Enterprise を使用している場合、アプリを動作させるには管理者が **Copilot CLI** ポリシーを有効にする必要があります。

### GitHub Copilot app をインストールして構成する

GitHub Copilot app を使用するには、まずアプリをインストールします。Windows、macOS、Linux 向けのバージョンが用意されています。アプリをインストールして認証し、Tailspin Toys リポジトリを追加します。

1. ブラウザーで [GitHub Copilot app のランディングページ](https://gh.io/app)を開きます。
2. 使用しているプラットフォーム向けのアプリをダウンロードし、ランディングページの手順に従ってインストールします。
3. インストールが完了したら、アプリを開きます。
4. **Sign in to GitHub** を選択し、画面の指示に従って認証します。GitHub Enterprise Server を使用している場合は **Use GitHub Enterprise** を選択し、求められたらサーバーアドレスを入力します。
5. 認証後、リポジトリを接続するよう求められます。先ほど作成した `<YOUR_GITHUB_HANDLE>/tailspin-toys` という名前の Tailspin Toys リポジトリを選択します。
6. **Continue** を選択してオンボーディングを続けます。
7. テーマの選択を求められたら、最も好みのものを選び、**Finish** を選択します。

> aside positive
> Tailspin Toys のコピーが一覧に自動的に表示されなかった場合は、アプリのオンボーディングを完了した後に追加できます。完了すると、Copilot app のホーム画面が表示されます。そこで **Choose from GitHub** を選択し、リポジトリ名 (\<YOUR_GITHUB_HANDLE\>/tailspin-toys) で検索して選択します。これでリポジトリが Copilot app に追加されます。

### ワークスペースを確認する

プロジェクトを接続したら、各領域を確認します。アプリのサイドバーは、主に次の領域で構成されています。

- **Sessions** - エージェントが作業する場所です。各セッションは分離された独自のワークスペースで実行されるため、変更が競合することなく複数のセッションを同時に実行できます。次のレッスンで最初のセッションを開始します。
- **Quick chats** - 独自のブランチやワークスペースを必要としない、質問やブレインストーミング向けの簡易的な会話です。このレッスンの最後に試します。
- **My work** - アプリの **GitHub ネイティブ統合**を通じて表示される Issue と pull request です。アプリを離れずに、Issue と pull request の参照や絞り込み、CI ステータスの確認、Issue からのセッション開始、pull request のレビューを行えます。
- **Automations** - スケジュールまたはオンデマンドで実行する、保存済みのエージェントタスクです。

#### 用意されたバックログを確認する

アプリは GitHub とネイティブに統合されているため、リポジトリで待機中の作業がアプリ内に表示されます。テンプレートからリポジトリを作成したときに、バックログとなる Issue が用意されています。表示されていることを確認します。

1. サイドバーで **My work** を選択します。
2. テンプレートはバックログに 8 件の Issue を用意しています。このワークショップでは次の 3 件に焦点を当てます。表示されていることを確認してください。

   - ユーザーがカテゴリーとパブリッシャーでゲームを絞り込めるようにする
   - リポジトリのコーディング標準を更新する
   - ゲーム一覧ページにページネーションを実装する

3. Issue を選択して詳細を読みます。各 Issue はエージェントセッションの開始点にもなります。ワークショップの後半では、これらの Issue から作業を開始します。

> aside positive
> My work の項目一覧は自動的に絞り込まれ、Copilot app に追加したリポジトリの項目だけが表示されます。ほかのリポジトリの作業項目を表示するには、そのリポジトリをアプリに追加してください。

### クイックチャットを試す

アプリに慣れるには、アプリ自体について質問するのが効果的です。その用途には **quick chat** が適しています。Quick chats ではブランチや worktree を作成せずに質問やブレインストーミングができるため、セッションを必要としない、その場限りの簡単な質問に最適です。

1. サイドバーで **Quick chats** の横にある **+** を選択し、新しいチャットを開きます。
2. アプリのセッションがどのように動作するかを尋ねます。

   ```plaintext
   GitHub Copilot app は worktree をどのように使っていますか？
   ```

3. 会話ビューで回答を読みます。各セッションが分離された独自の git worktree で実行されるため、変更が競合することなく複数のエージェントを並列実行できることがわかります。会話はいつでも継続でき、新しいチャットも開始できます。

### まとめと次のステップ

GitHub Copilot app をインストールし、プロジェクトを接続して、ワークスペースを確認しました。学習した内容は次のとおりです。

- アプリをインストールして GitHub にサインインする。
- GitHub リポジトリからプロジェクトを追加する。
- ワークスペースを確認し、**My work** で用意されたバックログを見つける。
- クイックチャットを使って、その場限りの簡単な質問をする。

次は、最初のエージェントセッションを開始し、ゲームカードに星評価を表示する最初の変更をプロジェクトに加えます。レッスン 2「最初のエージェントセッションの実行」に進んでください。

### リソース

- [GitHub Copilot app について](https://docs.github.com/copilot/concepts/agents/github-copilot-app)
- [GitHub Copilot app の概要](https://docs.github.com/copilot/how-tos/github-copilot-app/getting-started)
- [GitHub Copilot app でのエージェントセッションの操作](https://docs.github.com/copilot/how-tos/github-copilot-app/agent-sessions)

## レッスン 2: 最初のエージェントセッションの実行
Duration: 20

前のレッスンでは、ワークスペースを確認し、クイックチャットを使いました。ここでは、**エージェントセッション**を開始し、プロジェクトに最初の変更を加えます。変更は小規模なものにします。ゲームのデータにはすでに星評価が含まれていますが、ホームページのゲームカードにはまだ表示されていません。エージェントに表示を依頼し、変更をレビューして、最初の pull request としてマージします。

このレッスンでは、次の内容を学習します。

- エージェントセッションを開始し、セッションの構成を理解する。
- プロジェクトに小規模で対象を絞った変更を加えるようエージェントに依頼する。
- ワークスペースの差分ビューで変更をレビューする。
- アプリをローカルで実行し、ブラウザーで変更を確認する。
- 最初の pull request を作成してマージする。

### シナリオ

Tailspin Toys の各ゲームには星評価を設定でき、ゲーム詳細ページにはすでに表示されています。一方、ホームページのゲームカードには、タイトル、カテゴリー、パブリッシャー、説明だけが表示されています。最初のセッションの準備運動として、各カードに既存の評価を表示するようエージェントに依頼します。小規模で自己完結した、最初のセッションに最適な変更です。

### セッションの構造

**セッション**とは、分離された独自のワークスペースで実行されるエージェントとの会話です。すべてのセッションに**専用の git worktree とブランチ**が割り当てられます。そのため、一方では機能を追加し、もう一方ではバグを修正するなど、変更を競合させずに複数のセッションを同時に実行できます。セッションはリポジトリごとにグループ化されてサイドバーに表示され、選択すると切り替えられます。

セッション内には、エージェントとの**会話**、ファイルを調査および編集するときのエージェントの**ツールアクティビティ**、差分付きの**変更済みファイル**一覧という3つの要素が表示されます。

### セッションを開始して変更を依頼する

新しいセッションを開始し、プロジェクトの調査と機能の実装に取りかかります。前のレッスンでは、GitHub リポジトリからプロジェクトを追加しました。そのリポジトリ用の新しいセッションを作成し、変更を依頼します。

1. GitHub Copilot app に戻ります。アプリを閉じている場合は開きます。
2. **Home screen** を選択します。
3. リポジトリに `tailspin-toys` が選択されていることを確認します。

   ![リポジトリセレクターに tailspin-toys が設定され、プロンプトの下にモデルセレクターが表示された GitHub Copilot app のプロンプトボックス](github-copilot-workshop/img/app-2-start-session.png)

4. 次のプロンプトを使って変更を依頼します。

   ```plaintext
   ゲームカードに各ゲームの星評価を表示してください。Game 型にはすでに starRating フィールドが含まれています。これは 5 点満点の数値で、まだ評価されていないゲームの場合は null になります。src/components/GameCard.astro の各カードに星評価を表示し、starRating が null の場合は代わりに "No rating yet" と表示してください。変更は小さくとどめ、カードのレイアウトは作り直さないでください。
   ```

> aside positive
> プロンプトに、Copilot が更新するファイル名が含まれていることに注目してください。Copilot が作業に含めるファイルを指定する必要はありませんが、方向性を示すことで、コードをすばやく生成し、トークン使用量を削減できます。

5. <kbd>Enter</kbd> を選択して、プロンプトを Copilot に送信します。

Copilot app は、最初にプロジェクトの分離されたコピーである新しい worktree を作成して作業を開始します。次にプロジェクトを調査し、新機能の追加に必要な更新対象ファイルを見つけて、必要なコードを作成します。これで Copilot app を使って新機能を追加できました。

### 差分をレビューする

AI が生成したすべての変更は、どれほど小さくてもマージ前にレビューする必要があります。Copilot app 内で変更を確認します。

1. アプリの右上隅にある **Toggle review panel** を選択します。Copilot が行った未処理の変更がすべて表示される差分画面が開きます。

   ![Create PR の右側にある Toggle review panel ボタンを矢印で示した GitHub Copilot app の上部ツールバー](github-copilot-workshop/img/app-2-review-panel.png)

2. ゲームの詳細表示に使用される中心的なファイル `GameCard.astro` にコードが追加されていることを確認します。次のような小さなブロックが追加されているはずです。評価がある場合は表示し、`starRating` が `null` の場合は "No rating yet" を表示します。

   ```astro
   {game.starRating !== null ? (
       <span class="text-xs font-medium px-2.5 py-0.5 rounded bg-amber-900/60 text-amber-300" data-testid="game-rating">
           ★ {game.starRating} / 5
       </span>
   ) : (
       <span class="text-xs font-medium text-slate-500" data-testid="game-rating-empty">
           No rating yet
       </span>
   )}
   ```

> aside positive
> Copilot は、すべての生成 AI ツールと同様に決定論的ではなく確率的に動作するため、実際のコードは上記と異なる場合があります。ただし、比較的よく似たものになります。

### 変更を確認する

コードを読むだけで動作すると判断せず、視覚的にもテストします。そのためには、ターミナルからアプリを起動して、すべてが動作することを確認する必要があります。Copilot app にはターミナルが組み込まれています。

1. Copilot app の右側にあるレビューパネルで **Terminal** を選択します。**Terminal** ボタンがない場合は、**+** (**Open in panel** というラベルが付いています) を選択してから **Terminal** を選択します。

   ![GitHub Copilot app のレビューパネルにある Terminal ボタン](github-copilot-workshop/img/app-terminal-screenshot.png)

2. ターミナルウィンドウに次のコマンドを入力し、Web アプリの開発サーバーを起動します。

   ```shell
   npm run dev
   ```

3. サーバーが起動したら、ブラウザーウィンドウを開きます。起動には少し時間がかかります。
4. http://localhost:4321 に移動します。
5. ランディングページのすべてのゲームに星評価が表示されていることを確認します。
6. ターミナルウィンドウに戻ります。
7. <kbd>Ctrl</kbd>+<kbd>C</kbd> を選択して開発サーバーを停止します。

### 最初の pull request を作成してマージする

変更に問題がないことを確認できたので、リリースします。エージェントに pull request の作成を依頼し、github.com で自分でレビューしてマージします。今回は手動で管理します。後のレッスンでは、Copilot でこの作業の一部を自動的に処理する方法を確認します。

1. 右上隅にある **Create PR** を選択します。
2. 求められた場合は **Sign in with your browser** を選択し、画面の指示に従って認証します。
3. Copilot が PR の作成を開始します。

PR が作成されると、Copilot はリポジトリで実行する必要があるワークフローを監視します。しばらくすると、右上のボタンが **Ready to merge** に変わります。これは PR をマージする準備が整ったことを示します。

4. チャットのすぐ上にある **PR** バブルを選択し、レビューペインで PR を開いて pull request を確認します。必要に応じて、ここで PR をレビューできます。
5. 準備ができたら **Ready to merge** を選択します。
6. 新しいダイアログウィンドウで **Merge pull request** を選択し、pull request をマージします。

これで Web サイトに新機能を反映できました。

### まとめと次のステップ

最初のエージェントセッションを開始し、最初の変更をリリースしました。具体的には、次の作業を行いました。

- エージェントセッションを開始し、セッションの構成を学習した。
- ゲームカードに小規模で対象を絞った変更を加えるようエージェントに指示した。
- ワークスペースの差分ビューで変更をレビューした。
- アプリをローカルで実行し、ブラウザーで星評価を確認した。
- pull request を作成し、github.com で自分でマージした。

次は、アプリを使ってリポジトリにカスタム指示の標準を追加します。バックログ内の Issue の1つから作業を開始します。レッスン 3「カスタム指示による Copilot のガイド」に進んでください。

### リソース

- [GitHub Copilot app でのエージェントセッションの操作](https://docs.github.com/copilot/how-tos/github-copilot-app/agent-sessions)
- [GitHub Copilot app について](https://docs.github.com/copilot/concepts/agents/github-copilot-app)
- [GitHub Copilot app での Issue と pull request の管理](https://docs.github.com/copilot/how-tos/github-copilot-app/managing-issues-and-pull-requests)

## レッスン 3: カスタム指示による Copilot のガイド
Duration: 20

生成 AI を扱うとき、コンテキストは重要です。タスクを特定の方法で実行する必要がある場合や、Copilot が把握しておくべき背景情報がある場合は、そのコンテキストを利用できるようにします。特に強力なツールの1つが[指示ファイル](https://docs.github.com/copilot/customizing-copilot/about-customizing-github-copilot-chat-responses)です。指示ファイルには、必要なコードの内容だけでなく、その構成方法も記述します。このレッスンでは、リポジトリにドキュメント標準を追加します。ここから先の多くの作業と同様に、バックログの Issue から開始し、エージェントに変更を行わせます。

このレッスンでは、次の内容を学習します。

- リポジトリ指示とパス固有の指示ファイルがエージェントにどのように渡されるかを確認する。
- バックログ内の指示に関する Issue からセッションを開始する。
- `.github/copilot-instructions.md` にドキュメント標準を追加するようエージェントに依頼する。
- 変更をレビューし、pull request としてマージする。

### シナリオ

優れた開発組織と同様に、Tailspin Toys にも開発プラクティスのガイドラインと要件があります。内容は次のとおりです。

- TSDoc doc comment の形式でコードにドキュメントを追加する。
- フォーマット方法を文書化し、lint によって適用する。

指示ファイルを使用すると、示されたプラクティスに沿ってタスクを実行するために必要な情報を Copilot に提供できます。

### 指示ファイル

カスタム指示を使うと、Copilot にコンテキストと設定を提供でき、コーディングスタイルや要件をより正確に理解させることができます。Copilot をガイドし、より関連性の高い提案やコードスニペットを得るための強力な機能です。希望するコーディング規約、ライブラリ、コードに含めるコメントの種類まで指定できます。リポジトリ全体に適用する指示や、タスクレベルのコンテキストとして特定のファイル種類に適用する指示を作成できます。

指示ファイルには2つの種類があります。

- `.github/copilot-instructions.md` は、リポジトリに対する**すべての**リクエストで Copilot に送信される単一の指示ファイルです。このファイルには、Copilot に送信するほとんどのチャットまたは CLI リクエストに関係する、プロジェクトレベルの情報を記載します。使用する技術スタック、構築するものの概要、ベストプラクティスなど、全体に適用するガイダンスを含められます。
- `.github/instructions/*.instructions.md` ファイルは、特定のタスクやファイル種類向けに作成できます。特定の言語 (TypeScript や Astro など) や、UI コンポーネントまたは新しい単体テスト一式の作成といったタスクに関するガイドラインを提供できます。

> aside positive
> Copilot は AGENTS.md、CLAUDE.md、GEMINI.md を通じて指示のガイダンスを取り込むほかの標準もサポートしており、常に適切なコンテキストを提供できます。

#### 指示ファイルを管理するためのベストプラクティス

指示ファイルの作成方法を詳しく説明することは、このワークショップの範囲外です。ただし、サンプルプロジェクトに含まれる例は、代表的なアプローチを示しています。概要は次のとおりです。

- `copilot-instructions.md` の指示は、構築するものの説明、プロジェクトの構造、全体的なコーディング標準など、プロジェクトレベルのガイダンスに絞ります。
- `*.instructions.md` ファイルは、ファイル種類 (単体テスト、Astro コンポーネント、データレイヤー) または特定のタスクに固有の指示を提供するために使用します。
- 自然言語を使います。ガイダンスは明確にし、コードの適切な例と不適切な例を提示します。

AI の使い方に唯一の方法がないのと同様に、指示ファイルの作成方法にも唯一の正解はありません。プロジェクトに最適な方法は、試行を重ねることで見つけられます。

> aside positive
> GitHub Copilot を使用するすべてのプロジェクトには、充実した指示ファイル一式を用意することをお勧めします。このプロジェクトのファイルを確認すると、多くのコードファイル種類に対応する指示ファイルがあることがわかります。
>
> テンプレートや出発点が必要な場合は、指示ファイル、カスタムエージェントなどのリソースが揃ったリポジトリ [awesome-copilot](https://awesome-copilot.github.com/) を確認してください。

### このプロジェクトのカスタム指示ファイルを確認する

このリポジトリに含まれる指示ファイルを確認します。中心となる `copilot-instructions.md` が1つと、さまざまなタスクに対応する `*.instructions.md` ファイル一式があります。エディターまたは GitHub Web UI で開いてください。

1. レビューパネルが表示されていない場合は、右上の **Toggle review panel** を選択して開きます。

   ![Create PR の右側にある Toggle review panel ボタンを矢印で示した GitHub Copilot app の上部ツールバー](github-copilot-workshop/img/app-2-review-panel.png)

2. **+** を選択し、レビューパネルに新しい項目を追加します。
3. **File** を選択します。
4. `copilot-instructions.md` を検索します。
5. ファイル一覧から `copilot-instructions.md` を選択して開きます。
6. ファイルを確認します。プロジェクトの簡単な説明に加えて、**Agent notes**、**Code standards**、**Scripts**、**Repository Structure** などのセクションがあります。**Code standards** の下には、ネストされた **GitHub Actions Workflows** のガイダンスがあります。これらは Copilot とのすべてのやり取りに適用されます。
7. **Show folder view** を選択して、フォルダーナビゲーターを開きます。

   ![GitHub Copilot app でファイルを開いたレビューパネルにある Show folder view ボタン](github-copilot-workshop/img/app-show-folder-view.png)

8. `.github/instructions` フォルダーに移動し、ファイルを確認します。Astro ファイル、Drizzle データレイヤー、テストなどに対応する指示があります。
9. `.github/instructions/unit-tests.instructions.md` を開きます。先頭の `applyTo` フィールドに注目してください。これはリポジトリのルートを基準とする glob で、指示を適用するファイルを決定します。ここでは、TypeScript のテストファイル (`**/*.test.ts` に一致するファイルなど) が対象になります。
10. このプロジェクトで単体テストを作成するための固有の指示を確認します。
11. 最後に `.github/instructions/drizzle.instructions.md` を開き、末尾まで移動します。ほかの指示ファイル (`unit-tests.instructions.md` など) と、プロジェクト内の既存ファイルへのリンクに注目してください。これにより、大きな指示セットを小さく再利用可能なファイルに分割し、コード生成時に参照する例を Copilot に提示できます。そこに記載されたパスは、リポジトリのルートではなく指示ファイルを基準とします。

> aside positive
> `copilot-instructions.md` の **Code formatting requirements** セクションにはプロジェクトのコーディング標準が記載されていますが、コード内のドキュメントはまだ必須ではありません。次の手順で、TSDoc doc comment とファイルコメントヘッダーの規則を追加します。

### 指示に関する Issue から開始する

前のレッスンでは、直接入力したプロンプトからセッションを開始しました。しかし、多くの作業は Issue から始まります。指示ファイルを更新するために登録された Issue に基づいて新しいセッションを作成し、更新を依頼します。

> aside positive
> 指示ファイルは Copilot が生成するコードに大きな影響を与えるため、Copilot を明確にガイドする内容になっていることを慎重に確認してください。このレッスンのように、Copilot で最初のバージョンを作成した後、自分でレビューして更新内容が要件を満たすことを確認する方法が効果的です。

1. サイドバーで **My work** を選択します。
2. **リポジトリのコーディング標準を更新する** というタイトルの Issue を選択して開きます。
3. 右上の **New session** を選択し、Issue に基づく新しいセッションを開始します。

   ![GitHub Copilot app の Issue ビューで、右上の New session ボタンを矢印で示した画面](github-copilot-workshop/img/app-new-session-from-issue.png)

4. 次のプロンプトを使い、Issue に記載された要件を満たすように指示ファイルを更新することを Copilot に依頼します。

  ```plaintext
  この issue に従って、記載されている要件を満たすように、このプロジェクトの指示ファイルを更新してください。PR はまだ作成しないでください。
  ```

Copilot が更新を行います。

### 変更をレビューする

Copilot が行った更新を読み、更新された指示に基づいて生成するコード例も提示させます。

1. 右上の **Changes** を選択してコードの変更を開きます。

   ![GitHub Copilot app のセッションパネルにあるタブで、Changes タブを矢印で示した画面](github-copilot-workshop/img/app-select-changes.png)

2. 更新された指示ファイルをレビューします。コードにドキュメントとコメントを追加するためのガイドラインが含まれていることを確認します。

> aside positive
> AI は決定論的ではなく確率的に動作するため、実際のテキストは異なります。

3. 次のプロンプトを使い、Copilot が今後生成するコード例を作成するよう依頼します。

  ```plaintext
  実際の更新は行わず、コードがどのようになるかを見せてください。新しい指示に基づくと、すべての Publisher を返す新しいライブラリコンポーネントの作成を Copilot に依頼した場合、そのコードはどのようなものになりますか？
  ```

4. Copilot が提案するコードをレビューします。更新された指示で求めたとおり、TSDoc doc comment とファイルヘッダーコメントが含まれていることを確認します。

これでプロジェクトの指示ファイルを更新し、その効果を確認できました。

### pull request を作成してマージする

指示ファイルはリポジトリのアセットとなり、チームのほかのメンバーと共有されます。ほかのアセットと同様に、作業内容を含む PR を作成します。

1. 右上隅にある **Create PR** を選択します。
2. 求められた場合は **Sign in with your browser** を選択し、画面の指示に従って認証します。
3. Copilot が PR の作成を開始します。

PR が作成されると、Copilot はリポジトリで実行する必要があるワークフローを監視します。しばらくすると、右上のボタンが **Ready to merge** に変わります。これは PR をマージする準備が整ったことを示します。

4. **Ready to merge** を選択します。
5. 新しいダイアログウィンドウで **Merge pull request** を選択し、pull request をマージします。

> aside positive
> 標準がデフォルトブランチにマージされると、すべてのメンバーと新しいセッションでプロジェクトの一部として利用できます。次のレッスンで最新のデフォルトブランチからフィルター機能のセッションを開始すると、エージェントは自動的にこの標準に従います。生成された TypeScript に、依頼していなくても TSDoc doc comment が含まれます。指示が生成コードを形作ることを示す、小さいながらも実際的な例です。

### まとめと次のステップ

アプリが指示ファイルからコンテキストを取得する仕組みを確認し、セッションを使ってリポジトリ全体の標準を追加してマージしました。具体的には、次の作業を行いました。

- リポジトリの `copilot-instructions.md` とパス固有の `*.instructions.md` ファイルを確認した。
- バックログ内の指示に関する Issue からセッションを開始した。
- `.github/copilot-instructions.md` にドキュメント標準を追加するようエージェントに依頼した。
- 変更をレビューし、pull request としてマージした。

次は、新しいセッションでフィルター機能を構築し、先ほどマージした標準が適用される様子を確認します。レッスン 4「Autopilot による機能の構築」に進んでください。

### リソース

- [GitHub Copilot をカスタマイズするための指示ファイル](https://docs.github.com/copilot/customizing-copilot/about-customizing-github-copilot-chat-responses)
- [GitHub Copilot app のカスタマイズ](https://docs.github.com/copilot/how-tos/github-copilot-app/customize-github-copilot-app)
- [カスタム指示を作成するためのベストプラクティス](https://docs.github.com/enterprise-cloud@latest/copilot/using-github-copilot/coding-agent/best-practices-for-using-copilot-to-work-on-tasks#adding-custom-instructions-to-your-repository)
- [Awesome Copilot - 指示ファイルなどのリソース集](https://awesome-copilot.github.com/)

## レッスン 4: Autopilot による機能の構築
Duration: 30

ここまで、プロジェクトに小さな更新をいくつか加えました。しかし、より本格的な変更には、よりしっかりしたプロセスが必要です。GitHub Copilot app は既存のフローと連携できるように設計されており、適切なものを適切な方法で構築できます。このレッスンから3回にわたり、一般的な開発プロセスに従います。まず Issue を使って新機能を生成し、エージェントスキルで検証テストと linter を実行します。

このレッスンでは、次の内容を学習します。

- フィルター機能に関する Issue から新しいセッションを開始する。
- **Plan** モードで機能を計画し、**Autopilot** で構築する。
- 生成されたコードが、以前マージしたドキュメント標準に従っていることを確認する。
- プロジェクトの `quality-checks` スキルで作業を検証する。

### シナリオ

ホームページにはすべてのゲームが一覧表示されますが、訪問者は一覧を絞り込めません。フィルター機能に関する Issue では、**カテゴリー**と**パブリッシャー**でゲームを絞り込めるようにすることが求められています。Copilot を使ってこの機能を実装します。

### 背景

AI コーディングエージェントを開発フローに導入しても、基本は変わりません。むしろ、基本はさらに重要になります。多くの開発者は、次のようなフローに従います。

1. 必要な作業の詳細が記載された Issue を開く。
2. 構築する内容の計画を作成する。
3. コードを構築してレビューする。
4. テストを実行してコードを検証する。
5. 新機能を手動で検証する。
6. pull request (PR) を作成する。
7. コードのレビューと継続的インテグレーションプロセスが成功したら、コードをマージする。

> aside positive
> 正確な手順はチームや Organization によって異なりますが、多くの場合は上記の流れを変形したものです。

この標準的なアプローチを守ることで、AI が生成したコードが定められた要件を満たし、人間が作成したコードと同じ審査プロセスを通るようにできます。

### セッションモード

**セッションモード**は、エージェントの自律性を制御します。プロンプトフィールド下のドロップダウンから設定し、いつでも変更できます。

- **Interactive**: ユーザーとエージェントが共同で作業します。エージェントは変更を提案し、続行前に入力を待ちます。
- **Plan**: エージェントが最初に計画を作成します。計画実行前に内容をレビューして承認します。
- **Autopilot**: エージェントが完全に自律して作業し、入力を待たずにコードの作成、テストの実行、反復を行います。

### フィルター機能を計画する

潜在的な問題を見つける最適なタイミングは、コードを作成する前です。そのためには、事前に少し計画を立てるのが効果的です。Copilot と計画を立てると、一連の手順と採用するアプローチが生成されます。その計画をレビューし、改善案があれば提案してから、計画に基づいて Copilot にコードを生成させることができます。

Issue を開いて新しいセッションを開始し、Plan モードに切り替えて計画を作成します。

1. ナビゲーションタブから **My work** を選択します。
2. **ユーザーがカテゴリーとパブリッシャーでゲームを絞り込めるようにする** というタイトルの Issue を選択します。
3. 右上の **New session** を選択します。

   ![GitHub Copilot app の Issue ビューで、右上の New session ボタンを矢印で示した画面](github-copilot-workshop/img/app-new-session-from-issue.png)

4. モードに **Plan** と表示されるまで <kbd>Shift</kbd>+<kbd>Tab</kbd> を選択します。

   ![モードセレクターが Plan に設定され、矢印で示された GitHub Copilot app のプロンプトボックス](github-copilot-workshop/img/app-4-plan-mode.png)

5. 次のプロンプトを送信します。Issue から開始したため、フィルター機能の Issue はすでにこのセッションのコンテキストに含まれています。

   ```plaintext
   issue に記載されている要件に基づいて作業を計画してください。計画を立てる過程で確認したいことがあれば、遠慮なく質問してください。
   ```

6. 計画の作成中に、エージェントから追加の質問が提示される場合があります。自分で機能を構築するときの方針に基づいて回答します。

> aside positive
> Copilot は確率的に動作するため、追加で尋ねられる質問は異なります。質問がまったくない場合もありますが、問題ありません。

7. 完了すると、Copilot が計画の概要を提示します。計画をレビューしてください。クエリの構築、フィルターコントロールの追加、テストの作成が提案されているはずです。必要に応じてフィードバックを返して改善できます。エージェントは提案を新しいバージョンに反映します。

### Autopilot で構築する

計画が完成したので、Copilot に実装を構築させます。

1. **Plan summary** ダイアログのオプション一覧で、**Approve and implement with autopilot** に最も近いオプションを選択します。

Copilot が実装作業を開始します。

> aside positive
> Copilot が必要なコードの作成を自動的に開始しない場合は、「計画に沿って実装を進めてください」のようなプロンプトを使って開始を依頼できます。
>
> 必要な更新の作成には数分かかります。エージェントはファイルを編集および作成し、テストを作成して実行し、反復します。この時間に、ここまで学習した内容を振り返ったり、飲み物を用意したりできます。

### 変更をレビューする

AI が生成したすべてのコードは、マージ前にレビューする必要があります。コードをレビューし、サイトを実行して問題がないことを確認します。

1. 右上の **Changes** を選択してコードの変更を開きます。

   ![GitHub Copilot app のセッションパネルにあるタブで、Changes タブを矢印で示した画面](github-copilot-workshop/img/app-select-changes.png)

2. 変更をレビューします。新しい TypeScript ファイル、Astro ファイル、テストファイルが表示されます。新しいヘルパー関数には、レッスン3でマージしたドキュメント標準に従い、依頼していなくても TSDoc doc comment とファイルヘッダーコメントが含まれていることを確認します。
3. Copilot app の右側にあるレビューパネルで **Terminal** を選択します。**Terminal** ボタンがない場合は、**+** (**Open in panel** というラベルが付いています) を選択してから **Terminal** を選択します。

   ![GitHub Copilot app のレビューパネルにある Terminal ボタン](github-copilot-workshop/img/app-terminal-screenshot.png)

4. ターミナルウィンドウに次のコマンドを入力し、Web アプリの開発サーバーを起動します。

   ```shell
   npm run dev
   ```

5. サーバーが起動したら、ブラウザーウィンドウを開きます。起動には少し時間がかかります。
6. http://localhost:4321 に移動します。
7. ランディングページでフィルターを使用できることを確認します。
8. 問題がある場合は、Copilot に更新を依頼できます。
9. 問題がなければ、ターミナルウィンドウに戻ります。
10. <kbd>Ctrl</kbd>+<kbd>C</kbd> を選択して開発サーバーを停止します。

### quality-checks スキルで作業を検証する

差分を目視で確認するだけで完了とすることもできますが、このチームには明確な品質基準と、それを繰り返し確認する方法があります。

**エージェントスキル**を使うと、テストの実行、ビルドの生成、pull request の作成など、繰り返し発生するタスクの実行方法を Copilot に指示できます。スキルは、エージェントが必要に応じて読み込める指示、スクリプト、リソースのフォルダーです。[Agent Skills はオープン標準](https://github.com/agentskills/agentskills)であり、さまざまなエージェントで使用されています。そのため、同じスキルをエージェントモードの Copilot Chat、Copilot cloud agent、Copilot CLI、GitHub Copilot app で使用できます。

スキルはプロジェクトの `.github/skills` フォルダー、またはグローバルの `~/.copilot/skills` に配置します。各スキルは、YAML frontmatter (`name` と `description`) と、それに続く Markdown の指示が記載された `SKILL.md` ファイルを含むフォルダーです。

```yaml
---
name: quality-checks
description: このプロジェクトのすべてのテスト、lint、品質チェックの実行を担当します — Vitest のユニットテスト、Playwright の E2E テスト、ESLint の実行、失敗のデバッグ、コード変更の検証、commit・push・merge 前の準備状態の確認を行います。（抜粋）
---
```

スキルには、スクリプト、アセット、参考資料を含むサブフォルダーも追加できます。完全な構造については、[エージェントスキルの仕様](https://agentskills.io/specification)を参照してください。

> aside positive
> スキルは動的に読み込まれます。エージェントは `description` フィールドに基づいて適用するスキルを判断します。明確でシナリオに合った説明を記述することが、スキルが使用されるか無視されるかを左右します。

### quality-checks スキルを確認する

スキルの内容を確認します。

1. レビューパネルが表示されていない場合は、右上の **Toggle review panel** を選択して開きます。

   ![Create PR の右側にある Toggle review panel ボタンを矢印で示した GitHub Copilot app の上部ツールバー](github-copilot-workshop/img/app-2-review-panel.png)

2. **+** を選択し、レビューパネルに新しい項目を追加します。
3. **File** を選択します。
4. `SKILL.md` を検索します。
5. ファイル一覧から `SKILL.md .github/skills/quality-checks` を選択して開きます。
6. `name` と `description` を確認します。説明は、コード変更を commit、push、merge する前にテスト、lint、検証する必要がある場合に、このスキルを使用することをエージェントに伝えます。
7. スキル全体を読みます。単体テスト、Playwright のエンドツーエンドテスト、ESLint の各スイートを実行するスクリプト、実行順序、一般的な失敗のデバッグ方法が記載されています。そのため、エージェントは推測するのではなく、チームの方法でチェックを実行できます。

### チェックを実行する

同じフィルター機能のセッションで、エージェントに作業の検証を依頼します。スキル名を説明する必要はありません。エージェントがリクエストに一致するスキルを見つけます。

1. Copilot app に戻ります。
2. スラッシュコマンド `/quality-checks` を使ってスキルを直接呼び出し、<kbd>Enter</kbd> を選択します。
3. エージェントはスキルに従って単体テスト、linter、エンドツーエンドテストを実行し、結果を報告します。失敗したものがあれば、問題を修正して、すべて成功するまでチェックを再実行するよう依頼します。
4. **このセッションを開いたままにします。** 次のレッスンでは、この pull request のマージを **Agent Merge** に任せます。

### まとめと次のステップ

実際の機能をエンドツーエンドで構築し、チームの基準に照らして検証しました。具体的には、次の作業を行いました。

- 最新のプロジェクトで、フィルター機能に関する Issue から新しいセッションを開始した。
- Plan モードで機能を計画し、Autopilot で構築した。
- 生成されたヘルパーが、レッスン3でマージしたドキュメント標準に従っていることを確認した。
- `quality-checks` スキルで作業を検証した。

次は、pull request の作成からマージまでを **Agent Merge** に任せます。レッスン 5「Agent Merge によるマージ」に進んでください。

### リソース

- [GitHub Copilot app でのエージェントセッションの操作](https://docs.github.com/copilot/how-tos/github-copilot-app/agent-sessions)
- [Agent Skills について](https://docs.github.com/copilot/concepts/agents/about-agent-skills)
- [GitHub Copilot app のカスタマイズ](https://docs.github.com/copilot/how-tos/github-copilot-app/customize-github-copilot-app)
- [GitHub Copilot のクラウドサンドボックスとローカルサンドボックスについて](https://docs.github.com/copilot/concepts/about-cloud-and-local-sandboxes)

## レッスン 5: Agent Merge によるマージ
Duration: 15

フィルター機能の構築と検証が完了しました。最後のステップはマージです。このワークショップではすでに2回マージしており、どちらも pull request を作成して github.com で自分でマージしました。今回は、pull request のライフサイクル全体をアプリ内から管理する **Agent Merge** に処理を任せます。

このレッスンでは、次の内容を学習します。

- Agent Merge の概要と、マージのライフサイクルを自動化する仕組みを学ぶ。
- フィルター機能のセッションで Agent Merge を有効にする。
- pull request の作成、CI の実行、すべて成功した後のマージを確認する。

### シナリオ

ここ数回のモジュールでは、コードの作成から Copilot による UI の直接検証まで、さまざまなレベルの自動化を確認しました。開発をさらに高速化するために、Tailspin Toys は審査および検証済みの pull request を自動的にマージする方法を検討しています。

### Agent Merge の概要

**Agent Merge** を使うと、Copilot app で pull request をマージするまでの最終工程を自動化できます。有効にすると、アプリのセッションが pull request を読み取り、失敗した CI チェックの修正、レビューコメントへの対応、必要に応じたリベースなど、マージを妨げる問題に対処します。そして GitHub で許可され次第、pull request をマージします。バックグラウンドで動作し、アプリを再起動しても継続し、pull request がマージされると自動的に無効になります。

ここまでは、github.com で自分で **Merge pull request** を選択していました。Agent Merge はその責任をエージェントに移すため、エージェントが PR の完了までを管理している間に次のタスクへ進めます。作業のレビューと承認は引き続き自分で行い、エージェントには機械的な最終工程だけを任せます。

### Agent Merge で PR を管理する

コードを手動でレビューし、テストを実行し、Copilot による UI の検証も完了しました。新しいコードをコードベースにマージします。Agent Merge に PR を継続的インテグレーション (CI) のプロセスからマージまで管理させます。

1. 前のモジュールでフィルター機能を追加していたセッションに戻ります。
2. 右上隅にある **Create PR** の横のドロップダウンを選択します。
3. **Agent merge** を選択して Agent Merge を有効にします。

   ![GitHub Copilot app で展開された Create PR ドロップダウンの Agent merge オプションを矢印で示した画面](github-copilot-workshop/img/app-enable-agent-merge.png)

4. ボタンのテキストが **Agent merge** に変わります。
5. **Agent merge** ボタンを選択し、Agent Merge のプロセスを開始します。

Copilot app が PR の作成と管理を開始します。最初にプロジェクトを調査して PR の最適な作成方法を判断し、新しい PR を作成します。

しばらくすると、Copilot が再び作業を開始し、リポジトリ上ですべてのテストを実行する CI プロセスなど、PR の条件を確認します。ほかのチームメンバーによるレビュー、実行が必要なチェック (CI プロセス)、PR をマージできるかどうかのステータスを報告します。

6. **Agent merge** の横にあるドロップダウンを選択してから **Merge pull request** を選択し、Agent Merge に pull request のマージを許可します。

   ![Agent merge ドロップダウンで、エージェントに許可された Address reviews、Fix CI failures、Resolve conflicts の操作と、矢印で示された Merge pull request](github-copilot-workshop/img/app-agent-merge-merge.png)

7. すべての CI プロセスが成功すると、つまりテストに合格すると、Copilot が pull request をマージします。

### まとめと次のステップ

コードの生成、テストと検証、pull request のプロセスなど、開発プロセスの複数の部分を自動化しました。具体的には、次の作業を行いました。

- Agent Merge の概要と、マージのライフサイクルを自動化する仕組みを学習した。
- フィルター機能のセッションで Agent Merge を有効にした。
- pull request の作成、CI の実行、すべて成功した後のマージを確認した。

次は、1 つの機能をデータベース・バックエンド・フロントエンドの 3 層に分割し、依存関係を保ったまま **Stacked Pull Requests** としてまとめてマージします。レッスン 6「Stacked Pull Requests」に進んでください。

### リソース

- [GitHub Copilot app での Issue と pull request の管理](https://docs.github.com/copilot/how-tos/github-copilot-app/managing-issues-and-pull-requests)
- [GitHub Copilot app について](https://docs.github.com/copilot/concepts/agents/github-copilot-app)

## レッスン 6: Stacked Pull Requests
Duration: 25

ここまでは、1 つのセッションで 1 つの pull request を作成し、マージしてきました。しかし実務では、1 つの機能がデータベース・バックエンド・フロントエンドといった複数の層にまたがることがよくあります。このような大きな変更を 1 つの巨大な pull request にまとめると、レビューが難しくなります。このレッスンでは、1 つの機能を 3 つの層に分割し、それぞれをサブセッションで実装して、**Stacked Pull Requests**（積み重ねた pull request）として提出します。

このレッスンでは、次の内容を学習します。

- Stacked Pull Requests の概念と、大きな変更を層ごとに分割する理由を学ぶ。
- `gh stack` CLI 拡張と `gh-stack` スキルを準備し、エージェントがスタックを操作できるようにする。
- 親 issue と、Data Base・Back End・Front End の 3 つの子 issue の関係を確認する。
- 親 issue からセッションを開始し、各子 issue をそれぞれのサブセッションに委任する。
- 3 つの pull request が前の層のブランチの上に積み重なっていることを確認する。
- CI がすべて成功したことを確認し、スタックを一括でマージする。

### シナリオ

Tailspin Toys はゲームのクラウドファンディングサイトですが、現在カタログにはゲームのタイトル・カテゴリー・パブリッシャー・評価しか表示されておらず、「そのゲームがどれだけ支援を集めているか」がまったく分かりません。そこで、各ゲームに **目標金額・調達済み金額・支援者数** を持たせ、一覧ページと詳細ページの両方にプログレスバーとして表示する機能を追加します。

この機能はデータモデル・データアクセス層・UI のすべてに変更が必要です。これを 1 つの大きな pull request にすると、レビュワーは無関係な差分を一度に読まなければならず、レビューが後回しになったり、見落としが生じたりします。**とくに、前のレッスンで学んだ Autopilot のように AI が短時間で大量のコードを生成する場合、pull request は巨大になりがちで、レビュー品質が下がりやすくなります。** そこで、この機能を 3 つの層に分割します。

- **Data Base** — スキーマ・マイグレーション・シードデータ
- **Back End** — データアクセスヘルパー・型定義・進捗計算の純粋関数とユニットテスト
- **Front End** — プログレスバーコンポーネント・ページへの組み込み・e2e テスト

層ごとに pull request を分けると、それぞれの diff が小さく焦点が絞られるため、レビューが速くなります。データベースに詳しいレビュワーは Data Base の層を、UI に詳しいレビュワーは Front End の層を、といったように **層ごとに適切なレビュワー** が担当できます。AI がタスクを次々にこなすとき、1 つのタスクが 1 つの pull request に対応し、次のタスクをその上に積むという流れは、スタックの構造にそのまま当てはまります。

### Stacked Pull Requests とは

**Stacked Pull Requests** は、同じリポジトリ内にある依存関係のある 2 つ以上の pull request の連なりです。通常の pull request はベースブランチが `main` ですが、スタックでは次のようになります。

- 一番下（bottom）の pull request は、リポジトリの既定のブランチ（`main` などのトランク）をベースブランチにします。
- それより上の各 pull request は、**1 つ下の pull request のブランチ** をベースブランチにします。

今回の資金調達機能では、次のように 3 層のスタックを作ります。

```text
feat/funding-frontend  → PR #3（ベース: feat/funding-backend）   ← 一番上（Front End）
feat/funding-backend   → PR #2（ベース: feat/funding-database）
feat/funding-database  → PR #1（ベース: main）                    ← 一番下（Data Base）
main（トランク／既定のベースブランチ）
```

各層のブランチとベースブランチ、そして依存関係を表にすると次のとおりです。

| 層 | 子 issue | ブランチ | ベースブランチ | 依存 |
|----|---------|---------|--------------|------|
| Data Base | `[Data Base] games テーブルに資金調達フィールドを追加し、マイグレーションとシードデータを更新する` | `feat/funding-database` | `main` | なし（最初に着手） |
| Back End | `[Back End] 資金調達フィールドをデータアクセス層に通し、進捗計算ヘルパーを追加する` | `feat/funding-backend` | `feat/funding-database` | Data Base |
| Front End | `[Front End] 資金調達の進捗をプログレスバーとして一覧と詳細に表示する` | `feat/funding-frontend` | `feat/funding-backend` | Back End |

スタックには次のような利点があります。

- **層ごとに小さな diff**: 各 pull request は、その層のブランチと 1 つ下のブランチとの差分だけを表示します。そのため、レビュワーは他の層のノイズに惑わされずに、その層だけを集中してレビューできます。
- **前の層を待たずに次を積める**: 下位の層がマージされていなくても、その上に次の層を積み上げて作業を続けられます。AI エージェントで一度に多くのコードを生成する場合、1 つのタスクが 1 つの pull request に対応し、次のタスクをその上に積むという流れにそのまま当てはまります。
- **下位がマージされると上位が自動で追従**: スタックの一番下の pull request をマージすると、残りのブランチは自動的にリベースされ、次の pull request がトランク（`main`）を直接ベースブランチにするように付け替えられます。ブランチ間の同期という面倒な作業を GitHub が肩代わりします。
- **ルールと CI がすべての層に適用**: ブランチ保護ルールや CI チェックは、一番下だけでなくスタック内のすべての pull request に対して実行されます。どの層も同じ品質基準を満たしてからマージされます。

> aside positive
> スタックの各層は「家を建てる」のに似ています。まず基礎（Data Base）を固め、その上に骨組み（Back End）を組み、最後に内装（Front End）を仕上げます。ある層のコードが別の層に依存する場合、その依存先は必ず同じブランチか、より下のブランチになければなりません。

### 親 issue を確認する

このワークショップのテンプレートには、資金調達機能のための親 issue と 3 つの子 issue があらかじめ用意されています。まず、それぞれの内容を確認します。

1. ブラウザーで、自分のコピーしたリポジトリの **Issues** タブを開きます。
2. **ゲームの資金調達の進捗（支援者数・目標金額・調達済み金額）を表示する** というタイトルの親 issue を開きます。
3. 親 issue の本文を読みます。この機能が 3 つの子 issue に分割されていること、依存順が Data Base → Back End → Front End であることが説明されています。
4. 続けて、3 つの子 issue を開いて受け入れ条件を確認します。
   - **[Data Base] games テーブルに資金調達フィールドを追加し、マイグレーションとシードデータを更新する**
   - **[Back End] 資金調達フィールドをデータアクセス層に通し、進捗計算ヘルパーを追加する**
   - **[Front End] 資金調達の進捗をプログレスバーとして一覧と詳細に表示する**

各子 issue が、どのファイルを変更し、前の層の何に依存しているかを把握しておくと、スタックの構造が理解しやすくなります。

> aside positive
> このワークショップでは、親 issue が `#9`、子 issue が `#10`（Data Base）・`#11`（Back End）・`#12`（Front End）になります。自分で issue を作り直した場合など、番号が異なることがあります。その場合は、以降の手順とプロンプトの番号を自分の環境の番号に読み替えてください。

### gh stack 拡張と gh-stack スキルを準備する

GitHub のスタック機能は、GitHub CLI（`gh`）の **`gh stack` 拡張** で操作します。エージェント（GitHub Copilot）にスタックを扱わせるには、あわせて **`gh-stack` スキル** をインストールします。このスキルを入れておくと、Copilot が `gh stack` コマンドを使ってブランチとベースブランチを正しく組み立てられます。

1. Copilot app のレビューパネルで **Terminal** を開きます（レッスン 4 と同じ手順です）。
2. GitHub CLI のバージョンが **2.90.0 以降**、Git が **2.20 以降** であることを確認します。

    ```shell
    gh --version
    git --version
    ```

3. `gh stack` 拡張をインストールします。

    ```shell
    gh extension install github/gh-stack
    ```

4. AI コーディングエージェント向けの `gh-stack` スキルをインストールします。

    ```shell
    gh skill install github/gh-stack
    ```

> aside positive
> 公式ドキュメントには「To use stacked pull requests with AI coding agents, like GitHub Copilot, install the `gh-stack` skill」と記載されています。このスキルを入れてから Copilot に委任すると、エージェントが `gh stack init`・`gh stack add`・`gh stack submit` などを使って、各 pull request のベースブランチを自動で正しく設定します。

> aside negative
> Stacked Pull Requests はパブリックプレビューの機能です。UI や挙動が変わることがあります。利用には GitHub CLI 2.90.0 以降と Git 2.20 以降が必要です。

### セッションを開始して作業を委任する

親 issue からセッションを開始し、そのセッションに 3 つの層の実装を委任します。Copilot app は、各子 issue を **サブセッション**（このセッションから起動される子セッション）で担当し、それぞれの成果物を Stacked Pull Request として積み上げます。

1. GitHub Copilot app に戻ります。
2. ナビゲーションタブから **My work** を選択します。
3. **ゲームの資金調達の進捗（支援者数・目標金額・調達済み金額）を表示する** というタイトルの親 issue を選択します。
4. 右上の **New session** を選択します。Issue から開始したため、親 issue はすでにこのセッションのコンテキストに含まれています。
5. モードに **Autopilot** と表示されるまで <kbd>Shift</kbd>+<kbd>Tab</kbd> を選択します。各層は範囲が明確で分離されたタスクのため、エージェントが自律して層ごとに構築・検証・pull request の作成を進められます。
6. 次のプロンプトを送信します。issue 番号・ブランチ名・ベースブランチ・使用するコマンドを具体的に指定しているため、そのまま実行できます（番号が異なる場合は自分の環境に合わせて読み替えてください）。

    ```plaintext
    この issue（#9）は、ゲームの資金調達の進捗表示という 1 つの機能を、Data Base・Back End・Front End の 3 層に分割した親 issue です。gh-stack スキルと gh stack コマンドを使って、3 つの子 issue（#10 Data Base、#11 Back End、#12 Front End）を Stacked Pull Requests として実装してください。

    進め方:
    1. まず 3 つの子 issue（#10、#11、#12）の本文と受け入れ条件を読み、依存順が #10 → #11 → #12（Data Base → Back End → Front End）であることを確認してください。
    2. 各子 issue を、それぞれ独立したサブセッションで担当してください。1 つのサブセッションが 1 つの層、1 つのブランチ、1 つの pull request に対応します。
    3. まず一番下の層だけを作ってください。gh stack init で main をトランクとしてスタックを開始し、ブランチ feat/funding-database を作成して、#10 Data Base の変更（db/ 配下のスキーマ・マイグレーション・シードデータ）だけを実装・コミットしてください。後続の層に属する変更をこのブランチに含めないでください。
    4. 次に、gh stack add でスタックの上に feat/funding-backend を追加し、#11 Back End の変更（src/types/game.ts、src/lib/games.ts、新規の src/lib/funding.ts とそのユニットテスト）を実装・コミットしてください。このブランチのベースは自動的に feat/funding-database になります。
    5. 続けて、gh stack add でスタックの上に feat/funding-frontend を追加し、#12 Front End の変更（新規の src/components/FundingProgress.astro、GameCard.astro と詳細ページへの組み込み、新規の e2e テスト）を実装・コミットしてください。このブランチのベースは自動的に feat/funding-backend になります。
    6. 各層の実装が終わるたびに、その層で /quality-checks を実行し、ユニットテスト・lint・e2e テストが通ることを確認してから次の層に進んでください。あわせて、その層の diff がその層だけに閉じていることを自分でレビューしてください。
    7. 3 層すべてが完成したら、gh stack push で全ブランチを push し、gh stack submit で 3 つの依存する pull request をまとめて作成し、スタックとしてリンクしてください。pull request は draft ではなく ready for review として作成してください。各 pull request の説明には、その層の変更内容と対応する子 issue 番号を記載してください。
    8. 最後に gh stack view を実行し、3 つのブランチ・pull request・ベースブランチ・ステータスが正しく積み重なっていることを報告してください。
    ```

7. エージェントが作業を開始します。まず親 issue と 3 つの子 issue を読み、依存順を確認してから、`gh stack init` でスタックを開始し、Data Base の層のサブセッションを起動します。

> aside positive
> 公式の Copilot チュートリアルでは、「Start the pr-stack and build only the first layer:（スタックを開始し、最初の層だけを作る）」のように、一度に 1 層ずつ指示することが推奨されています。層が大きくなりすぎたら、「このブランチは大きくなっています。独立してレビューできる 2 つの層に分割する方法を提案してください」と依頼して、さらに分割することもできます。

> aside positive
> Copilot が層をまたぐ作業を 1 つのセッション内で進めようとした場合は、「各子 issue をそれぞれ別のサブセッションで担当し、層ごとにブランチと pull request を分けてください」と念押しできます。サブセッションは、このセッションの配下にグループ化されて表示されます。

> aside negative
> 各層は必ず **下から順に** 実装してください。順序を飛ばすと、上位の層が存在しない下位の層に依存してしまい、スタックが成立しません。**一番下の層のミスは、その上のすべてのブランチに波及します。** 次の層に進む前に、必ず一番下の層をレビューしてください。

> aside positive
> `gh stack submit` を **自分でターミナルから実行する** 場合は、対話型のエディター画面が開きます。PR のないブランチは既定ですべて含まれ、チェックボックスまたは `^x` で除外できます。各 PR のタイトル・説明・draft 状態をその場で編集し、<kbd>Ctrl</kbd>+<kbd>S</kbd> ですべてを一度に submit します。新規 PR は既定で **ready for review** になり、**CREATE AS** トグルで draft に切り替えられます。エージェント（Copilot）が非対話環境で実行する場合はこのエディターをスキップするため、上のプロンプトでは明示的に ready for review を指定しています。

### Stacked PR を確認する

エージェントが 3 つの層を実装し、pull request を提出したら、スタックの構造を確認します。まずターミナルで、次にブラウザーで確認します。

1. Copilot app のターミナルで、次のコマンドを実行してスタックの状態を確認します。

    ```shell
    gh stack view
    ```

    3 つのブランチ（`feat/funding-database`・`feat/funding-backend`・`feat/funding-frontend`）と、それぞれにリンクされた pull request、ステータス、最新コミットが積み重なって表示されます。
2. ブラウザーで、自分のリポジトリの **Pull requests** タブを開きます。
3. 3 つの pull request（Data Base・Back End・Front End）が作成されていることを確認します。もし **Draft** と表示されている pull request があれば、その pull request を開いて **Ready for review** を選択し、レビュー可能な状態にします。
4. Front End の pull request（一番上）を開きます。pull request のタイトル付近に **スタックアイコン** と、いま何層目を見ているかを示す番号が表示されます。
5. マージボックスに表示される **スタックマップ** を確認します。スタックマップには、スタック内のすべての pull request とそのステータスが表示され、トランク（`main`）が一番下、その上に各層が積み重なって見えます。ワンクリックで各層に移動できます。
6. 各 pull request の **ベースブランチ** を確認します。次のようになっているはずです。
   - Data Base の pull request のベースブランチは `main`
   - Back End の pull request のベースブランチは `feat/funding-database`
   - Front End の pull request のベースブランチは `feat/funding-backend`
7. それぞれの pull request の **Files changed** を開き、diff がその層の変更だけに絞られていることを確認します。Data Base の pull request には `db/` 配下の変更、Back End の pull request には `src/lib/` や `src/types/` の変更、Front End の pull request には `src/components/` や `e2e-tests/` の変更が表示されます。

> aside positive
> 各層の diff がその層だけに閉じているのがスタックの利点です。もしある層に別の層の変更が混ざっていたら、Copilot に「その変更は下位の層に移動してください」と伝えて修正できます。レビュー指摘への対応も同じ考え方です。指摘は **該当する層のブランチ** で直し、`gh stack sync` や `gh stack checkout BRANCH-NAME` でブランチ間を移動して、修正を上の層へ伝播させます。

### CI を確認して一括マージする

スタックのマージは、必ず **一番下（トランクに近い層）から上へ** 行います。今回は 3 つの層がすべて完成しているので、スタック全体を一括でマージします。

1. スタック内のいずれかの pull request のマージボックスを確認します。マージボックスには、その pull request だけでなく **スタック全体のステータス** が表示されます。
2. すべての層で CI チェック（GitHub Actions によるテストなど）が成功していることを確認します。CI チェックは一番下の層だけでなく、スタック内のすべての pull request で実行されます。
3. マージボックスに **Rebase stack** ボタンが表示されている場合は、スタックの履歴が直線的でない（下位のブランチに変更が入った、またはトランクが先に進んだ）状態です。まず **Rebase stack** を選択してスタックをリベースしてから、マージに進みます。
4. スタック全体を一括でマージするには、**一番上（Front End）の pull request** をマージします。一番上をマージすると、その下にあるすべての pull request も下から順に一緒にマージされます。
5. マージ後、3 つの pull request がすべてマージ済みになり、資金調達機能の全層が `main` に取り込まれたことを確認します。

> aside positive
> スタックの途中の pull request をマージすることもできます。その場合、それより下の pull request も一緒にマージされ、上に残った pull request は自動的にトランク（`main`）を直接ベースブランチにするように付け替えられます。中間の pull request だけを単独でマージすることはできません。

> aside negative
> Stacked Pull Requests では auto-merge は利用できません。また、下位の層が承認されず CI も通っていない状態では、上位の層をマージできません。スタックは常に下から順にマージされる点を覚えておいてください。

### まとめと次のステップ

1 つの機能を複数の層に分割し、依存関係を保ったまま Stacked Pull Requests として提出・マージしました。具体的には、次の作業を行いました。

- Stacked Pull Requests の概念と、大きな変更を層ごとに分割する理由を学習した。
- 資金調達機能の親 issue と、Data Base・Back End・Front End の 3 つの子 issue の関係を確認した。
- 親 issue からセッションを開始し、各子 issue をそれぞれのサブセッションに委任して、依存順（Data Base → Back End → Front End）で 3 層を実装した。
- 3 つの pull request が前の層のブランチの上に積み重なっていることを確認し、CI がすべて成功したことを確認してスタックを一括でマージした。

これで、アイデアから機能のマージまでの一連の流れを、小さな変更から複数層にまたがる機能まで体験しました。次は、ここまで学んだベストプラクティスを振り返り、次に学ぶ内容を確認します。レッスン 7「振り返りと次のステップ」に進んでください。

### リソース

- [Stacked pull requests について](https://docs.github.com/ja/pull-requests/get-started/about-stacked-prs)
- [Stacked pull requests のクイックスタート](https://docs.github.com/ja/pull-requests/get-started/stacked-prs-quickstart)
- [Stacked pull requests の CLI コマンド](https://docs.github.com/ja/pull-requests/reference/stacked-prs-cli-commands)
- [Stacked pull requests の管理](https://docs.github.com/ja/pull-requests/how-tos/create-pull-requests/managing-stacked-pull-requests)
- [Stacked pull requests のマージ](https://docs.github.com/ja/pull-requests/how-tos/merge-and-close-pull-requests/merging-stacked-pull-requests)
- [AI が生成したコードを pull request に積み重ねる](https://docs.github.com/ja/copilot/tutorials/stack-ai-generated-code-in-pull-requests)
- [GitHub Copilot app でのエージェントセッションの操作](https://docs.github.com/ja/copilot/how-tos/github-copilot-app/agent-sessions)

## レッスン 7: 振り返りと次のステップ
Duration: 10

ここ数回のレッスンでは、GitHub Copilot app を使い、アイデアから機能のマージまでを実践しました。取り組んだ内容は次のとおりです。

- リポジトリを接続し、アプリのワークスペースと用意されたバックログを確認した。
- 直接指定したタスクと Issue からセッションを開始し、Plan モードと Autopilot モードでエージェントの動作を制御した。
- カスタム指示と再利用可能なスキルでエージェントをガイドした。
- github.com で自分でマージする方法から、**Agent Merge** に pull request のマージを任せる方法まで、段階的なマージ自動化を使って変更をリリースした。
- 複数の層にまたがる機能をサブセッションに分割し、**Stacked Pull Requests** として積み重ねて一括でマージした。

ベストプラクティスと今後の進め方を確認します。

### ベストプラクティス

AI ツールを使用するときは、その周辺の基盤が出力の品質を左右します。このワークショップでは、指示ファイル、スキル、カスタムエージェントがそれぞれ役割を果たしました。これらに投資し、セッション間で再利用してください。

タスクに合わせて**モードとモデル**を選択します。構築前にアプローチを検討するには **Plan**、対象を絞った変更で作業に関与し続けるには **Interactive**、範囲が明確で分離されたタスクに限って **Autopilot** を使用します。定型的な編集には高速なモデルを選び、複雑な作業には推論能力が高く、より多くの推論を行うモデルを選びます。

基盤と同じくらい、コンテキストも重要です。何を、なぜ、どのように構築するかを明確に説明すると、出力は大きく変わります。アイデアを本格的なセッションに移す前に範囲を決める場所として、Quick chats が役立ちます。

### さらに確認する機能

コアワークフローを学習しました。ほかにも確認する価値がある機能があります。

- 完全なセッションを必要としない、その場限りの簡単な質問に使用する **Quick chats**。
- 構築前に問題について対話し、重要なフィードバックを得るための **Rubber duck**。
- ロール、その tools、指示をまとめ、繰り返し使用する専門的な作業に対応する [**Custom agents**](https://docs.github.com/copilot/concepts/agents/cloud-agent/about-custom-agents)。
- セッションで起きたことの記録を生成する [`/chronicle`](https://docs.github.com/copilot/how-tos/copilot-cli/use-copilot-cli/chronicle)。
- Ollama、Foundry Local、LM Studio を介したローカルモデルなど、独自のプロバイダーのモデルを使用する [Bring your own key (BYOK)](https://docs.github.com/copilot/how-tos/github-copilot-app/use-byok-models)。
- GitHub がホストする分離環境でセッションを実行する [Cloud sandboxes](https://docs.github.com/copilot/concepts/about-cloud-and-local-sandboxes)。
- アプリを直接リポジトリ、セッション、プロンプトの画面で開く [Deep links](https://docs.github.com/copilot/how-tos/github-copilot-app/open-with-deep-links)。

### 次のステップ

ツールを使いこなす最良の方法は、使い続けることです。実稼働コード、趣味のコード、長年構想していながら構築できていなかった小さなアプリなどに活用してください。学んだことをチームと共有し、チームからも学びましょう。そして、引き続きドキュメントを確認してください。

GitHub Copilot エコシステムをさらに学ぶには、[VS Code ワークショップ](https://github-samples.github.io/copilot-workshops/ja-jp/vscode/)、[Copilot CLI ワークショップ](https://github-samples.github.io/copilot-workshops/ja-jp/cli/)、[Cloud agent ワークショップ](https://github-samples.github.io/copilot-workshops/ja-jp/cloud/)を確認してください。

### リソース

- [GitHub Copilot app について](https://docs.github.com/copilot/concepts/agents/github-copilot-app)
- [GitHub Copilot app の概要](https://docs.github.com/copilot/how-tos/github-copilot-app/getting-started)
- [GitHub Copilot app のカスタマイズ](https://docs.github.com/copilot/how-tos/github-copilot-app/customize-github-copilot-app)
- [クラウドサンドボックスとローカルサンドボックスについて](https://docs.github.com/copilot/concepts/about-cloud-and-local-sandboxes)
