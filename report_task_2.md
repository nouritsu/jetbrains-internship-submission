# System Info
- Using `Brave Browser 145.1.87.192` devtools
- Development server ran using `npm 10.9.4`

# Data

## `[src]` Link
### color
- Computed Value: `rgb(245, 194, 231)`
- Declaring Rule: `nav a:first-child`
- Source-Mapped Location: `_theme.scss:98`
- CSS Location: `jetbrains-css-source-mapping.b2d9cf43.css:38`

### font-family
- Computed Value: `"JetBrains Mono", monospace`
- Declaring Rule: `body`
- Source-Mapped Location: `style.scss:9`
- CSS Location: `jetbrains-css-source-mapping.b2d9cf43.css:7`

### font-size
- Computed Value: `22.5px`
- Declaring Rule: `nav a`
- Source-Mapped Location: `style.scss:36`
- CSS Location: `jetbrains-css-source-mapping.b2d9cf43.css:304`

### text-decoration-line
- Computed Value: `none`
- Declaring Rule: `nav a:first-child`
- Source-Mapped Location: `_theme.scss:98`
- CSS Location: `jetbrains-css-source-mapping.b2d9cf43.css:38`

### display
- Computed Value: `block`
- Declaring Rule: `nav a:first-child`
- Source-Mapped Location: `_theme.scss:98`
- CSS Location: `jetbrains-css-source-mapping.b2d9cf43.css:38`

## `[GitHub]` Link
### color
- Declaring Rule: `nav a:nth-child(2)`
- Source-Mapped Location: `_theme.scss:98`

## `[LinkedIn]` Link
### color
- Declaring Rule: `nav a:nth-child(3)`
- Source-Mapped Location: `_theme.scss:98`

## Main `<h1>` Text
### background-image
- Computed Value: linear-gradient(to bottom right, #f5c2e7 0%, #f4c1e7 1.38889%, ...) text;
- Declaring Rule: `h1`
- Source-Mapped Location: `style.scss:22`
- CSS Location: `jetbrains-css-source-mapping.b2d9cf43.css:22`

## `$pink` Variable
### declaration
- Declared At: `_theme.scss:23`

# Observations
I have found the following three cases where source mapping becomes ambigious or unusable.

## Case 1
The selectors for our links are all different even though they all map to the same line.
Namely,
- `src` link with selector `nav a:first-child` maps to `_theme.scss:98`
- `GitHub` link with selector `nav a:nth-child(2)` also maps to `_theme.scss:98`
- `LinkedIn` link with selector `nav a:nth-child(3)` also maps to `_theme.scss:98`

This is because our `@for` loop unfolded into 7 rules (one for each `link-color`) but the source map does not directly convey this.

## Case 2
The variable `$pink` represents the colour value `#f5c2e7` but the value is traced incorrectly.
- the `$pink` variable is defined at `_theme.scss:23`
- trace of the colour leads us back to `_theme.scss:98` (from colour property of `src` link)

This happens due to the `@include` expansion.

## Case 3
Three properties for `src` link map to the same `@include` call.
- `color` maps to `_theme.scss:98`
- `text-decoration-line` also maps to `_theme.scss:98`
- `display` also maps to `_theme.scss:98`

This is a similar problem to Case 1, where the the source map points to an `@include` call, when it should point to the declaration in the referenced mixin.
