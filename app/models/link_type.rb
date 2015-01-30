class LinkType < ActiveRecord::Base

  # Validations
  validates :name,
    presence: true,
    length: {:minimum => 3, :maximum => 250 }

  validates :description,
    length: {:minimum => 3, :maximum => 2050 },
    unless: proc {|client| client.description.blank?}

  # Associations
  has_many :project_links
  has_one :picture, :as => :imageable, :dependent => :destroy, :class_name => "Image::LinkTypePicture"

  # return an active record relation object with the search query in its where clause
  # Return the ActiveRecord::Relation object
  # == Examples
  #   >>> link_type.search(query)
  #   => ActiveRecord::Relation object
  scope :search, lambda {|query| where("LOWER(name) LIKE LOWER('%#{query}%') OR\
                                        LOWER(description) LIKE LOWER('%#{query}%') OR\
                                        LOWER(button_text) LIKE LOWER('%#{query}%')")
                        }
end
