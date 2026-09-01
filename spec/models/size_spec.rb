require "rails_helper"

RSpec.describe Size, type: :model do
  describe "associations" do
    it { is_expected.to have_and_belong_to_many(:product_kinds) }
  end

  it "is valid with a size value" do
    expect(build(:size)).to be_valid
  end

  it "can be shared across product kinds" do
    size = create(:size)
    magnet = create(:product_kind)
    lamp = create(:product_kind)

    size.product_kinds << [ magnet, lamp ]

    expect(size.reload.product_kinds).to contain_exactly(magnet, lamp)
  end
end
