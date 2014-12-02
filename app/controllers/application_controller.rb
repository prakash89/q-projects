class ApplicationController < ActionController::Base

  protect_from_forgery

  include ParamsParserHelper
  include FlashHelper
  include UrlHelper
  include TitleHelper
  include NavigationHelper
  include AuthenticationHelper
  include ActionController::HttpAuthentication::Token::ControllerMethods

  ## This filter method is used to fetch current user
  before_filter :current_user

end
