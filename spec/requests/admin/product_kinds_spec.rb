require "rails_helper"

RSpec.describe "Admin::ProductKinds", type: :request do
  before { sign_in create(:user) }

  describe "GET /admin/product_kinds" do
    it "lists product kinds" do
      create(:product_kind, name: "magnet")

      get admin_product_kinds_path

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("magnet")
    end
  end

  describe "GET /admin/product_kinds/:id" do
    it "shows a product kind" do
      get admin_product_kind_path(create(:product_kind))

      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /admin/product_kinds/new" do
    it "renders the form" do
      get new_admin_product_kind_path

      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /admin/product_kinds" do
    it "creates a product kind and redirects to it" do
      expect {
        post admin_product_kinds_path, params: {
          product_kind: { name: "lamp", material: "resin", description: "Glows." }
        }
      }.to change(ProductKind, :count).by(1)

      expect(response).to redirect_to(admin_product_kind_path(ProductKind.last))
    end
  end

  describe "PATCH /admin/product_kinds/:id" do
    it "updates the product kind" do
      kind = create(:product_kind, name: "old")

      patch admin_product_kind_path(kind), params: { product_kind: { name: "new" } }

      expect(response).to redirect_to(admin_product_kind_path(kind))
      expect(kind.reload.name).to eq("new")
    end
  end

  describe "DELETE /admin/product_kinds/:id" do
    it "destroys the product kind" do
      kind = create(:product_kind)

      expect {
        delete admin_product_kind_path(kind)
      }.to change(ProductKind, :count).by(-1)

      expect(response).to redirect_to(admin_product_kinds_path)
    end
  end
end
