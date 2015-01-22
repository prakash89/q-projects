class Admin::ClientsController < Admin::BaseController

  def index
    get_collections
  end

  def show
    @client = Client.find(params[:id])
    render_list
  end

  def new
    @client = Client.new
    render_list
  end

  def edit
    @client = Client.find(params[:id])
    render_list
  end

  def create
    @client = Client.new(client_params)
    @client.valid?

    if @client.errors.blank?
      @client.save

      message = translate("forms.created_successfully", :item => "Client")
      set_flash_message(message, :success)
    else
      message = @client.errors.full_messages.to_sentence
      set_flash_message(message, :alert)
    end

    render_or_redirect(@client.errors.any?, admin_client_url(@client), "new")
  end

  def update
    @client = Client.find(params[:id])
    @client.assign_attributes(client_params)
    @client.valid?

    if @client.errors.blank?
      @client.save

      message = translate("forms.updated_successfully", :item => "Client")
      set_flash_message(message, :success)
    else
      message = @client.errors.full_messages.to_sentence
      set_flash_message(message, :alert)
    end

    render_or_redirect(@client.errors.any?, admin_client_url(@client), "edit")
  end

  def destroy
    @client = Client.find(params[:id])

    @client.destroy
    get_collections
    @client = @clients and @clients.any? ? @clients.first : Client.new

    message = translate("forms.destroyed_successfully", :item => "Client")
    set_flash_message(message, :success)

    respond_to do |format|
      format.html { redirect_to admin_clients_url notice: message }
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
