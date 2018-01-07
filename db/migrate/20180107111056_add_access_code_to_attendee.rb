class AddAccessCodeToAttendee < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :access_code, :string

    Attendee.all.each do |attendee|
      #save attendee to triger the callbacks
      attendee.save!
    end
  end
end
