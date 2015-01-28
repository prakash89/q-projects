function validateProjectLinkForm() {

    $('#form_project_link').validate({
      debug: true,
      rules: {
        "project_link[link_type_id]": "required",
        "project_link[url]": "required"
      },
      errorElement: "span",
      errorClass: "help-block",
      messages: {
        "project_link[link_type_id]": "Please select a Link Type",
        "project_link[url]": "Please specify Url"
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
          errorHtml = "<div id='div_project_link_js_validation_error' class=\"alert alert-danger\" data-alert=\"alert\" style=\"margin-bottom:5px;\">"+ errorMessage +"</div>"
          $("#project_link_form_error").html(errorHtml);

          // Show error labels
          $("div.error").show();
        } else {
          // Hide error labels
          $("div.error").hide();

          // Removing the error message
          $("#project_link_form_error").remove();
        }
      }

    });

}
