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
    @link_type = LinkType.new(link_type_params)
    message = translate("forms.created_successfully", :item => "LinkType")
    admin_save_item(@link_type, message)
  end

  def update
    @link_type = LinkType.find(params[:id])
    @link_type.assign_attributes(link_type_params)
    message = translate("forms.updated_successfully", :item => "LinkType")
    admin_save_item(@link_type, message)
  end

  def destroy
    admin_destroy(:link_types, admin_link_types_url)
  end

  private

  def set_navs
    set_nav("admin/link_types")
  end

  def link_type_params
    params[:link_type].permit(:name, :description, :url, :button_text, :under_construction)
  end

end
