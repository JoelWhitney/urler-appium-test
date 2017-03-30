Given(/^I enter the app$/) do
  if $test_settings.is_ipad && $test_settings.is_landscape
    _screenshot_folder_name = "iPadAir_landscape"
  elsif $test_settings.is_ipad && !$test_settings.is_landscape
    _screenshot_folder_name = "iPadAir"
  elsif !$test_settings.is_ipad && !$test_settings.is_landscape
    _screenshot_folder_name = "iPhone6"
  else !$test_settings.is_ipad && $test_settings.is_landscape
  _screenshot_folder_name = "iPhone6_landscape"
  end
  _main_view_controller = $mobile_app.wait_for_screen(MainViewController)
  _scan_controller = _main_view_controller.scan_controller
end

Then(/^I open all screens of the app to take screenshots$/) do
  if $test_settings.is_ipad && $test_settings.is_landscape
    _screenshot_folder_name = "iPadAir_landscape"
  elsif $test_settings.is_ipad && !$test_settings.is_landscape
    _screenshot_folder_name = "iPadAir"
  elsif !$test_settings.is_ipad && !$test_settings.is_landscape
    _screenshot_folder_name = "iPhone6"
  else !$test_settings.is_ipad && $test_settings.is_landscape
    _screenshot_folder_name = "iPhone6_landscape"
  end
  # from ScanController
  #======================================
  # browse maps
  _scan_controller = $mobile_app.wait_for_screen(ScanController)

end
