require 'rails_helper'

RSpec.describe User, type: :model do
  it 'should be valid with full attributes' do
    user = FactoryGirl.build(:user)
    expect(user).to be_valid
  end

  it 'should not be valid without email' do
    user = FactoryGirl.build(:user, email: nil)
    expect(user).to_not be_valid
  end
end
