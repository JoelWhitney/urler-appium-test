
require 'rubygems'
require 'appium_lib'


# this class is the main entry point of the app workflow.
# this class is instantiated before each scenario, and can be accessed as a global variable $mobile_app
# when app launched,
#    it could show welcome page,
#    or open the last opened map.
class MobileApp

  def initialize

  end


  def launch_the_app
    return screen(MainViewController).await
  end


  def wait_for_screen(screen_cls)
    screen_obj = nil
    begin
      screen_obj = screen_cls.new.await
      log("on #{screen_cls.name} now")
    rescue
      fail("the app is not on #{screen_cls.name} !")
    end

    return screen_obj
  end


  # Validation functions
  # expected_screen_class_name: Class of expected screen
  # Example usage: $mobile_app.validate_current_screen(FavoritesScreen)
  def validate_current_screen(expected_screen_class)
    begin
      expected_screen_class.new.await
      log("   Validated currently on #{expected_screen_class.name}")
      return true
    rescue
      log("   not currently on #{expected_screen_class.name}")
      return false
    end
  end
end