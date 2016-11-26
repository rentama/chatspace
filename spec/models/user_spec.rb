require "rails_helper"

describe User do
  describe "#create" do
    let(:user) { build(:user) }
      it "is valid with a name, email, password, password_confirmation" do
        expect(user).to be_valid
      end

    let(:user_lacking_in_a_name) { build(:user, name: "")}
      it "is invalid without a name" do
        user_lacking_in_a_name.valid?
        expect(user_lacking_in_a_name.errors[:name]).to include("を入力してください")
      end

    let(:user_lacking_in_a_email) { build(:user, email: "")}
      it "is invalid without a email" do
        user_lacking_in_a_email.valid?
        expect(user_lacking_in_a_email.errors[:email]).to include("を入力してください")
      end

    let(:user_lacking_in_a_password) { build(:user, password: "")}
      it "is invalid without a password" do
        user_lacking_in_a_password.valid?
        expect(user_lacking_in_a_password.errors[:password]).to include("を入力してください")
      end

    let(:user_lacking_in_a_password_confirmation) { build(:user, password_confirmation: "")}
      it "is invalid without a password_confirmation" do
        user_lacking_in_a_password_confirmation.valid?
        expect(user_lacking_in_a_password_confirmation.errors[:password_confirmation]).to include("とPasswordの入力が一致しません")
      end

    let(:first_user) { create(:user)}
    let(:another_user) { build(:user)}
      it "is invalid with a duplicate email" do
        another_user.email = first_user.email
        another_user.valid?
        expect(another_user.errors[:email]).to include("はすでに存在します")
      end

    let(:user_with_a_password_that_has_less_than_6_characters) {build(:user, password: "12345", password_confirmation: "12345")}
      it "is invalid with a password that has less than 6 characters" do
        user_with_a_password_that_has_less_than_6_characters.valid?
        expect(user_with_a_password_that_has_less_than_6_characters.errors[:password]).to include("は6文字以上で入力してください")
      end

    let(:user_with_a_password_that_has_more_than_or_equal_to_6_characters) { build(:user, password:"123456", password_confirmation: "123456")}
      it "is valid with a password that has more or equal to 6 characters" do
        expect(user_with_a_password_that_has_more_than_or_equal_to_6_characters).to be_valid
      end
  end
end
