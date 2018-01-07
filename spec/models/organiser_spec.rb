require 'rails_helper'

RSpec.describe Organiser, type: :model do
  it 'should be valid with full attributes' do
    organiser = FactoryGirl.build(:organiser)
    expect(organiser).to be_valid
  end

  it 'should be Organiser' do
    organiser = FactoryGirl.build(:organiser)
    expect(organiser.type).to eq(Organiser.name)
  end

  it 'should not be valid without email' do
    organiser = FactoryGirl.build(:organiser, email: nil)
    expect(organiser).to_not be_valid
  end
end
