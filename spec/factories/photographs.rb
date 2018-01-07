FactoryGirl.define do
  factory :photograph do
    image {ActionDispatch::Http::UploadedFile.new(:tempfile => File.new("#{Rails.root}/spec/files/mostafa.jpg"), :filename => "mostafa.jpg")}

    after(:build) do |photograph|
      photograph.photographer = FactoryGirl.create(:photographer)
      photograph.attendee_access_code = FactoryGirl.create(:attendee).access_code
    end
  end
end
