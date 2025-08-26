require_relative 'basic'
require 'psych'

module Sancho
  module Task

    # Read configuration
    class ReadConfig < Basic
      def self.run
        config = Sancho::CONFIG_FILE

        begin
          if File.exist?(config)
            Psych
              .load(File.read(config))
              .transform_keys(&:to_sym)
              .then{ return Model::Config.new(**it) }
          end 
        rescue StandardError => e
          puts "Sancho configuration error", e.message
        end

        conf = Model::Config.new(
          Sancho::DEFAULT_SITE_DIR,
          Sancho::DEFAULT_SITE_DOMAIN,
          Sancho::DEFAULT_SITE_TITLE,
          %w[README.md CHANGELOG.md])

        dump = Psych.dump(conf.to_h.transform_keys(&:to_s))
        File.write(config, dump)

        conf
      end
    end
    
  end
end
