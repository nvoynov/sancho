# frozen_string_literal: true
require 'date'
require_relative 'sancho/conf'
require_relative 'sancho/page'
require_relative 'sancho/site'

# Github Pages site generator
module Sancho
  extend self

  VERSION = "0.4.0"

  DOCS = 'docs'.freeze

  def root
    dir = File.dirname(__dir__)
    File.expand_path(dir)
  end

  def assets
    File.join(root, '_layouts')
  end

  def docs
    Site.new(**Conf.read.to_h)
  end

  # Rake.application.rake_require "tasks", [sancho]
  def tasks
    ['tasks', [File.join(root, 'lib')]]
  end

end
