# frozen_string_literal: true

require "vcr"

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/cassettes"
  config.allow_http_connections_when_no_cassette = false
  config.hook_into :webmock
  config.configure_rspec_metadata!

  config.default_cassette_options = {
    record: :new_episodes,
    match_requests_on: %i[method host path],
  }

  # Strip sensitive headers
  config.before_record do |interaction|
    interaction.response.headers.delete("Set-Cookie")
    interaction.request.headers.delete("Authorization")
    interaction.request.headers.delete("X-Stripe-Client-User-Agent")
  end

  # Filter sensitive data
  # https://relishapp.com/vcr/vcr/v/6-0-0/docs/configuration/filter-sensitive-data
  # config.filter_sensitive_data("<AUTH_TOKEN>") do |interaction|
  #   interaction.request.headers["Authorization"].first
  # end
end
