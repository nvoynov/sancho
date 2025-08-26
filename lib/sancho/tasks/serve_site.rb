require_relative 'basic'

module Sancho
  module Task

    # Serve site
    class ServeSite
      def self.run
        ru = File.join(__dir__, CONFIG_RU)
        system "rackup #{ru}" 
      end

      # rackup file
      CONFIG_RU = 'config.ru'
    end
    
  end
end
