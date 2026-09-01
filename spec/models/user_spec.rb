require "rails_helper"

RSpec.describe User, type: :model do
  describe "associations" do
    it { is_expected.to have_many(:sessions).dependent(:destroy) }
  end

  describe "password" do
    it { is_expected.to have_secure_password }

    it "authenticates with the correct password" do
      user = create(:user, password: "s3cret", password_confirmation: "s3cret")

      expect(user.authenticate("s3cret")).to eq(user)
      expect(user.authenticate("wrong")).to be(false)
    end

    it "is invalid without a password" do
      user = build(:user, password: nil)

      expect(user).not_to be_valid
    end
  end

  describe "email_address normalization" do
    it "strips surrounding whitespace and downcases" do
      user = create(:user, email_address: "  Person@Example.COM  ")

      expect(user.email_address).to eq("person@example.com")
    end

    it "normalizes on lookup too" do
      user = create(:user, email_address: "person@example.com")

      expect(User.find_by(email_address: "  PERSON@EXAMPLE.COM ")).to eq(user)
    end
  end

  describe ".authenticate_by" do
    it "returns the user for matching credentials" do
      user = create(:user, email_address: "login@example.com", password: "opensesame", password_confirmation: "opensesame")

      expect(User.authenticate_by(email_address: "login@example.com", password: "opensesame")).to eq(user)
    end

    it "returns nil for a wrong password" do
      create(:user, email_address: "login@example.com", password: "opensesame", password_confirmation: "opensesame")

      expect(User.authenticate_by(email_address: "login@example.com", password: "nope")).to be_nil
    end
  end

  describe "email_address uniqueness" do
    it "rejects a duplicate address at the database level" do
      create(:user, email_address: "dupe@example.com")

      expect { create(:user, email_address: "dupe@example.com") }
        .to raise_error(ActiveRecord::RecordNotUnique)
    end
  end
end
