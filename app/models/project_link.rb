class ProjectLink < ActiveRecord::Base

  # Validations
  validates :url,
    length: { :maximum => 510 },
    unless: proc {|link_type| link_type.url.blank?},
    format: {:with => /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix}

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
