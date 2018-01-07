require 'rails_helper'

RSpec.describe Api::PhotographsController, type: :controller do
  before(:each) do
    @photograph = FactoryGirl.build(:photograph)
    @attendee = FactoryGirl.build(:attendee)
    @photographer = FactoryGirl.create(:photographer)
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
      organiser = FactoryGirl.create(:organiser)

      expect {
        post :create, params: {
          "photograph[attendee_access_code]": @attendee.access_code,
          "photograph[images][]": @photograph.image,
          secret: Api::Authentication.generate_secret(api_photographs_path, organiser),
          token: organiser.token
        }
      }.to raise_error(CanCan::AccessDenied)
    end
  end
end
