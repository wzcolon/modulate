require 'spec_helper'

describe Modulate do

  it "is a module" do
    expect(Modulate).to be_a(Module)
  end

  it "extends 'ActiveRecord::Base'" do
    ActiveRecord::Base.should respond_to(:modulate) 
  end

  it "adds a relationship to each model that calls it" do
    Account.should_receive(:has_many).with(:modulate_documents, as: :attachable, class_name: "Modulate::Document")
    Account.modulate
  end

  it "adds nested attributes to each model that calls it" do
    Account.should_receive(:accepts_nested_attributes_for).with(:modulate_documents)
    Account.modulate
  end

  it "adds attr_accessible for document model to each model that calls it" do
    Account.should_receive(:attr_accessible).with(:modulate_documents_attributes)
    Account.modulate
  end

  context "when no user_method is set" do

    it "adds does not add a user_method attr_accessor to each model that calls it" do
      Account.should_not_receive(:attr_accessor).with(nil)
      Account.modulate
    end

    context "when a user method is set" do

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

      it "adds a user_method attr_accessor to each model that calls it" do
        Account.should_receive(:attr_accessor).with(:some_user)
        Account.modulate
      end
    end
  end
end
