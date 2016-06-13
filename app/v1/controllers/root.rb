module App
  module V1
    class Root < Grape::API
      desc "Generic information about this server."
      get "/" do
        routes = App::API.routes.map{ |route|
          next unless route.present? && route.description.present?
          ["#{route.request_method}: #{route.path}", route.description]
        }
        {
          ok: true,
          name: "Your name",
          status: 200,
          env: ENV['RACK_ENV'],
          endpoints: Hash[routes.compact].sort.to_h
        }
      end
    end
  end
end