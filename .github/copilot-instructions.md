## ファイル編集ルール

- `github-copilot-workshop/index.html` (バージョンセレクター) は編集しないでください
- `github-copilot-workshop/versions/*/index.html` (各バージョンのコンテンツ) も直接編集しないでください
- コンテンツを更新する場合は、必ず `workshop.md` を編集してください

## workshop.mdの更新手順

1. `workshop.md` を編集
2. 以下のコマンドで最新バージョンを更新:

```bash
# 一時フォルダに生成
claat export -o ./temp-export workshop.md

# 最新バージョン番号を設定（例: v1.0.1）
LATEST_VERSION="v1.0.1"

# 最新バージョンフォルダにコピー
cp temp-export/github-copilot-workshop/index.html "github-copilot-workshop/versions/${LATEST_VERSION}/index.html"

# 画像パスを修正（iframe内で正しく表示するため）
sed -i '' 's|src="img/|src="../../img/|g' "github-copilot-workshop/versions/${LATEST_VERSION}/index.html"

# 新しい画像があれば更新
cp -r temp-export/github-copilot-workshop/img/* github-copilot-workshop/img/ 2>/dev/null || true

# 一時フォルダを削除
rm -rf temp-export

echo "✅ ${LATEST_VERSION} の更新が完了しました"
```

3. 新しいバージョンをリリースする場合:
   - 新しいバージョンフォルダを作成（例: `versions/v1.0.2/`）
   - `versions.json` を更新して新バージョンを追加
   - `defaultVersion` を新バージョンに変更

## カスタムバージョン（個社向け）の更新手順

カスタムバージョンは `versions.json` に登録せず、`github-copilot-workshop/custom/` 配下に配置します。
バージョンセレクターには表示されず、直接URLでのみアクセスできます。

### 既存のカスタムバージョン

| 名前 | ソースファイル | URL |
|------|---------------|-----|
| NRI | `workshop-nri.md` | `custom/nri/index.html` |
| DENSO | `workshop-denso.md` | `custom/denso/index.html` |

### カスタムバージョンの更新手順

1. 対応するソースファイル（例: `workshop-nri.md`）を編集
2. 以下のコマンドで更新:

```bash
# カスタム名を設定（例: nri）
CUSTOM_NAME="nri"

# 一時フォルダに生成
claat export -o ./temp-export "workshop-${CUSTOM_NAME}.md"

# カスタムバージョンフォルダにコピー
cp temp-export/github-copilot-workshop/index.html "github-copilot-workshop/custom/${CUSTOM_NAME}/index.html"

# 画像パスを修正（iframe内で正しく表示するため）
sed -i '' 's|src="img/|src="../../img/|g' "github-copilot-workshop/custom/${CUSTOM_NAME}/index.html"

# 新しい画像があれば更新
cp -r temp-export/github-copilot-workshop/img/* github-copilot-workshop/img/ 2>/dev/null || true

# 一時フォルダを削除
rm -rf temp-export

echo "✅ ${CUSTOM_NAME} カスタムバージョンの更新が完了しました"
```

### 新しいカスタムバージョンの作成

1. `workshop.md` をコピーして `workshop-<name>.md` を作成
2. タイトルやコンテンツをカスタマイズ
3. `github-copilot-workshop/custom/<name>/` ディレクトリを作成
4. 上記の更新手順を実行
5. この表に新しいカスタムバージョンを追記