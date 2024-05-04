class OrdersController < ApplicationController
  before_action :authenticate_customer!, only: [:new, :create]
  before_action :set_event, only: [:new, :create]

  def accept_proposal
    @order = Order.find(params[:id])
    @order.update!(status: "confirmed")
    @order.service_proposal.update!(status: "confirmed")
    flash[:notice] = "Proposta aceita, o evento será realizado"
    redirect_to request.referrer || root_url
  end

  def index
    if customer_signed_in?
      orders = current_customer.orders
    elsif buffet_owner_signed_in?
      orders = current_buffet_owner.buffet.orders
    else
      redirect_to root_path
    end
    @open_orders = orders.where(status: [0, 1] )
    @closed_orders = orders.where.not(status: [0, 1])
  end

  def show
    @order = Order.find(params[:id])
  end
  
  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.event = @event
    if @order.save!
      redirect_to @order, notice: 'Pedido enviado com sucesso'
    else
      flash.now[:alert] = 'Erro ao enviar Pedido'
      render :new
    end
  end

  private
  def order_params
    params.require(:order).permit(:date, :people_count, :details, :address)
  end

  def set_event
    @event = Event.find(params[:event_id])
  end
end