require 'spec_helper'

describe "document handling" do

  let(:account) { FactoryGirl.create(:account) } 

  describe "uploading a document" do

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

  describe "downloading a document" do

    before :each do
      visit "/accounts/#{account.id}"
      attach_file('account_modulate_uploads_attributes_0_attachment', Rails.root.join('../../', 'spec', 'fixtures', 'test.txt'))
      click_button "Update Account"

      doc_id = Modulate::Document.last.id
      visit "/accounts/#{account.id}"
      visit "/modulate/documents/#{doc_id}"
    end

    it "downloads the file from Riak" do
      require 'launchy'
      puts "hello"
      save_and_open_page
      expect(page.response_headers['Content-Type']).to eq("text/plain")
    end

  end

end

