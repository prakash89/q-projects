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
    respond_to  do |format|
      format.html { get_collections and render :index }
      format.js {}
    end
  end

  def create
    @role = Role.new(params[:role].permit(:name))
    if params[:role] && params[:role][:member_id]
      @member = User.find_by_id(params[:role][:member_id])
      @role.member_id = @member.id if @member
    else
      @member = User.new
    end

    @role.resource = @project
    @role.valid?

    ## Check if the role is already added to this project
    project_users = @project.users
    if project_users.include?(@member)
      @role.errors.add(:member_id, "This user is already a member of this project.")
    end

    respond_to do |format|
      if @role.errors.blank?
        @member.add_role @role.name, @project
        message = "#{@member.name} has been added to the team as #{@role.name}"
        set_flash_message(message, :success)
        format.html { redirect_to role_url(@role), notice: message }
        format.js {}
      else
        message = @role.errors.full_messages.to_sentence
        set_flash_message(message, :alert)
        format.html { render action: "new" }
        format.js {}
      end
    end
  end

  def destroy
    @role = Role.find(params[:id])
    @member = User.find_by_id(params[:member_id]) if params[:member_id]
    @success = false
    if @member.roles.delete(@role)
      @success = true
      message = "#{@member.name} has been removed from the team"
      set_flash_message(message, :success)
    end
    respond_to do |format|
      format.html { redirect_to admin_project_url(@project), notice: message}
      format.js {}
    end
  end

  private

  def get_project
    @project = Project.find_by_id(params[:project_id])
  end

  def get_collections
    relation = @current_user.roles.where("resource_id = #{@project.id} and resource_type = 'Project'")
    if params[:query]
      @query = params[:query].strip
      relation = relation.search(@query) if !@query.blank?
    end
    @roles = relation.order("created_at desc").page(@current_page).per(@per_page)
    return true
  end

end
