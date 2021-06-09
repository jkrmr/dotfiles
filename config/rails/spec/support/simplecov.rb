# frozen_string_literal: true

if ENV["COVERAGE"]
  require "simplecov"

  SimpleCov.start("rails") do
    add_filter "/spec/"
    add_filter "/config/"
    add_filter "/vendor/"

    add_group "Decorators", "app/decorators"
    add_group "Serializers", "app/serializers"
    add_group "Services", "app/services"
    add_group "Uploaders", "app/uploaders"
    add_group "Vendored", "lib"
  end

  Rails.application.eager_load! if defined?(Rails)
end
