require_relative 'sancho'
require 'erb'

TEMP = '.tmp'.freeze
LAYOUT = '_layout'.freeze

namespace :sancho do

  desc "dummy"
  task :dummy do
    puts "Dummy!"
  end

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
      body = rendered.result
      name = File.basename(sample, '.erb')
      File.write(name, body)
    }

    docs.pages.each{|page|
      include = "-T #{LAYOUT}/layout.html -B #{header} -A #{footer}"
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
