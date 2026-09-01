module AuthenticationHelpers
  # Drives the real session/login flow so the signed cookie is set for
  # subsequent requests in a request spec.
  def sign_in(user, password: "password")
    post session_path, params: { email_address: user.email_address, password: password }
  end
end

RSpec.configure do |config|
  config.include AuthenticationHelpers, type: :request
end
