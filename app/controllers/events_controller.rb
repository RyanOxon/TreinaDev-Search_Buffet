class EventsController < ApplicationController
  before_action :authenticate_buffet_owner!, only: [:new, :create]
  before_action :set_event, only: [:edit, :update, :show]
  before_action :set_lists, only: [:edit, :update, :new, :create]

  def index
    if buffet_owner_signed_in?
      @events = current_buffet_owner.buffet.events
    else
      @events = Event.all
    end
  end

  def edit; end

  def update
    @event = Event.new(event_params)
    @event.buffet = current_buffet_owner.buffet
    feature_ids = params[:event][:feature_ids].reject(&:blank?)
    if @event.save
      @event.features.destroy_all
      if feature_ids.any?
        feature_ids.each do |id|
          EventFeature.create!(event: @event, feature: Feature.find(id))
        end
      end
      redirect_to @event, notice: "Evento atualizado com sucesso"
    else
      flash.now[:alert] = "Erro ao atualizar evento"
      render :edit
    end
  end

  def show; end

  def new
    @event = Event.new
  end

  def create
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

  def set_event
    @event = Event.find(params[:id])
  end

  def set_lists
    @features = Feature.all
    @event_categories = EventCategory.all
  end
end