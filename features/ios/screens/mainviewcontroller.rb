
class MainViewController  < ScreenBase

  def await(opts = nil)
    wait_true{ exists{ find_element(:name, "scan_controller_bttn") } }
    self
  end

  def scan_controller
    transition(
      :action => Proc.new(){
        find_element(:name, "scan_controller_bttn").click
      },
      :screen => ScanViewController,
      :await => true
    )
  end

end