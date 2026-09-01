require "rails_helper"

RSpec.describe "Admin::Sizes", type: :request do
  before { sign_in create(:user) }

  describe "GET /admin/sizes" do
    it "lists sizes" do
      create(:size)

      get admin_sizes_path

      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /admin/sizes/:id" do
    it "shows a size" do
      get admin_size_path(create(:size))

      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /admin/sizes/new" do
    it "renders the form" do
      get new_admin_size_path

      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /admin/sizes" do
    it "creates a size and redirects to it" do
      expect {
        post admin_sizes_path, params: { size: { size: 3 } }
      }.to change(Size, :count).by(1)

      expect(response).to redirect_to(admin_size_path(Size.last))
    end
  end

  describe "PATCH /admin/sizes/:id" do
    it "updates the size" do
      size = create(:size, size: 1)

      patch admin_size_path(size), params: { size: { size: 4 } }

      expect(response).to redirect_to(admin_size_path(size))
      expect(size.reload.size).to eq(4)
    end
  end

  describe "DELETE /admin/sizes/:id" do
    it "destroys the size" do
      size = create(:size)

      expect {
        delete admin_size_path(size)
      }.to change(Size, :count).by(-1)

      expect(response).to redirect_to(admin_sizes_path)
    end
  end
end
