#Modulate

This project rocks and uses MIT-LICENSE.

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
      @doc = @account.modulate_documents.detect(&:new_record?) 
      @doc.attached_by_id = current_user unless @doc.blank?
      if @account.save
        redirect_to accounts_path, notice: "successfully"
      else
        flash.now[:alert] = "error"
        render :show
      end
    end
  end
```

