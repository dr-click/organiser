require 'rails_helper'

RSpec.describe Api::ApisController, type: :controller do
  describe "GET #index" do
    it "returns success" do
      get :index
      expect(response).to be_success
    end
  end

  describe "GET #generate_secret" do
    it "returns success" do
      user = FactoryGirl.create(:user)
      get :generate_secret, params: {uri: "/users", user_id: user.id}
      expect(response).to be_success
    end

    it "returns valid secret with token" do
      user = FactoryGirl.create(:user)
      get :generate_secret, params: {uri: "/users", user_id: user.id}
      expect(response).to be_success
      expect(JSON.parse(response.body)).to eq({"secret"=>"#{Api::Authentication.generate_secret('/users', user)}"})
    end

    it "returns valid secret without token" do
      user = FactoryGirl.create(:user)
      get :generate_secret, params: {uri: "/users"}
      expect(response).to be_success
      expect(JSON.parse(response.body)).to eq({"secret"=>"#{Api::Authentication.generate_secret('/users')}"})
    end
  end
end
