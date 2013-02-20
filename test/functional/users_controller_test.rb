require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def get_index
    @users = []
    3.times do
      @users << FactoryGirl.build(:user)
    end
    User.stubs(:all).returns(@users)
    get :index, format: :json
  end
  
  def test_getting_index_renders_successfully
    get_index
    assert_response :success
  end


  def post_create
    post :create, format: :json
  end

  def test_post_creating_with_valid_data_should_render
    @user = FactoryGirl.build(:user)
    User.stubs(:create).returns(@user)
    post_create
    assert_response 201
  end

  def test_post_creating_with_invalid_data_should_render
    User.any_instance.stubs(:create).returns(false)
    post_create
    assert_response 422
  end

  def authenticate
    post :authenticate
  end

  def test_with_valid_credentials_gives_token
    @user = FactoryGirl.build(:user)
    @user.stubs(:token).returns(SecureRandom.uuid)
    User.stubs(:find_by_email).returns(@user)
    @user.stubs(:authenticate).returns(@user)
    authenticate
    assert_response :success
  end

  def test_with_invalid_credentials_gives_error
    @user = FactoryGirl.build(:user)
    @user.stubs(:token).returns(SecureRandom.uuid)
    User.stubs(:find_by_email).returns(@user)
    @user.stubs(:authenticate).returns(false)
    authenticate
    assert_response 401
  end






=begin
  context 'with some users' do

    setup do
      @users = []
      3.times do
        @users << FactoryGirl.build(:user)
      end
      User.stubs(:all).returns(@users)
    end
    
    context 'when fetching the users index page' do
      get :index
    end

  end
=end
end
