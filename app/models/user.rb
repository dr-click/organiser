class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  validates_format_of :email,:with => Devise::email_regexp

  before_save :update_user_token

  #######
  private
  ######

  #update user token if it's null
  def update_user_token
    self.token ||= Api::Authentication.generate_user_token(self)
  end
end
