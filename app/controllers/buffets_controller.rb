class BuffetsController < ApplicationController
  before_action :set_buffet, only: :show

  def show; end

  def new
    redirect_to current_buffet_owner.buffet if current_buffet_owner.buffet
    @buffet = Buffet.new
    @payment_methods = PaymentMethod.all
  end

  def create
    @buffet = Buffet.new(buffet_params)
    @payment_methods = PaymentMethod.all
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
    buffet_params = params.require(:buffet).permit(:brand_name, :corporate_name, :registration, :phone_number,
                                                  :email, :address, :district, :city, :state_code, :zip_code,
                                                  :description)
  end

  def set_buffet
    @buffet = Buffet.find(params[:id])
  end
end