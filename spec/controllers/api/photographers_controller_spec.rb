require 'rails_helper'

RSpec.describe Api::PhotographersController, type: :controller do
  before(:each) do
    # allow(controller).to receive(:authenticate_user!).and_return(true)
    # allow(controller).to receive(:current_user).and_return(@user)
    @photographer = FactoryGirl.create(:photographer)
    @photographer_2 = FactoryGirl.create(:photographer)
    @organiser = FactoryGirl.create(:organiser)
  end

  describe "GET #index" do
    it "returns success" do
      get :index, params: {secret: Api::Authentication.generate_secret(api_photographers_path, @organiser), token: @organiser.token}
      expect(response).to be_success
    end

    it "returns list of photographers" do
      get :index, params: {secret: Api::Authentication.generate_secret(api_photographers_path, @organiser), token: @organiser.token}
      expect(JSON.parse(response.body)["users"].count).to eq(Photographer.count)
    end

    it "not accessible for non organiser user" do
      expect {
        get :index, params: {secret: Api::Authentication.generate_secret(api_photographers_path, @photographer), token: @photographer.token}
      }.to raise_error(CanCan::AccessDenied)
    end
  end

  describe "GET #show" do
    it "returns success" do
      get :show, params: {id: @photographer.id, secret: Api::Authentication.generate_secret(api_photographer_path(@photographer), @organiser), token: @organiser.token}
      expect(response).to be_success
    end

    it "returns a photographer" do
      get :show, params: {id: @photographer.id, secret: Api::Authentication.generate_secret(api_photographer_path(@photographer), @organiser), token: @organiser.token}
      expect(JSON.parse(response.body)["user"]["id"]).to eq(@photographer.id)
    end

    it "not accessible for non organiser user" do
      expect {
        get :show, params: {id: @photographer.id, secret: Api::Authentication.generate_secret(api_photographer_path(@photographer), @photographer), token: @photographer.token}
      }.to raise_error(CanCan::AccessDenied)
    end
  end

  describe "POST #create" do
    it "returns success" do
      photographer = FactoryGirl.build(:photographer)

      post :create, params: {
        "photographer[name]": photographer.name,
        "photographer[email]": photographer.email,
        "photographer[password]": 'password',
        "photographer[password_confirmation]": 'password',
        secret: Api::Authentication.generate_secret(api_photographers_path, @organiser),
        token: @organiser.token
      }
      expect(response).to be_success
    end

    it "returns success false if blank email" do
      photographer = FactoryGirl.build(:photographer)

      post :create, params: {
        "photographer[name]": photographer.name,
        "photographer[email]": '',
        "photographer[password]": 'password',
        "photographer[password_confirmation]": 'password',
        secret: Api::Authentication.generate_secret(api_photographers_path, @organiser),
        token: @organiser.token
      }
      expect(response).to be_success
      expect(JSON.parse(response.body)['success']).to eq(false)
      expect(JSON.parse(response.body)['errors']).to include("email")
    end

    it "returns success false if blank password" do
      photographer = FactoryGirl.build(:photographer)

      post :create, params: {
        "photographer[name]": photographer.name,
        "photographer[email]": photographer.email,
        "photographer[password]": '',
        "photographer[password_confirmation]": 'password',
        secret: Api::Authentication.generate_secret(api_photographers_path, @organiser),
        token: @organiser.token
      }
      expect(response).to be_success
      expect(JSON.parse(response.body)['success']).to eq(false)
      expect(JSON.parse(response.body)['errors']).to include("password")
    end

    it "not accessible for non organiser user" do
      photographer = FactoryGirl.build(:photographer)

      expect {
        post :create, params: {
          "photographer[name]": photographer.name,
          "photographer[email]": photographer.email,
          "photographer[password]": 'password',
          "photographer[password_confirmation]": 'password',
          secret: Api::Authentication.generate_secret(api_photographers_path, @photographer),
          token: @photographer.token
        }
      }.to raise_error(CanCan::AccessDenied)
    end
  end

  
  describe "PATCH #update" do
    it "returns success" do
      patch :update, params: {
        id: @photographer.id,
        "photographer[name]": @photographer.name,
        secret: Api::Authentication.generate_secret(api_photographer_path(@photographer), @organiser),
        token: @organiser.token
      }
      expect(response).to be_success
    end

    it "returns success false if blank email" do

      patch :update, params: {
        id: @photographer.id,
        "photographer[email]": '',
        secret: Api::Authentication.generate_secret(api_photographer_path(@photographer), @organiser),
        token: @organiser.token
      }
      expect(response).to be_success
      expect(JSON.parse(response.body)['success']).to eq(false)
      expect(JSON.parse(response.body)['errors']).to include("email")
    end

    it "not accessible for non organiser user" do
      expect {
        patch :update, params: {
          id: @photographer.id,
          "photographer[name]": @photographer.name,
          secret: Api::Authentication.generate_secret(api_photographer_path(@photographer), @photographer),
          token: @photographer.token
        }
      }.to raise_error(CanCan::AccessDenied)
    end
  end


  describe "DELETE #destroy" do
    it "returns success" do
      delete :destroy, params: {
        id: @photographer_2.id,
        secret: Api::Authentication.generate_secret(api_photographer_path(@photographer_2), @organiser),
        token: @organiser.token
      }
      expect(response).to be_success
    end

    it "not accessible for non organiser user" do
      expect {
        delete :destroy, params: {
          id: @photographer.id,
          secret: Api::Authentication.generate_secret(api_photographer_path(@photographer), @photographer),
          token: @photographer.token
        }
      }.to raise_error(CanCan::AccessDenied)
    end
  end
end
