class EventsController < ApplicationController
  before_action :authenticate_buffet_owner!, only: [:new, :create, :edit, :update]
  before_action :set_event, only: [:edit, :update, :show, :cover, :disable, :activate]
  before_action :set_lists, only: [:edit, :update, :new, :create]

  def disable
    @event.update(active: false)
    redirect_to @event, notice: 'Evento desativado com sucesso'
  end

  def activate
    @event.update(active: true)
    redirect_to @event, notice: 'Evento reativado com sucesso'
  end

  def cover
    unless params[:cover] && @event.holder_images.exists?(params[:cover])
      return redirect_to @event, alert: 'Imagem não encontrada' 
    end
    cover_photo = @event.holder_images.find(params[:cover])
    if @event.update(cover_photo: cover_photo)
      redirect_to @event, notice: 'Capa atualizada com sucesso'
    end
  end

  def index
    if buffet_owner_signed_in?
      @events = current_buffet_owner.buffet.events
    else
      redirect_to root_path
    end
  end

  def edit; end

  def update
    feature_ids = params[:event][:feature_ids].reject(&:blank?)
    if @event.update(event_params)
      @event.set_features(feature_ids)
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
      @event.set_features(feature_ids)
      redirect_to @event, notice: "Evento cadastrado com sucesso"
    else
      flash.now[:alert] = "Erro ao cadastrar evento"
      render :new
    end
  end

  private
  def event_params
    params.require(:event).permit(:name, :description, :min_capacity,
                                  :max_capacity, :default_duration,
                                  :menu, :event_category_id, :exclusive_address,
                                  imageable_images_attributes: [:image, :user_id])
  end

  def set_event
    @event = Event.find(params[:id])
    if buffet_owner_signed_in? && current_buffet_owner != @event.buffet.buffet_owner
      redirect_to current_buffet_owner.buffet, alert: 'Acesso não autorizado'
    end
  end

  def set_lists
    @features = Feature.all
    @event_categories = EventCategory.all
  end

end