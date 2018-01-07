class Photograph < ApplicationRecord
  validates :attendee_access_code, presence: true

  belongs_to :photographer

  mount_uploader :image, ImageUploader

  def as_json()
    {
      id: id,
      attendee_access_code: attendee_access_code,
      image: {
        original: image.url,
        large: image.url(:large),
        medium: image.url(:medium),
        small: image.url(:small)
      },
      photographer: photographer.as_json
    }
  end
end
