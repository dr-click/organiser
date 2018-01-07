User.delete_all

# Admin - Confirmed E-mail
password = "password"

admin    = "a@maildrop.cc"
organiser =  User.where(email: admin).first_or_initialize
organiser.password = password
organiser.password_confirmation = password
organiser.sign_in_count ||= 0
organiser.confirmed_at ||= Time.now
organiser.type ||= Organiser.name
organiser.save!



user     = "a@mailinator.com"
photographer =  User.where(email: user).first_or_initialize
photographer.password = password
photographer.password_confirmation = password
photographer.sign_in_count ||= 0
photographer.confirmed_at ||= Time.now
photographer.type ||= Photographer.name
photographer.save!


5.times do
  User.create(email: Faker::Internet.email, password: password, password_confirmation: password, sign_in_count: 1, confirmed_at: Time.now)
end
User.where(type: nil).update_all(type: Attendee.name)
