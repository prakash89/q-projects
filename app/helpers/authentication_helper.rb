module AuthenticationHelper

  # Returns the default URL to which the system should redirect the user after successful authentication
  def default_redirect_url_after_sign_in
    user_dashboard_url
  end

  # Returns the default URL to which the system should redirect the user after an unsuccessful attempt to authorise a resource/page
  def default_sign_in_url
    user_sign_in_url
  end

  def user_profile_url
    ConfigCenter::QApps::QAUTH_URL + "/user/profile"
  end

  def update_user_profile_data_and_auth_token
    # Storing the user object
    # Redirect to the Q-Auth sign in page with required params
    params_hsh = {
                    client_app: ConfigCenter::Authentication::CLIENT_APP_NAME,
                    redirect_back_url: create_user_session_url
                  }
    url = add_query_params(ConfigCenter::Authentication::SIGN_IN_URL, params_hsh)
    redirect_to url
  end

  def current_user
    return @current_user if @current_user
    # Check if the user exists with the auth token present in session
    @current_user = User.find_by_id(session[:id])
  end

  def require_user
    current_user
    if @current_user
      update_user_profile_data_and_auth_token if @current_user.token_expired?
    else
      @heading = translate("authentication.error")
      @alert = translate("authentication.permission_denied")
      store_flash_message("#{@heading}: #{@alert}", :errors)
      redirect_to default_sign_in_url
    end
  end

  def require_admin
    current_user
    unless (@current_user && (@current_user.is_super_admin? || @current_user.is_admin?))
      @heading = translate("authentication.error")
      @alert = translate("authentication.permission_denied")
      store_flash_message("#{@heading}: #{@alert}", :errors)
      redirect_to default_sign_in_url
    end
  end

  def require_super_admin
    current_user
    unless (@current_user && @current_user.is_super_admin?)
      @heading = translate("authentication.error")
      @alert = translate("authentication.permission_denied")
      store_flash_message("#{@heading}: #{@alert}", :errors)
      redirect_to default_sign_in_url
    end
  end

  def get_redirect_back_url
    session[:redirect_back_url] || default_redirect_url_after_sign_in
  end

  # def redirect_url_if_sign_in_fails
  #   sign_in_url
  # end

  # def redirect_url_after_sign_in
  #   home_url
  # end

  # def redirect_url_after_sign_out
  #   sign_in_url
  # end

  # def redirect_if_signed_in
  #   redirect_to redirect_url_after_sign_in if current_user
  # end

  # def redirect_unless_signed_in
  #   redirect_to redirect_url_if_sign_in_fails unless current_user
  # end

end
