class Account < ActiveRecord::Base
  modulate

  attr_accessible :modulate_documents_attributes, :modulate_uploads_attributes
  
end
