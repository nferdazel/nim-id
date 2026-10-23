#import "@preview/orange-book:0.7.1": book, chapter, appendices, part-change
#import "@preview/orange-book:0.7.1": (
  part-state,
  part-location,
  part-counter,
  main-color-state,
  appendix-state,
)

// ===========================================================================
//  Print layout — "Dasar Pemrograman Nim" (id) and "Learning Nim" (en).
//
//  One file for both editions. The direction is DESIGN.md: quiet editorial
//  pages, identity carried by type and hairlines instead of colour or
//  decoration, safe in black-and-white print, no external fonts, no images.
//
//  Trim 178 x 233 mm. The inner margin is wider than the outer one so the
//  binding has room; the folio lives at the foot and nowhere else.
// ===========================================================================

// --- Palette (DESIGN.md) ---------------------------------------------------
#let ink = rgb("#1a1c1f")         // body text
#let ink-soft = rgb("#4a4e55")    // running heads, captions, metadata
#let accent = rgb("#1f3a5f")      // chapter numbers, opening rules, links
#let rule = rgb("#d8d3c6")        // separators; never a block of colour
#let code-paper = rgb("#f4f1ea")  // code panel, one step off the paper
#let panel-fill = rgb("#f1f3f5")  // fill pandoc's syntax highlighter paints

// --- Book metadata ---------------------------------------------------------
#let doc-title = [$title$]
#let doc-subtitle = [$subtitle$]
#let doc-author = "$for(by-author)$$it.name.literal$$sep$, $endfor$"
#let doc-date-str = "$date$"
#let doc-lang = "$lang$"

// Month names are listed here instead of taken from a locale: Typst ships
// month names for English only, and this book is published in two languages.
#let months-id = (
  "Januari", "Februari", "Maret", "April", "Mei", "Juni",
  "Juli", "Agustus", "September", "Oktober", "November", "Desember",
)
#let months-en = (
  "January", "February", "March", "April", "May", "June",
  "July", "August", "September", "October", "November", "December",
)

// Numeric-only test spelled out instead of via regex: this file is also a
// Pandoc template, where a lone dollar sign starts a variable.
#let human-date = (value, months) => {
  if value == "" { return "" }
  let parts = value.split("-")
  let numeric = (p) => p.len() > 0 and p.clusters().all(c => c in "0123456789")
  if parts.len() == 3 and parts.all(numeric) {
    str(int(parts.at(2))) + " " + months.at(int(parts.at(1)) - 1) + " " + parts.at(0)
  } else {
    value
  }
}

#let doc-date = human-date(doc-date-str, if doc-lang == "id" { months-id } else { months-en })

// Book version, read from the _variables.yml that tools/gen-version.sh writes
// from VERSION before every render.
#let doc-version = yaml("_variables.yml").at("version", default: "")

#let edition-label = if doc-lang == "id" { "Edisi Bahasa Indonesia" } else { "English edition" }
#let version-word = if doc-lang == "id" { "Versi" } else { "Version" }
#let license-line = if doc-lang == "id" {
  [Teks buku: CC BY-SA 4.0 · Kode contoh: MIT]
} else {
  [Book text: CC BY-SA 4.0 · Code samples: MIT]
}
#let doc-keywords = if doc-lang == "id" {
  ("Nim", "pemrograman", "buku", "bahasa Indonesia", "dasar pemrograman Nim")
} else {
  ("Nim", "programming", "book", "English", "learning Nim")
}

// --- Cover -----------------------------------------------------------------
// Pure type and two hairlines: a title, a rule pair, the edition, the author,
// and the version. No image, no colour field (DESIGN.md, "Halaman depan").
#let cover-page = block(width: 178mm, height: 233mm, fill: white)[
  #set text(fill: ink)
  #place(top + left, block(width: 178mm)[
    #v(30mm)
    #pad(x: 24mm)[
      #text(size: 8.5pt, tracking: 0.16em)[#upper(edition-label)]
      #v(3.5mm)
      #line(length: 100%, stroke: 0.5pt + rule)
      #v(15mm)
      #text(size: 29pt, weight: "bold")[#doc-title]
      #v(5mm)
      #line(length: 62mm, stroke: 2pt + accent)
      #v(1.4mm)
      #line(length: 62mm, stroke: 0.6pt + rule)
      #v(7mm)
      #text(size: 13pt, style: "italic", fill: ink-soft)[#doc-subtitle]
    ]
  ])
  #place(bottom + left, block(width: 178mm)[
    #pad(x: 24mm, bottom: 26mm)[
      #line(length: 100%, stroke: 0.5pt + rule)
      #v(5mm)
      #grid(
        columns: (1fr, auto),
        align: (left, right),
        text(size: 12pt)[#doc-author],
        text(size: 9pt, fill: ink-soft)[#version-word #doc-version],
      )
      #v(2mm)
      #text(size: 8.5pt, fill: ink-soft)[#license-line]
    ]
  ])
]

