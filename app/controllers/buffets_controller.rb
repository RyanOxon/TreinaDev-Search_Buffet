class BuffetsController < ApplicationController
  before_action :set_buffet, only: [:show, :edit, :update]
  before_action :payment_methods, only: [:edit, :update, :new, :create]
  before_action :authenticate_buffet_owner!,  only: [:edit, :update, :new, :create]

  def index
    redirect_to current_buffet_owner.buffet if buffet_owner_signed_in?
    @buffets = Buffet.all
  end

  def search
    @search = params[:query]
    category_value = revert_i18n(@search)
    @buffet = Buffet.find_by(brand_name: @search)
    return redirect_to @buffet if @buffet.present?
    @buffets = Buffet.left_outer_joins(events: :event_category )
              .where("buffets.brand_name LIKE ? OR buffets.city = ? OR event_categories.category = ?", 
              "%#{@search}%", @search, category_value).distinct.order('buffets.brand_name ASC')
  end

  def show
    @events = @buffet.events
  end

  def edit; end

  def update
    payment_methods_ids = params[:buffet][:payment_method_ids].reject(&:blank?)
    if payment_methods_ids.any? && @buffet.update(buffet_params)
      @buffet.buffet_payment_methods.destroy_all
      payment_methods_ids.each do |id|
        method = PaymentMethod.find(id)
        BuffetPaymentMethod.create!(buffet: @buffet, payment_method: method)
      end
    redirect_to @buffet, notice: 'Buffet atualizado com sucesso'
    else
      @buffet.errors.add(:payment_method_ids, "não pode ficar em branco") unless payment_methods_ids.any?
      flash.now[:alert] = "Erro ao atualizar Buffet"
      render :edit
    end
  end

  def new
    if current_buffet_owner.buffet.present?
      redirect_to current_buffet_owner.buffet, notice: 'Voce ja possui um buffet'
    end
    @buffet = Buffet.new
  end

  def create
    @buffet = Buffet.new(buffet_params)
    @buffet.buffet_owner = current_buffet_owner
    payment_methods_ids = params[:buffet][:payment_method_ids].reject(&:blank?)
    
    if payment_methods_ids.any? && @buffet.save
      payment_methods_ids.each do |id|
        method = PaymentMethod.find(id)
        BuffetPaymentMethod.create!(buffet: @buffet, payment_method: method)
      end
      redirect_to @buffet, notice: "Buffet cadastrado com sucesso"
    else
      @buffet.errors.add(:payment_method_ids, "não pode ficar em branco") unless payment_methods_ids.any?
      flash.now[:alert] = "Erro ao cadastrar Buffet"
      render :new
    end
  end


  private
  def buffet_params
    params.require(:buffet).permit(:brand_name, :corporate_name,
                                                  :registration, :phone_number,
                                                  :email, :address, :district, 
                                                  :city, :state_code, :zip_code,
                                                  :description)
  end

  def set_buffet
    @buffet = Buffet.find(params[:id])
    if buffet_owner_signed_in? && current_buffet_owner != @buffet.buffet_owner
      redirect_to current_buffet_owner.buffet, alert: 'Acesso não autorizado'
    end
  end

  def payment_methods
    @payment_methods = PaymentMethod.all
  end

  def revert_i18n(translated_category)
    categories_i18n = EventCategory.categories.keys.map {|key| [
                      I18n.t("activerecord.attributes.event_category.category.#{key}"), key]}.to_h
    EventCategory.categories[categories_i18n[translated_category]]
  end
end