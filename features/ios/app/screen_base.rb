

# this is a base class for all screen classes and MobileApp
# it provides functions for screen/page transition

class ScreenBase

  def await(wait_opts={})
    # wait_for_elements_exist([trait], wait_opts)
    # unless wait_opts.has_key?(:await_animation) && !wait_opts[:await_animation]
    #   sleep(transition_duration)
    # end
    # self
  end



# used to transition from one screen to another
# return an instance of the screen the app transitions to
  def transition(transition_options={})
    # uiquery = transition_options[:tap]
    action = transition_options[:action]
    screen_arg = transition_options[:screen]
    should_await = transition_options.has_key?(:await) ? transition_options[:await] : true

    if !action.nil?
      action.call()
    end

    screen_obj = screen_arg.is_a?(Class) ? screen(screen_arg) : screen_arg
    screen_obj ||= self

    if should_await
      wait_opts = transition_options[:wait_options] || {}
      if screen_obj == self
        unless wait_opts.has_key?(:await_animation) && !wait_opts[:await_animation]
          sleep(transition_duration)
        end
      else
        screen_obj.await(wait_opts)
      end
    end

    log("=> #{screen_obj.class.name}")

    screen_obj
  end


  def take_screenshot(folder, file_name=nil)
     _path = "./screenshots"
     if !folder.nil?
        _path = "./screenshots/" + folder
     end

     if file_name.nil?
       file_name = self.class.name + ".png"
     else
       file_name += ".png"
     end

     begin
       # make sure screenshots folder exists
       FileUtils.mkdir_p _path
       sleep(8)
       screenshot "#{_path}/#{file_name}"
       log("   screenshot saved to: #{_path}/#{file_name}")
       sleep(1)
     rescue
       log("   could not take a screenshot! app crashed?")
     end
  end

end


