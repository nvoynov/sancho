---
title: Sancho Readme
keywords:
  - ruby
  - github-pages-generator
...

## Overview

Sancho plays [Github Pages](https://pages.github.com/) generator designed for simplest site generation from a few markdown files.

In my scenario, I always have README.md and CHANGELOG.md, sometimes STORY.md for every project and present those on the project page.

It utilizes [Pandoc](https://pandoc.org) for Markdown to HTML translation; source markdonw could be [Pandoc Markdown](https://pandoc.org/MANUAL.html#pandocs-markdown).

## Installation

Install the gem

    gem install sancho

Or add it by

    bundle add sancho --git https://github.com/nvoynov/sancho.git

Install [pandoc](https://pandoc.org/installing.html)

## Usage

[Basic flow]{.underline}

    # go to tareget directory
    cd my_thing
    # create .sancho.yml configuration file and copy basis site assets
    sancho init
    # do some configuration and template changes
    # then build the site
    sancho build
    # test the site
    sancho serve

[Template]{.underline}

To change template just place your `_layouts/template.html` file. Read [Pandoc Templates](https://pandoc.org/MANUAL.html#templates) section for details.

## Links

- [Zenweb, stupid fast static website generation](https://www.zenspider.com/projects/zenweb.html)
- [Creating Static Sites in Ruby with Rack](https://devcenter.heroku.com/articles/static-sites-ruby)
