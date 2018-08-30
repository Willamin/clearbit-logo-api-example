#!/usr/bin/env ruby
require 'sinatra'
require 'net/http'
require 'uri'
require 'better_errors'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

# name => content
IMAGES = {}

def fetch_logo(name)
  uri = URI.parse("https://logo.clearbit.com/#{name}")
  resp = Net::HTTP.get_response(uri)
  if resp.kind_of?(Net::HTTPOK)
    IMAGES[name] = resp.body
  end
  nil
rescue
  nil
end

get '/image/:name' do
  content_type('image/png')
  response.headers['Cache-Control'] = 'public, max-age=300'
  unless IMAGES['name']
    fetch_logo(params['name'])
  end
  IMAGES[params['name']]
end

get '/' do
  name =
    if params[:name]
      params[:name]
    else
      'clearbit.com'
    end

  fetch_logo(name)

  erb :index, locals: {name: name}
end