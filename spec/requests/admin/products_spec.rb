require "rails_helper"

RSpec.describe "Admin::Products", type: :request do
  before { sign_in create(:user) }

  let(:character) { create(:character) }
  let(:product_kind) { create(:product_kind) }

  def valid_attributes
    { stock: 5, price: "49.99", cost: "20.0", aditional_info: "info",
      character_id: character.id, product_kind_id: product_kind.id }
  end

  describe "GET /admin/products" do
    it "lists products" do
      create(:product)

      get admin_products_path

      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /admin/products/:id" do
    it "shows a product" do
      get admin_product_path(create(:product))

      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /admin/products/new" do
    it "renders the form" do
      get new_admin_product_path

      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /admin/products" do
    it "creates a product with valid attributes" do
      expect {
        post admin_products_path, params: { product: valid_attributes }
      }.to change(Product, :count).by(1)

      expect(response).to redirect_to(admin_product_path(Product.last))
    end

    it "re-renders with unprocessable_entity when the character is missing" do
      post admin_products_path, params: { product: valid_attributes.merge(character_id: nil) }

      expect(response).to have_http_status(422)
      expect(Product.count).to eq(0)
    end

    it "attaches uploaded images" do
      file = Rack::Test::UploadedFile.new(StringIO.new("bytes"), "image/png", original_filename: "a.png")

      post admin_products_path, params: { product: valid_attributes.merge(images: [ file ]) }

      expect(Product.last.images).to be_attached
    end
  end

  describe "PATCH /admin/products/:id" do
    it "updates the product" do
      product = create(:product, stock: 1)

      patch admin_product_path(product), params: { product: { stock: 9 } }

      expect(response).to redirect_to(admin_product_path(product))
      expect(product.reload.stock).to eq(9)
    end

    it "purges images whose ids are passed in remove_image_ids" do
      product = create(:product)
      product.images.attach(io: StringIO.new("bytes"), filename: "a.png", content_type: "image/png")
      attachment_id = product.images_attachments.first.id

      perform_enqueued_jobs do
        patch admin_product_path(product), params: {
          product: { stock: product.stock },
          remove_image_ids: [ attachment_id ]
        }
      end

      expect(product.reload.images).not_to be_attached
    end
  end

  describe "DELETE /admin/products/:id" do
    it "destroys the product" do
      product = create(:product)

      expect {
        delete admin_product_path(product)
      }.to change(Product, :count).by(-1)

      expect(response).to redirect_to(admin_products_path)
    end
  end
end
