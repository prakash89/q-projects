module ConfigCenter

  module GeneralValidations

    # xxxx@yyyy.zzz format
    EMAIL_FORMAT_REG_EXP = /\A(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})\z/i

    # xxx-xxx-xxxx format
    MOBILE_FORMAT_REG_EXP = /\A([0-9\(\)\/\+ \-]){3}-([0-9\(\)\/\+ \-]){3}-([0-9\(\)\/\+ \-]){4}\z/i

    # xxx-xxx-xxxx format
    PHONE_FORMAT_REG_EXP = /\A\(([0-9\(\)\/\+ \-]){3}\) ([0-9\(\)\/\+ \-]){3}-([0-9\(\)\/\+ \-]){4}\z/i

    # Generic Name
    # a to z (both upper and lower case), 1 to 9, space, dot(.) and curly brackets "(" & ")" allowed.
    NAME_MIN_LEN = 2
    NAME_MAX_LEN = 256
    NAME_FORMAT_REG_EXP = /\A[a-zA-Z1-9\-\ \(\)\.+]*\z/i

    # User Name
    # Minimum length is 6 by default and maximum length is 32 by default
    # Only characters (both upper and lowercase), numbers, dot(.), underscore (_)
    # No spaces, hyphen or any other special characters are allowed
    USERNAME_MIN_LEN = 6
    USERNAME_MAX_LEN = 128
    USERNAME_FORMAT_REG_EXP = /\A[a-zA-Z0-9\_]*\z/

    # Password
    # should have atleast 1 Character (a to z (both upper and lower case))
    # and 1 Number (1 to 9)
    # and 1 Special Character from (!,@,$,&,*,_)",
    PASSWORD_MIN_LEN = 7
    PASSWORD_MAX_LEN = 256
    PASSWORD_FORMAT_REG_EXP = /\A(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9!@$#&*_\.,;:])/
    # PASSWORD_FORMAT_REG_EXP = /\A(?=.*?[a-z][A-Z])(?=.*?\d)(?=.*?[!@$&*_])/i
  end

  module Defaults

    # Default password to be assigned while mocking a user
    PASSWORD = "Password@1"

    # Other constans should follow here.
    EXCLUDED_JSON_ATTRIBUTES = []

    ##
    def host
      case Rails.env
      when "development"
        'http://localhost:3000'
      when "it"
        'http://it.q-project.qwinixtech.com'
      when "uat"
        'http://uat.q-project.qwinixtech.com'
      when "production"
        'http://q-project.qwinixtech.com'
      else
        'http://localhost:3000'
      end
    end
  end

end
