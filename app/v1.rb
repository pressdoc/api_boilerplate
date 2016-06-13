module App
  class API < Grape::API
    format :json

    rescue_from Grape::Exceptions::ValidationErrors do |e|
      error!({ error: 422, message: "Validation Error: #{e.message}" }, 422)
    end

    rescue_from Error do |e|
      error!({ error: e.code, message: e.message }, e.code)
    end

    route(:any, '*path') do
      raise NotFound.new("Not found")
    end

    mount App::V1::Root

    add_swagger_documentation(
      hide_format: true,
      hide_documentation_path: true,
      api_version: 'v1',
      info: {
        title: 'API Version 1',
        description: 'Super yolo.',
      },
      format: :json
    )
  end
end