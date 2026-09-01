require "rails_helper"

RSpec.describe ProductKind, type: :model do
  describe "associations" do
    it { is_expected.to have_and_belong_to_many(:sizes) }
  end

  it "is valid with its attributes" do
    expect(build(:product_kind)).to be_valid
  end

  it "can be linked to several sizes" do
    kind = create(:product_kind)
    small = create(:size)
    large = create(:size)

    kind.sizes << [ small, large ]

    expect(kind.reload.sizes).to contain_exactly(small, large)
    expect(small.reload.product_kinds).to include(kind)
  end
end
