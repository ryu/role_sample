# frozen_string_literal: true

require "test_helper"

class UserRoleTest < ActiveSupport::TestCase
  test "cannot assign the same role to a user twice" do
    alice = users(:alice)
    role = roles(:global_developer)
    duplicate = UserRole.new(user: alice, role: role)
    assert_not duplicate.valid?
    assert_includes duplicate.errors[:role_id], "has already been taken"
  end

  test "same role can be assigned to different users" do
    role = roles(:global_developer)
    bob = users(:bob)
    user_role = UserRole.new(user: bob, role: role)
    assert user_role.valid?
  end
end
