class OrdersController < ApplicationController
  before_action :set_event, only: [:new, :create]

  def index
    @orders = current_customer.orders
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