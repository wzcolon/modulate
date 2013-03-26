class AccountsController < ApplicationController 
  def index
    @accounts = Account.all
  end 

  def show
    @account = Account.find(params[:id])
  end

  def update
    @account = Account.find(params[:id])
    @account.attributes = params[:account]
    @doc = @account.modulate_documents.detect(&:new_record?) 
    @doc.attached_by_id = 1
    if @account.save
      redirect_to accounts_path, notice: "successfully"
    else
      flash.now[:alert] = "I like pie Error"
      render :show
    end
  end

end
