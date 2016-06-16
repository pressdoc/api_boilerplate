require 'digest/sha1'

module JWT
  HEADER_PATTERN = /^Bearer /
  ALGORITHM = 'HS256'
  AUDIENCE = 'http://{AUDIENCE}'
  ISSUER = 'http://{ISSUER}'

  def self.verify_authorization_header(authorization_header, date_header)
    token = authorization_header.gsub(HEADER_PATTERN, '') if authorization_header && authorization_header.match(HEADER_PATTERN)
    unless token
      raise Unauthorized, "Access Denied: Bearer token not supplied."
    end

    aud, iat, iss, secret = [ AUDIENCE, date_header, ISSUER, ENV['APP_SECRET'] ]
    verify_jti = proc { |jti|
      jti == Digest::SHA1.hexdigest([secret, iat, aud, iss].join(':').to_s)
    }
    options = { aud: aud, iat: iat, iss: iss, leeway: 1800, verify_aud: true, verify_iat: true, verify_iss: true, verify_jti: verify_jti, algorithm: ALGORITHM }
    begin
      verified_token = JWT.decode(token, secret, true, options)
    rescue => e
      puts e.message
      raise Unauthorized, "Access Denied: Invalid bearer token."
    end
    verified_token
  end
end
