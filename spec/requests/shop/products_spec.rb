require "rails_helper"

RSpec.describe "Shop::Products", type: :request do
  describe "GET /shop" do
    it "is reachable without authentication" do
      get shop_root_path

      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /shop/products" do
    it "lists all products newest first" do
      old = create(:product)
      old.update_column(:created_at, 2.days.ago)
      new = create(:product)

      get shop_products_path

      expect(response).to have_http_status(:ok)
      expect(response.body.index(new.title)).to be < response.body.index(old.title)
    end

    it "filters by product_kind_id" do
      kind = create(:product_kind, name: "magnet")
      other_kind = create(:product_kind, name: "lamp")
      wanted = create(:product, product_kind: kind)
      unwanted = create(:product, product_kind: other_kind)

      get shop_products_path, params: { product_kind_id: kind.id }

      expect(response.body).to include(wanted.title)
      expect(response.body).not_to include(unwanted.title)
    end

    it "filters by character_id" do
      hero = create(:character, name: "Spider-Man")
      villain = create(:character, name: "Green Goblin")
      wanted = create(:product, character: hero)
      unwanted = create(:product, character: villain)

      get shop_products_path, params: { character_id: hero.id }

      expect(response.body).to include(wanted.title)
      expect(response.body).not_to include(unwanted.title)
    end
  end

  describe "GET /shop/products/:id" do
    it "shows a product" do
      product = create(:product)

      get shop_product_path(product)

      expect(response).to have_http_status(:ok)
      expect(response.body).to include(product.title)
    end

    it "responds 404 for an unknown product" do
      get shop_product_path(id: 0)

      expect(response).to have_http_status(:not_found)
    end
  end
end
