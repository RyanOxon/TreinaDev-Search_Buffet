class EventsController < ApplicationController
  def index
    @events = current_buffet_owner.buffet.events
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
    @features = Feature.all
    @event_categories = EventCategory.all
  end

  def create
    @features = Feature.all
    @event_categories = EventCategory.all
    @event = Event.new(event_params)
    @event.buffet = current_buffet_owner.buffet
    feature_ids = params[:event][:feature_ids].reject(&:blank?)
    if @event.save
      if feature_ids.any?
        feature_ids.each do |id|
          EventFeature.create!(event: @event, feature: Feature.find(id))
        end
      end
      redirect_to @event, notice: "Evento cadastrado com sucesso"
    else
      flash.now[:alert] = "Erro ao cadastrar evento"
      render :new
    end
  end

  private
  def event_params
    event_params = params.require(:event).permit(:name, :description, :min_capacity,
                                                :max_capacity, :default_duration,
                                                :menu, :event_category_id, :exclusive_address)
  end

end