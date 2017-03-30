# This file provides setup and common functionality across all features.  It's
# included first before every test run, and the methods provided here can be 
# used in any of the step definitions used in a test.  This is a great place to
# put shared data like the location of your app, the capabilities you want to
# test with, and the setup of selenium.

require 'rspec/expectations'
require 'appium_lib'
require 'cucumber/ast'

# don't buffer the console output. get real-time update on jenkins console page
$stdout.sync = true

# Load the desired configuration from appium.txt,
if ENV['DEVICE']=='ipad'
  caps = Appium.load_appium_txt file:'./features/support/ipad/appium.txt', verbose: true
else
  caps = Appium.load_appium_txt file:'./features/support/iphone/appium.txt', verbose: true
end

Appium::Driver.new(caps)
# not a good idea to extend Object with Appium methods ?
Appium.promote_appium_methods Object


# setup and tear-down, run before and after each Scenario
Before do |scenario|
  $driver.start_driver

  # settings for testing,
  $test_settings = TestSettings.new
  $test_settings.current_feature = scenario.feature.name.downcase.tr(" ", "_").tr(",", "_")
  $test_settings.current_feature_start_time = Time.now.strftime("%Y-%m-%d_%H-%M-%S")

  # check if simulator really booted
  cmd = %x( xcrun simctl list | grep Booted )
  print("#{cmd}")
  
  # global variable for the app, it is ready to use in each steps.
  $mobile_app = MobileApp.new()

  $current_scenario = scenario
  print("  Scenario: #{scenario.name}\n")

  $step_count = scenario.test_steps.count
  $step_index = 0
  # print out the first step if exists
  if $step_index < $step_count
    print("    #{scenario.test_steps[$step_index].source.last.keyword} #{scenario.test_steps[$step_index].name} \n")
  end
end


# after each scenario
After do |scenario|
  if(scenario.failed?)
    take_failure_screenshot
  end

  print("\n")
  $driver.driver_quit

  $test_settings.current_feature = ""
  $test_settings.current_feature_start_time = ""
  $test_settings.screen_shots.clear

  $test_settings.step_fail_and_continue = false
  $test_settings.step_error_message = ""
end


# after each step
AfterStep do |scenario|
  if $test_settings.step_fail_and_continue
    Dir.mkdir("reports") unless File.exists?("reports")
    warning_file = File.open("./reports/fail_continue.json", "a")

    fail_continue_item = Hash.new
    fail_continue_item["feature"] = $current_scenario.feature.name
    fail_continue_item["scenario"] = $current_scenario.name
    fail_continue_item["step"] = $current_scenario.test_steps[$step_index].name
    fail_continue_item["error_message"] = $test_settings.step_error_message
    _json_str = JSON.dump(fail_continue_item) + ","

    #str = "{\"feature\":\"#{$current_scenario.feature.name}\",\"scenario\":\"#{$current_scenario.name}\",\"step\":\"#{$current_scenario.test_steps[$step_index].name}\",\"error_message\":\"#{$test_settings.step_error_message}\"},"
    warning_file.write(_json_str)
    warning_file.close()
  end

  $test_settings.step_fail_and_continue = false
  $test_settings.step_error_message = ""

  # print out next step if exists
  $step_index += 2
  if $step_index < $step_count
    print("    #{$current_scenario.test_steps[$step_index].source.last.keyword} #{$current_scenario.test_steps[$step_index].name} \n")
  end
end
