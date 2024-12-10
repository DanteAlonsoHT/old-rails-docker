ENV['RAILS_ENV'] = 'test'

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'database_cleaner'
require 'factory_girl_rails'
require 'rails/test_help'

Rails.env = 'test'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.use_transactional_fixtures = true

  if Rails.env.test? && ActiveRecord::Base.connection_config[:database] == 'ecommerce_puntospoint_development'
    raise "Test environment is using the development database!"
  end

  config.before(:suite) do
    raise "DatabaseCleaner is deleting wrong database" if Rails.env.test? && ActiveRecord::Base.connection_config[:database] == 'ecommerce_puntospoint_development'
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  config.before(:suite) do
    FactoryGirl.create(:administrator, email: 'admin@test.com', password: 'password') unless Administrator.exists?
  end

  ENV['JWT_SECRET'] ||= 'test_secret'

  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.include FactoryGirl::Syntax::Methods

  config.order = "random"
end
