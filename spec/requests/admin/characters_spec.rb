require "rails_helper"

RSpec.describe "Admin::Characters", type: :request do
  before { sign_in create(:user) }

  describe "GET /admin/characters" do
    it "lists characters" do
      create(:character, name: "Batman")

      get admin_characters_path

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Batman")
    end
  end

  describe "GET /admin/characters/:id" do
    it "shows a character" do
      character = create(:character)

      get admin_character_path(character)

      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /admin/characters/new" do
    it "renders the form" do
      get new_admin_character_path

      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /admin/characters" do
    it "creates a character and redirects to it" do
      expect {
        post admin_characters_path, params: { character: { name: "Joker", klass: "DC" } }
      }.to change(Character, :count).by(1)

      expect(response).to redirect_to(admin_character_path(Character.last))
    end
  end

  describe "PATCH /admin/characters/:id" do
    it "updates the character" do
      character = create(:character, name: "Old")

      patch admin_character_path(character), params: { character: { name: "New" } }

      expect(response).to redirect_to(admin_character_path(character))
      expect(character.reload.name).to eq("New")
    end
  end

  describe "DELETE /admin/characters/:id" do
    it "destroys the character" do
      character = create(:character)

      expect {
        delete admin_character_path(character)
      }.to change(Character, :count).by(-1)

      expect(response).to redirect_to(admin_characters_path)
    end
  end

  it "requires authentication" do
    delete session_path # sign out

    get admin_characters_path

    expect(response).to redirect_to(new_session_path)
  end
end
