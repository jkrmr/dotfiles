# frozen_string_literal: true

Rails.application.config.generators do |g|
  g.orm :active_record, primary_key_type: :uuid
  g.stylesheets false
  g.template_engine :erb
  g.test_framework :rspec, view_specs: false, routing_specs: false
end
