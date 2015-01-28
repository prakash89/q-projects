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
    process_link_type(message, "new")
  end

  def update
    @link_type = LinkType.find(params[:id])
    @link_type.assign_attributes(link_type_params)
    message = translate("forms.updated_successfully", :item => "LinkType")
    process_link_type(message, "edit")
  end

  def destroy
    link_type = LinkType.find(params[:id])

    link_type.destroy
    get_collections(:link_types)

    message = translate("forms.destroyed_successfully", :item => "LinkType")
    set_flash_message(message, :success)

    respond_to do |format|
      format.html { redirect_to admin_link_types_url notice: message }
      format.js { render :index }
    end
  end

  private

  def set_navs
    set_nav("admin/link_types")
  end

  def link_type_params
    params[:link_type].permit(:name, :description, :url ,:theme, :button_text, :under_construction)
  end

  def process_link_type(message, action_name)
    @link_type.valid?
    if @link_type.errors.blank?
      @link_type.save
      set_flash_message(message, :success)
      redirect_url = admin_link_type_url(@link_type)
    else
      message = @link_type.errors.full_messages.to_sentence
      set_flash_message(message, :alert)
      redirect_url = nil
    end
    render_or_redirect(@link_type.errors.any?, redirect_url, action_name)
  end

end
