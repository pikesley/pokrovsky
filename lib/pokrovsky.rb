require_relative 'pokrovsky/historiograph'
require_relative 'pokrovsky/day'
require_relative 'pokrovsky/commit'

require 'sinatra/base'
require 'haml'
require 'kramdown'
require 'rack-google-analytics'
require 'curb'

class PokrovskyService < Sinatra::Base
  get '/:user/:repo/:text' do
    ssfaas   = 'http://uncleclive.herokuapp.com/'
    text = '/%s/' % [
        URI.encode(params[:text])
    ]
    full_url = URI.join(ssfaas, text, 'gitfiti')

    c         = Curl::Easy.new("%s" % full_url)
    c.headers = {
        'Accept' => 'application/json'
    }
    c.perform

    @h      = Pokrovsky::Historiograph.new c.body
    @h.user = params[:user]
    @h.repo = params[:repo]
    @h.to_s
  end

  run! if app_file == $0
end