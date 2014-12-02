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
                        redirect_back_url: get_redirect_back_url
                      }
        url = add_query_params(ConfigCenter::Authentication::SIGN_IN_URL, params_hsh)
        # Update the user info
        # user_info = API.ping_user_info_url.get_user_info
        # current_user.update_attributes(user_info)
        # current_user.save
        redirect_to url
      end
    end

    def create_session
      login_handle = params[:login_handle]
      password = params[:login_password]

      begin
        obj = User.authenticate(login_handle, password)
        success = obj.first
        data = obj.last

        if success
          @current_user = data
          store_session
          redirect_to redirect_url_after_sign_in
        else
          store_flash_message("Invalid Login Handle or Password", :error)
          render :new
        end
      rescue CouldntConnectError
        url = ConfigCenter::Authentication::SIGN_IN_URL
        store_flash_message("Couldn't connect to Q-Auth Server. Please make sure that the authenticating server is running and the url #{url} is valid.", :error)
        render :new
      end
    end

    def sign_out

      store_flash_message("You have successfully signed out", :notice)

      # Reseting the auth token for user when he logs out.
      # @current_user.update_attribute :auth_token, SecureRandom.hex

      session.delete(:id)

      redirect_to redirect_url_after_sign_out
    end

    private

    def set_navs
      set_nav("Login")
    end

  end
end
