class Admin::ProjectsController < Admin::BaseController

  def index

    get_collections

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
      format.js {}
    end
  end

  def show
    ## Creating the project object
    @project = Project.find(params[:id])

    respond_to do |format|
      format.html { get_collections and render :index }
      format.json { render json: @project }
      format.js {}
    end
  end

  def new
    ## Intitializing the project object
    @project = Project.new

    respond_to do |format|
      format.html { get_collections and render :index }
      format.json { render json: @project }
      format.js {}
    end
  end

  def edit
    ## Fetching the project object
    @project = Project.find(params[:id])

    respond_to do |format|
      format.html { get_collections and render :index }
      format.json { render json: @project }
      format.js {}
    end
  end

  def create
    ## Creating the project object
    @project = Project.new(project_params)

    ## Validating the data
    @project.valid?

    respond_to do |format|
      if @project.errors.blank?

        # Saving the project object
        @project.save

        # Setting the flash message
        message = translate("forms.created_successfully", :item => "Project")
        set_flash_message(message, :success)

        format.html {
          redirect_to project_url(@project), notice: message
        }
        format.json { render json: @project, status: :created, location: @project }
        format.js {}
      else

        # Setting the flash message
        message = @project.errors.full_messages.to_sentence
        set_flash_message(message, :alert)

        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
        format.js {}
      end
    end
  end

  def update
    ## Fetching the project
    @project = Project.find(params[:id])

    ## Updating the @project object with params
    @project.assign_attributes(project_params)

    ## Validating the data
    @project.valid?

    respond_to do |format|
      if @project.errors.blank?

        # Saving the project object
        @project.save

        # Setting the flash message
        message = translate("forms.updated_successfully", :item => "Project")
        set_flash_message(message, :success)

        format.html {
          redirect_to project_url(@project), notice: message
        }
        format.json { head :no_content }
        format.js {}

      else

        # Setting the flash message
        message = @project.errors.full_messages.to_sentence
        set_flash_message(message, :alert)

        format.html {
          render action: "edit"
        }
        format.json { render json: @project.errors, status: :unprocessable_entity }
        format.js {}

      end
    end
  end

  def destroy
    ## Fetching the project
    @project = Project.find(params[:id])

    respond_to do |format|
      ## Destroying the project
      @project.destroy
      @project = Project.new

      # Fetch the projects to refresh ths list and details box
      get_collections
      @project = @projects.first if @projects and @projects.any?

      # Setting the flash message
      message = translate("forms.destroyed_successfully", :item => "Project")
      set_flash_message(message, :success)

      format.html {
        redirect_to projects_url notice: message
      }
      format.json { head :no_content }
      format.js {}

    end
  end

  private

  def set_navs
    set_nav("admin/projects")
  end

  def project_params
    params[:project].permit(:name, :description, :pretty_url, :client_id)
  end

  def get_collections
    # Fetching the projects
    relation = Project.where("")
    @filters = {}

    if params[:query]
      @query = params[:query].strip
      relation = relation.search(@query) if !@query.blank?
    end

    @projects = relation.order("created_at desc").page(@current_page).per(@per_page)

    ## Initializing the @project object so that we can render the show partial
    @project = @projects.first unless @project

    return true

  end

end
