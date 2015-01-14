QAuthRubyClient.configure do |config|
  config.q_app_name = "Q-Projects"
  config.default_redirect_url_after_sign_in = "/user/dashboard"
  config.default_redirect_url_after_sign_out = "/"
end