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
    @docs = @account.modulate_documents.select(&:new_record?)
    @docs.each do |doc|
      doc.attached_by_id = 1 unless doc.blank?
    end

    if @account.save
      redirect_to accounts_path, notice: "successfully"
    else
      flash.now[:alert] = "error"
      render :show
    end
  end

end
