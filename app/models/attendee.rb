class Attendee < User
  before_save :update_access_code

  #######
  private
  ######

  #update user token if it's null
  def update_access_code
    self.access_code ||= Api::Authentication.generate_access_code(Attendee)
  end
end
