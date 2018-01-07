require 'rails_helper'

RSpec.describe Location, type: :model do
  it 'should be valid with full attributes' do
    location = FactoryGirl.build(:location)
    expect(location).to be_valid
  end
end
