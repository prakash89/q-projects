module Public
  class UserSessionsController < ApplicationController

    before_filter :require_user, :only => :sign_out
    before_filter :set_navs

    layout 'sign_in'

    def sign_in
      if current_user
        redirect_to user_dashboard_url
        return
      else
        # Storing the user object
        # Redirect to the Q-Auth sign in page with required params
        params_hsh = {
                        client_app: ConfigCenter::Authentication::CLIENT_APP_NAME,
                        redirect_back_url: create_user_session_url
                      }
        url = add_query_params(ConfigCenter::Authentication::SIGN_IN_URL, params_hsh)
        redirect_to url
      end
    end

    def create_session
      response = User.create_session(params[:auth_token])
      if response.is_a?(User)
        @current_user = response
        session[:id] = @current_user.id
        redirect_to get_redirect_back_url
      else
        raise response["errors"]["name"]
      end
    end

    def sign_out

      store_flash_message("You have successfully signed out", :notice)

      # Reseting the auth token for user when he logs out.
      # @current_user.update_attribute :auth_token, SecureRandom.hex

      session.delete(:id)

      redirect_to default_redirect_url_after_sign_in
    end

    private

    def set_navs
      set_nav("Login")
    end

  end
end
