require "rails_helper"

describe "Message" do
  describe "#create" do
    let(:message) { build(:message) }
      it "is valid with body" do
        expect(message).to be_valid
      end
    let(:message_body_blank) { build(:message, body: "")}
      it "is invalid without body" do
        message_body_blank.valid?
        expect(message_body_blank.errors[:body]).to include("を入力してください")
      end
  end
end
