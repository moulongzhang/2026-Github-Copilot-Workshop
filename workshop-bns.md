author: GitHub
summary: Bandai Namco Studios GitHub Copilot ハンズオン
id: github-copilot-workshop
categories: AI, Development
environments: Web
status: Published
feedback link: https://example.com/feedback

# Bandai Namco Studios GitHub Copilot ハンズオン

## ワークショップについて
Duration: 5

バンダイナムコスタジオの皆さま、本日はお集まりいただきありがとうございます。GitHub からお届けする 1 時間のハンズオンへようこそ。本セッションは GitHub の社員が直接ご案内します。

![GitHub Copilot Logo](github-copilot-workshop/img/octocat_copilot.png)

短い時間ですが、**手を動かして GitHub Copilot を体感する**ことをゴールに据えています。普段エンジニアでない方でも、AI とどう付き合うかの勘所を掴んでいただけるよう構成しています。

### 本日のゴール
- VS Code / GitHub Copilot CLI / Copilot App が動く状態を確認する
- トークン / AI Credit を抑えるコツを理解する
- **Copilot App** で「調査 → 要件 → 計画 → 実装」をローカルファイルで状態管理しながら進める
- 用途に応じてモデルを使い分け（Opus 4.8 / Sonnet 4.6 / MAI-Code-1-Flash）、コストを振り返る

### 全体の流れ
**VS Code / Copilot App 確認 → トークン最適化の基礎 → 演習: トークン最適なタスク管理ツールの開発（調査 → 要件 → 計画 → 実装 → コスト振り返り）**

すべて **GitHub Copilot App** を中心に進めます。

> aside positive
> 本日のメイン演習は **GitHub Copilot App** を中心に行います。GitHub Issues / Pull Request を使った issue-driven 開発が使えない環境でも、`research.md` / `spec.md` / `plan/` といった**ローカルファイルを「状態」として扱う**ことで、AI 駆動開発の流れをそのまま再現できます。

### 前提条件
- GitHub Copilot Business のライセンス（876 Enterprise / GitHub EMU アカウント）
- Windows または macOS
- Visual Studio Code（Agents Window）または GitHub Copilot App
- プロジェクト作業フォルダで GitHub Copilot CLI を使えること

> aside positive
> 配布済みの「イベント参加準備ガイド」に沿って、876 Enterprise ユーザーアカウント認証とアプリのセットアップが完了している前提で進めます。未完了の方はお声がけください。

## VS Code / Copilot App の確認
Duration: 5

本日のメイン演習は **GitHub Copilot App** を中心に行います。Copilot App を起点に、対象フォルダを開き、VS Code と Terminal（Copilot CLI）まで一通り動くことを確認しましょう。

### 1. Copilot App の起動確認

Copilot App を起動します。モデル選択・セッション管理・Autopilot などのメニューが表示されれば起動成功です。

### 2. 対象フォルダを開く

**session の「+」** をクリックし、**Local folder or repository** からプロジェクト作業フォルダを選んで開きます。

### 3. セッションでレスポンスを確認

開いたフォルダの右の **「+」ボタン**でセッションを開き、入力欄に次のように打ってレスポンスが返ることを確認します。

```
hoge
```

何らかの応答が返れば、Copilot App は正常に動作しています。

### 4. VS Code へのアクセス確認

Copilot App 画面の**右上から VS Code を起動**し、GitHub Copilot にアクセスできること（Copilot が有効になっていること）を確認します。

### 5. Copilot CLI の起動確認

Copilot App 画面の**右上から Terminal を起動**し、次を入力して Copilot CLI が立ち上がることを確認します。

```bash
copilot
```

対話型インターフェースが表示されたら成功です。`/user` でログイン中のアカウント（876 Enterprise ユーザーであること）も確認できます。

> aside negative
> いずれかが起動しない場合は GitHub EMU アカウント（876 Enterprise）でログインできているかを確認します。CLI では `/login` で再認証、`/logout` で切り替えができます。

## 参考情報: トークン / AI Credit を抑えるコツ
Duration: 10

Copilot Business は AI Credits（UBB: 使用量ベース課金）で動きます。次の演習に入る前に、**消費を抑えながら品質を上げる**ための要点を読み物として押さえておきましょう。以下は GitHub のウェビナー「エージェントの品質とトークンの最適化」の要約です。

