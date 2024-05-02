class OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
  end
  
  def new
    @event = Event.find(params[:event_id])
    @order = Order.new
  end

  def create
    @event = Event.find(params[:event_id])
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.status = 0
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
end