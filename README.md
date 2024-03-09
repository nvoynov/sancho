---
title: Sancho Readme
keywords:
  - ruby
  - github-pages-generator
...

`Sancho` is static site generator for [Github Pages](https://pages.github.com/). Site content should to be written in Markdown or [Pandoc Markdown](https://pandoc.org/MANUAL.html#pandocs-markdown). And it will be rendered with [Pandoc](https://pandoc.org/)

## Installation

Run

    $ bundle add sancho --git https://github.com/nvoynov/sancho.git

Require it in the Rakefile

```ruby
require "sancho"
source, folders = Sancho.tasks
Rake.application.rake_require source, folders
```

Install [pandoc](https://pandoc.org/installing.html)

## Usage

To initialize site content, run the initialization task

    $ rake sancho:init

Configure the site content by customizing `sancho.yml`

Render HTML content from markdown sources

    $ rake sancho:docs

Serve it locally by

    $ rake sancho:serve

[Template]{.underline}

You can provide your own HTML template by placing `_layouts/template.html` file. Read [Pandoc Templates](https://pandoc.org/MANUAL.html#templates) section for details.

## Links

- [Zenweb, stupid fast static website generation](https://www.zenspider.com/projects/zenweb.html)
- [Creating Static Sites in Ruby with Rack](https://devcenter.heroku.com/articles/static-sites-ruby)
