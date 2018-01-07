class AddTokenToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :token, :string
    User.all.each do |user|
      #save user to triger the callbacks
      user.save
    end
  end
end
