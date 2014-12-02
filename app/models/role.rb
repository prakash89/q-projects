class Role < ActiveRecord::Base
  
  scopify

  attr_accessor :member_id

  has_and_belongs_to_many :users, :join_table => :users_roles
  belongs_to :resource, :polymorphic => true

  ## Validations
  validates :resource, :presence=>true, :unless => Proc.new { |x| [ConfigCenter::Roles::QDASH_SUPER_ADMIN, ConfigCenter::Roles::QDASH_ADMIN].include?(x.name) }
  validates :name, :presence=>true
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
