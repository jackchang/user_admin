require 'test_helper'

class UserTest < ActiveSupport::TestCase

   test "should respond to attributes" do
     user = User.new
     assert user.respond_to? :user_name
     assert user.respond_to? :first_name
     assert user.respond_to? :last_name
     assert user.respond_to? :email
     assert user.respond_to? :role_names
   end
 
   test "should validate presence" do
     user = User.new
     assert user.invalid?
     assert_equal "can't be blank", user.errors[:user_name][0]
     assert_equal "can't be blank", user.errors[:first_name][0]
     assert_equal "can't be blank", user.errors[:last_name][0]
     assert_equal "can't be blank", user.errors[:email][0]
   end

   test "should validate user_name uniqueness" do
     user = User.new user_name: "FOO", email: "xyz@xyz.com"
     assert user.invalid?
     assert_equal "has already been taken", user.errors[:user_name][0]
   end

   test "should validate user_name length" do
     name = "xyz" * 20
     user = User.new user_name: name, email: "xyz@xyz.com"
     assert user.invalid?
     assert_equal "is too long (maximum is 50 characters)", user.errors[:user_name][0]
   end

   test "should validate email" do
     user = User.new user_name: "new", email: "xyz.xyz.com"
     assert user.invalid?
     assert_equal "is invalid", user.errors[:email][0]
   end

   test "unique relationship: has many roles" do
     user = users(:one)
     assert_equal 2, user.roles.count
   end

end
