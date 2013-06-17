require 'test_helper'

class RoleTest < ActiveSupport::TestCase

   test "should respond to attributes" do
     role = Role.new
     assert role.respond_to? :name
     assert role.respond_to? :description
   end
 
   test "should validate presence" do
     role = Role.new
     assert role.invalid?
     assert_equal "can't be blank", role.errors[:name][0]
     assert_equal "can't be blank", role.errors[:description][0]
   end

   test "should validate uniqueness" do
     role = Role.new name: "Role1", description: "xyz"
     assert role.invalid?
     assert_equal "has already been taken", role.errors[:name][0]
   end

   test "relationship: has many users" do
     role = roles(:two)
     assert_equal 2, role.users.count
   end
end
