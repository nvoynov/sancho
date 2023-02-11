# frozen_string_literal: true
require "psych"
require "date"

# Github Pages site generator
module Sancho
  extend self

  VERSION = "0.2.0"

  DOCS = 'docs'.freeze
  CONF = "sancho.yml".freeze

  def root
    dir = File.dirname(__dir__)
    File.expand_path(dir)
  end

  def assets
    File.join(root, '_layouts')
  end

  # Rake.application.rake_require "tasks", [sancho]
  def tasks
    ['tasks', [File.join(root, 'tasks.rake')]]
  end

  Config = Struct.new(:domain, :title, :pages)

  class Site
    attr_reader :domain
    attr_reader :title
    attr_reader :pages

    def initialize(config)
      @domain = config.domain
      @title = config.title
      @pages = config.pages.map{ Page.new(_1) }
    end

    def <<(page)
      @pages << page
    end

    def pages_by_date
      @pages.sort{|a, b| b.date <=> a.date}
    end
  end

  class Page
    attr_reader :source
    attr_reader :date
    attr_reader :url

    def initialize(source, url = '')
      @source = source
      @date = File.mtime(source).to_date
      @url = url.empty? ? File.basename(source, '.md').downcase + '.html' : url
    end
  end

  def docs
    Site.new(config)
  end

  def config
    conf = Config.new('change.the.domain', 'change.the.title', %w[README.md CHANGELOG.md]).freeze
    text = Psych.dump(conf)
    head = text.lines.first
    body = text.lines.drop(1).join
    unless File.exist?(CONF)
      File.write(CONF, body)
      return conf
    end
    body = File.read(CONF)
    Psych.load([head, body].join, freeze: true)
  end
end
