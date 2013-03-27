module Modulate::Relation

  def modulate(name=:modulate_documents, options={})
    has_many name, {as: :attachable, class_name: "Modulate::Document"}.reverse_merge(options)
    accepts_nested_attributes_for name 
    attr_accessor :"#{Modulate.configuration.user_method}" unless Modulate.configuration.user_method == nil
  end

end
