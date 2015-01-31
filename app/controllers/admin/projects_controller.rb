class Admin::ProjectsController < Poodle::AdminController

  private

  def permitted_params
    params[:project].permit(:name, :description, :pretty_url, :client_id)
  end

end
