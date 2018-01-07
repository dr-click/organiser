require 'rails_helper'

RSpec.describe Photographer, type: :model do
  it 'should be valid with full attributes' do
    photographer = FactoryGirl.build(:photographer)
    expect(photographer).to be_valid
  end

  it 'should be Photographer' do
    photographer = FactoryGirl.build(:photographer)
    expect(photographer.type).to eq(Photographer.name)
  end

  it 'should not be valid without email' do
    photographer = FactoryGirl.build(:photographer, email: nil)
    expect(photographer).to_not be_valid
  end
end
