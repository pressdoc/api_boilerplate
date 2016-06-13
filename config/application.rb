$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app/v1'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'boot'

Bundler.require :default, ENV['RACK_ENV']

if ENV['RACK_ENV'] == "development" || ENV['RACK_ENV'] == "test"
  Dotenv.load
  Dotenv.overload ".env.#{ENV['RACK_ENV']}"
end

Dir[File.expand_path('../initializers/*.rb', __FILE__)].each {|f| require f }
Dir[File.expand_path('../../app/v1/middleware/*.rb', __FILE__)].each {|f| require f }
Dir[File.expand_path('../../app/v1/models/*.rb', __FILE__)].each {|f| require f }
Dir[File.expand_path('../../app/v1/controllers/*.rb', __FILE__)].each {|f| require f }
Dir[File.expand_path('../../app/v1/services/*.rb', __FILE__)].each {|f| require f }
Dir[File.expand_path('../../app/*.rb', __FILE__)].each {|f| require f}

require 'v1'