function validateRoleForm() {

    $('#form_role').validate({
      debug: true,
      rules: {
        "role[member_id]": "required",
        "role[name]": "required"
      },
      errorElement: "span",
      errorClass: "help-block",
      messages: {
        "role[member_id]": "can't be blank",
        "role[name]": "can't be blank",
      },
      highlight: function(element) {
          $(element).parent().parent().addClass("has-error");
      },
      unhighlight: function(element) {
          $(element).parent().parent().removeClass("has-error");
      },
      invalidHandler: function(event, validator) {
        // 'this' refers to the form
        var errors = validator.numberOfInvalids();
        if (errors) {

          // Populating error message
          var errorMessage = errors == 1
            ? 'You missed 1 field. It has been highlighted'
            : 'You missed ' + errors + ' fields. They have been highlighted';

          // Removing the form error if it already exists
          errorHtml = "<div id='div_role_js_validation_error' class=\"alert alert-danger\" data-alert=\"alert\" style=\"margin-bottom:5px;\">"+ errorMessage +"</div>"
          $("#role_form_error").html(errorHtml);

          // Show error labels
          $("div.error").show();

        } else {
          // Hide error labels
          $("div.error").hide();

          // Removing the error message
          $("#role_form_error").remove();
        }
      }

    });

}
