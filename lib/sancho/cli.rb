require_relative 'config'
require_relative 'model'
require_relative 'tasks'

module Sancho

  # Command line interface
  module CLI
    module_function

    def call(argv)
      case argv.first&.to_sym
      when :init
        init
      when :build
        build
      when :serve
        serve
      when :help
        puts BANNER
      else
        puts "Sancho: didn't get you", BANNER
      end
    end

    def init
      Task::ReadConfig.run      
      Task::CopyAssets.run
      ptrn = File.join(Sancho::LAYOUTS_DIR, '**/*.*')
      copied = Dir[ptrn].map{ "  #{it}" }
      puts 'Sancho site assets copied', copied
    end

    def build
      conf = Task::ReadConfig.run
      Task::BuildSite.run(conf)
      ptrn = File.join(conf.directory, '*.html')
      generated = Dir[ptrn].map{ "  #{it}" }
      puts 'Sancho HTML generated', generated
    end

    def serve
      Task::ServeSite.run
    end

    BANNER = <<~STR
      Sancho GitHub Pages generator v#{Sancho::VERSION}

      Usage:
        # initialize by creating .sancho.yml config file
        sancho init

        # build site by .sancho.yml configuration
        sancho build

        # serve the built site
        sancho serve

        # to see this message
        sancho help
    STR
  end
end
