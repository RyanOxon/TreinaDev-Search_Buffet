class OrdersController < ApplicationController
  before_action :authenticate_customer!, only: [:new, :create, :accept_proposal]
  before_action :set_event, only: [:new, :create]
  before_action :set_order, only:[:accept_proposal, :reject_proposal, :cancel, :show]
  before_action :check_order_inactivity, only: [:show]
  before_action :check_proposal_exp_date, only: [:show]

  def accept_proposal
    @order.confirmed!
    @order.service_proposal.confirmed!
    flash[:notice] = "Proposta aceita, o evento será realizado"
    redirect_to request.referrer
  end

  def reject_proposal
    @order.service_proposal.rejected!
    flash[:notice] = "Proposta recusada, aguardando nova proposta"
    redirect_to request.referrer
  end

  def cancel
    @order.canceled!
    @order.service_proposal.canceled! if @order.service_proposal.present?
    flash[:alert] = "Proposta cancelada, negociação encerrada"
    redirect_to request.referrer
  end

  def index
    if customer_signed_in?
      orders = current_customer.orders
    elsif buffet_owner_signed_in?
      orders = current_buffet_owner.buffet.orders
    else
      return redirect_to root_path
    end
    @open_orders = orders.where(status: ['waiting', 'negotiating'] )
    @closed_orders = orders.where.not(status: ['waiting', 'negotiating'] )
  end

  def show; end
  
  def new
    unless @event.buffet.active?
      return redirect_to root_path, alert: 'Não é possivel abrir novos pedidos para este buffet'
    end
    unless @event.active?
      return redirect_to root_path, alert: 'Não é possivel abrir novos pedidos para este evento'
    end
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.event = @event
    if @order.save()
      redirect_to @order, notice: 'Pedido enviado com sucesso'
    else
      flash.now[:alert] = 'Erro ao criar pedido'
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

  def set_order
    @order = Order.find(params[:id])
    unless user_signed_in_and_has_access?
      return redirect_to root_path, alert: 'Acesso não autorizado' 
    end
  end
  
  def user_signed_in_and_has_access?
    (customer_signed_in? && @order.customer == current_customer) || 
    (buffet_owner_signed_in? && @order.event.buffet == current_buffet_owner.buffet)
  end

  def check_order_inactivity
    if @order.inactivity?
      @order.canceled!
      flash[:alert] = "Pedido cancelado por inatividade do buffet"
    end
  end

  def check_proposal_exp_date
    if @order.service_proposal.present? && @order.service_proposal.expiration_date < Date.today
      @order.service_proposal.canceled!
      @order.canceled!
      flash[:alert] = "Proposta cancelada devido a data de validade"
    end
  end
end