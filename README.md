---
title: Sancho Readme
keywords:
  - ruby
  - github-pages-generator
...

## Overview

`Sancho` is static site generator for Github Pages. It supposed that your site will be placed in `docs` directory, under `docs` git branch.

For rendering HTML `Sancho` utilizes [Pandoc](https://pandoc.org), and it is supposed that your site pages will be written in Markdown or [Pandoc Markdown](https://pandoc.org/MANUAL.html#pandocs-markdown).

By default configuration (`sancho.yml`) your site will consists of two files `README.md` and `CHANGELOG.md`. It will also create `robots.txt` and `sitemap.xml` files. When you don't need them - just remove `*.erb` inside `_layouts` directory.

## Installation

Run

    bundle add sancho --git https://github.com/nvoynov/sancho.git

Modify Rakefile adding

```ruby
require "rake"
require "sancho"
source, folders = Sancho.tasks
Rake.application.rake_require source, folders
```

Install [pandoc](https://pandoc.org/installing.html)

## Usage

### Basics

1. Commit your repo changes!
2. Run `$ git checkout docs`
3. Run `$ rake sancho:init`
4. Modify `sancho.yml` for pages and `_layouts/header.md` for navbar
5. Run `$ rake sancho:generate`
6. Run `$ git push -u origin docs`

### Template

You can provide your own HTML template by placing `_layouts/template.html` file. Read [Pandoc Templates](https://pandoc.org/MANUAL.html#templates) section for details.

## Links

- [Zenweb, stupid fast static website generation](https://www.zenspider.com/projects/zenweb.html)
- [Creating Static Sites in Ruby with Rack](https://devcenter.heroku.com/articles/static-sites-ruby)
