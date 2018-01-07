require 'rails_helper'

RSpec.describe Api::PhotographsController, type: :controller do
  before(:each) do
    @photograph = FactoryGirl.build(:photograph)
    @photograph_2 = FactoryGirl.create(:photograph)
    @attendee = FactoryGirl.build(:attendee)
    @attendee_2 = FactoryGirl.create(:attendee)
    @photographer = FactoryGirl.create(:photographer)
    @organiser = FactoryGirl.create(:organiser)
  end

  describe "POST #create" do
    it "returns success" do
      post :create, params: {
        "photograph[attendee_access_code]": @attendee.access_code,
        "photograph[images][]": @photograph.image,
        secret: Api::Authentication.generate_secret(api_photographs_path, @photographer),
        token: @photographer.token
      }
      expect(response).to be_success
    end

    it "returns success false if blank access_code" do
      post :create, params: {
        "photograph[attendee_access_code]": '',
        "photograph[images][]": @photograph.image,
        secret: Api::Authentication.generate_secret(api_photographs_path, @photographer),
        token: @photographer.token
      }
      expect(response).to be_success
      expect(JSON.parse(response.body)['success']).to eq(false)
      expect(JSON.parse(response.body)['errors']).to include("Access Code")
    end

    it "not accessible for non photographer user" do


      expect {
        post :create, params: {
          "photograph[attendee_access_code]": @attendee.access_code,
          "photograph[images][]": @photograph.image,
          secret: Api::Authentication.generate_secret(api_photographs_path, @organiser),
          token: @organiser.token
        }
      }.to raise_error(CanCan::AccessDenied)
    end
  end

  describe "GET #index" do
    it "returns success" do
      get :index, params: {
        photographer_id: @photograph_2.photographer_id,
        secret: Api::Authentication.generate_secret(api_photographer_photographs_path(@photograph_2.photographer), @organiser),
        token: @organiser.token
      }

      expect(response).to be_success
    end

    it "returns list of photographs" do
      get :index, params: {
        photographer_id: @photograph_2.photographer_id,
        secret: Api::Authentication.generate_secret(api_photographer_photographs_path(@photograph_2.photographer), @organiser),
        token: @organiser.token
      }
      expect(JSON.parse(response.body)["photographs"].count).to eq(@photograph_2.photographer.photographs.count)
    end

    it "returns list of photographs for current_user as photographer" do
      get :index, params: {
        secret: Api::Authentication.generate_secret(api_photographs_path, @photographer),
        token: @photographer.token
      }
      expect(JSON.parse(response.body)["photographs"].count).to eq(@photographer.photographs.count)
    end

    it "returns list of photographs for attendee" do
      get :index, params: {
        attendee_id: @attendee_2.id,
        secret: Api::Authentication.generate_secret(api_attendee_photographs_path(@attendee_2), @attendee_2),
        token: @attendee_2.token
      }
      expect(JSON.parse(response.body)["photographs"].count).to eq(@attendee_2.photographs.count)
    end
  end

  describe "GET #show" do
    it "returns success" do
      get :show, params: {
        id: @photograph_2.id,
        secret: Api::Authentication.generate_secret(api_photograph_path(@photograph_2), @attendee_2),
        token: @attendee_2.token
      }

      puts api_photograph_path(@photograph_2)
      puts response.body
      expect(response.body).to redirect_to(@photograph_2.image.url)
    end
  end
end
