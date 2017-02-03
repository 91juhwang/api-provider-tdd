require 'spec_helper'
require 'rspec/rails'

describe Api::V1::UsersController do
  before(:each) { request.headers['Accept'] = "application/vnd.restfulapi-server-rails.v1" }
  describe "GET #show" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      get :show, id: @user.id, format: :json
    end

    it "should return the information about a reporter on a hash" do
      user_response = JSON.parse(response.body, symbolize_names: true)
      expect(user_response[:email]).to eql @user.email
    end

    it 'should return the http status of 200' do
      expect(response).to have_http_status(200)
    end
  end
end
