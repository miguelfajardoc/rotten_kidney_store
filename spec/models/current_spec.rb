require "rails_helper"

RSpec.describe Current, type: :model do
  after { Current.reset }

  it "exposes the session that is assigned to it" do
    session = create(:session)

    Current.session = session

    expect(Current.session).to eq(session)
  end

  it "delegates #user to the current session" do
    session = create(:session)

    Current.session = session

    expect(Current.user).to eq(session.user)
  end

  it "returns nil for #user when there is no session" do
    expect(Current.user).to be_nil
  end
end