// --- Inner title page ------------------------------------------------------
// Sits on the verso of the cover, before the table of contents, and carries
// the colophon at its foot: version, date, and the two licences.
#let front-page = [
  #place(top + center, block(width: 100%)[
    #v(42mm)
    #set align(center)
    #text(size: 9pt, tracking: 0.16em, fill: ink-soft)[#upper(edition-label)]
    #v(6mm)
    #text(size: 22pt, weight: "bold")[#doc-title]
    #v(2mm)
    #line(length: 48mm, stroke: 1.2pt + accent)
    #v(5mm)
    #text(size: 12pt, style: "italic", fill: ink-soft)[#doc-subtitle]
    #v(10mm)
    #text(size: 12pt)[#doc-author]
  ])
  #v(24mm)
  #align(center)[
    #text(size: 8.5pt, fill: ink-soft)[
      #version-word #doc-version · #doc-date \
      #license-line
    ]
  ]
]


// ---------------------------------------------------------------------------
// Table of contents, level 1
//
// Orange-book draws a part as a grey bar with a roman numeral, which would sit
// next to titles that already say "Bagian 0" to "Bagian C". The part appears as
// a small label instead; chapters keep their number, dot leaders, and folio.
// ---------------------------------------------------------------------------
#show outline.entry.where(level: 1): it => {
  context {
    let loc = it.element.location()
    let numbered = it.element.numbering != none
    let num = if numbered {
      numbering(
        if appendix-state.at(loc) != none { "A" } else { "1" },
        counter(heading).at(loc).first(),
      )
    } else { none }
    let row = link(loc, grid(
      columns: (1.4cm, 1fr, auto),
      align: (left, left, right),
      text(size: 10pt, weight: "bold", fill: accent)[#if numbered [#num]],
      text(size: 10pt, weight: if numbered { "bold" } else { "regular" })[
        #it.element.body #box(width: 1fr, repeat(text(fill: rule)[. #h(3pt)]))
      ],
      text(size: 10pt)[#it.page()],
    ))
    if part-change.at(loc) {
      [
        #v(12pt)
        #text(size: 8.5pt, tracking: 0.12em, fill: ink-soft)[#upper(part-state.at(loc))]
        #v(3pt)
        #row
      ]
    } else { row }
  }
}

// ---------------------------------------------------------------------------
// Chapter opening
//
// Orange-book draws the title in a panel three centimetres wider than the text
// block, so long chapter titles run off the trim. This draws the shape DESIGN.md
// asks for instead: a small label, the title, and one hairline.
//
// Two rules are needed. The table of contents is built before the book body, so
// its own title is caught by the first rule, which must not break the page (the
// title sits inside a block, where Typst forbids a page break). Chapters arrive
// later and get the second rule.
// ---------------------------------------------------------------------------
#let chapter-opening(it, break-page: false) = {
  if break-page { pagebreak(to: "odd") }
  part-change.update(x => false)
  counter(figure.where(kind: image)).update(0)
  counter(figure.where(kind: table)).update(0)
  counter(math.equation).update(0)
  block(above: 0pt, below: 0pt)[
    #v(14mm)
    #if it.numbering != none [
      #context {
        let n = str(counter(heading).display(it.numbering)).trim(".").trim()
        let word = if appendix-state.at(here()) != none {
          if doc-lang == "id" { "Lampiran" } else { "Appendix" }
        } else if doc-lang == "id" { "Bab" } else { "Chapter" }
        text(size: 8.5pt, tracking: 0.16em, fill: ink-soft)[#upper(word) #n]
      }
      #v(3.5mm)
    ]
    #text(size: 23pt, weight: "bold", hyphenate: false)[#it.body]
    #v(5mm)
    #block(width: 100%, line(length: 100%, stroke: 0.5pt + rule))
    #v(7mm)
  ]
}

// Page numbering is drawn by the footer rule below, not by Quarto: the cover
// and the front matter carry no folio. This must be set before the book is
// built, because its own pages are created inside `book` and would otherwise
// already carry a number.
#set page(numbering: none)

#show: book.with(
  width: 178mm,
  height: 233mm,
  // Inner margin carries the binding, the outer one stays smaller; the top is
  // tight so the running head sits close to the text block.
  margin: (inside: 32mm, outside: 27mm, top: 21mm, bottom: 25mm),
  font-size: 11pt,
  // Space between paragraphs, no first-line indent (DESIGN.md): with an indent
  // and this spacing together the start of a paragraph becomes ambiguous.
  first-line-indent: false,
  // The cover and the inner title page are drawn in full above, so the
  // built-in title block stays empty (and invisible).
  title: "",
  subtitle: "",
  author: "",
  date: "$date$",
  lang: "$lang$",
  main-color: accent,
  logo: {
    let logo-info = brand-logo.at("medium", default: none)
    if logo-info != none { image(logo-info.path, alt: logo-info.at("alt", default: none)) }
  },
