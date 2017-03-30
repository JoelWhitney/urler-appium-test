require 'fileutils'


# some utility/helper functions here



def screen(clz)
  clz.new()
end


# a helper function to determine if the device is a phone or tablet
# example:
#   if device_is_phone
#     puts "it is a phone !"
#   end
def device_is_phone
  # check device size to determine if it is a phone or tablet
  (window_size.height < 700) and (window_size.width < 700)
end




# print out message to console
# example:
#   log("map closed")
#   log("map closed", self)
def log(msg, cls=nil)
  time_stamp = Time.now.strftime("%H:%M:%S")
  if cls.nil?
    print "      [#{time_stamp}] #{msg}\n"
  else
    print "      [#{time_stamp}] #{cls.class.name}: #{msg}\n"
  end
end



def fail_and_continue(msg)
  $test_settings.step_fail_and_continue = true
  $test_settings.step_error_message = $test_settings.step_error_message +  msg + "\\n"
  log("   fail and continue: #{msg}")
end


# take a screenshot png, save to ./screenshots/*.png
# if no file name given, use time stamp as file name
# example:
#   take_screenshot "a.png"
def take_failure_screenshot(file_name=nil)
  begin
    # make sure screenshots folder exists
    FileUtils.mkdir_p './screenshots/failure'

    # if file name given, use time stamp
    if file_name.nil?
      file_name = Time.now.strftime("%Y-%m-%d_%H-%M-%S.png")
    end

    sleep(1)
    screenshot "./screenshots/failure/#{file_name}"
    log("screenshot taken: ./screenshots/failure/#{file_name}")
    sleep(1)

    # add to report
    embed("./screenshots/failure/#{file_name}", "image/png", "SCREENSHOT")
  rescue
    log("   app crashed, could not take a screenshot!")
  end
end



def wait_busy_animation_if_exists
  if exists{ find_element(:class_name, "UIAActivityIndicator") } && find_element(:class_name, "UIAActivityIndicator").displayed?
    wait_true{ !find_element(:class_name, "UIAActivityIndicator").displayed? }
    log("wait animation disappeared")
  end
end


def wait_network_idle
  wait_true(60) { !exists{find_element(:xpath, "//XCUIElementTypeWindow/XCUIElementTypeStatusBar/XCUIElementTypeOther/XCUIElementTypeOther[@name='Network connection in progress']") } }
end