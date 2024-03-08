---
title: Sancho Readme
keywords:
  - ruby
  - github-pages-generator
...

## Overview

`Sancho` is static site generator for [Github Pages](https://pages.github.com/) that proposes placing your site content under `docs` directory in a separate git branch branch.

For rendering HTML `Sancho` utilizes [Pandoc](https://pandoc.org), and it is supposed that your site pages will be written in Markdown or [Pandoc Markdown](https://pandoc.org/MANUAL.html#pandocs-markdown).

## Installation

Run

    bundle add sancho --git https://github.com/nvoynov/sancho.git

Require Sancho in Rakefile

```ruby
require "sancho"
source, folders = Sancho.tasks
Rake.application.rake_require source, folders
```

Install [pandoc](https://pandoc.org/installing.html)

## Usage

[First flow]{.underline}

1. Commit your repo changes!
2. Run `$ git checkout docs`
3. Run `$ rake sancho:init`
4. Customize `sancho.yml` for pages and `_layouts/header.md` for navbar
5. Run `$ rake sancho:generate` to create your site
6. Run `$ rake sancho:serve` to run the site locally
7. Run `$ git push -u origin docs`


Having done first flow once, one can use the simplified one:

1. Make changes in your markdown files and maybe the site configuration
2. Check it visually by running `$ rake sancho:serve`
3. Run `$ rake sancho:release` to get done checkout, merging, and pushing

[Template]{.underline}

You can provide your own HTML template by placing `_layouts/template.html` file. Read [Pandoc Templates](https://pandoc.org/MANUAL.html#templates) section for details.

## Links

- [Zenweb, stupid fast static website generation](https://www.zenspider.com/projects/zenweb.html)
- [Creating Static Sites in Ruby with Rack](https://devcenter.heroku.com/articles/static-sites-ruby)
