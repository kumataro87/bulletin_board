require 'rails_helper'

RSpec.describe Post, type: :model do
  it "is valid with a content, user_id" do
    user = create(:user)
    post = user.posts.build(content: "test post", user_id:user.id)
    expect(post).to be_valid
  end

  it "is invalid without a user_id" do
    user = build(:user)
    post = user.posts.build(content: "test post", user_id: nil)
    expect(post).to be_invalid
  end

  it "is valid with a content" do
    user = create(:user)
    post = user.posts.build(content: "  ", user_id:user.id)
    expect(post).to be_invalid
  end

  it "is invalid for more than 10000 chars" do
    user = create(:user)
    post = user.posts.build(content: "a" * 10001, user_id: user.id)
    expect(post).to be_invalid
  end

  it "is deleted when user is deleted" do
    user = create(:user)
    post = user.posts.create(content: "test post", user_id: user.id)
    expect { user.destroy }.to change{ Post.count }.by(-1)
  end

  it "most recent first" do
    user = create(:user)
    create(:post, user: user)
    create(:post, :yesterday, user: user)
    most_recent = create(:post, :now, user: user)
    expect(most_recent).to match Post.first
  end
end
