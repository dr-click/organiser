class CreatePhotographs < ActiveRecord::Migration[5.0]
  def change
    create_table :photographs do |t|
      t.integer :photographer_id
      t.string :image
      t.string :attendee_access_code

      t.timestamps
    end
  end
end
