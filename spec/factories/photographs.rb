FactoryGirl.define do
  factory :photograph do
    photographer_id 1
    image {ActionDispatch::Http::UploadedFile.new(:tempfile => File.new("#{Rails.root}/spec/files/mostafa.jpg"), :filename => "mostafa.jpg")}

    after(:build) do |photograph|
      photograph.photographer = FactoryGirl.create(:photographer)
      attendee_access_code = FactoryGirl.create(:photographer).access_code
    end
  end
end
