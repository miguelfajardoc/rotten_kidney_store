require "rails_helper"

RSpec.describe "Sessions", type: :request do
  describe "GET /session/new" do
    it "renders the login form" do
      get new_session_path

      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /session" do
    it "signs in with valid credentials and redirects to root" do
      user = create(:user, email_address: "member@example.com", password: "password", password_confirmation: "password")

      post session_path, params: { email_address: "member@example.com", password: "password" }

      expect(response).to redirect_to(root_url)
      follow_redirect!
      expect(response).to have_http_status(:ok)
    end

    it "re-prompts with an alert on bad credentials" do
      create(:user, email_address: "member@example.com", password: "password", password_confirmation: "password")

      post session_path, params: { email_address: "member@example.com", password: "wrong" }

      expect(response).to redirect_to(new_session_path)
      expect(flash[:alert]).to eq("Try another email address or password.")
    end
  end

  describe "DELETE /session" do
    it "terminates the session and redirects to login" do
      user = create(:user)
      post session_path, params: { email_address: user.email_address, password: "password" }

      delete session_path

      expect(response).to redirect_to(new_session_path)
      expect(Session.count).to eq(0)
    end
  end

  describe "authentication gate" do
    it "redirects unauthenticated users away from protected pages" do
      get admin_products_path

      expect(response).to redirect_to(new_session_path)
    end

    it "returns to the originally requested page after signing in" do
      character = create(:character)
      user = create(:user)

      get admin_characters_path
      expect(response).to redirect_to(new_session_path)

      post session_path, params: { email_address: user.email_address, password: "password" }

      expect(response).to redirect_to(admin_characters_url)
    end
  end
end
