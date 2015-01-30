class Role < ActiveRecord::Base
  SCRUM_MASTER = "Scrum Master"
  PRODUCT_OWNER = "Product Owner"
  STAKEHOLDER = "Stakeholder"
  AGILE_MENTOR = "Agile Mentor"
  SCRUM_TEAM_MEMBER = "Scrum Team Member"

  LIST = [SCRUM_MASTER, PRODUCT_OWNER, STAKEHOLDER, AGILE_MENTOR, SCRUM_TEAM_MEMBER]

  belongs_to :user
  belongs_to :project

  ## Validations
  validates :user, :presence=>true
  validates :project, :presence=>true
  validates :name, inclusion: LIST
  validates :user_id, uniqueness: {:scope => :project_id, message: "this user is already a member of this team"}
end
