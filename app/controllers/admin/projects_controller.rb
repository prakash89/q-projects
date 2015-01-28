class Admin::ProjectsController < Admin::BaseController

  def index
    get_collections(:projects)
  end

  def show
    @project = Project.find(params[:id])
    render_list(:projects)
  end

  def new
    @project = Project.new
    render_list(:projects)
  end

  def edit
    @project = Project.find(params[:id])
    render_list(:projects)
  end

  def create
    @project = Project.new(project_params)
    message = translate("forms.created_successfully", :item => "Project")
    process_project(message, "new")
  end

  def update
    @project = Project.find(params[:id])
    @project.assign_attributes(project_params)
    message = translate("forms.updated_successfully", :item => "Project")
    process_project(message, "edit")
  end

  def destroy
    project = Project.find(params[:id])

    project.destroy
    get_collections(:projects)

    message = translate("forms.destroyed_successfully", :item => "Project")
    set_flash_message(message, :success)

    respond_to do |format|
      format.html { redirect_to admin_projects_url notice: message }
      format.js { render :index }
    end
  end

  private

  def set_navs
    set_nav("admin/projects")
  end

  def project_params
    params[:project].permit(:name, :description, :pretty_url, :client_id)
  end

  def process_project(message, action_name)
    @project.valid?
    if @project.errors.blank?
      @project.save
      set_flash_message(message, :success)
      redirect_url = admin_project_url(@project)
    else
      message = @project.errors.full_messages.to_sentence
      set_flash_message(message, :alert)
      redirect_url = nil
    end
    render_or_redirect(@project.errors.any?, redirect_url, action_name)
  end

end
