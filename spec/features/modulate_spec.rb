require 'spec_helper'

describe "uploading a document" do
  
  let(:account) { FactoryGirl.create(:account) } 

  it "stores the file to Riak" do
    visit "/accounts/#{account.id}"
    attach_file('account_modulate_documents_attributes_0_attachment', Rails.root.join('../../', 'spec', 'fixtures', 'test.txt'))
    click_button "Update Account"
    expect(page).to have_content('successfully')
  end
end