$if(toc-depth)$
  outline-depth: $toc-depth$,
$endif$
$if(quarto.language.crossref-ch-prefix)$
  supplement-chapter: "$quarto.language.crossref-ch-prefix$",
$endif$
  // Part openings are drawn by the rule below, not by orange-book: its default
  // fills the page with a tinted field, which conflicts with the black-and-white
  // brief in DESIGN.md. Only the chapter list from the package is kept.
  part-font-size: 6em,
  outline-small-depth: 1,
  cover-background: rgb(0, 0, 0, 0),
  cover: cover-page,
  copyright: front-page,
)

// ---------------------------------------------------------------------------
// Chapter opening
//
// Orange-book draws the title in a panel three centimetres wider than the text
// block, so long chapter titles run off the trim. This replaces it with the
// shape DESIGN.md asks for: a small chapter label, the title, and one hairline.
// The heading element itself stays in place, so the outline and the running
// head keep working.
// ---------------------------------------------------------------------------
#show heading.where(level: 1): it => chapter-opening(it, break-page: true)

// ---------------------------------------------------------------------------
// Part opening
//
// A quiet page: the part title, a hairline, and the chapters it contains.
// No colour field, no roman numeral (the titles already carry "Bagian 0" to
// "Bagian C", so a second number would only contradict them).
// ---------------------------------------------------------------------------
#let part(title) = {
  pagebreak(to: "odd")
  part-change.update(x => true)
  part-state.update(x => title)
  part-counter.step()
  [
    #context {
      let her = here()
      part-location.update(x => her)
    }
    #context {
      set par(justify: false)
      v(34mm)
      text(size: 24pt, weight: "bold", hyphenate: false)[#part-state.get()]
      v(5mm)
      line(length: 100%, stroke: 0.5pt + rule)
      v(10mm)
      let chapters = query(heading.where(level: 1)).filter(it =>
        it.numbering != none and part-state.at(it.location()) == title)
      for hn in chapters {
        let num = numbering("1", counter(heading).at(hn.location()).first())
        link(hn.location(), grid(
          columns: (1.1cm, 1fr, auto),
          align: (left, left, right),
          text(size: 9.5pt, fill: accent, weight: "bold")[#num],
          text(size: 9.5pt)[#hn.body #box(width: 1fr, repeat(text(size: 9.5pt, fill: rule)[. #h(3pt)]))],
          text(size: 9.5pt)[#hn.location().page()],
        ))
        v(3mm)
      }
    }
  ]
}

// ---------------------------------------------------------------------------
// Running head and folio
//
// One number per page, at the foot. Orange-book also prints a number inside
// the header, so the header is rebuilt here to carry the running head alone:
// the book title on the left-hand pages, the chapter title on the right-hand
// ones. A chapter opening carries neither.
// ---------------------------------------------------------------------------
#set page(header: context {
  let pn = counter(page).at(here()).first()
  // Part openings carry the field and the numeral; no running head on top.
  if part-change.at(here()) { return }
  let openers = query(heading.where(level: 1))
  // A chapter that starts on this page needs no running head.
  if openers.any(it => it.location().page() == pn) { return }
  // Running heads belong to the numbered main matter: front matter and the
  // table of contents come before the first numbered chapter.
  let numbered = openers.filter(it => it.numbering != none and it.location().page() < pn)
  if numbered.len() == 0 { return }
  let recto = calc.odd(pn)
  let label = if recto { numbered.last().body } else { doc-title }
  set text(size: 8.5pt, fill: ink-soft)
  block(
    width: 100%,
    inset: (bottom: 4pt),
    stroke: (bottom: 0.4pt + rule),
    align(if recto { right } else { left }, label),
  )
})

// ---------------------------------------------------------------------------
// Folio
//
// Quarto prints the page number with `numbering`, which also puts it on the
// cover, the title page, and the table of contents. The number is drawn here
// instead, so it starts with the first numbered chapter and appears nowhere
// else. Part openings and chapter openings keep their folio; only the front
// matter loses it.
// ---------------------------------------------------------------------------
#set page(
  numbering: none,
  footer: context {
    let pn = counter(page).at(here()).first()
    let numbered = query(heading.where(level: 1)).filter(it => it.numbering != none)
    if numbered.len() == 0 { return }
    if pn < numbered.first().location().page() { return }
    set text(size: 8.5pt, fill: ink-soft)
    align(center, numbering("1", pn))
  },
)
//
// Ragged right on purpose: justified text at this measure would open rivers
// of space (DESIGN.md). Hyphenation stays on so the ragged edge does not
// wander too far.
// ---------------------------------------------------------------------------
#show par: set par(
  justify: false,
  leading: 0.72em,
  spacing: 1.05em,
  first-line-indent: 0pt,
)

