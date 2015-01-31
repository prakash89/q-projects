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
    admin_create(:clients)
  end

  def update
    admin_update(:clients)
  end

  def destroy
    admin_destroy(:clients, admin_clients_url)
  end

  private

  def set_navs
    set_nav("admin/clients")
  end

  def permitted_params
    params[:client].permit(:name, :description, :pretty_url ,:city, :state, :country)
  end

end
