class EventPricesController < ApplicationController

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
    event_price_params = params.require(:event_price).permit(:base_value, :extra_per_hour,
                                        :extra_per_person, :price_type, :event_id)
    
  end

end