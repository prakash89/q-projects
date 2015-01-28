function validateLinkTypeForm() {

    $('#form_link_type').validate({
      debug: true,
      rules: {
        "link_type[name]": {
            required: true,
            minlength: 2,
            maxlength: 50
        },
      },
      errorElement: "span",
      errorClass: "help-block",
      messages: {
        "link_type[name]": "can't be blank"
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
          errorHtml = "<div id='div_link_type_js_validation_error' class=\"alert alert-danger\" data-alert=\"alert\" style=\"margin-bottom:5px;\">"+ errorMessage +"</div>"
          $("#link_type_form_error").html(errorHtml);

          // Show error labels
          $("div.error").show();
        } else {
          // Hide error labels
          $("div.error").hide();

          // Removing the error message
          $("#link_type_form_error").remove();
        }
      }

    });

}
