require_relative 'basic'
require 'tmpdir'
require 'erb'

module Sancho
  module Task

    # Build site
    class BuildSite < Basic
      # @param config [Model::Config]
      def self.run(config)
        %w[images css jss]
          .map{ File.join(config.directory, it) }
          .each{ mkdir_p it } 

        styles = File.join(Sancho::LAYOUTS_DIR, 'styles.css')
        cp styles, File.join(config.directory, 'css') 
        
        pages = config.pages.map{ Model::Page.from(it) }
        index = config.pages.find{ it.downcase =~ /^index/ }
        pages << Model::Page.from(config.pages.first, 'index.html') \
          unless index
        
        site = Model::Site.new(
          domain: config.domain,
          title: config.title,
          pages:)
        
        # process erb require site variable
        Dir["#{Sancho::LAYOUTS_DIR}/*.erb"].each do |erb|
          content = ERB.new(File.read(erb), trim_mode: '%').result(binding)
          filename = File.join(config.directory, File.basename(erb,'.erb'))
          File.write(filename, content)
        end

        srcdir = Dir.pwd
        Dir.mktmpdir do |dir|
          header = File.join(dir, 'header.html')
          footer = File.join(dir, 'footer.html')
          system "pandoc -o #{header} #{Sancho::LAYOUTS_DIR}/header.md"
          system "pandoc -o #{footer} #{Sancho::LAYOUTS_DIR}/footer.md"

          optns = PANDOC_OPTIONS + " -B #{header} -A #{footer}"
          site.pages.each{
            source = File.join(srcdir, it.source)
            system "pandoc #{optns} -o #{config.directory}/#{it.url} #{source}"
          }
        end
      end

      PANDOC_OPTIONS = "-s --toc --template #{Sancho::LAYOUTS_DIR}/layout.html -c css/styles.css"
    end
    
  end
end
