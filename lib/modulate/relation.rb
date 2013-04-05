module Modulate::Relation

  def modulate(name=:modulate_documents, options={})
    has_many name, {as: :attachable, class_name: "Modulate::Document", inverse_of: :attachable}.reverse_merge(options)  # for uploading
    has_many :modulate_uploads, as: :attachable, class_name: 'Modulate::Document', inverse_of: :attachable # for creating
    accepts_nested_attributes_for :modulate_uploads
    accepts_nested_attributes_for name 
    attr_accessor :"#{Modulate.configuration.user_method}" unless Modulate.configuration.user_method == nil
  end

end
