class ModulateGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  desc "This generator will add document uploading functionality to a model you specify and create two views"

  argument :model_name, type: :string, required: true

  def edit_model
    line = "class #{model_name.constantize} < ActiveRecord::Base"
    gsub_file "app/models/#{model_name.underscore}.rb", /(#{Regexp.escape(line)})/mi do |match|
      "#{match}\n  modulate\n"
    end
  end

  def copy_view_files
    template "_modulate_documents.html.haml", "app/views/#{model_name.underscore}s/_modulate_#{model_name.underscore}_documents.html.haml"
    template "_modulate_attachments.html.haml", "app/views/#{model_name.underscore}s/_modulate_attachments.html.haml"
  end

  def copy_initializer
    copy_file "_carrierwave.rb", "config/initializers/carrierwave.rb"
  end

  private

  def gsub_file(relative_destination, regexp, *args, &block)
    path = relative_destination
    content = File.read(path).gsub(regexp, *args, &block)
    File.open(path, 'wb') { |file| file.write(content) }
  end 

end

