require 'erb'
require_relative 'sancho'
include Sancho

TEMP = '.tmp'.freeze
LAYOUT = '_layouts'.freeze

namespace :sancho do

  desc "docs"
  task :docs do
    site = Sancho::DOCS
    temp = TEMP
    docs = Sancho.docs
    [site, temp].each{ makedirs _1 unless Dir.exist?(_1) }

    header = File.join(temp, 'header.html')
    footer = File.join(temp, 'footer.html')
    # styles = File.join(docs, '_styles.css')

    sh "pandoc -o #{header} #{LAYOUT}/header.md"
    sh "pandoc -o #{footer} #{LAYOUT}/footer.md"

    # process .erb
    samples = Dir.glob("#{LAYOUT}/*.erb")
    @site = docs
    samples.each {|sample|
      erb = File.read(sample)
      renderer = ERB.new(erb, trim_mode: '%<>')
      body = renderer.result
      name = File.join(site, File.basename(sample, '.erb'))
      File.write(name, body)
    }

    index = docs.pages.find{|page| page.source.downcase =~ /^index/ }
    docs << Page.new(docs.pages.first.source, 'index.html') unless index

    docs.pages.each{|page|
      include = "--template #{LAYOUT}/layout.html -B #{header} -A #{footer} "
      sh "pandoc -s #{include} -o #{site}/#{page.url} #{page.source}"
    }
  end

end

# suppose for gem
# namespace :sancho do
# init
#   git checkout -b docs
#   copy something? lib/sancho, lib/tasks
#   patch Rakefile?
