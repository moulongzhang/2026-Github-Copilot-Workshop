CODELAB_ID := github-copilot-workshop
OUT_DIR := $(CODELAB_ID)
TEMP_DIR := temp-export

LATEST_VERSION := $(shell jq -r .defaultVersion $(OUT_DIR)/versions.json)

# export-codelab: claat export → コピー → 画像パス修正 → 後片付け
#   $(1) = ソースMarkdown
#   $(2) = 出力先ディレクトリ
define export-codelab
	go tool claat export -o ./$(TEMP_DIR) $(1)
	mkdir -p $(2)
	cp $(TEMP_DIR)/$(CODELAB_ID)/index.html $(2)/index.html
	# -i.bak は macOS (BSD sed) と Linux (GNU sed) の両方で動作するポータブルな書き方
	sed -i.bak 's|src="img/|src="../../img/|g' $(2)/index.html
	$(RM) $(2)/index.html.bak
	cp -r $(TEMP_DIR)/$(CODELAB_ID)/img/* $(OUT_DIR)/img/ 2>/dev/null || true
	$(RM) -r $(TEMP_DIR)
endef

.PHONY: export export-custom

# 最新バージョンのエクスポート: make export
# 別バージョンを指定: make export VERSION=v1.0.4
export: VERSION ?= $(LATEST_VERSION)
export:
	$(call export-codelab,workshop.md,$(OUT_DIR)/versions/$(VERSION))
	@echo "✅ $(VERSION) のエクスポートが完了しました"

# カスタムバージョンのエクスポート: make export-custom NAME=nri
export-custom:
	@test -n "$(NAME)" || (echo "❌ NAME を指定してください (例: make export-custom NAME=nri)" && exit 1)
	$(call export-codelab,workshop-$(NAME).md,$(OUT_DIR)/custom/$(NAME))
	@echo "✅ $(NAME) カスタムバージョンのエクスポートが完了しました"
