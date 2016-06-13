require 'spec_helper'

describe App::API do
  include Rack::Test::Methods

  def app
    App::API
  end

  context "a method that does not exist" do
    before :all do
      get '/test'
    end

    it 'should return a 404 status' do
      expect(last_response.status).to eq(404)
    end

    it 'should return a 404 "Not Found" error message' do
      expect(last_response.body).to eq({ "error": 404, "message": "Not found" }.to_json)
    end
  end
end