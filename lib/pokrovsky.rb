require_relative 'pokrovsky/historiograph'
require_relative 'pokrovsky/day'
require_relative 'pokrovsky/commit'

require 'sinatra/base'
require 'haml'
require 'kramdown'
require 'rack-google-analytics'
require 'curb'
require 'nokogiri'

class PokrovskyService < Sinatra::Base
  set :port, ENV["POKROVSKY_PORT"]
  set :bind, "0.0.0.0"

  @@locals = {
#      :bootstrap_theme => '../lavish-bootstrap.css',
      :github          => {
          :user    => 'pikesley',
          :project => 'pokrovsky',
          :ribbon  => 'right_gray_6d6d6d'
      }
  }

  get '/' do
    haml :readme, :locals => @@locals.merge(
        {
            :title => 'Vandalising Git history for fun and profit.'
        }
    )
  end

  get '/:user/:repo/:text' do
    ssfaas    = 'http://dead-cockroach:%s' % [
      ENV["COCKROACH_PORT"]
    ]
    text      = '/%s' % [
        URI.encode(params[:text][0...6])
    ]
    full_url  = URI.join(ssfaas, text)
    c         = Curl::Easy.new("%s" % full_url)
    c.headers = {
        'Accept' => 'application/json'
    }
    c.perform

    @h      = Pokrovsky::Historiograph.new c.body_str, params[:user], params[:repo]
    halt 200, { 'Content-Type' => 'text/plain' }, @h.to_s
  end

  run! if app_file == $0
end
