require 'spec_helper'

describe Modulate::Relation do
  describe "modulate" do
    let(:modulated_model) {
      Class.new(ActiveRecord::Base) {
        self.abstract_class = true
      }
    }

    let(:association) { modulated_model.reflect_on_association(custom_name) }
    let(:custom_name) { :modulate_documents }

    it "will create the has_many" do
      modulated_model.modulate
      expect(association.macro).to eq(:has_many)
    end
  
    describe "with custom name" do
      let(:custom_name) { :docs }

      it "creates an association" do
        modulated_model.modulate custom_name
        expect(association.name).to eq(custom_name)
      end
    end
  end
end
