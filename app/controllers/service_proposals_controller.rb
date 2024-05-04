class ServiceProposalsController < ApplicationController

  def create
    @order = Order.find(params[:order_id])
    @service_proposal = ServiceProposal.new(proposal_params)
    @service_proposal.order = @order
    if @service_proposal.save
      @order.update!(status: 1)
      redirect_to @service_proposal.order, notice: "Proposta enviada, aguardando confirmação do cliente"
    else
      render "orders/show"
    end
  end

  def update
    @order = Order.find(params[:order_id])
    if @service_proposal.update(proposal_params, status: 0)
      redirect_to @service_proposal.order, notice: "Proposta atualizada, aguardando confirmação do cliente"
    else
      render "orders/show"
    end
  end

  def proposal_params
    params.require(:service_proposal).permit(:value, :extra_fee, :discount,
                                            :description, :expiration_date,
                                            :payment_method_id )
  end
end