require_relative 'page'
require 'forwardable'

module Sancho
  module Model

    # Site model
    Site = Data.define(:domain, :title, :pages) do
      extend Forwardable
      def_delegator :pages, :each, :each_page

      def pages_by_date
        pages.sort{|a, b| b.date <=> a.date }
      end
      
      def add(page)
        with(pages: pages.push(page))
      end
      alias << add
    end    
    
  end
end
