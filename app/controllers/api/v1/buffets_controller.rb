class Api::V1::BuffetsController < ActionController::API
  def index
    if params[:search]
      @buffets = Buffet.where('brand_name LIKE ?', "%#{params[:search]}%")
    else
      @buffets = Buffet.all
    end

    render json: @buffets.as_json(
                        only: [ :id, :brand_name, :city, :state_code, :description],
                        include: {payment_methods: {only: [:id, :method]}})
  end

  def show
    @buffet = Buffet.find_by(id: params[:id])

    return render status: 404 if @buffet.nil?

    render json: @buffet.as_json(
                        only: [ :id, :brand_name, :phone_number, :email, :address,
                         :district, :city, :state_code, :zip_code, :description],
                        include: {payment_methods: {only: [:id, :method]}})
  end
end