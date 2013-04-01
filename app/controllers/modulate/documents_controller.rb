class Modulate::DocumentsController < Modulate::ApplicationController 
  
  def destroy
    @doc = Modulate::Document.find(params[:id])
    if @doc.destroy
      redirect_to :back
    end
  end

  def show
    @doc = Modulate::Document.find(params[:id])
    @file = Modulate::DocumentUploader.new.retrieve_from_store!(@doc.key) 
    redirect_to :back
  end
end
