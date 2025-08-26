# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "minitest/autorun"
require "minitest/pride"
require "sancho"
include Sancho

class Tempbox
  # Execute block inside temp folder
  def self.call
    Dir.mktmpdir([TMPRX]) do |dir|
      Dir.chdir(dir) { yield }
    end
  end
  TMPRX = 'sanchobox'.freeze
end
