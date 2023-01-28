---
title: Readme
keywords:
- ruby
- static-site-generator
...

## Overview

`Sancho` is Github Pages generator for Github Repositories or private pages. It supposed that your site will be placed in `docs` directory, under `docs` git branch.

For rendering HTML `Sancho` utilizes [Pandoc](https://pandoc.org), and it is supposed that your site pages will be written in Markdown or [Pandoc Markdown](https://pandoc.org/MANUAL.html#pandocs-markdown).

By default configuration (`sancho.yml`) your site will consists of just two files `README.md` and `CHANGELOG.md`.

It will also create `robots.txt` and `sitemap.xml` files. When you don't need them - just remove `*.erb` inside `_layouts` directory.

## Installation

Clone sancho repository

```
git clone https://github.com/nvoynov/sancho.git
```

## Usage

### Basics

1. Commit your repo changes!
2. Run `$ git checkout docs`
3. Run `$ rake sancho:generate`
4. Run `$ git push -u origin docs`

### Template

You can provide your own HTML template by placing `_layouts/template.html` file. Read [Pandoc Templates](https://pandoc.org/MANUAL.html#templates) section for details.