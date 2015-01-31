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
    admin_create(:projects)
  end

  def update
    admin_update(:projects)
  end

  def destroy
    admin_destroy(:projects, admin_projects_url)
  end

  private

  def set_navs
    set_nav("admin/projects")
  end

  def permitted_params
    params[:project].permit(:name, :description, :pretty_url, :client_id)
  end

end
