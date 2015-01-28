class Role < ActiveRecord::Base

  scopify

  attr_accessor :member_id

  QDASH_SUPER_ADMIN = "Q-Dash Super Admin"
  QDASH_ADMIN = "Q-Dash Admin"

  SCRUM_MASTER = "Scrum Master"
  PRODUCT_OWNER = "Product Owner"
  STAKEHOLDER = "Stakeholder"
  AGILE_MENTOR = "Agile Mentor"
  SCRUM_TEAM_MEMBER = "Scrum Team Member"

  LIST = [SCRUM_MASTER, PRODUCT_OWNER, STAKEHOLDER, AGILE_MENTOR, SCRUM_TEAM_MEMBER]
  ADMIN_ROLES = [QDASH_SUPER_ADMIN, QDASH_ADMIN]

  has_and_belongs_to_many :users, :join_table => :users_roles
  belongs_to :resource, :polymorphic => true

  ## Validations
  validates :resource, :presence=>true, :unless => Proc.new { |x| [ConfigCenter::Roles::QDASH_SUPER_ADMIN, ConfigCenter::Roles::QDASH_ADMIN].include?(x.name) }
  validates :name, :presence=>true
  validates :member_id, :presence=>true
  validate  :validate_role_resource_combination

  def validate_role_resource_combination
    case self.name
    when ConfigCenter::Roles::QDASH_SUPER_ADMIN, ConfigCenter::Roles::QDASH_ADMIN
    	self.resource = nil
    else
    	self.errors.add(:resource, "Please select a Project") if self.resource.blank?
    end
  end

end
