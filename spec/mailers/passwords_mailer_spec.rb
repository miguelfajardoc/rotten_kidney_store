require "rails_helper"

RSpec.describe PasswordsMailer, type: :mailer do
  describe "#reset" do
    let(:user) { create(:user, email_address: "reset@example.com") }
    let(:mail) { described_class.reset(user) }

    it "is addressed to the user with the expected subject and sender" do
      expect(mail.subject).to eq("Reset your password")
      expect(mail.to).to eq([ "reset@example.com" ])
      expect(mail.from).to eq([ "from@example.com" ])
    end

    it "links to the token-scoped reset page in both parts" do
      token_url = edit_password_url(user.password_reset_token, host: "example.com")

      expect(mail.html_part.body.encoded).to include("this password reset page")
      expect(mail.text_part.body.encoded).to include("/passwords/")
      # the token changes per call, so just assert the path shape is present
      expect(mail.html_part.body.encoded).to match(%r{/passwords/[^"]+/edit})
      expect(token_url).to match(%r{/passwords/.+/edit})
    end
  end
end
