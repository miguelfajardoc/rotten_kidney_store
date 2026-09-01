require "rails_helper"

RSpec.describe Character, type: :model do
  it "is valid with a name and klass" do
    expect(build(:character)).to be_valid
  end

  it "persists name and klass" do
    character = create(:character, name: "Deadpool", klass: "Marvel")

    expect(character.reload).to have_attributes(name: "Deadpool", klass: "Marvel")
  end

  it "can be referenced by products" do
    character = create(:character)
    create(:product, character: character)

    expect(Product.where(character: character).count).to eq(1)
  end
end
