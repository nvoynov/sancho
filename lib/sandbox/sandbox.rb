require "psych"

Conf = Struct.new(:domain, :pages)
Page = Struct.new(:source, :url, :time) do
  def date
    time.strftime '%Y-%m-%d'
  end
end
Site = Struct.new(:domain, :pages) do
  def pages_by_date
    pages.sort{|a, b| b.date <=> a.date}
  end
end

domain = 'nvoynov.github.io/marko'
pages = %w[README.md CHANGELOG.md STORY.md]
  .map{"marko/docs/#{_1}"}

conf = Conf.new(domain, pages)
site = begin
  pages = conf.pages.map{|page|
    source = page
    url = File.basename(page, '.md').downcase + '.html'
    date = File.mtime(page)
    Page.new(source, url, date)
  }
  Site.new(domain, pages)
end

pp site
puts

text = Psych.dump(conf)
head = text.lines.first
docs = text.lines.drop(1).join
File.write('docs.yml', docs)
body = File.read('docs.yml')
conf = Psych.load([head, body].join, freeze: true)
pp conf
puts

require "erb"
# sitemap.xml
erb = File.read('sitemap.xml.erb', trim_mode: '%<>')
renderer = ERB.new(erb)
@site = site
sitemap = renderer.result
puts sitemap

# robots.txt
