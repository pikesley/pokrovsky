require_relative 'pokrovsky/historiograph'
require_relative 'pokrovsky/day'
require_relative 'pokrovsky/commit'

require 'sinatra/base'
require 'haml'
require 'kramdown'
require 'rack-google-analytics'
require 'curb'

class PokrovskyService < Sinatra::Base
  use Rack::GoogleAnalytics, :tracker => 'UA-20895204-12'

  get '/' do
    haml :readme, :locals => {
        :title           => 'Vandalising Git history for fun and profit.',
        :text            => markdown(File.read('README.md')),
        :bootstrap_theme => '../lavish-bootstrap.css',
        :github_ribbon   => 'right_gray_6d6d6d'
    }
  end

  get '/:user/:repo/:text' do
    ssfaas    = 'http://uncleclive.herokuapp.com/'
    text      = '/%s/' % [
        URI.encode(params[:text])
    ]
    full_url  = URI.join(ssfaas, text, 'gitfiti')
    c         = Curl::Easy.new("%s" % full_url)
    c.headers = {
        'Accept' => 'application/json'
    }
    c.perform

    @h      = Pokrovsky::Historiograph.new c.body
    @h.user = params[:user]
    @h.repo = params[:repo]
    halt 200, {'Content-Type' => 'text/plain'}, @h.to_s
  end

  run! if app_file == $0
end