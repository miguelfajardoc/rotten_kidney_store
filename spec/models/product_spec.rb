require "rails_helper"

RSpec.describe Product, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:character) }
    it { is_expected.to belong_to(:product_kind) }
    it { is_expected.to have_many_attached(:images) }
  end

  it "is invalid without a character or product kind" do
    expect(build(:product, character: nil)).not_to be_valid
    expect(build(:product, product_kind: nil)).not_to be_valid
  end

  describe "#title" do
    it "combines the character and product kind names" do
      product = build(
        :product,
        character: build(:character, name: "Wolverine"),
        product_kind: build(:product_kind, name: "magnet")
      )

      expect(product.title).to eq("Wolverine magnet")
    end

    it "falls back to a numbered title when no names are available" do
      expect(Product.new.title).to eq("Product #")
    end
  end

  describe "#sold_out?" do
    it "is true when stock is zero or negative" do
      expect(build(:product, stock: 0)).to be_sold_out
      expect(build(:product, stock: -3)).to be_sold_out
    end

    it "is true when stock is nil" do
      expect(build(:product, stock: nil)).to be_sold_out
    end

    it "is false when stock is positive" do
      expect(build(:product, stock: 2)).not_to be_sold_out
    end
  end

  describe "images" do
    it "attaches uploaded files without a limit" do
      product = create(:product)

      product.images.attach(
        io: StringIO.new("fake-image-bytes"),
        filename: "figure.png",
        content_type: "image/png"
      )

      expect(product.images).to be_attached
      expect(product.images.count).to eq(1)
    end
  end
end
