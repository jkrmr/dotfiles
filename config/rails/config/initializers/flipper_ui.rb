# frozen_string_literal: true

# Flipper UI configuration

Flipper::UI.configure do |config|
  # descriptions loaded from YAML file or database (postgres, mysql, etc)
  # return has to be hash of {String key => String description}
  config.descriptions_source = lambda { |keys|
    # TODO: Add FeatureFlag builder
    # TODO: Add FeatureFlaggable mixin
  }

  # Disable TSwift greeting video
  config.fun = false

  # Set to true to show feature descriptions on the list page as well as the
  # view page.
  config.show_feature_description_in_list = true

  config.banner_text = "[#{Rails.env}] Feature Flags"
  config.banner_class =
    case Rails.env.to_sym
    when :production then "danger"
    when :staging then "warning"
    when :development then "info"
    else "dark"
    end
end
