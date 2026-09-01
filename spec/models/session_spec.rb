require "rails_helper"

RSpec.describe Session, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:user) }
  end

  it "is valid with a user" do
    expect(build(:session)).to be_valid
  end

  it "is invalid without a user" do
    expect(build(:session, user: nil)).not_to be_valid
  end

  it "is destroyed when its user is destroyed" do
    session = create(:session)

    expect { session.user.destroy }.to change(Session, :count).by(-1)
  end
end
