require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  context 'fetching the index action' do
    setup do
      @users = []
      3.times do
        @users << FactoryGirl.build(:user)
      end
      User.stubs(:all).returns(@users)
      get :index, format: :json
    end
    should respond_with :success
  end

  context 'posting to the create action' do
    context 'with valid credentials' do
      setup do
        @user = FactoryGirl.build(:user)
        User.stubs(:create).returns(@user)
        post :create, format: :json
      end
      should respond_with 201
    end

    context 'with invalid credentials' do
      setup do
        User.any_instance.stubs(:create).returns(false)
        post :create, format: :json
      end
      should respond_with 422
    end
  end

  context 'when posting to the authenticate action' do
    context 'with valid credentials' do
      setup do
        @user = FactoryGirl.build(:user)
        @user.stubs(:token).returns(SecureRandom.uuid)
        User.stubs(:find_by_email).returns(@user)
        @user.stubs(:authenticate).returns(@user)
        post :authenticate
      end
      should respond_with :success
    end

    context 'with invalid credentials' do
      setup do
        @user = FactoryGirl.build(:user)
        @user.stubs(:token).returns(SecureRandom.uuid)
        User.stubs(:find_by_email).returns(@user)
        @user.stubs(:authenticate).returns(false)
        post :authenticate
      end
      should respond_with 401
    end
  end

end
