
class AboutScreen < ScreenBase

  def await(opts = nil)
    wait_true{ find_elements(:xpath, "//UIANavigationBar[@name='About']") }
    wait_true{ exists{ button("Account") } }
    self
  end

  def check_version(version)
    _version = find_elements(:xpath, "//UIATableCell/UIAStaticText[@name='App Version']/../UIAStaticText").last.text
    if _version == version
      log("App Version: #{_version}")
    else
      fail_and_continue("App Version:#{_version}, expected:#{version}")
    end
  end

  def check_build(build_num)
    _build_num = find_elements(:xpath, "//UIATableCell/UIAStaticText[@name='Build']/../UIAStaticText").last.text

    if _build_num == build_num
      log("Build: #{build_num}")
    else
      fail_and_continue("Build:#{_build_num}, expected:#{build_num}")
    end
  end

  def back
    transition(
        :action => Proc.new(){
          button("Account").click
        },
        :screen => AccountScreen,
        :await => true
    )
  end

end