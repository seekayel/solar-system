mkdir -p public/{images,js,css}
touch ./{config.ru,public/index.html}
bundle init

echo "source 'https://rubygems.org'
gem 'rack'
" > Gemfile

bundle install

cat > config.ru <<- EOM
use Rack::Static,
:urls => ["/images", "/js", "/css"],
:root => "public"

run lambda { |env|
  [
    200,
    {
      'Content-Type'  => 'text/html',
      'Cache-Control' => 'public, max-age=86400'
    },
    File.open('public/index.html', File::RDONLY)
  ]
}
EOM


