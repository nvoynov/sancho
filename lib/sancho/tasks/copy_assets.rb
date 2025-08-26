require_relative 'basic'

module Sancho
  module Task

    # Copy Sancho assets
    class CopyAssets < Basic
      # @param dest [String] directory to punch
      def self.run
        dir = Sancho::LAYOUTS_DIR
        return if Dir.exist?(dir)

        mkdir_p dir
        cp_r "#{Sancho.assets}/.", dir
      end
    end
    
  end
end
