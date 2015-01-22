class LinkType < ActiveRecord::Base

  # Validations
  validates :name, presence: true

  # Associations
  has_one :picture, :as => :imageable, :dependent => :destroy, :class_name => "Image::LinkTypePicture"
  has_many :project_links

  # Callbacks
  before_save :chop_description

  def chop_description
    self.description = self.description[0..250]
  end

  # return an active record relation object with the search query in its where clause
  # Return the ActiveRecord::Relation object
  # == Examples
  #   >>> link_type.search(query)
  #   => ActiveRecord::Relation object
  scope :search, lambda {|query| where("LOWER(name) LIKE LOWER('%#{query}%') OR\
                                        LOWER(description) LIKE LOWER('%#{query}%') OR\
                                        LOWER(theme) LIKE LOWER('%#{query}%') OR\
                                        LOWER(button_text) LIKE LOWER('%#{query}%')")
                        }

end
