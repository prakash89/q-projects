class Client < ActiveRecord::Base

  extend UrlValidator

  # Validations
  validates :name,
    presence: true,
    length: {:minimum => 3, :maximum => 250 }

  validates :description,
    length: {:minimum => 3, :maximum => 2050 },
    unless: proc {|client| client.description.blank?}

  validate_url :pretty_url

  # Callbacks
  before_validation :format_pretty_url, unless: proc {|client| client.pretty_url.blank?}

  # Associations
  has_many :projects
  has_many :users
  has_one :logo, :as => :imageable, :dependent => :destroy, :class_name => "Image::ClientLogo"

  # return an active record relation object with the search query in its where clause
  # Return the ActiveRecord::Relation object
  # == Examples
  #   >>> project.search(query)
  #   => ActiveRecord::Relation object
  scope :search, lambda {|query| where("LOWER(clients.name) LIKE LOWER('%#{query}%') OR LOWER(clients.description) LIKE LOWER('%#{query}%') OR LOWER(clients.city) LIKE LOWER('%#{query}%') OR LOWER(clients.state) LIKE LOWER('%#{query}%') OR LOWER(clients.country) LIKE LOWER('%#{query}%')")}

  # * Return address which includes city, state & country
  # == Examples
  #   >>> client.display_address
  #   => "Mysore, Karnataka, India"
  def display_address
    address_list = []
    address_list << city unless city.blank?
    address_list << state unless state.blank?
    address_list << country unless country.blank?
    address_list.join(", ")
  end

  def format_pretty_url
    self.pretty_url = "http://" + pretty_url if pretty_url && !pretty_url.start_with?("http")
  end

end
