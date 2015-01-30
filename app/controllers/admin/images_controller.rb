class Admin::ImagesController < Admin::BaseController

  skip_before_filter :set_navs, :parse_pagination_params

  def new
    image_type = params[:image_type] || "Image::Base"
    @image = image_type.constantize.new
  end

  def edit
    image_type = params[:image_type] || "Image::Base"
    @image = image_type.constantize.find(params[:id])
  end

  def create
    image_type = params[:image_type] || "Image::Base"
    resource = params[:imageable_type].constantize.find params[:imageable_id]
    @image = image_type.constantize.new
    @image.imageable = resource
    @image.image = params[:image][:image]
    @image.save
    populate_flash_message("Image has been created successfully")

    redirect_url = params[:redirect_url] || root_url
    render_or_redirect(@image.errors.any?, redirect_url, "new")
  end

  def update
    image_type = params[:image_type] || "Image::Base"
    @image = image_type.constantize.find(params[:id])
    @image.image = params[:image][:image]
    @image.save
    populate_flash_message("Image has been updated successfully")

    redirect_url = params[:redirect_url] || root_url
    render_or_redirect(@image.errors.any?, redirect_url, "edit")
  end

  private
  def populate_flash_message(message)
    if @image.errors.blank?
      message = translate(message)
      set_flash_message(message, :success, false)
    else
      message = @image.errors.full_messages.to_sentence
      set_flash_message(message, :alert, false)
    end
  end

end
