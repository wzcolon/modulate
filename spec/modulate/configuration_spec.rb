require 'spec_helper'

describe Modulate::Configuration do

  describe "defaults" do

    it "uses 'nil' as the user method" do
      expect(Modulate.configuration.user_method).to eq(nil)
    end

  end

  describe "customizing the configuration" do

    before :all do
      Modulate.instance_variable_set :@configuration, nil
      Modulate.configure do |config|
        config.user_method = :some_user
      end

    end

    after :all do
      Modulate.instance_variable_set :@configuration, nil
      Modulate.configure
    end

    it "allows customizing the user_method" do
      expect(Modulate.configuration.user_method).to eq(:some_user)
    end

  end

end
