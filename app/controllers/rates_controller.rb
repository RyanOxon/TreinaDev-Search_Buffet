class RatesController < ApplicationController
  before_action :authenticate_customer!, only: [:new]
  before_action :set_buffet, only: [:new, :create, :show, :index]

  def index; end

  def show
    @rate = Rate.find(params[:id])
  end

  def new
    @rate = Rate.new()
  end

  def create
    @rate = Rate.new(rate_params)
    @rate.buffet = @buffet
    @rate.customer = current_customer
    if @rate.save
      redirect_to buffet_rate_path(@buffet, @rate), notice: 'Avaliação enviada com sucesso!'
    else
      flash.now[:alert] = 'Erro ao enviar avaliação!'
      render :new
    end
  end

  private
  def set_buffet
    @buffet = Buffet.find(params[:buffet_id])
  end

  def rate_params
    params.require(:rate).permit(:score, :comment)
  end
end