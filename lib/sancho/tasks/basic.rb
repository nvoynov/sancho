require_relative '../config'
require_relative '../model'
require 'fileutils'

module Sancho
  module Task

    # Basic action
    class Basic
      extend FileUtils

      def self.run(*args, **kwargs)
      end
    end
    
  end
end
