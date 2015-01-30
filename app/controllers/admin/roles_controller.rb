class Admin::RolesController < Admin::BaseController

  before_filter :get_project
  skip_before_filter :set_navs, :parse_pagination_params

  def refresh
    User.fetch_all_users(current_user.auth_token)
    @role = Role.new
    render action: :new
  end

  def new
    @role = Role.new
  end

  def create
    @user = User.find_by_id(role_params[:user_id])
    @role = @project.add_role(@user, role_params[:name])
    if @role.errors.blank?
      message = "#{@user.name} has been added to the team as #{@role.name}"
      set_flash_message(message, :success)
    end
  end

  def destroy
    @role = Role.find_by_id(params[:id])
    @project.remove_role(@role)
    message = "#{@role.user.name} has been removed from the team"
    set_flash_message(message, :success)
  end

  private

  def get_project
    @project = Project.find_by_id(params[:project_id])
  end

  def role_params
    params[:role].permit(:name, :user_id)
  end

  def get_collections
    @roles = @project.roles.order("created_at desc").page(@current_page).per(@per_page)
    return true
  end

end
