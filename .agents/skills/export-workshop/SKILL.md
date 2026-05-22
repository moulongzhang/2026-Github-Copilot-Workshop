---
name: export-workshop
description: >
  Export Google Codelab HTML from workshop Markdown sources.
  Use after editing workshop.md or workshop-*.md to generate/update the corresponding HTML.
  Trigger on: "export workshop", "generate codelab", "update HTML", "make export",
  "update NRI version", "build DENSO version", "generate custom version",
  "ワークショップをエクスポート", "codelabを生成", "HTMLを更新".
---

# export-workshop

Export Codelab HTML from workshop Markdown sources.

## Prerequisites

- `claat` is pinned via the `tool` directive in `go.mod`
- Export tasks are defined in `Makefile`
- `jq` is required (to read the default version from `versions.json`)

## Source files and output paths

| Type | Source | Output |
|------|--------|--------|
| Standard | `workshop.md` | `github-copilot-workshop/versions/<VERSION>/index.html` |
| Custom | `workshop-<NAME>.md` | `github-copilot-workshop/custom/<NAME>/index.html` |

### Existing custom versions

| NAME | Source file |
|------|------------|
| nri | `workshop-nri.md` |
| denso | `workshop-denso.md` |

## Export commands

### Standard version

Export to the default version (read from `defaultVersion` in `versions.json`):

```bash
make export
```

Specify a version explicitly:

```bash
make export VERSION=v1.0.4
```

### Custom version

```bash
make export-custom NAME=nri
```

## Releasing a new version

1. Run `make export VERSION=<new-version>`
2. Update `github-copilot-workshop/versions.json`:
   - Add the new version to the beginning of the `versions` array
   - Set `defaultVersion` to the new version

## Important rules

- Always run export after editing `workshop.md` or `workshop-*.md` to regenerate the HTML
- Do NOT edit `github-copilot-workshop/index.html` (version selector)
- Do NOT edit `github-copilot-workshop/versions/*/index.html` directly
