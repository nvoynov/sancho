# https://devcenter.heroku.com/articles/static-sites-ruby
require 'rack/static'
require './lib/sancho'

use Rack::Static,
  :urls => ["/images", "/js", "/css"],
  :root => "docs"

text_plain = { 'content-type'  => 'text/plain' }
text_html = {
  'content-type'  => 'text/html',
  'cache-control' => 'public, max-age=86400'
}

run lambda {|env|
  target = env['REQUEST_PATH'][1..-1]
  source = File.join(Sancho::DOCS, target)
  return [404, text_plain, ['not found']] \
    unless File.exist?(source)
  [200, text_html, File.open(source, File::RDONLY)]
}
