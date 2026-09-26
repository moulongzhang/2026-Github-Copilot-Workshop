CODELAB_ID := github-copilot-workshop
OUT_DIR := $(CODELAB_ID)
TEMP_DIR := temp-export
CODELAB_ASSET_DIR := assets/codelab-elements
CODELAB_ASSET_PREFIX := ../../$(CODELAB_ASSET_DIR)

LATEST_VERSION := $(shell jq -r .defaultVersion $(OUT_DIR)/versions.json)

define rewrite-codelab-runtime
	sed -i.bak \
		-e 's|https://storage.googleapis.com/claat-public/codelab-elements.css|$(CODELAB_ASSET_PREFIX)/codelab-elements.css|g' \
		-e 's|https://storage.googleapis.com/claat-public/native-shim.js|$(CODELAB_ASSET_PREFIX)/native-shim.js|g' \
		-e 's|https://storage.googleapis.com/claat-public/custom-elements.min.js|$(CODELAB_ASSET_PREFIX)/custom-elements.min.js|g' \
		-e 's|https://storage.googleapis.com/claat-public/prettify.js|$(CODELAB_ASSET_PREFIX)/prettify.js|g' \
		-e 's|https://storage.googleapis.com/claat-public/codelab-elements.js|$(CODELAB_ASSET_PREFIX)/codelab-elements.js|g' \
		$(1)
	$(RM) $(1).bak
endef

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
	$(call rewrite-codelab-runtime,$(2)/index.html)
	cp -r $(TEMP_DIR)/$(CODELAB_ID)/img/* $(OUT_DIR)/img/ 2>/dev/null || true
	$(RM) -r $(TEMP_DIR)
endef

.PHONY: export export-custom fix-codelab-runtime

# 最新バージョンのエクスポート: make export
# 別バージョンを指定: make export VERSION=v1.0.5
# 別ソースを指定: make export VERSION=v1.0.4 SRC=workshop-beginner.md
export: VERSION ?= $(LATEST_VERSION)
export: SRC ?= workshop.md
export:
	$(call export-codelab,$(SRC),$(OUT_DIR)/versions/$(VERSION))
	@echo "✅ $(VERSION) のエクスポートが完了しました ($(SRC))"

# カスタムバージョンのエクスポート: make export-custom NAME=nri
export-custom:
	@test -n "$(NAME)" || (echo "❌ NAME を指定してください (例: make export-custom NAME=nri)" && exit 1)
	$(call export-codelab,workshop-$(NAME).md,$(OUT_DIR)/custom/$(NAME))
	@echo "✅ $(NAME) カスタムバージョンのエクスポートが完了しました"

# 既存の生成済みHTMLを、リポジトリ内に固定したCodelabsランタイムへ切り替える
fix-codelab-runtime:
	@for file in $(OUT_DIR)/versions/*/index.html $(OUT_DIR)/custom/*/index.html; do \
		sed -i.bak \
			-e 's|https://storage.googleapis.com/claat-public/codelab-elements.css|$(CODELAB_ASSET_PREFIX)/codelab-elements.css|g' \
			-e 's|https://storage.googleapis.com/claat-public/native-shim.js|$(CODELAB_ASSET_PREFIX)/native-shim.js|g' \
			-e 's|https://storage.googleapis.com/claat-public/custom-elements.min.js|$(CODELAB_ASSET_PREFIX)/custom-elements.min.js|g' \
			-e 's|https://storage.googleapis.com/claat-public/prettify.js|$(CODELAB_ASSET_PREFIX)/prettify.js|g' \
			-e 's|https://storage.googleapis.com/claat-public/codelab-elements.js|$(CODELAB_ASSET_PREFIX)/codelab-elements.js|g' \
			"$$file"; \
		$(RM) "$$file.bak"; \
	done
