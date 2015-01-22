class Admin::ClientsController < Admin::BaseController

  def index
    get_collections

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @clients }
      format.js {}
    end
  end

  def show
    ## Creating the client object
    @client = Client.find(params[:id])

    respond_to do |format|
      format.html { get_collections and render :index }
      format.json { render json: @client }
      format.js {}
    end
  end

  def new
    ## Intitializing the client object
    @client = Client.new

    respond_to do |format|
      format.html { get_collections and render :index }
      format.json { render json: @client }
      format.js {}
    end
  end

  def edit
    ## Fetching the client object
    @client = Client.find(params[:id])

    respond_to do |format|
      format.html { get_collections and render :index }
      format.json { render json: @client }
      format.js {}
    end
  end

  def create
    ## Creating the client object
    @client = Client.new(client_params)

    ## Validating the data
    @client.valid?

    respond_to do |format|
      if @client.errors.blank?

        # Saving the client object
        @client.save

        # Setting the flash message
        message = translate("forms.created_successfully", :item => "Client")
        set_flash_message(message, :success)

        format.html {
          redirect_to admin_client_url(@client), notice: message
        }
        format.json { render json: @client, status: :created, location: @client }
        format.js {}
      else

        # Setting the flash message
        message = @client.errors.full_messages.to_sentence
        set_flash_message(message, :alert)

        format.html { render action: "new" }
        format.json { render json: @client.errors, status: :unprocessable_entity }
        format.js {}
      end
    end
  end

  def update
    ## Fetching the client
    @client = Client.find(params[:id])

    ## Updating the @client object with params
    @client.assign_attributes(client_params)

    ## Validating the data
    @client.valid?

    respond_to do |format|
      if @client.errors.blank?

        # Saving the client object
        @client.save

        # Setting the flash message
        message = translate("forms.updated_successfully", :item => "Client")
        set_flash_message(message, :success)

        format.html {
          redirect_to admin_client_url(@client), notice: message
        }
        format.json { head :no_content }
        format.js {}

      else

        # Setting the flash message
        message = @client.errors.full_messages.to_sentence
        set_flash_message(message, :alert)

        format.html {
          render action: "edit"
        }
        format.json { render json: @client.errors, status: :unprocessable_entity }
        format.js {}

      end
    end
  end

  def destroy
    ## Fetching the client
    @client = Client.find(params[:id])

    respond_to do |format|
      ## Destroying the client
      @client.destroy
      @client = Client.new

      # Fetch the clients to refresh ths list and details box
      get_collections
      @client = @clients.first if @clients and @clients.any?

      # Setting the flash message
      message = translate("forms.destroyed_successfully", :item => "Client")
      set_flash_message(message, :success)

      format.html {
        redirect_to admin_clients_url notice: message
      }
      format.json { head :no_content }
      format.js {}

    end
  end

  private

  def set_navs
    set_nav("admin/clients")
  end

  def client_params
    params[:client].permit(:name, :description, :pretty_url ,:city, :state, :country)
  end

  def get_collections
    # Fetching the clients
    relation = Client.where("")
    @filters = {}

    if params[:query]
      @query = params[:query].strip
      relation = relation.search(@query) if !@query.blank?
    end

    @clients = relation.order("created_at desc").page(@current_page).per(@per_page)

    ## Initializing the @client object so that we can render the show partial
    @client = @clients.first unless @client

    return true
  end

end
