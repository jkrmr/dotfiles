# frozen_string_literal: true

require "capybara/rspec"
require "capybara/apparition"

# Debugging:
# ---------

# You can grab screenshots of a page at any point by calling
# `save_screenshot("/path/to/file.png")`.

# When the `:inspector` option is enabled, you can insert `page.driver.debug`
# into your tests to pause the test and launch a browser which gives you the
# WebKit inspector to view your test run with.
Capybara.register_driver :apparition_debug do |app|
  Capybara::Apparition::Driver.new(app, inspector: true)
end

Capybara.javascript_driver = ENV["CAPYBARA_DEBUG"].present? ? :apparition_debug : :apparition
