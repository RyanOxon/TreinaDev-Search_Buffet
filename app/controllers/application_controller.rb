class ApplicationController < ActionController::Base
before_action :buffet_created?, if: :check_redirect

  def check_redirect
    buffet_owner_signed_in? && action_name != 'new' && action_name != 'destroy'
  end

  def buffet_created?
    flash[:alert] = "É necessario ter um buffet cadastrado para continuar"
    redirect_to new_buffet_path unless current_buffet_owner.buffet
  end
  
  def after_sign_in_path_for(resource)
    new_buffet_path # replace this with your desired path
  end
end
