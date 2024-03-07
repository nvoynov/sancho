require 'psych'

module Sancho
  class Conf < Data.define(:domain, :title, :pages)
    def self.read
      return new(**Psych.load(File.read(CONF)).transform_keys(&:to_sym)) \
        if File.exist?(CONF)

      new.tap{|o| File.write(CONF, Psych.dump(o.to_h.transform_keys(&:to_s))) }
    rescue => e
      puts 'Sancho: reading config error', e.full_message
      new
    end

    def initialize(domain: 'domain', title: 'title', pages: %w[README.md CHANGELOG.md])
      super
    end

    CONF = 'sancho.yml'
  end
end
