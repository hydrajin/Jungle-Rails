require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do

  #! Step 2:Define validation specs

    it "validates new user with all fields and password matching" do
      @user = User.create(name: "dude", email: "a@a.com", password: "abcd", password_confirmation: "abcd")
      expect(@user).to be_valid
    end

    it "validates that a password matches " do
      @user = User.create(name: "dude", email: "a@a.com", password: "abcd", password_confirmation: "1234")
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "validates that a password is present " do
      @user = User.create(name: "dude", email: "a@a.com", password: nil, password_confirmation: nil)
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it "validates that an email is present" do
      @user = User.create(name: "dude", email: nil, password: "abcd", password_confirmation: "abcd")
      @user.save
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "validates that an email is unique (not case sensitive and not duplicate)" do
      @user1 = User.create(name: "dude", email: "a@a.com", password: "abcd", password_confirmation: "abcd")
      @user2 = User.create(name: "dude", email: "a@a.com", password: "abcd", password_confirmation: "abcd")
      @user2.save
      @user3 = User.create(name: "dude", email: "A@A.com", password: "abcd", password_confirmation: "abcd")
      @user3.save
      expect(@user2).not_to be_valid
      expect(@user2.errors.full_messages).to include("Email has already been taken")
      expect(@user3).not_to be_valid
      expect(@user3.errors.full_messages).to include("Email has already been taken")
    end

    it "validates that a name is present" do
      @user = User.create(name: nil, email: "a@a.com", password: "abcd", password_confirmation: "abcd")
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Name can't be blank")
    end

    #! Step 3: Password minimum length

    it "validates that a password is greater than 4 characters" do
      @user = User.create(name: "dude", email: "a@a.com", password: "abc", password_confirmation: "abc")
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 4 characters)")
    end

    #! Step 4: New authentication (class) method
  
    describe ".authenticate_with_credentials" do
      # examples for this class method here
      it "validates that the user logs in if authentification is correct" do
        user1 = User.new(name: "dude", email: "a@a.com", password: "1234", password_confirmation: "1234")
        user1.save
        user2 = User.authenticate_with_credentials("a@a.com", "1234")
        expect(user1).to eql(user2)
      end

      it "validates that the user dosn't login if authentification is incorrect" do
        user1 = User.new(name: "dude", email: "a@a.com", password: "1234", password_confirmation: "1234")
        user1.save
        user2 = User.authenticate_with_credentials("a@a.com", "abcd")
        expect(user1).to_not eql(user2)
      end

      #! Step 4: Edge cases

      it "validates that the user logs in if email is uppercase" do
        user1 = User.new(name: "dude", email: "a@a.com", password: "1234", password_confirmation: "1234")
        user1.save
        user2 = User.authenticate_with_credentials("A@a.cOm", "1234")
        expect(user1).to eql(user2)
      end

      it "validates that the user logs in if email has whitespace" do
        user1 = User.new(name: "dude", email: "a@a.com", password: "1234", password_confirmation: "1234")
        user1.save
        user2 = User.authenticate_with_credentials("   a@a.com ", "1234")
        expect(user1).to eql(user2)
      end
    end
  end
end