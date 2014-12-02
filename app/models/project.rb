class Project < ActiveRecord::Base

  resourcify
  
  # Validations
  validates :name, presence: true
  validates :description, presence: true
  validates :pretty_url, presence: true
  
  # Associations
  belongs_to :client, foreign_key: :client_id
  has_one :logo, :as => :imageable, :dependent => :destroy, :class_name => "Image::ProjectLogo"

  has_many :roles, -> { where resource_type: "Project"}, class_name: 'Role', foreign_key: :resource_id
  has_many :users, through: :roles

  has_many :project_links
  
  # return an active record relation object with the search query in its where clause
  # Return the ActiveRecord::Relation object
  # == Examples
  #   >>> project.search(query)
  #   => ActiveRecord::Relation object
  scope :search, lambda {|query| where("LOWER(projects.name) LIKE LOWER('%#{query}%') OR LOWER(projects.description) LIKE LOWER('%#{query}%')")
                        }
  
end
