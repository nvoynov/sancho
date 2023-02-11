require 'erb'
require_relative 'sancho'
include Sancho

TEMP = '.tmp'.freeze
LAYOUT = '_layouts'.freeze

namespace :sancho do
  desc "init"
  task :init do
    if Dir.exist?('_layouts')
      puts "Sancho initialized already"
      exit(0)
    end
    cp_r "#{Sancho.assets}/.", "_layouts"
    Sancho.config
    puts <<~EOF
      Sancho initialized! To create GitHub Pages:
        1. run 'git checkout -b docs'
        2. configure site in 'sancho.yml'
        3. run 'rake sancho:docs'
        4. commit changes, push 'docs'
    EOF
  end

  desc "docs"
  task :docs do
    site = Sancho::DOCS
    mkdir_p %w[images css js].map{ File.join(site, _1)}
    temp = TEMP
    docs = Sancho.docs
    [site, temp].each{ makedirs _1 unless Dir.exist?(_1) }

    header = File.join(temp, 'header.html')
    footer = File.join(temp, 'footer.html')
    sh "pandoc -o #{header} #{LAYOUT}/header.md"
    sh "pandoc -o #{footer} #{LAYOUT}/footer.md"

    styles = File.join(LAYOUT, 'styles.css')
    cp styles, File.join(site, 'css')

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
      options = []
      options << "-s --toc"
      options << "--template #{LAYOUT}/layout.html -c css/styles.css"
      options << "-B #{header} -A #{footer} "
      sh "pandoc #{options.join(?\s)} -o #{site}/#{page.url} #{page.source}"
    }
  end

end

# suppose for gem
# namespace :sancho do
# init
#   git checkout -b docs
#   copy something? lib/sancho, lib/tasks
#   patch Rakefile?
