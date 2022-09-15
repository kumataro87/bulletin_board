require 'rails_helper'

RSpec.describe 'Test User model', type: :model do
    it "is valid with a name, email and password" do
        # user = User.new(
        #     name: "hoge1", 
        #     email: "hoge1@example.com",
        #     password: "password"
        # )
        user = build(:user)
        expect(user).to be_valid
    end
    
    it "is invalid without an email address" do
        user = build(:user, email: nil)
        # user.email = ''
        expect(user).to be_invalid
    end
    
    it "is invalid without a duplicate email address" do
        user = create(:user)
        common_email = user.email
        user.save
        another_user = create(:user)
        another_user.email = common_email
        expect(another_user).to be_invalid
    end
end