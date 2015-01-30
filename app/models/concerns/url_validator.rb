module UrlValidator
  def validate_url(attribute, maxlength=510)
    validates attribute,
      length: { :maximum => maxlength },
      format: {:with => /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix},
      unless: proc {|record| record.send(attribute).blank?}
  end
end