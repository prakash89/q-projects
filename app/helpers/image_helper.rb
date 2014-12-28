module ImageHelper

  DEFAULT_PLACE_HOLDER_HEIGHT = 60
  DEFAULT_PLACE_HOLDER_WIDTH = 100
  DEFAULT_PLACE_HOLDER_TEXT = "<No Image>"

  # This method only works with carrier wave way of doing.
  # eg: user.profile_picture.image.large.url
  # Usage:
  # image_url(user, "profile_picture.image.large.url")
  # image_url(user, "profile_picture.image.large.url")
  # image_url(user, "profile_picture.image.large.url", {width: 40, height: 10})
  # Where as the hash contains width and height for the place holder incase if the object doesn't has the image object
  def image_url(object, eval_url, place_holder={})
    begin
      url = object.send :eval, eval_url
      raise if url.blank?
    rescue
      #binding.pry
      url = place_holder[:url] ? place_holder[:url] : "http://placehold.it/#{place_holder[:width]}x#{place_holder[:height]}&text=#{place_holder[:text]}"
    end
    return url
  end

  # This method will render the image with required width and height.
  # The image url will be set to the placeholder url if the object doesn't respond to the image method
  # Usage:
  # display_image(client, "logo.image.url")
  # display_image(client, "logo.image.url",
  #                       width: "100%", height:"100%")
  # display_image(client, "logo.image.url",
  #                       width: "100%", height:"100%",
  #                       place_holder: {width: 100, height: 50, text: "<No Image>"})
  def display_image(object, eval_url, hsh={})
    hsh[:width] = "100%" unless hsh[:width]
    hsh[:height] = "auto" unless hsh[:height]

    ph = hsh.has_key?(:place_holder) ? hsh[:place_holder] : {}
    ph[:width] = ph.has_key?(:width) ? ph[:width] : DEFAULT_PLACE_HOLDER_WIDTH
    ph[:height] = ph.has_key?(:height) ? ph[:height] : DEFAULT_PLACE_HOLDER_HEIGHT
    ph[:text] = ph.has_key?(:text) ? ph[:text] : DEFAULT_PLACE_HOLDER_TEXT
    hsh[:place_holder] = ph

    hsh[:style] = "" unless hsh[:style]
    hsh[:class] = "" unless hsh[:class]
    img_url = image_url(object, eval_url, ph)
    return image_tag img_url, class: hsh[:class], style: "width:#{hsh[:width]};height:#{hsh[:height]};#{hsh[:style]}"
  end

  def display_user_image(user, hsh)
    hsh[:width] = "100%" unless hsh[:width]
    hsh[:height] = "auto" unless hsh[:height]

    ph = hsh.has_key?(:place_holder) ? hsh[:place_holder] : {}
    ph[:width] = ph.has_key?(:width) ? ph[:width] : DEFAULT_PLACE_HOLDER_WIDTH
    ph[:height] = ph.has_key?(:height) ? ph[:height] : DEFAULT_PLACE_HOLDER_HEIGHT
    ph[:text] = ph.has_key?(:text) ? ph[:text] : DEFAULT_PLACE_HOLDER_TEXT
    hsh[:place_holder] = ph
    #binding.pry
    hsh[:style] = "" unless hsh[:style]
    hsh[:class] = "" unless hsh[:class]
    hsh[:size] = "thumb" unless hsh[:size]

    if user.send("#{hsh[:size]}_url").blank?
      url = "http://placehold.it/#{ph[:width]}x#{ph[:height]}&text=#{ph[:text]}"
    else
      url = ConfigCenter::QApps::QAUTH_URL + user.send("#{hsh[:size]}_url")
    end

    return image_tag url, class: hsh[:class], style: "width:#{hsh[:width]};height:#{hsh[:height]};#{hsh[:style]}"
  end

  ## Returns new photo url or edit existing photo url based on
  #  object is associated with photo or not
  # == Examples
  #   >>> upload_image_link(@user, admin_user_path(@user), :profile_picture)
  #   => "/admin/images/new" OR
  #   => "/admin/images/1/edit"
  def upload_image_link(object, redirect_url, assoc_name=:photo)

    photo_object = nil
    photo_object =  object.send(assoc_name) if object.respond_to?(assoc_name)
    #binding.pry
    if photo_object.present?
      edit_admin_image_path(photo_object,
                                 :redirect_url => redirect_url,
                                 :imageable_id => object.id,
                                 :imageable_type => object.class.to_s,
                                 :image_type => photo_object.class.name)
    else
      photo_object = object.send("build_#{assoc_name}")
      new_admin_image_path(:redirect_url => redirect_url,
                                 :imageable_id => object.id,
                                 :imageable_type => object.class.to_s,
                                 :image_type => photo_object.class.name)
    end
  end

end
