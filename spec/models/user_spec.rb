require 'rails_helper'

RSpec.describe User, type: :model do
  it {should have_many(:tweets).dependent(:destroy)}
  it { should validate_uniqueness_of(:username).case_insensitive }

  describe "#set_display_name" do
    context "when display_name is set" do
      it "does not change the display name" do
        user = build(:user, username: "james", display_name: "James Harded")
        user.save
        expect(user.reload.display_name).to eq("James Harded")
      end
    end

    context "when display_name is  not set" do
      it "humanize the previously set name" do
        user = build(:user, username: "james", display_name: nil)
        user.save
        expect(user.reload.display_name).to eq("James")
      end
    end
  end

end
