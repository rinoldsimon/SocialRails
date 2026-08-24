# frozen_string_literal: true

require "test_helper"

class PostPolicyTest < ActiveSupport::TestCase
  def setup
    @owner = User.create!(name: "Ada", username: "ada_test", email: "ada@example.com", password: "password12")
    @other = User.create!(name: "Bob", username: "bob_test", email: "bob@example.com", password: "password12")
    @post = @owner.posts.create!(body: "Hello from the square.")
  end

  test "owner can destroy" do
    assert PostPolicy.new(@owner, @post).destroy?
  end

  test "other user cannot destroy" do
    assert_not PostPolicy.new(@other, @post).destroy?
  end
end
