CarrierWave.configure do |config|
      config.storage = :riak
      config.riak_nodes = [
        { :host => "127.0.0.1", :http_port => 9000 }
      ]
    end

    RSpec.configure do |config|

      config.order = :random

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