module Api
  class Authentication
    def self.is_valid_token_and_secret? token, secret, uri, user_klass=User
      user = user_klass.where(token: token).first
      return user if user && is_valid_secret?(secret, uri, user)
    end

    def self.is_valid_secret? secret, uri, user=nil
      return (secret == generate_secret(uri, user)) ? true : false
    end

    #Generate secret based on uri, salt and the user token if exists
    def self.generate_secret uri, user=nil
      uri = uri[0..-2] if uri[-1] == "/"
      hash = ""
      hash += "#{user.token}-" if user
      hash += "#{uri}-"
      hash += "S@lT"
      Digest::SHA1.hexdigest(hash)
    end

    def self.generate_user_token user
      payload = {email: user.email, timestamp: Time.zone.now}
      return JWT.encode payload, nil, 'none'
    end

    def self.generate_access_code(klass)
      code = SecureRandom.hex(6)
      if klass.where(access_code: code).any?
        return self.generate_access_code(klass)
      else
        return code
      end
    end
  end
end
