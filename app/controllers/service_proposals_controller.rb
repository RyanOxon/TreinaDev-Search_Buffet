class ServiceProposalsController < ApplicationController
  before_action :set_proposal, only: :update
  before_action :authenticate_buffet_owner!,  only: [:update, :create]


  def create
    @order = Order.find(params[:order_id])
    @service_proposal = ServiceProposal.new(proposal_params)
    @service_proposal.order = @order
    if @service_proposal.save
      @order.negotiating!
      redirect_to @service_proposal.order, notice: "Proposta enviada, aguardando confirmação do cliente"
    else
      render "orders/show"
    end
  end

  def update

    @order = Order.find(params[:order_id])
    if @service_proposal.update(proposal_params)
      @service_proposal.waiting!
      redirect_to @service_proposal.order, notice: "Proposta atualizada, aguardando confirmação do cliente"
    else
      flash.now[:alert] = 'Erro ao atualizar'
      render "orders/show"
    end
  end

  private
  def proposal_params
    params.require(:service_proposal).permit(:value, :extra_fee, :discount,
                                            :description, :expiration_date,
                                            :payment_method_id )
  end
  def set_proposal
    @service_proposal = ServiceProposal.find(params[:id])
    if buffet_owner_signed_in? && current_buffet_owner.buffet != @service_proposal.order.event.buffet
      redirect_to current_buffet_owner.buffet, alert: 'Acesso não autorizado'
    end  
  end
end