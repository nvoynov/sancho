# https://devcenter.heroku.com/articles/static-sites-ruby
require 'rack/static'

use Rack::Static,
  :urls => ["/images", "/js", "/css"],
  :root => "docs"

# @todo find requested page
#   return 404 when not found
#   return File.open
run lambda {|env|
  [
    200,
    {
      'content-type'  => 'text/html',
      'cache-control' => 'public, max-age=86400'
    },
    File.open('docs/index.html', File::RDONLY)
  ]
}
