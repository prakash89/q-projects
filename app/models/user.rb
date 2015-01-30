class User < QAuthRubyClient::User

  # Associations
  has_many :roles
  has_many :projects, through: :roles
end
