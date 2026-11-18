# docs/

Source notes for the two editions of the book. Everything here is working material for the author,
not part of the rendered site; the reader-facing text lives in `books/`.

| File | Holds |
|---|---|
| [`plan.md`](plan.md) | The plan the book is written against: what each part delivers and in what order. |
| [`writing-guide.md`](writing-guide.md) | Chapter template, sentence rules, the Definition of Done a chapter must meet. |
| [`glossary.md`](glossary.md) | The canonical term list. Both glossary pages in the books mirror it, and `tools/check-glossary-page.py` compares them. |
| [`publishing-standards.md`](publishing-standards.md) | What a published edition must satisfy, from typography to the PDF. |
| [`release.md`](release.md) | The release procedure: `./task release`, the tag, the attached PDFs. |
| [`deploy-vps.md`](deploy-vps.md) | The VPS setup behind nim.qouver.com: Caddy, the deploy script, rollback. |

The rules a change has to follow are in [`../CONTRIBUTING.md`](../CONTRIBUTING.md); the gates are in
[`../README.md`](../README.md#quality-gates).
