// HELPERS

// https://github.com/typst/typst/discussions/3876
#let to_string(content) = {
  if content.has("text") {
    content.text
  } else if content.has("children") {
    content.children.map(to_string).join("")
  } else if content.has("body") {
    to_string(content.body)
  } else if content == [ ] {
    " "
  }
}

// SETTINGS

#let default_page_settings = (
  paper: "a4", margin: (x: 1.3cm, y: 1.2cm), numbering: none,
  flipped: false,
)

// From typst website
#let link_fg = rgb("#007aff")

#let template(doc) = {
  set page(..default_page_settings)
  set text(size: 1em)
  show link: content => text(fill: link_fg, content)

  show heading: content => text(content, size: 1.25em)
  show heading.where(level: 2): content => align(center, content)
  show heading.where(level: 3): content => align(center, text([
    #content
    #v(0.5em)
  ]))

  doc
}
