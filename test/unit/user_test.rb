require 'test_helper'

class UserTest < ActiveSupport::TestCase
  subject { @user = User.create!(FactoryGirl.attributes_for(:user)) }
  should validate_presence_of :email
  should validate_uniqueness_of :email

  context 'when creating a user' do
    setup do
      @user = FactoryGirl.build(:user)
      @user.save
    end
    should 'set the token' do
      assert @user.token.present?
    end
  end

end
