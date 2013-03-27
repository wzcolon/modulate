module Modulate

  class Engine < ::Rails::Engine

    config.to_prepare do
      ActiveRecord::Base.extend Modulate::Relation
    end

    initializer "modulate.carrierwave.riak" do
      CarrierWave.configure do |config|
        config.storage = :riak
      end
    end

  end

end

