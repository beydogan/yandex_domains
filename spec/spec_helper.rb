$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'yandex_domains'
require 'webmock/rspec'
require 'pry'

WebMock.disable_net_connect!

# Source: https://github.com/sferik/twitter/blob/master/spec/helper.rb
def a_delete(path)
  a_request(:delete, YandexDomains::Client.base_uri + path)
end

def a_get(path)
  a_request(:get, YandexDomains::Client.base_uri + path)
end

def a_post(path)
  a_request(:post, YandexDomains::Client.base_uri + path)
end

def a_put(path)
  a_request(:put, YandexDomains::Client.base_uri + path)
end

def stub_delete(path)
  stub_request(:delete, YandexDomains::Client.base_uri + path)
end

def stub_get(path)
  stub_request(:get, YandexDomains::Client.base_uri + path)
end

def stub_post(path)
  stub_request(:post, YandexDomains::Client.base_uri + path)
end

def stub_put(path)
  stub_request(:put, YandexDomains::Client.base_uri + path)
end

def fixture_path
  File.expand_path('../fixtures', __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end