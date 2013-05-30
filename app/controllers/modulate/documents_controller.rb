class Modulate::DocumentsController < Modulate::ApplicationController 
  
  def destroy
    respond_to do |format|
      @doc = Modulate::Document.find(params[:id])

      if @doc.destroy
        format.html { redirect_to :back }
        format.json { head :ok }
      end

    end
  end

  def show
    @doc = Modulate::Document.find(params[:id])
    @file = @doc.attachment.read
    send_data(@file, filename: @doc.filename)
  end
end
