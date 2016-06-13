class Authorization < Grape::Middleware::Base
  def before
    puts "Hello World"
  end
end