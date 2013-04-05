require 'simplecov'
SimpleCov.start

ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb", __FILE__)
require "rails/test_help"
require "rspec/rails"
require "factory_girl_rails"
require "launchy"
require "pry"
require 'riak/test_server'
require 'yaml'

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec

  config.order = :random
end

CarrierWave.configure do |config|
  config.storage = :riak
  config.riak_nodes = [
    { :host => "127.0.0.1", :http_port => 9000 }
  ]
end

RSpec.configure do |config|

  config.before :suite do
    begin
      config = YAML.load_file('spec/support/test_server.yml')
      $riak_test_server = Riak::TestServer.create(config.symbolize_keys)
      $riak_test_server.start
    rescue => e
      warn "Can't run Riak::TestServer specs. Specify the location of your Riak installation in 'spec/support/test_server.yml. See warning e.inspect"
    end
  end

  config.after :suite do
    FileUtils.rm_rf(File.expand_path('../../uploads', __FILE__))
    $riak_test_server.stop
    puts "Stoping test server..." 
    $riak_test_Server = nil
    FileUtils.rm_rf(File.expand_path('../test_server', __FILE__))
  end
end
