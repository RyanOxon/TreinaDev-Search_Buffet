class HolderImagesController < ApplicationController
  def create 
    return redirect_to root_path unless authorized?
    @holder_image = HolderImage.new(images_params)
    if params.has_key?(:event_id)
      @event = Event.find(params[:event_id])
      @holder_image.set_event(@event, current_buffet_owner) if buffet_owner_signed_in?
      if @holder_image.save
        flash[:notice] = 'Imagem anexada com sucesso'
        return redirect_to @holder_image.holder
      else
        flash.now[:alert] = 'Erro ao anexar imagem'
        render 'events/show'
      end
    end
    if params.has_key?(:rate_id)
      @rate = Rate.find(params[:rate_id])
      @holder_image.set_rate(@rate, current_customer) if customer_signed_in?
      if @holder_image.save
        flash[:notice] = 'Imagem anexada com sucesso'
        return redirect_to buffet_rate_path(@holder_image.holder.buffet, @holder_image.holder)
      else
        flash.now[:alert] = 'Erro ao anexar imagem'
        render 'rates/show'
      end
    end
  end
  
  def destroy
    @holder_image = HolderImage.find(params[:id])
    @event = @holder_image.holder
    if authorized? && @holder_image.destroy
      return redirect_to @event, notice: 'Imagem removida com sucesso'
    else
      flash.now[:alert] = 'Erro ao remover imagem'
      redirect_to root_path
    end
  end

  private
  def images_params
    params.require(:holder_image).permit(:image) unless params[:holder_image].nil?
  end

  def authorized?
    if customer_signed_in?
      return params.has_key?(:rate_id) && Rate.find(params[:rate_id]).customer == current_customer
    end
    if buffet_owner_signed_in?
      return params.has_key?(:event_id) && Event.find(params[:event_id]).buffet == current_buffet_owner.buffet
    end
    false
  end
end