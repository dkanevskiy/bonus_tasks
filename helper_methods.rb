module HelperMethods

  def hovers
    @driver.navigate.to 'https://the-internet.herokuapp.com/hovers'
    avatar = @driver.find_element(:css, '.figure:last-of-type')
    @driver.action.move_to(avatar).perform
  end

  def drag_and_drop
    @driver.navigate.to 'https://the-internet.herokuapp.com/drag_and_drop'
    @source = @driver.find_element(:id, 'column-a')
    @target = @driver.find_element(:id, 'column-b')
    @driver.action.drag_and_drop(@target, @source).perform
  end

  def select_list(option_text)
    @driver.navigate.to 'https://the-internet.herokuapp.com/dropdown'
    @option = Selenium::WebDriver::Support::Select.new(@driver.find_element(:id => "dropdown"))
    @option.select_by(:text, "#{option_text}")
  end

  def iframe(text)
    @driver.navigate.to 'https://the-internet.herokuapp.com/iframe'
    @driver.switch_to.frame('mce_0_ifr')
    @driver.find_element(:id, 'tinymce').send_keys("#{text}")
  end

  def jquery_ui_menu
    @driver.navigate.to 'https://the-internet.herokuapp.com/jqueryui/menu'
    @driver.action.move_to(@driver.find_element(:css, "#ui-id-3>a")).perform
    @wait.until {@driver.find_element(:css, "#ui-id-4>a").displayed?}
    @driver.action.move_to(@driver.find_element(:css, "#ui-id-4>a")).perform
    @wait.until {@driver.find_element(:css, "#ui-id-5>a").displayed?}
    @driver.action.move_to(@driver.find_element(:css, "#ui-id-5>a")).perform
  end

  def javascript_alert
    @driver.navigate.to 'https://the-internet.herokuapp.com/javascript_alerts'
    @driver.find_element(:xpath, './/li[1]/button').click
    alert = @driver.switch_to.alert
    assert_equal(alert.text, 'I am a JS Alert')
    alert.accept
  end

  def javascript_alert_cancel
    @driver.navigate.to 'https://the-internet.herokuapp.com/javascript_alerts'
    @driver.find_element(:xpath, './/li[2]/button').click
    alert = @driver.switch_to.alert
    assert_equal(alert.text, 'I am a JS Confirm')
    alert.dismiss
  end

  def javascript_prompt(text)
    @driver.navigate.to 'https://the-internet.herokuapp.com/javascript_alerts'
    @driver.find_element(:xpath, './/li[3]/button').click
    alert = @driver.switch_to.alert
    assert_equal(alert.text, 'I am a JS prompt')
    alert.send_keys(text)
    alert.accept
  end

  def new_window
    @driver.navigate.to 'https://the-internet.herokuapp.com/windows'
    @driver.find_element(:css, '.example>a').click
    @driver.switch_to.window @driver.window_handles.last
  end

end

