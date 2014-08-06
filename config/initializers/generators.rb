Rails.application.config.generators do |g|
  g.stylesheets false
  g.javascripts false
  g.helper false
  g.test_framework :rspec, view_specs: false, helper_specs: false, controller_specs: false
end

