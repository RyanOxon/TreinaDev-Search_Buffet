class Api::V1::EventsController < ActionController::API
  def index
    @buffet = Buffet.find_by(id: params[:buffet_id])
    @events = @buffet.events

    return render status: 404 if @events.nil?
    
    render json: @events.as_json(
                        only: [:id, :name, :description, :min_capacity, :max_capacity,
                        :default_duration, :menu, :exclusive_address],
                        include: {event_category: {only: [:id, :category]},
                                  features: {only: [:id, :feature]},
                                  event_prices: {only: [:price_type, :base_value, :extra_per_person, :extra_per_hour]}})
  end

  def availability
    unless params[:date] && params[:num_people]
      return render status: 400, json: { error: 'Missing required parameters' }
    end
  
    @event = Event.find_by(id: params[:id])
    return render status: 404 if @event.nil? 
  
    unless @event.date_available?(params[:date])
      return render status: 200, json: {available: false, reason: "date is not available"}
    end
    unless @event.capacity_available?(params[:num_people])
      return render status: 200, json: {available: false, reason: "number of people exceed event limit"}
    end

    render status: 200, json: {available: true}
  end
end