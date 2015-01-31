class Admin::LinkTypesController < Admin::BaseController

  def index
    get_collections(:link_types)
  end

  def show
    @link_type = LinkType.find(params[:id])
    render_list(:link_types)
  end

  def new
    @link_type = LinkType.new
    render_list(:link_types)
  end

  def edit
    @link_type = LinkType.find(params[:id])
    render_list(:link_types)
  end

  def create
    admin_create(:link_types)
  end

  def update
    admin_update(:link_types)
  end

  def destroy
    admin_destroy(:link_types, admin_link_types_url)
  end

  private

  def set_navs
    set_nav("admin/link_types")
  end

  def permitted_params
    params[:link_type].permit(:name, :description, :url, :button_text, :under_construction)
  end

end
