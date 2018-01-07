require 'rails_helper'

RSpec.describe Attendee, type: :model do
  it 'should be valid with full attributes' do
    attendee = FactoryGirl.build(:attendee)
    expect(attendee).to be_valid
  end

  it 'should be Attendee' do
    attendee = FactoryGirl.build(:attendee)
    expect(attendee.type).to eq(Attendee.name)
  end

  it 'should not be valid without email' do
    attendee = FactoryGirl.build(:attendee, email: nil)
    expect(attendee).to_not be_valid
  end
end
