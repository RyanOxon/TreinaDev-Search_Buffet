class ApplicationController < ActionController::Base
before_action :buffet_created?, if: :check_redirect

  def check_redirect
    buffet_owner_signed_in? && ![['buffets', 'new'], ['buffets', 'create'], 
                                ['sessions', 'destroy']]
                                .include?([controller_name, action_name])  
  end

  def buffet_created?
    unless current_buffet_owner.buffet
      flash[:alert] = "É necessario ter um buffet cadastrado para continuar"
      redirect_to new_buffet_path 
    end
  end
  
  def after_sign_in_path_for(resource)
    return new_buffet_path if buffet_owner_signed_in?
    root_path
  end
end
