class ProjectLink < ActiveRecord::Base
  
  # Validations
  validates :link_type, presence: true
  validates :url, presence: true
  validates :project, presence: true
  
  # Associations
  belongs_to :project
  belongs_to :link_type
  
end
