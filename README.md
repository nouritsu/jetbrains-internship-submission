# About

A simple link-tree style website used to study CSS transformations.
The design draws heavy inspiration (direct copy pastes) from my (WIP) website: https://nouritsu.com

This repository is my solution the task described by: https://internship.jetbrains.com/projects/1770

# Usage

### Demo
The website is deployed at: https://hire-me.nouritsu.com
It will remain accessible for at least 1 month starting `2026-03-16`.
NOTE: the website is not styled for mobile (like at all) but for the usecase, this will suffice.

### Build
First, clone this repository (or download it manually)
```sh
$ git clone https://github.com/nouritsu/jetbrains-internship-submission
```
Open in a shell in the project directory and run
```sh
$ npm run build # or directly: `parcel build index.html`
```
The files will be bundled using `parcel` and

### Build (nix users)
This repository has a `flake.nix` with a development shell, enter it with
```
$ nix develop
```
> note: you may need to enable flakes and/or nix-command

A help message will show the available commands. It can be printed again with the command `helpme`

### Development Server
The development server can be started with
```sh
$ npm run dev # or directly: `parcel index.html`
```

# Notes

## Frameworks/Stack
I decided to use SCSS because it requires a preprocessor.
This makes it so that the generated CSS files do not directly correspond to the source files.

## SCSS Features
I tried to violate the 1:1 correspondence in a few ways, namely
- compile time computation (like math functions)
- loop generated selectors (`rainbow-links` creates 7 blocks from a single `@for`)
- cross file inlining (the `_theme.scss` partial is imported using `@use`)
- SCSS variables (any `$` variables are SCSS and work more like macros)

## Bundler Choice
Not being too familiar with web development, I first started out with the default: `vite`.
Vite `^8.0.0` did not work, it does not support CSS sourcemaps: https://github.com/vitejs/vite/issues/2830

Instead of messing around with plugins, I decided to go with [Parcel](https://github.com/parcel-bundler/parcel).
It is a minimal bundler (so less clutter in `dist/`) and it did not need a lot of boilerplate like with Webpack.

## CSS Transformation
When `build` is invoked, Parcel's Sass transformer compiles the SCSS files into optimized CSS files.

First, the transformer does the following
- all imports (`@use`) are inlined
- `$` variables are substituted
- other comptime expansions like `@mixin` `@for` are expanded
- function calls like from `sass::math` etc. are evaluated

Next, the CSS is optimized and minified (Parcel uses https://lightningcss.dev/).

Finally, the output is a single `css` file in `dist/`.

## Source Maps
I did not have to enable any additional flags to generate the source maps.
The CSS source map can be found in `dist/`. Here as `jetbrains-css-source-mapping.72158c9d.css.map`.
```
dist/
  jetbrains-css-source-mapping.72158c9d.css
  index.html
  jetbrains-css-source-mapping.b0b93030.js
  jetbrains-css-source-mapping.72158c9d.css.map
  jetbrains-css-source-mapping.b0b93030.js.map
```

## Report
My report for Task #2 can be found in this repository as `report_task_2.md`
