class Admin::ClientsController < Admin::BaseController

  def index
    get_collections(:clients)
  end

  def show
    @client = Client.find(params[:id])
    render_list(:clients)
  end

  def new
    @client = Client.new
    render_list(:clients)
  end

  def edit
    @client = Client.find(params[:id])
    render_list(:clients)
  end

  def create
    @client = Client.new(client_params)
    message = translate("forms.created_successfully", :item => "Client")
    admin_save_item(@client, message)
  end

  def update
    @client = Client.find(params[:id])
    @client.assign_attributes(client_params)
    message = translate("forms.updated_successfully", :item => "Client")
    admin_save_item(@client, message)
  end

  def destroy
    admin_destroy(:clients, admin_clients_url)
  end

  private

  def set_navs
    set_nav("admin/clients")
  end

  def client_params
    params[:client].permit(:name, :description, :pretty_url ,:city, :state, :country)
  end

end
