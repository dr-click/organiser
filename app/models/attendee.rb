class Attendee < User
  before_save :update_access_code

  def as_json()
    {
      id: id,
      name: name,
      email: email,
      token: token,
      access_code: access_code,
      created_at: created_at
    }
  end

  #######
  private
  ######

  #update user token if it's null
  def update_access_code
    self.access_code ||= Api::Authentication.generate_access_code(Attendee)
  end
end
