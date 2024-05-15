class MessagesController < ApplicationController

  def create
    unless customer_signed_in? || buffet_owner_signed_in?
      return redirect_to root_path
    end
    @message = Message.new(params.require(:message).permit(:content))
    @message.user = current_customer if customer_signed_in?
    @message.user = current_buffet_owner.buffet if buffet_owner_signed_in?
    @order = Order.find(params[:order_id])
    @message.order = @order
    if @message.save
      redirect_to @order, notice: 'Mensagem enviada com sucesso!'
    else
      redirect_to @order, alert: 'Erro ao enviar mensagem'
    end

  end

  
end