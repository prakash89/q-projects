class ApplicationController < ActionController::Base
  protect_from_forgery

  ## This filter method is used to fetch current user
  before_filter :current_user

  def render_list
    respond_to do |format|
      format.html { get_collections and render :index }
      format.js {}
    end
  end

  def render_or_redirect(error, redirect_url, action)
    respond_to do |format|
      format.html {
        if error
          render action: action
        else
          redirect_to redirect_url, notice: @message
        end
      }
      format.js {}
    end
  end

end
