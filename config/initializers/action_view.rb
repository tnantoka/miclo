Rails.application.config.action_view.field_error_proc = -> (html_tag, instance) {
  %Q(<div class="field_with_errors has-error">#{html_tag}</div>).html_safe
}
