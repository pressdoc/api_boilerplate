require 'rubygems'

ENV['RACK_ENV'] ||= 'test'

require 'simplecov'
SimpleCov.start do
  add_filter "/spec/"
  add_filter "/config/initializers/"
end

require 'rack/test'
require 'database'
require 'factory_girl'

require File.expand_path('../../config/environment', __FILE__)

RSpec.configure do |config|
  config.color = true
  config.formatter = :documentation

  config.mock_with :rspec
  config.expect_with :rspec
  config.raise_errors_for_deprecations!

  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    Database.clean_all
    FactoryGirl.find_definitions
  end
end

RSpec::Matchers.define :be_the_same_time_as do |expected|
  match do |actual|
    expect(expected.strftime("%d-%m-%Y %H:%M:%S")).to eq(actual.strftime("%d-%m-%Y %H:%M:%S"))
  end
end

require 'capybara/rspec'
Capybara.configure do |config|
  config.app = App::API.new
  config.server_port = 9293
end