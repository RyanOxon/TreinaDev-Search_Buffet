class EventPricesController < ApplicationController
  before_action :authenticate_buffet_owner!, only: [:new, :create, :edit, :update]
  before_action :set_price, only: [:edit, :update]
  
  def edit; end

  def update 
    if @event_price.update(event_price_params)
      if @event_price.price_type == 'standard'
        flash[:notice] = 'Preço padrão ajustado'
      else
        flash[:notice] = 'Preço especial ajustado'
      end
      redirect_to @event_price.event
    else
      flash.now[:alert] = "Erro ao ajustar valor"
      render 'new'
    end
  end
  
  def new
    @event_price = EventPrice.new()
    @event_price.price_type = params[:price_type]
    @event_price.event = Event.find(params[:event_id])
  end

  def create
    @event_price = EventPrice.new(event_price_params)
    if @event_price.save
      if @event_price.price_type == 'standard'
        flash[:notice] = 'Preço padrão ajustado'
      else
        flash[:notice] = 'Preço especial ajustado'
      end
      redirect_to @event_price.event
    else
      flash.now[:alert] = "Erro ao ajustar valor"
      render 'new'
    end
  end

  private
  def event_price_params 
    params.require(:event_price).permit(:base_value, :extra_per_hour,
                                        :extra_per_person, :price_type, :event_id)
  end

  def set_price
    @event_price = EventPrice.find(params[:id])
    if buffet_owner_signed_in? && current_buffet_owner.buffet != @event_price.event.buffet
      redirect_to current_buffet_owner.buffet, alert: 'Acesso não autorizado'
    end
  end

end