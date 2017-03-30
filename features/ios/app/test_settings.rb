

class TestSettings

  attr_accessor :measurement_unit
  attr_accessor :route_simulation
  attr_accessor :check_for_updates
  attr_accessor :only_download_on_wifi
  attr_accessor :last_navigation_directions
  attr_accessor :optimize_route

  #image comparison
  attr_accessor :compare_screenshot
  attr_accessor :screenshot_baseline
  attr_accessor :screen_shots

  #current scenario
  attr_accessor :current_feature
  attr_accessor :current_feature_start_time

  #fail_and_contiue
  attr_accessor :step_fail_and_continue
  attr_accessor :step_error_message

  #organization properties
  attr_accessor :run_on_devext

  #is it a release build
  attr_accessor :release_build

  #android package
  attr_accessor :app_package

  # portal account for updating mmpk
  attr_accessor :portal_url
  attr_accessor :test_mmpk_folder      # folder name on ar_NavUITest holding mmpk for testing
  attr_accessor :test_user_name        # account for testing app
  attr_accessor :test_password
  attr_accessor :mmpk_update_folder
  attr_accessor :mmpk_user_name       # account for hosting mmpk files
  attr_accessor :mmpk_password

  #faked gps location
  # attr_accessor :faked_latitude
  # attr_accessor :faked_longitude

  #driver properties
  attr_accessor :is_ipad
  attr_accessor :is_landscape
  attr_accessor :screenshot_rotation

  def initialize
    # default unit is metric
    @run_on_devext = false
    @is_ipad = false
    @is_landscape = false
    @measurement_unit = "Metric"
    @route_simulation = "Off"
    @check_for_updates = true
    @only_download_on_wifi = true
    @last_navigation_directions = Array.new
    @optimize_route = true
    @compare_screenshot = false
    @screenshot_baseline = "baseline"
    @screen_shots = Array.new

    @current_feature = ""
    @current_feature_start_time = ""

    @release_build = false
    # Pulled from appium.txt
    @app_package = ''

    @portal_url = "https://appsregression.maps.arcgis.com"
    @test_mmpk_folder = "NavUITest"
    @test_user_name = "ar_NavUITest"                  # account for testing app
    @test_password = "navuitest1"
    @mmpk_update_folder = "mmpk_for_update_test"      # the folder in ar_mmpk account, holding the update mmpk
    @mmpk_user_name = "ar_mmpk"                       # account for hosting mmpk files
    @mmpk_password = "esri1234"

    # @faked_latitude = nil
    # @faked_longitude = nil

    # Set if tablet
    if ENV['DEVICE']!= nil and  ENV['DEVICE'].upcase =='IPAD'
      @is_ipad = true
    end

    # Set if Landscape
    if ENV['ORIENTATION'] != nil and ENV['ORIENTATION'].upcase == 'LANDSCAPE'
      @is_landscape = true
    end

    # compare screenshot
    @compare_screenshot = false
    _compare_screenshot_env_var = ENV['compare_screenshot']
    if !_compare_screenshot_env_var.nil? && _compare_screenshot_env_var == 'true'
      @compare_screenshot = true
      # screenshot baseline
      _screenshot_baseline = ENV['screenshot_baseline']
      if !_screenshot_baseline.nil?
        @screenshot_baseline = _screenshot_baseline
      end
      log("   screenshot baseline = #{@screenshot_baseline}")
    end

  end

end