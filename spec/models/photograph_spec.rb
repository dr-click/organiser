require 'rails_helper'

RSpec.describe Photograph, type: :model do
  it 'should be valid with full attributes' do
    photograph = FactoryGirl.build(:photograph)
    expect(photograph).to be_valid
  end

  it 'should not be valid without attendee_access_code' do
    photograph = FactoryGirl.build(:photograph)
    photograph.attendee_access_code = ''
    expect(photograph).to_not be_valid
  end
end
