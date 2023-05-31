# CSS notes

## Common properties
- `background-color`
- `font-size`
- `color`
- `font-family`
- `text-decoration` : underline, none
- `font-style` : italic
- `text-transform` : uppercase
- `font` : italic bold 20px/2.5 Verdana, "Trebuchet MS", Tahoma, sans-serif;

## Selectors
- descendent vs **direct** descendent: [^1]
  - `main ul li` would select all `li` that are a *descendent* of `ul` that are a *descendent* of `main`
  `main ul > li` would select only `li` that are a direct child of `ul` and nothing else (i.e., no further nested ordered lists)
  - see Challenge problem solution on practice problems [^1]

## Box model
- `display: inline` : Inline Elements [^2]
  - `width` and `height` are based on content
  - margins: `left` and `right` work (`top` and `bottom` are ignored)
  - padding, borders: all work
- `display: inline-block` : act like `block` elements, but do NOT take up an entire row - they flow like `inline` elements from 1 line to the next [^2]
  - width will be based on content (not `width` property)
  - can also apply `vertical-align` (top, middle, bottom)
- CANNOT nest `block` or `inline-block` inside `inline` elements [^2]
- `content-box` : the default box-model; does not include the padding or borders in width and height [^5]q6
- `img` elements are `inline` by default [^6]

## Margin / Padding
- top   |      left & right      |   bottom
- top   |   right   |   bottom   |   left
-    top & bottom   |   left & right
- Padding vs Margins: [^3]
  - padding is PART of the clickable area of an object;  margin is *not*
  - *top & bottom* margins will collapse (take the greater value of either, not add them together), but *not* left & right
  - padding does *not* collapse
  - potential approaches: [^3]
    - within a container, use padding for horizontal separation, use margins for vertical distance
    - OR use margins everywhere unless you need padding

## ems vs rems
- ems are based on the *calculated* (current) font size - they "compound" if the font size changes in nested elements [^4]
- rems are baesd on the *root* (font size defined in html element) - they remain consistent [^4]
  - older browsers may not recognize `rem`s - use a fallback: [^4]
    ```css
    p {
      font-size: 20px; font-size: 1.25rem; /* accepted fallback formatting */
    }
    ```
    - note: most older browsers assume a 16px default font-size; hence 1.25rem would be 20px

## `auto`
- means different things depending on usage [^4]
  - when used for `width` or `height` : fits entire element incl. margins in its container
  - when used for left or right `margin`: will push element all the way to right or left, respectively (i.e,. to *opposite* side)
  - when used for top or bottom `margin` : will be `0`
  - cannot be used for `padding`
- vs 100% [^4]
  - `width: auto` : fits everything (incl. margins, border, padding) into container
  - `width: 100%` & `border-box`: does NOT include margins when fitting into container
  - `width: 100%` & `content-box` : does NOT include margins, border, or padding when fitting

## images
- can use `outline: 1px solid red` for development / debugging [^7]q1
- use `display: block` to prevent a gap under the img [^10]
  - `<img>` default as 'inline' which aligns the bottom of the image with the baseline of fonts

## position
- `top`, `right`, `bottom`, `left` (*offset properties*) only work with *positioned* properties (i.e., not `position: static`) [^9]
  - `static`: the default - items that are part of normal page flow; appear in the same order as markup; **cannot** use offset properties
  - `relative`: items are positioned relative to where the browser would normally put it, but still hold a "non-offset" space that other elements respect in document flow
  - `absolute` : moves the element to a position *within an ancenstor element that has a fixed, relative, absolute or sticky position* (a position *other than static*), or "body" if no other suitable parent exists; AND removes element from document flow
  - `fixed` : positions an element within the *window*; also removed from normal flow of document
- `z-index` : only works on *positioned* elements

## misc
- `textarea` : can add css: `resize` : vertical, horizontal, both to define what axes a resize is allowed in [^8]css video
- liquid layouts : relative sizes remain constant (e.g., use percentage widths) [^11]
- fluid layouts : like liquid until they reach a max or min and then act fixed [^11]


# References
[^1]: [CSS Practice Problem](https://launchschool.com/lessons/4495fbf7/assignments/8e39567e)
[^2]: [The Visual Formatting Model](https://launchschool.com/lessons/f039db62/assignments/b7312e44)
[^3]: [Padding and Margins](https://launchschool.com/lessons/f039db62/assignments/599aa8b5)
[^4]: [ Dimensions](https://launchschool.com/lessons/f039db62/assignments/b237bc64)
[^5]: [Practice Problems: Spacing and Dimensions](https://launchschool.com/lessons/f039db62/assignments/01231289)
[^6]: [HTML and CSS Quiz](https://launchschool.com/quizzes/f3990794/)
[^7]: [Guided Project: A Simple Photo Gallery](https://launchschool.com/lessons/de86d90a/assignments/69d139b4)
[^8]: [Forms Walkthrough Project](https://launchschool.com/lessons/d4fbe0e0/assignments/222db9b7)
[^9]: [ Positioning](https://launchschool.com/lessons/e01b7c79/assignments/9724b485)
[^10]: [The strange <img> gap in HTML](https://dev.to/christiankaindl/the-strange-img-gap-in-html)
[^11]: [Responsive Design](https://launchschool.com/lessons/e01b7c79/assignments/64451750)