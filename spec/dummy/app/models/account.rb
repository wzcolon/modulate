class Account < ActiveRecord::Base
  modulate

  attr_accessible :modulate_documents_attributes
  
end
