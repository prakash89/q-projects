class ApplicationController < ActionController::Base
  protect_from_forgery

  ## This filter method is used to fetch current user
  before_filter :current_user, :set_default_title

  private

  def set_default_title
    set_title("Q-Projects")
  end

  def defaultize_options(collection_name, options)
    options.reverse_merge!(
      kls: collection_name.to_s.camelize.singularize.camelize.constantize
    )
    options.reverse_merge!(
      message: translate("forms.destroyed_successfully", :item => options[:kls].name)
    )
    options
  end

  def admin_create(collection_name, **options)
    options = defaultize_options(collection_name, options)
    obj = options[:kls].new(permitted_params)
    instance_variable_set("@#{collection_name.to_s.singularize}", obj)
    admin_save_item(obj, options[:message])
  end

  def admin_update(collection_name, **options)
    options = defaultize_options(collection_name, options)
    obj = options[:kls].find(params[:id])
    obj.assign_attributes(permitted_params)
    instance_variable_set("@#{collection_name.to_s.singularize}", obj)
    admin_save_item(obj, options[:message])
  end

  def admin_save_item(obj, message)
    obj.save
    set_flash_message(message, :success) if obj.errors.blank?
    action_name = params[:action].to_s == "create" ? "new" : "edit"
    url = obj.persisted? ? url_for([:admin, obj]) : nil
    render_or_redirect(obj.errors.any?, url, action_name)
  end

  def admin_destroy(collection_name, redirect_url, **options)
    options = defaultize_options(collection_name, options)
    obj = options[:kls].find(params[:id])
    obj.destroy
    get_collections(collection_name)
    set_flash_message(options[:message], :success)
    respond_to do |format|
      format.html { redirect_to redirect_url, notice: options[:message] }
      format.js { render :index }
    end
  end

end
