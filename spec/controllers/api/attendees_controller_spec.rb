require 'rails_helper'

RSpec.describe Api::AttendeesController, type: :controller do
  before(:each) do
    @attendee = FactoryGirl.create(:attendee)
    @photographer = FactoryGirl.create(:photographer)
    @organiser = FactoryGirl.create(:organiser)
  end

  describe "GET #index" do
    it "returns success" do
      put :revoke, params: {
        id: @attendee.id,
        secret: Api::Authentication.generate_secret(revoke_api_attendee_path(@attendee), @organiser),
        token: @organiser.token
      }

      expect(response).to be_success
    end

    it "returns empty access_code" do
      put :revoke, params: {
        id: @attendee.id,
        secret: Api::Authentication.generate_secret(revoke_api_attendee_path(@attendee), @organiser),
        token: @organiser.token
      }

      expect(response).to be_success
      expect(JSON.parse(response.body)["attendee"]["access_code"]).to eq(nil)
    end

    it "not accessible for non organiser user" do
      expect {
        put :revoke, params: {
          id: @attendee.id,
          secret: Api::Authentication.generate_secret(revoke_api_attendee_path(@attendee), @photographer),
          token: @photographer.token
        }
      }.to raise_error(CanCan::AccessDenied)
    end
  end
end
