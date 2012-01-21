require 'test_helper'

class MnemonicsControllerTest < ActionController::TestCase
  setup do
    @mnemonic = mnemonics(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mnemonics)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mnemonic" do
    assert_difference('Mnemonic.count') do
      post :create, :mnemonic => @mnemonic.attributes
    end

    assert_redirected_to mnemonic_path(assigns(:mnemonic))
  end

  test "should show mnemonic" do
    get :show, :id => @mnemonic.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @mnemonic.to_param
    assert_response :success
  end

  test "should update mnemonic" do
    put :update, :id => @mnemonic.to_param, :mnemonic => @mnemonic.attributes
    assert_redirected_to mnemonic_path(assigns(:mnemonic))
  end

  test "should destroy mnemonic" do
    assert_difference('Mnemonic.count', -1) do
      delete :destroy, :id => @mnemonic.to_param
    end

    assert_redirected_to mnemonics_path
  end
end