### 1. モデルは「必要十分」で選ぶ
- 計画・設計・デバッグなど高い推論が要る作業: Opus / GPT-5.5 系
- 通常の実装: Sonnet / GPT-5.4 系
- 小さなリファクタ・反復作業・ドキュメント更新: Haiku / mini 系
- 迷ったら **Auto Mode** を基本に

### 2. コンテキストは入れすぎない
- 入るからといって埋めない。モデルは先頭と末尾を重視し、**中盤は抜けやすい**（Context Rot）
- 新しいタスクは `/clear`、長いセッションは `/compact` を慎重に使う
- 必要な文脈だけ与え、不要な情報は足さない

### 3. プロンプトで迷わせない
- 具体的に、背景・理由も添えて指示する
- 「X なら停止」のように**停止条件**を書く
- 調査 → 計画 → 実装と作業を分割する（この後の演習がまさにこの形です）

### 4. 失敗を減らす仕組みを入れる
- エージェントの失敗は後続で積み上がる。テスト・リンター・スキャンなど決定論的なガードレールを置く
- 繰り返すミスは簡潔な `copilot-instructions.md` に反映する

### 参考リンク
- [Copilot のモデルと課金](https://docs.github.com/en/copilot/reference/copilot-billing/models-and-pricing)
- [モデル比較（Artificial Analysis）](https://artificialanalysis.ai/models?intelligence-index-cost=intelligence-index-cost)
- [Context Rot とは](https://www.producttalk.org/context-rot/)
- [トークン最適化 Tips 集（シナリオ別）](https://ashy-dune-0b4215a0f.7.azurestaticapps.net/detailed/index.html#/scenarios)
- [トークン最適化ウェビナー（レコーディング）](https://github.ondemand.goldcast.io/on-demand/04d8b78c-7149-48df-91a1-68029e126c4a?utm_medium=email&utm_source=ent&utm_campaign=701Kg000000Pj6vIAC)
- [シェル出力を抑えるツール例 rtk](https://github.com/rtk-ai/rtk)
- [複数ツール呼び出しをまとめる Copilot CodeAct Plugin](https://github.com/jsturtevant/copilot-codeact-plugin)

> aside positive
> 実利用に基づく削減アドバイスは、Copilot App / CLI で `/chronicle cost-tips` を実行すると得られます（最後の演習で実際に使います）。ポイントを一言でいえば「**適切なモデル × 余計な文脈を入れない × 作業を分割する**」。次の演習では、これを実際の開発フローで体験します。

## 演習: トークン最適なタスク管理ツールの開発
Duration: 3

ここからが本日の演習です。**GitHub Copilot App** を使って、小さな CLI タスク管理ツールを「調査 → 要件 → 計画 → 実装」の順で、**トークンを最適化しながら**作ります。

### なぜ「ローカルで状態管理」なのか

GitHub Issues / Pull Request を起点にする issue-driven 開発は強力ですが、社内ポリシーやリポジトリ権限の都合で**使えない場面**があります。そこで本演習では、各フェーズの成果物を以下のように**ローカルファイル**として残し、それ自体を開発の「状態（state）」として扱います。

```
your-project/
├── research.md      ← フェーズ1: 調査結果
├── spec.md          ← フェーズ2: 実装要件
└── plan/
    ├── task.md      ← フェーズ3: 大タスク
    ├── 1.md         ← 小タスク（実装順）
    ├── 2.md
    └── 3.md
```

> aside positive
> ポイントは **1フェーズ = 1セッション**。フェーズが終わったら成果物をファイルに保存し、`/clear`（または新しいセッションを開く）でコンテキストをリセットして次に進みます。こうするとコンテキストが汚れず、トークン消費も抑えられ、各フェーズの責務が明確になります。

### 作るもの（題材）

依存ゼロに近い**シンプルな CLI タスク管理ツール**を作ります。タスクの追加・一覧・完了・削除ができ、データはローカルの JSON ファイルに保存する、それだけの小さなアプリです。題材を小さくすることで、**作る対象ではなく「進め方」**に集中できます。

## フェーズ1: 調査（research.md）
Duration: 8

最初の調査フェーズは **Copilot CLI** で行います。Copilot App 画面の**右上から Terminal を開き**、`copilot` で CLI を起動します。

```bash
copilot
```

起動したら、`/model` で **Claude Opus 4.8** を選択します。高い推論力で調査・設計の土台を作るフェーズです。

```
/model
```

次に、`/research` コマンドで調査を依頼します。`/research` は、Web やコードベースを横断的に調べて結果をまとめる調査専用のコマンドです。

```
/research 依存を最小にした CLI タスク管理ツールを作りたいです。Python と Node.js の素の標準ライブラリだけで実装する場合の、それぞれの長所・短所、ファイル保存（JSON）の扱い方、CLI 引数のパース方法を比較してください。実装はまだしないでください。
```

調査結果が返ってきたら、**VS Code で内容を確認**します。納得できる内容であれば、CLI に保存を依頼します。

```
今の調査結果を research.md に保存してください。
```

保存できたら、このフェーズは完了です。セッションをクリアして状態をリセットします。

```
/clear
```

> aside positive
> ここで一度クリアするのが肝心です。「調査」という役割を終えたコンテキストを次に持ち込まないことで、要件フェーズがクリーンな状態で始められます。

## フェーズ2: 要件定義（spec.md）
Duration: 8

新しいセッションを開き、`research.md` をもとに実装要件をまとめます。要件作成・検証・保存まで**1つのプロンプト**で依頼します。

`/rubber-duck` は、原作者が気づきにくい論理の穴・抜け漏れ・設計の矛盾を指摘してくれる検証専用のコマンドです。

```text
@research.md を読んで、CLI タスク管理ツールの実装要件（spec）を作成してください。対象ユーザー、機能要件（追加・一覧・完了・削除）、データ形式、CLI コマンド仕様、非機能要件、対象外（やらないこと）を明記してください。要件を /rubber-duck で検証し、反映した内容を spec.md に保存してください。
```

保存できたら、**新しいセッションを開いて**次のフェーズに進みます。

> aside positive
> **rubber-duck のコツ**: 「厳しくレビューして」と添えると、より踏み込んだ指摘が得られます。指摘を鵜呑みにせず、自分で取捨選択することも大切です。

## フェーズ3: 計画（plan/ ディレクトリ）
Duration: 7

また新しいセッションを開き、調査と要件をもとに実装計画を立てます。計画作成と `/rubber-duck` 検証を**1つのプロンプト**で依頼します。

```text
@research.md と @spec.md をもとに、CLI タスク管理ツールの実装計画を作成してください。

- 大タスクと小タスクに分解する
- 実装順序を決める
- 各タスクのブロッカー（依存・前提）を明記する
- 各タスクのテストの成功条件と失敗条件を明記する

成果物は plan/ ディレクトリに保存してください。大タスクは plan/task.md に、小タスクは plan/1.[このファイルがどんな計画かわかる名前].md, plan/2.[同上].md, plan/3.[同上].md ... のように、実装順のインデックスと内容のわかるファイル名を付けて1ファイルずつ作成してください。

最後に作成した計画を /rubber-duck で検証してください。
```

保存できたら、**新しいセッションを開いて**次のフェーズに進みます。

> aside negative
> 計画フェーズの品質が、実装フェーズの成否をほぼ決めます。テストの「成功条件・失敗条件」が各小タスクに明記されているか、必ず VS Code で確認してから次に進みましょう。

## フェーズ4: 実装（Autopilot + サブセッション）
Duration: 10

いよいよ実装です。Copilot App で新しいセッションを開き、モデルを **Claude Sonnet 4.6** に切り替え、**Autopilot モード**にします（Autopilot では確認なしで自律的にファイル作成・編集・コマンド実行が進みます）。

次のように、計画に沿った実装をまとめて依頼します。

```text
@plan/task.md と @plan/ 配下の小タスク（1.md, 2.md, ...）に従って、CLI タスク管理ツールを実装してください。

各小タスクは MAI-Code-1-Flash モデルのサブセッションで実装してください。実装順序を守り、各タスクのテストの成功条件を満たしていることを確認しながら、すべてのタスクが完了するまで進めてください。
```

> aside positive
> **ローカル LLM を試してみたい方は**、サブセッションの実行を LiteLLM 経由の BYOK モデルに指定してみてください。

ここでのポイントは **役割分担**です。

- **親セッション（Sonnet 4.6 / Autopilot）**: 計画全体を統括し、タスクの進行を管理する
- **サブセッション（MAI-Code-1-Flash または LiteLLM 経由の BYOK モデル）**: 個々の小タスクを高速・低コストに実装する

> aside positive
> 軽量で高速な MAI-Code-1-Flash（または手元の BYOK モデル）を「実装の手」として小タスクに割り当て、推論力の高い Sonnet 4.6 を「司令塔」にすることで、**速度・コスト・品質のバランス**を取ります。これが、用途に応じてモデルを使い分ける実践例です。

実装が進む間は、VS Code でファイルの変化を眺めてみましょう。`plan/` の各タスクが1つずつ消化されていく様子が、ローカルの「状態」が前進していく感覚そのものです。

つまずいた場合は、次を試します。

- エラーメッセージをそのまま貼って「これを直して」と伝える
- うまくいかない小タスクだけ別モデルで再実行する
- `plan/` の該当タスクのテスト条件を見直す

### 動作を確認する

すべてのタスクが完了したら、実際にアプリを起動して挙動を確かめましょう。

```text
実装した CLI タスク管理ツールを実際に起動して、タスクの追加・一覧・完了・削除がひと通り動作することを確認してください。動かない箇所があれば修正してください。
```

ターミナルで自分でもコマンドを叩いてみて、データがローカルファイルに保存され、再起動しても状態が残ることを確かめると、「ローカルで状態を管理する」感覚がより掴めます。

## フェーズ5: コストを振り返る
Duration: 4

実装が一区切りしたら、今回の演習で**どれくらいトークンを消費し、いくらかかったか**を振り返ります。Copilot のセッション履歴は `~/.copilot/data.db` に記録されているので、これを Copilot 自身に集計してもらいましょう。

実装に使ったセッションで、次のように依頼します（`[ご自身のプロジェクト]` は自分の作業フォルダ名に置き換えてください）。

```text
~/.copilot/data.db の session テーブルを参照して、[ご自身のプロジェクト] 上で行ったすべてのセッションで使用したトークン数を計測し、価格表に合わせて金額も算出してください。
https://docs.github.com/en/copilot/reference/copilot-billing/models-and-pricing
```

モデルごとのトークン数と概算コストが出てきます。フェーズごとにセッションを分けたことが、どうコンテキスト消費に効いたかを確認しましょう。

### 次のステップ: /chronicle cost-tips

最後に、コスト最適化のヒントをまとめて確認できる `/chronicle cost-tips` を実行してみましょう。

```text
/chronicle cost-tips
```

表示されるヒントと、今回の集計結果・フェーズごとにセッションを分けた実践を照らし合わせると、どこでトークンを節約できたかが具体的に見えてきます。

> aside positive
> **本演習の学び**: 「調査 → 要件 → 計画 → 実装」を**フェーズごとにセッションを分け、成果物をローカルファイルに残す**ことで、issue-driven が使えない環境でも状態を管理しながら AI 駆動開発を進められます。モデルの使い分け（Opus 4.8 で設計、Sonnet 4.6 で統括、MAI-Code-1-Flash / BYOK で実装）と rubberduck による検証が、品質とコストの両立を支えます。

## おめでとうございます 🎉
Duration: 5

1 時間お疲れさまでした。本日は次を体験しました。

1. Copilot App / CLI の基本操作とトークン最適化の考え方
2. `/research` を使った調査と research.md への保存
3. `/rubber-duck` で検証しながらの要件定義（spec.md）と計画（plan/）
4. Autopilot + サブセッション（MAI-Code-1-Flash / BYOK）による実装
5. `~/.copilot/data.db` を使ったトークン・コストの振り返りと `/chronicle cost-tips`

これらを通じて、issue-driven が使えない環境でも **ローカルファイルを「状態」として spec-driven 開発を進める**流れを体験しました。

### トライアルライセンス施策のご案内
876 Enterprise の Copilot ライセンスをお持ちでない方向けに、**期間限定の GitHub Copilot Business トライアル（3000 AI Credits）** を用意しています。Web フォーム申請で自動付与、先着順で定員を順次拡大します。本日の課題を実施し、後日の事後アンケートにご回答ください。

### リソース
- [GitHub Copilot Documentation](https://docs.github.com/copilot)
- [GitHub Copilot ベストプラクティス](https://docs.github.com/copilot/using-github-copilot/best-practices-for-using-github-copilot)

質疑応答（17:45-17:55）で何でもお尋ねください。ありがとうございました！
