require 'test_helper'

class DevicesControllerTest < ActionController::TestCase
  setup do
    @device = devices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:devices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create device" do
    assert_difference('Device.count') do
      post :create, device: { environment: @device.environment, ip_addr: @device.ip_addr, mac_addr: @device.mac_addr, make: @device.make, model: @device.model, os: @device.os, os_version: @device.os_version, owner_id: @device.owner_id, phone_num: @device.phone_num, possesser_id: @device.possesser_id, project: @device.project, serial_num: @device.serial_num, service_provider: @device.service_provider, type: @device.type }
    end

    assert_redirected_to device_path(assigns(:device))
  end

  test "should show device" do
    get :show, id: @device
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @device
    assert_response :success
  end

  test "should update device" do
    put :update, id: @device, device: { environment: @device.environment, ip_addr: @device.ip_addr, mac_addr: @device.mac_addr, make: @device.make, model: @device.model, os: @device.os, os_version: @device.os_version, owner_id: @device.owner_id, phone_num: @device.phone_num, possesser_id: @device.possesser_id, project: @device.project, serial_num: @device.serial_num, service_provider: @device.service_provider, type: @device.type }
    assert_redirected_to device_path(assigns(:device))
  end

  test "should destroy device" do
    assert_difference('Device.count', -1) do
      delete :destroy, id: @device
    end

    assert_redirected_to devices_path
  end
end
