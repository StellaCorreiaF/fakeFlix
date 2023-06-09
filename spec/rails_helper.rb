# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

module LoggedUserHelpers
  def with_signed_in_user
    @user = User.last || User.create(
      email: "teste@example.com",
      password: "123456"
    )
    sign_in @user
  end

  def signed_in_user
    @user
  end
end

RSpec.configure do |config|

  config.include Devise::Test::IntegrationHelpers, type: :request
  config.include LoggedUserHelpers, type: :request
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
end
