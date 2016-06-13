require 'spec_helper'

describe App::V1::Root do
  include Rack::Test::Methods

  def app
    App::API
  end

  before :each do
    get '/'
  end

  it 'should return a 200 status' do
    expect(last_response.status).to eq(200)
  end
end