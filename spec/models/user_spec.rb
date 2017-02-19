require 'rails_helper'
describe User do
  describe '#create' do
    it "is valid with all elements" do
      user = build(:user)
      expect(user).to be_valid
    end
    it "is invalid without a name" do
      user = build(:user, name: "")
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end
    it "is invalid without an email" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end
    it "is invalid without a password" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end
    it "is invalid without a password_confirmation although whth a password" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end
    it "is valid when password has 8 characters or more " do
      user = build(:user, password: "hogehoge", password_confirmation: "hogehoge")
      expect(user).to be_valid
    end
    it "is invalid when password has less than 8 characters" do
      user = build(:user, password: "hogehog", password_confirmation: "hogehog")
      user.valid?
      expect(user.errors[:password][0]).to include("is too short")
    end
    it "is invalid when email has already existed" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include('has already been taken')
    end
  end
end
