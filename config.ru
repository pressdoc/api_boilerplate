require File.expand_path('../config/environment', __FILE__)
require File.expand_path('../lib/rack_cors', __FILE__)

use Rack::CORS do
  allow do
    origins '*'
    resource '*',
      :headers => :any,
      :methods => [ :get, :post, :put, :delete, :options ]
  end
end

run App::API