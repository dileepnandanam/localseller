class AuthHandler
  def self.create_authentication(creds)
    if auth = AuthHash.where(uid: creds['uid'], provider: creds['provider']).first
      auth
    else
      auth = AuthHash.create do |auth|
        auth.uid = creds['uid']
        auth.provider = creds['provider']
        auth.name = creds['info']['name']
        auth.email = creds['info']['email']
      end
      auth
    end

  end
end