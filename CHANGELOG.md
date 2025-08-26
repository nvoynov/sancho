---
title: Sancho Changelog
keywords:
  - static-site-generator
  - github-pages-generator
  - ruby
...

## [Unreleased]

__TODO__

- [ ] add progress copying assets and generated HTML files

```ruby
pattern = File.join(Sancho::LAYOUTS_DIR, '*.*')
puts "Sancho assets copied"
Dir[pattern]
  .map{ "  - #{it}"}
  .join(?\n)

conf = Task::ReadConfig.run
pattern = File.join(conf.directory, '*.html')
puts "Sancho site generated"
Dir[pattern]
  .map{ "  - #{it}"}
  .join(?\n)
```


## [0.7.0] - 2025-08-24

- designed CLI interface of init, build, serve commands
- removed Rake interface (that was dependency disaster)
- Ruby 3.4

## [0.6.0] - 2024-03-07

- designed new model based on Data.define
- designed tests for tasks.rake
- designed new `sancho:serve` and `sancho:release` tasks
- improved `sancho:init` output
- improved `sancho:docs` using Dir.mktempdir

## [0.3.0] - 2023-02-11

- packed as a gem
- added `sancho:init` rake task

## [0.2.0] - 2023-01-30

- added styles (pandoc.css with sticky navbar and changed code)
- added rackup

## [0.1.0] - 2023-01-28

- Project released
