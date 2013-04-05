class ModulateGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  desc "This generator will add document uploading functionality to a model you specify and create two views"

  argument :model_name, type: :string, required: true

  class_option :test_server, type: :boolean, default: false, desc: "Install Riak Test Server"

  def edit_model
    line = "class #{model_name.constantize} < ActiveRecord::Base"
    gsub_file "app/models/#{model_name.underscore}.rb", /(#{Regexp.escape(line)})/mi do |match|
      "#{match}\n  modulate\n"
    end
  end

  def copy_view_files
    template "_modulate_documents.html.haml", "#{folder_name}s/_modulate_#{partial_name}_documents.html.haml"
    template "_modulate_attachments.html.haml", "#{folder_name}s/_modulate_attachments.html.haml"
  end

  def copy_initializer
    copy_file "_carrierwave.rb", "config/initializers/carrierwave.rb"
  end

  def include_riak_test_server
    if options.test_server?
      File.open('spec/spec_helper.rb', 'w+') do |f| f.write(rspec_config)
      end
      template "_riak_test_server.yml", "/spec/support/riak_test_server.yml"
    end
  end

  private

  def gsub_file(relative_destination, regexp, *args, &block)
    path = relative_destination
    content = File.read(path).gsub(regexp, *args, &block)
    File.open(path, 'wb') { |file| file.write(content) }
  end 

  def partial_name
    name.join("_")
  end

  def name
    model_name.downcase.split('::')
  end

  def folder_name
    array = name.tap{
                      last = name.last
                      new = last + 's'
                      name.pop
                      name.push new
    }
    tail = array.join("/")
    "app/views/#{tail}"
  end

  def rspec_config
    %Q[CarrierWave.configure do |config|
      config.storage = :riak
      config.riak_nodes = [
        { :host => "127.0.0.1", :http_port => 9000 }
      ]
    end

    RSpec.configure do |config|

      config.order = :random

      config.before :suite do
        begin
          config = YAML.load_file('spec/support/test_server.yml')
          $riak_test_server = Riak::TestServer.create(config.symbolize_keys)
          $riak_test_server.start
        rescue => e
          warn "Can't run Riak::TestServer specs. Specify the location of your Riak installation in 'spec/support/test_server.yml. See warning e.inspect"
        end
      end

      config.after :suite do
        FileUtils.rm_rf(File.expand_path('../../uploads', __FILE__))
        $riak_test_server.stop
        puts "Stoping test server..." 
        $riak_test_Server = nil
        FileUtils.rm_rf(File.expand_path('../test_server', __FILE__))
      end
    end]
  end

end
