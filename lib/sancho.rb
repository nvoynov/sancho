# frozen_string_literal: true
require "psych"

# Github Pages site generator
module Sancho
  extend self

  DOCS = 'docs'.freeze
  CONF = "#{DOCS}.yml".freeze

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

    def pages_by_date
      @pages.sort_by{|a, b| b.date <=> a.date}
    end
  end

  class Page
    attr_reader :source
    attr_reader :date
    attr_reader :url

    def initialize(source)
      @source = source
      @date = File.mtime(source).date
      @url = File.basename(source, '.md').downcase + '.html'
    end
  end

  def docs
    Site.new(config)
  end

  protected

  def config
    conf = Config.new('change.the.domain', %w[README.md CHANGELOG.md]).freeze
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
