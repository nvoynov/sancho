require 'rack/static'

use Rack::Static,
  :urls => ["/images", "/js", "/css"],
  :root => "docs"

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
