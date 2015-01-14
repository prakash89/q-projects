class ApplicationController < ActionController::Base
  protect_from_forgery

  helper Poodle::Engine.helpers
  include Poodle::ParamsParserHelper
  include Poodle::FlashHelper
  include Poodle::UrlHelper
  include Poodle::TitleHelper
  include Poodle::ImageHelper
  include Poodle::NavigationHelper
  include Poodle::NotificationHelper
  include QAuthRubyClient::SessionsHelper

  ## This filter method is used to fetch current user
  before_filter :current_user

end
