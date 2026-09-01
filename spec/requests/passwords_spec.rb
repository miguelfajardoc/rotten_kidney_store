require "rails_helper"

RSpec.describe "Passwords", type: :request do
  describe "GET /passwords/new" do
    it "renders the reset request form" do
      get new_password_path

      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /passwords" do
    it "enqueues a reset email when the address matches a user" do
      user = create(:user, email_address: "forgot@example.com")

      expect {
        post passwords_path, params: { email_address: "forgot@example.com" }
      }.to have_enqueued_mail(PasswordsMailer, :reset).with(user)

      expect(response).to redirect_to(new_session_path)
      expect(flash[:notice]).to match(/Password reset instructions sent/)
    end

    it "does not send an email for an unknown address but still confirms" do
      expect {
        post passwords_path, params: { email_address: "nobody@example.com" }
      }.not_to have_enqueued_mail(PasswordsMailer, :reset)

      expect(response).to redirect_to(new_session_path)
      expect(flash[:notice]).to match(/Password reset instructions sent/)
    end
  end

  describe "GET /passwords/:token/edit" do
    it "renders the reset form for a valid token" do
      user = create(:user)

      get edit_password_path(user.password_reset_token)

      expect(response).to have_http_status(:ok)
    end

    it "redirects with an alert for an invalid token" do
      get edit_password_path("not-a-real-token")

      expect(response).to redirect_to(new_password_path)
      expect(flash[:alert]).to match(/invalid or has expired/)
    end
  end

  describe "PATCH /passwords/:token" do
    it "resets the password when confirmation matches" do
      user = create(:user)

      patch password_path(user.password_reset_token),
        params: { password: "brandnew1", password_confirmation: "brandnew1" }

      expect(response).to redirect_to(new_session_path)
      expect(flash[:notice]).to match(/Password has been reset/)
      expect(user.reload.authenticate("brandnew1")).to be_truthy
    end

    it "re-renders with an alert when confirmation does not match" do
      user = create(:user)
      token = user.password_reset_token

      patch password_path(token),
        params: { password: "brandnew1", password_confirmation: "mismatch" }

      expect(response).to redirect_to(edit_password_path(token))
      expect(flash[:alert]).to eq("Passwords did not match.")
    end
  end
end