// ---------------------------------------------------------------------------
// Headings, levels 2 to 4
//
// Level 1 is the chapter opening, drawn above. Levels 2 to 4 share
// one shape: a bold title with the number hanging in the margin, in the
// accent colour. `sticky` keeps a heading with the text it introduces.
// ---------------------------------------------------------------------------
#show heading.where(level: 2): it => {
  set text(size: 1.32em, weight: "bold")
  let number = if it.numbering != none {
    let n = counter(heading).display(it.numbering)
    place(dx: -measure(n).width - 5mm, text(fill: accent)[#n])
  }
  block(above: 1.7em, below: 0.6em, sticky: true, number + it.body)
}

#show heading.where(level: 3): it => {
  set text(size: 1.15em, weight: "bold")
  let number = if it.numbering != none {
    let n = counter(heading).display(it.numbering)
    place(dx: -measure(n).width - 5mm, text(fill: accent)[#n])
  }
  block(above: 1.4em, below: 0.5em, sticky: true, number + it.body)
}

#show heading.where(level: 4): it => {
  set text(size: 1.02em, weight: "bold")
  let number = if it.numbering != none {
    let n = counter(heading).display(it.numbering)
    place(dx: -measure(n).width - 5mm, text(fill: accent)[#n])
  }
  block(above: 1.2em, below: 0.4em, sticky: true, number + it.body)
}

// ---------------------------------------------------------------------------
// Code
//
// Every fenced listing arrives through pandoc's `Skylighting`, which is a
// plain `block` filled with #f1f3f5 — not a block-level `raw`, so the obvious
// `show raw.where(block: true)` rule would never fire. The panel is caught
// here by its fill and redrawn as a warm near-white sheet with a hairline
// border: it survives a black-and-white printer without turning into a grey
// slab, and it never becomes the darkest element on the page. One size for
// every panel — a book does not resize its code from page to page — and long
// lines wrap at spaces, so a listing stays inside the measure and stays
// breakable. Inline code keeps Typst's own 0.8 em, which matches the serif at
// this size.
// ---------------------------------------------------------------------------
#let code-size = 9pt
// `raw` prints at 0.8 em of the text around it, so the ambient size is raised
// until the token glyphs themselves land on `code-size`.
#let code-panel-size = code-size * 1.25

#show block: it => {
  if it.fill == panel-fill {
    block(
      fill: code-paper,
      stroke: 0.4pt + rule,
      radius: 2pt,
      inset: (x: 8pt, y: 7pt),
      above: 0.85em,
      below: 0.85em,
      width: 100%,
      text(size: code-panel-size, it.body),
    )
  } else {
    it
  }
}

// ---------------------------------------------------------------------------
// Tables
//
// Horizontal rules only, no zebra striping (DESIGN.md). The header row is
// bold and keeps its rule; cells get enough padding to breathe, and a wide
// table is allowed to break across pages rather than run off the trim.
// ---------------------------------------------------------------------------
#set table(inset: (x: 6pt, y: 5pt), stroke: none, align: left)
#set table.hline(stroke: 0.5pt + rule)
#show table.header: set text(weight: "bold")

// ---------------------------------------------------------------------------
// Footnotes
// ---------------------------------------------------------------------------
#set footnote(numbering: "1")
#show footnote: set text(size: 0.85em)

// ---------------------------------------------------------------------------
// PDF metadata
//
// The title page passes empty strings to orange-book, so the real metadata is
// set here: title, author, subject, and keywords.
// ---------------------------------------------------------------------------
#set document(
  title: doc-title,
  author: doc-author,
  description: doc-subtitle,
  keywords: doc-keywords,
)

// ---------------------------------------------------------------------------
// Callouts and links
//
// Quarto draws callouts with the palette of the HTML theme (a bright blue box),
// and links inherit Typst's default blue. Both would be the only colour on the
// page, so they are redrawn with the book palette: a paper-toned box, a rule on
// the binding side, and links in the accent colour.
// ---------------------------------------------------------------------------
#let callout(body: [], title: "Callout", background_color: rgb("#dddddd"), icon: none, icon_color: black, body_background_color: white) = {
  block(
    breakable: false,
    fill: code-paper,
    stroke: (left: 2pt + accent, rest: 0.4pt + rule),
    width: 100%,
    radius: 1pt,
    inset: (x: 10pt, y: 8pt),
    block(below: 4pt, text(size: 0.95em, weight: "bold")[
      #if icon != none [#text(fill: accent)[#icon] ]#title
    ]) + block(above: 2pt, body),
  )
}

#show link: set text(fill: accent)
