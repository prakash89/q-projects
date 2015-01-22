module Api
  module V1
    class ClientsController < Api::V1::BaseController

      skip_before_filter :require_auth_token
      before_filter :require_admin_auth_token, :parse_pagination_params

      def show
        prepare_data { Client.find_by_id(params[:id]) }
        render_json
      end

      def index
        proc_code = Proc.new do
          relation = Client.where("")
          relation = relation.search(params[:query].strip) if params[:query] && !params[:query].blank?

          @data = relation.order("name asc").page(@current_page).per(@per_page)
          @success = true
        end
        render_json_response(proc_code)
      end

    end
  end
end
