# By using the symbol ':user', we get Factory Girl to simulate the User model.
FactoryGirl.define do
  faker_password = Faker::Internet.password(min_length = 8, max_length = 16)

  factory :user do
    email                   {Faker::Internet.unique.email}
    name                    {Faker::Name.unique.name}
    password                faker_password
    password_confirmation   faker_password
    confirmed_at            Time.now
  end

  factory :photographer, class: Photographer, parent: :user do
  end

  factory :attendee, class: Attendee, parent: :user do
  end

  factory :organiser, class: Organiser, parent: :user do
  end
end
