CarrierWave.configure do |config|
  config.storage = :riak
  config.riak_host = 'localhost'
  config.riak_port = 8098
end
