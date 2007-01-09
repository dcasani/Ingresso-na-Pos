require 'test_helper'

class ReferenceTeachersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reference_teachers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reference_teacher" do
    assert_difference('ReferenceTeacher.count') do
      post :create, :reference_teacher => { }
    end

    assert_redirected_to reference_teacher_path(assigns(:reference_teacher))
  end

  test "should show reference_teacher" do
    get :show, :id => reference_teachers(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => reference_teachers(:one).to_param
    assert_response :success
  end

  test "should update reference_teacher" do
    put :update, :id => reference_teachers(:one).to_param, :reference_teacher => { }
    assert_redirected_to reference_teacher_path(assigns(:reference_teacher))
  end

  test "should destroy reference_teacher" do
    assert_difference('ReferenceTeacher.count', -1) do
      delete :destroy, :id => reference_teachers(:one).to_param
    end

    assert_redirected_to reference_teachers_path
  end
end
