class Admin::ProjectLinksController < Admin::BaseController

  before_filter :get_project
  skip_before_filter :set_navs, :parse_pagination_params

  def new
    @project_link = ProjectLink.new
    @link_type = @project_link.link_type
  end

  def edit
    @project_link = ProjectLink.find(params[:id])
    @link_type = @project_link.link_type
  end

  # POST /project_links
  def create
    @project_link = ProjectLink.new(project_link_params)
    @project_link.project = @project
    @project.project_links << @project_link
    if @project_link.errors.blank?
      message = translate("Project Link has been added successfully")
      set_flash_message(message, :success)
    end
  end

  def update
    @project_link = ProjectLink.find(params[:id])
    @project_link.assign_attributes(project_link_params)
    @project_link.under_construction = params[:project_link][:under_construction] == "under_construction"
    @project_link.save
    if @project_link.errors.blank?
      message = translate("Project Link has been updated successfully")
      set_flash_message(message, :success)
    end
  end

  def destroy
    @project_link = ProjectLink.find(params[:id])
    @success = false
    if @project_link.destroy
      @success = true
    else
      message = translate("forms.destroyed_successfully", :item => "Project Link")
      set_flash_message(message, :success)
    end
  end

  private

  def get_project
    @project = Project.find_by_id(params[:project_id])
  end

  def project_link_params
    params[:project_link].permit(:url, :link_type_id, :under_construction)
  end

  def get_collections
    # Fetching the project_links
    relation = @project.project_links.where("project_id = #{@project.id}")

    if params[:query]
      @query = params[:query].strip
      relation = relation.search(@query) if !@query.blank?
    end

    @project_links = relation.order("created_at desc").page(@current_page).per(@per_page)

    ## Initializing the @project_link object so that we can render the show partial
    @project_link = @project_links.first unless @project_link

    return true

  end

end
