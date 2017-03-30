
class ScanController  < ScreenBase

  def await(opts = nil)
    wait_true{ exists{ find_element(:xpath, "//XCUIElementTypeNavigationBar[@name='Scan']") } }
    wait_true{ exists{ find_element(:xpath, "//XCUIElementTypeButton[@name='Refresh']") } }
    wait_true{ exists{ find_element(:xpath, "//XCUIElementTypeButton[@name='Info']") } }
    wait_true{ exists{ find_element(:xpath, "//XCUIElementTypeButton[@name='List']") } }
    wait_true{ exists{ find_element(:name, "code_text") } }
    self
  end

  def refresh
    find_element(:xpath, "//XCUIElementTypeButton[@name='Refresh']")
    verify_refreshed_state
  end

  def about_screen
    transition(
        :action => Proc.new(){
          find_element(:xpath, "//XCUIElementTypeButton[@name='Info']").click
        },
        :screen => AboutScreenController,
        :await => true
    )
  end

  def recents_screen
    transition(
        :action => Proc.new(){
          find_element(:xpath, "//XCUIElementTypeButton[@name='List']").click
        },
        :screen => RecentsScreenController,
        :await => true
    )
  end

  def code_text
    code_text_value = find_element(:name, "code_text").value
    return code_text_value
  end

  private def verify_refreshed_state
    refresh_bttn = find_element(:xpath, "//XCUIElementTypeButton[@name='Refresh']")
    if refresh_bttn.enabled?
      print("   screen was not reset. refresh button still enabled")
      fail
    end
    if code_text != "Scan valid ArcGIS URL"
      print("   screen was not reset. code text not set to default")
      fail
    end
  end

end