---
allowed-tools: Bash(git:*), Bash(mkdir:*), Bash(npm:*), Read(*.md), Fetch(*)
description: "spec-driven development (improved)"
---

あなた（Claude Code）は、以下の5フェーズで“検証可能な成果物”を順に作成・レビューし、承認を得ながら進みます。各フェーズは必ず **Go/No-Go** を明記し、差戻し理由は Change Log に追記してください。

## 共通規約

- ルート: `./.cckiro/specs/<spec-slug>/`
- `<spec-slug>` はケバブケース（例: `create-article-component`）。必要なら `YYYYMMDD-` を先頭付与。
- すべてのファイルは Markdown（YAML front matter 付）で作成。
- 追跡表 `./05-traceability.md` に **要件ID⇄設計ID⇄実装タスク⇄テストID⇄PR/コミット** をリンク。
- 変更は `./06-change-log.md` に記載（日時/フェーズ/変更点/理由/影響/承認者）。
- 各フェーズの成果物は **Definition of Done (DOD)** に合致するまで修正を繰り返す。

### 使用ツール
- 事前に `!mkdir -p ./.cckiro/specs` を実行。作成に失敗したら手順をテキストで提示。  
- `git` コマンドは“推奨例”のみ提示（実行は任意）。コミットメッセージは `<spec-slug>: <summary> (refs: R-001, T-003)` 形式。

---

## 1. 事前準備フェーズ
- ユーザーがタスク概要を伝える。あなたは `<spec-slug>` を提案。
- 実行: `!mkdir -p ./.cckiro/specs` と `!mkdir -p ./.cckiro/specs/<spec-slug>`
- 生成する初期ファイル:
  - `01-requirements.md`（要件）
  - `02-design.md`（設計）
  - `03-implementation-plan.md`（実装計画）
  - `04-test-plan.md`（テスト計画）
  - `05-traceability.md`（追跡表）
  - `06-change-log.md`（変更履歴）
  - `07-decisions.md`（意思決定ログ/ADR）
- DOD:
  - ディレクトリと空ファイルが作成済み
  - `<spec-slug>` が妥当（簡潔・一意）

---

## 2. 要件フェーズ（01-requirements.md）
- タスク概要を検証可能な要件へ分解。各要件は `R-001` 形式でID付与。
- 種別: 機能 / 非機能（性能・セキュリティ・運用・i18n・可観測性 等）
- 受け入れ基準（Given/When/Then または箇条書き）
- 想定外/除外事項（Out of Scope）
- リスクと前提条件
- 出力後、ユーザーに可否を確認。No-Go時は修正して再提示。
- DOD:
  - すべての要件が検証可能
  - 非機能要件が最低1項目ずつ定義
  - 受け入れ基準が明確
  - Traceabilityに要件IDが登録

---

## 3. 設計フェーズ（02-design.md）
- 要件を満たす構造/インタフェース/データモデル/失敗時動作/境界条件を記述。
- 図はテキストで（簡易シーケンスや表）。外部依存とバージョン上限も明示。
- DOD:
  - 各 `R-*` に対応する `D-*` 設計要素がある
  - エラーハンドリング/リトライ/ログ方針が記載
  - パフォーマンスとセキュリティの設計配慮が記載
  - Traceability更新済み

---

## 4. 実装計画フェーズ（03-implementation-plan.md, 04-test-plan.md）
- 実装タスク分解（`I-001`…）：粒度、見積り、担当（未定可）、依存関係。
- ロールバック/フラグ/段階的リリース方針があるとなお良い。
- テスト計画（`T-001`…）：ユニット/E2E/非機能（負荷/セキュリティ）と合否条件。
- DOD:
  - すべての `D-*` に対する実装タスクがある
  - 主要リスクと回避策が書かれている
  - テストが受け入れ基準と1:1以上で対応
  - Traceability更新済み

---

## 5. 実装フェーズ
- 実装は「要件」「設計」「実装計画」に従う。逸脱時は要件へ逆流して更新→Change Logに記録。
- 最小単位でPR。PR記述に要件/テストIDをリンク。
- DOD（完了の定義）:
  - すべてのテストが合格
  - 受け入れ基準を満たすデモ/サンプルが存在
  - ドキュメント（README/使用方法/制限）が更新
  - Traceabilityにコミット/PRが反映

---

## レビューの進め方（各フェーズ共通）
- 出力後に「レビュー観点チェックリスト」を提示
- ユーザーがOKなら「Go」と明言。差戻しは「No-Go + 修正点」で返す
- あなたは Change Log と Traceability を必ず更新してから次へ進む
