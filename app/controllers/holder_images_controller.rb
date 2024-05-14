class HolderImagesController < ApplicationController
  def create
    @holder_image = HolderImage.new(images_params)
    @holder_image.holder = Event.find(params[:event_id]) if params.has_key?(:event_id)
    @holder_image.user = current_buffet_owner
    if @holder_image.save
      redirect_to @holder_image.holder, notice: 'Imagem anexada ao evento'
    else
      flash.now[:alert] = 'Erro ao anexar imagem'
      render 'events/show'
    end
  end
  
  def destroy
    @holder_image = HolderImage.find(params[:id])
    @event = @holder_image.holder
    if @holder_image.destroy
      redirect_to @event, notice: 'Imagem removida com sucesso'
    else
      flash.now[:alert] = 'Erro ao remover imagem'
      render 'events/show'
    end
  end

  private
  def images_params
    params.require(:holder_image).permit(:image)
  end
end