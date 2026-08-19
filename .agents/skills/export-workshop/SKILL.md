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
| Alternate track | `workshop-beginner.md` | `github-copilot-workshop/versions/<VERSION>/index.html` (via `SRC=`) |
| Custom | `workshop-<NAME>.md` | `github-copilot-workshop/custom/<NAME>/index.html` |

### Existing custom versions

| NAME | Source file |
|------|------------|
| nri | `workshop-nri.md` |
| denso | `workshop-denso.md` |
| bns | `workshop-bns.md` |

### Version tracks

`versions/` holds two distinct tracks that share the same version selector:

| Version | Source | Content |
|---------|--------|---------|
| v1.0.0 – v1.0.3 | `workshop.md` | Codespaces + Python/Flask pomodoro timer (snapshots over time) |
| v1.0.4 (beginner) | `workshop-beginner.md` | Local machine + GitHub Copilot app + Astro Tailspin Toys |

v1.0.4 is a **separate track**, not a newer snapshot of `workshop.md`. `defaultVersion`
stays at `v1.0.3`; link to the beginner track with `?version=v1.0.4`.

### v1.0.4 companion repository

v1.0.4 uses a Japanese sample app template, not the upstream English one:

**[moulongzhang/2026-Github-Copilot-Workshop-Tailspin-Toys-JA](https://github.com/moulongzhang/2026-Github-Copilot-Workshop-Tailspin-Toys-JA)**

It is a translation of `github-samples/tailspin-toys` (MIT) where the docs,
`.github/instructions`, `.github/skills`, `.github/agents`, and the seeded issue
backlog (`.github/bootstrap-issues`) are Japanese, while the application source
code is unchanged. Participants create their copy with **Use this template** and
name it `tailspin-toys`.

When editing that repo, keep these English:

- frontmatter `name` values (skill and agent identifiers) and `applyTo` globs
- file paths, shell commands, npm script names
- everything under `src/`, `db/`, and `tests/`

Issue titles in `.github/bootstrap-issues/*.md` are quoted verbatim in
`workshop-beginner.md`. Changing a title there means updating the workshop too.

> `workshop-beginner.md` was bootstrapped from the upstream Japanese source with a
> one-off conversion script and is now maintained by hand. Do not regenerate it.

## Export commands

### Standard version

Export to the default version (read from `defaultVersion` in `versions.json`):

```bash
make export
```

Specify a version explicitly:

```bash
make export VERSION=v1.0.5
```

Specify a different source file (defaults to `workshop.md`):

```bash
make export VERSION=v1.0.4 SRC=workshop-beginner.md
```

### Custom version

```bash
make export-custom NAME=nri
```

## Releasing a new version

1. Run `make export VERSION=<new-version>` (add `SRC=<file>` for a non-standard source)
2. Update `github-copilot-workshop/versions.json`:
   - Add the new version to the beginning of the `versions` array
   - Set `defaultVersion` to the new version **only when it is a newer snapshot of the
     same track**. Do not repoint `defaultVersion` at a separate track.

## Important rules

- Always run export after editing `workshop.md` or `workshop-*.md` to regenerate the HTML
- Every source file must keep `id: github-copilot-workshop` in its metadata header —
  the Makefile copies from `temp-export/github-copilot-workshop/`, which claat names after `id`
- Do NOT edit `github-copilot-workshop/index.html` (version selector)
- Do NOT edit `github-copilot-workshop/versions/*/index.html` directly
