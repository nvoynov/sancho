require_relative 'page'
require 'forwardable'

module Sancho

  class Site < Data.define(:domain, :title, :pages)
    extend Forwardable
    def_delegator :pages, :each, :each_page
    def initialize(domain:, title:, pages:)
      pages = pages.map{|e| Page.new(e) }
      super
    end

    def pages_by_date
      pages.sort{|a, b| b.date <=> a.date}
    end

    def <<(page)
      with(pages: pages.unshift(page))
    end
  end

end
