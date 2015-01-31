class Admin::LinkTypesController < Poodle::AdminController
  private

  def permitted_params
    params[:link_type].permit(:name, :description, :url, :button_text, :under_construction)
  end

end
