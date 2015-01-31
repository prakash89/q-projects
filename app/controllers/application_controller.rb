class ApplicationController < ActionController::Base
  protect_from_forgery

  ## This filter method is used to fetch current user
  before_filter :current_user, :set_default_title

  private

  def set_default_title
    set_title("Q-Projects")
  end

end
