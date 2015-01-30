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
    admin_save_item(@project, message)
  end

  def update
    @project = Project.find(params[:id])
    @project.assign_attributes(project_params)
    message = translate("forms.updated_successfully", :item => "Project")
    admin_save_item(@project, message)
  end

  def destroy
    admin_destroy(:projects, admin_projects_url)
  end

  private

  def set_navs
    set_nav("admin/projects")
  end

  def project_params
    params[:project].permit(:name, :description, :pretty_url, :client_id)
  end

end
