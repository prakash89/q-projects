class Client < ActiveRecord::Base

  # Validations
  validates :name, presence: true
  validates :pretty_url, presence: true

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

end
