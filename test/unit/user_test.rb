require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def create_valid_user
    @user = FactoryGirl.build(:user)
  end

  def test_creating_a_user_saves
    create_valid_user
    assert @user.save
  end

  def test_creating_a_user_sets_token
    create_valid_user
    @user.save
    assert @user.token.present?
  end

end
