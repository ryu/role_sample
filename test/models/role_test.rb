# frozen_string_literal: true

require "test_helper"

class RoleTest < ActiveSupport::TestCase
  test "name is required" do
    role = Role.new(name: nil)
    assert_not role.valid?
    assert_includes role.errors[:name], "can't be blank"
  end

  test "name, resource_type, resource_id must be unique together" do
    existing = roles(:global_developer)
    duplicate = Role.new(name: existing.name, resource_type: nil, resource_id: nil)
    assert_not duplicate.valid?
  end
end
