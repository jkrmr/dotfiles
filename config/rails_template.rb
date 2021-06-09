# frozen_string_literal: true

require "json"

class Template
  TEMPLATE_DIR = File.expand_path("~/.dotfiles/config/rails")

  attr_accessor :directory, :relative_path, :absolute_path, :basename

  def self.files(subdir = "")
    Dir
      .glob(File.join(TEMPLATE_DIR, subdir, "**/*"), File::FNM_DOTMATCH)
      .reject { |absolute_path| File.directory?(absolute_path) }
      .map { |absolute_path| absolute_path.delete_prefix("#{TEMPLATE_DIR}/") }
      .map { |relative_path| new(relative_path) }
      .reject { |template| template.basename == "Gemfile" }
  end

  def initialize(relative_path)
    self.relative_path = relative_path
    self.absolute_path = File.join(TEMPLATE_DIR, relative_path)
    self.basename = File.basename(absolute_path)
  end

  def contents
    File.read(absolute_path)
  end
end

# Add gems to Gemfile
File.open("Gemfile", "a") do |file|
  file.puts Template.new("Gemfile").contents
end

# Add docs generation step to setup script (edit manually)
File.open("bin/setup", "a") do |file|
  file.puts 'puts "\n== Building documentation =="', 'system! "yard gems"'
end

# Add template config files
#
# - Add gem configuration initializers
# - RSpec configuration files
# - Procfile for Heroku
# - dotfiles
#
Template.files.each do |template|
  file(template.relative_path, template.contents)
end

after_bundle do
  # Generate spec/rails_helper.rb
  generate("rspec:install")

  # Prepend simplecov require to spec/rails_helper.rb
  rails_helper_lines = File.readlines("spec/rails_helper.rb")
  File.open("spec/rails_helper.rb", "w") do |file|
    file.puts(<<~RUBY)
      # require simplecov before anything else
      require_relative "./support/simplecov"

      #{rails_helper_lines.join}
    RUBY
  end

  # Add entries to package.json
  npm_config =
    JSON.load_file("package.json").tap do |json|
      json["license"] = "UNLICENSED"
      json["scripts"] = { format: "prettier-standard --fix" }
      json["prettier"] = "prettier-config-standard"
    end
  File.open("package.json", "w") { |file| JSON.dump(npm_config, file) }

  run(<<~SH)
    curl -Ls "https://www.gitignore.io/api/ruby,rails,node,emacs,vim" >> .gitignore

    yarn add -D prettier-config-standard prettier-standard

    yarn format

    rufo **/*.rb

    rubocop --auto-correct-all --fail-level F --display-only-fail-level-offenses

    rubocop
  SH
end
