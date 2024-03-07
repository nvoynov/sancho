require 'erb'
require 'tmpdir'
require_relative 'sancho'
include Sancho

TEMP = '.tmp'.freeze
LAYOUT = '_layouts'.freeze

namespace :sancho do
  desc "init"
  task :init do
    if Dir.exist?(LAYOUT)
      puts "Sancho initialized already"
      exit(0)
    end
    cp_r "#{Sancho.assets}/.", LAYOUT, verbose: false
    basics = Dir.glob(File.join(LAYOUT, '*.*'))
      .map{|e| "#{?\s * 4}created #{e}"}.join(?\n)
    Conf.read
    puts <<~EOF
      Punching basics..
      #{basics}

      Punching config..
          created #{Conf::CONF}

      Sancho initialized!

      To create GitHub Pages:
        1. run 'git checkout -b docs'
        2. configure in 'sancho.yml'
        3. run 'rake sancho:docs'
        4. commit changes, push 'docs'
    EOF
  end

  desc "docs"
  task :docs do
    site = Sancho::DOCS
    docs = Sancho.docs
    mkdir_p %w[images css js].map{ File.join(site, _1)}
    styles = File.join(LAYOUT, 'styles.css')
    cp styles, File.join(site, 'css')

    # process .erb
    samples = Dir.glob("#{LAYOUT}/*.erb")
    @site = docs
    samples.each {|erb|
      body = ERB.new(File.read(erb), trim_mode: '%<>').result(binding)
      name = File.join(site, File.basename(erb, '.erb'))
      File.write(name, body)
    }

    index = docs.pages.find{|page| page.source.downcase =~ /^index/ }
    docs << Page.new(docs.pages.first.source, 'index.html') unless index

    tmpdir = Dir.mktmpdir
    begin
      header = File.join(tmpdir, 'header.html')
      footer = File.join(tmpdir, 'footer.html')
      sh "pandoc -o #{header} #{LAYOUT}/header.md"
      sh "pandoc -o #{footer} #{LAYOUT}/footer.md"

      docs.each_page{|page|
        options = []
        options << "-s --toc"
        options << "--template #{LAYOUT}/layout.html -c css/styles.css"
        options << "-B #{header} -A #{footer} "
        sh "pandoc #{options.join(?\s)} -o #{site}/#{page.url} #{page.source}"
      }
    ensure
      remove_entry tmpdir
    end

  end

end
