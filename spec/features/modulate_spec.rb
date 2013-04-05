require 'spec_helper'

describe "uploading a document" do

  let(:account) { FactoryGirl.create(:account) } 

  before :each do
    visit "/accounts/#{account.id}"
    attach_file('account_modulate_uploads_attributes_0_attachment', Rails.root.join('../../', 'spec', 'fixtures', 'test.txt'))
    click_button "Update Account"
  end
  
  it "stores the file to Riak" do
    expect(page).to have_content('successfully')
  end

  it "sets the label" do
    expect(Modulate::Document.last.label).to eq('Test')
  end

end
