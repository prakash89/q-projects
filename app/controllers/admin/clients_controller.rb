class Admin::ClientsController < Poodle::AdminController

  private

  def permitted_params
    params[:client].permit(:name, :description, :pretty_url ,:city, :state, :country)
  end

end
