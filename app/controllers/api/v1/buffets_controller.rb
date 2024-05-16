class Api::V1::BuffetsController < ActionController::API
  def index
    if params[:search]
      @buffets = Buffet.where('brand_name LIKE ?', "%#{params[:search]}%").where(active: true)
    else
      @buffets = Buffet.where(active: true)
    end

    render json: @buffets.as_json(
                        only: [ :id, :brand_name, :city, :state_code, :description],
                        include: {payment_methods: {only: [:id], methods: :humanized_method_name }})
  end

  def show
    @buffet = Buffet.find_by(id: params[:id])

    return render status: 404 if @buffet.nil? || !@buffet.active?

    render json: @buffet.as_json(
                        only: [ :id, :brand_name, :phone_number, :email, :address,
                         :district, :city, :state_code, :zip_code, :description],
                         methods: :average,
                         include: {payment_methods: {only: [:id], methods: :humanized_method_name }})
  end
end