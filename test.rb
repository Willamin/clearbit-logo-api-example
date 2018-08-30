#!/usr/bin/env ruby
require 'minitest/autorun'
require 'minitest/spec'
require 'rack/test'
require_relative './app'

ENV['RACK_ENV'] = 'test'

include Rack::Test::Methods

def app
  Sinatra::Application
end

describe 'my example spec' do
  it 'should successfully show a page containing the header' do
    get '/'
    last_response.ok?
    last_response.body.must_include 'Clearbit Logo API Example'
  end
end

describe "my example spec" do
  it "should successfully return an image" do
    get '/image/clearbit.com'
    last_response.ok?
  end
end