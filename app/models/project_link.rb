class ProjectLink < ActiveRecord::Base

  extend UrlValidator

  validate_url :url

  validates :link_type, presence: true
  validates :project, presence: true

  # Associations
  belongs_to :project
  belongs_to :link_type

  # Callbacks
  before_validation :format_url

  def format_url
    self.url = "http://" + url if url && !url.start_with?("http")
  end

end
