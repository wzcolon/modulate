#Modulate

[![Build Status](https://travis-ci.org/wzcolon/modulate.png)](https://travis-ci.org/wzcolon/modulate)
[![Code Climate](https://codeclimate.com/github/wzcolon/modulate.png)](https://codeclimate.com/github/wzcolon/modulate)


##Overview

Modulate builds off CarrierWave and CarrierWave-Riak to allow quick integration of document storage to Riak. The generator will do the bulk of the work for you including building view partials that you can quickly incorporate if you chose to do so.

##Usage

Copy the engine migrations to your project and run the migrations.

```bash
  rake modulate_engine:install:migrations

  rake db:migrate
```

Run the generator for each ActiveRecord model you wish to add modulate to.
```bash
  rails generate modulate Account
```

You may optionally install the Riak test server in your application by passing the option to do so.  If you use this option, remember to configure the 'source' line in spec/support/test_server.yml with the local Riak installation path. This option will only work if Rspec is installed.
```bash
  rails generate modulate --test-server
```

The command above will add the 'modulate' method to your model. By default, it will create a has_many relationship to the Modulate::Documents class. If you would prefer to call the association by something other than modulate_documents then alter this line of code, supplying the name you wish to call the association.

```ruby
  class Account < ActiveRecord::Base
    modulate name = :attachments 
  end
```

If you are using mass-assignment protection in your models, add the following. 

```rails
  attr_accessible :modulate_documents_attributes, :modulate_uploads_attributes
```

Modify the CarrierWave initializer to meet your needs. The default assumes you are running a standard local Riak installation. For more information on how to configure Riak see [carrierwave-riak](https://github.com/motske/carrierwave-riak#configuration).

Modulate has the ability to track the user who added the document to the system. By default this will not be tracked, however, if you have a method that returns the current user and wish to track who is uploading documents, configure modulate with that method.

```ruby
  # config/initializers/modulate.rb

  Modulate.configure do |config|
    config.user_method = :some_user
  end
```

If you choose to track users then make sure your controller assigns the 'attached_by_id'.

```ruby
  # app/controllers/accounts_controller.rb

  AccountsController < ApplicationController
    def update
      @account = Account.find(params[:id])
      @account.attributes = params[:account]

      @docs = @account.modulate_documents.select(&:new_record?) 
      unless @docs.blank?
        @docs.each do |doc|
        @doc.attached_by_id = current_user 
      end

      if @account.save
        flash.now[:notice] = "successfully"
        redirect_to accounts_path
      else
        flash.now[:alert] = "error"
        render :edit
      end
    end
  end
```

