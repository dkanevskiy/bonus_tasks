require 'test-unit'
require 'selenium-webdriver'
require_relative 'helper_methods'

class TestBonusTasks < Test::Unit::TestCase
  include HelperMethods

  def setup
    @driver = Selenium::WebDriver.for :firefox
    @wait = Selenium::WebDriver::Wait.new(:timeout => 10)
  end

  def test_hovers
    hovers
    avatar_text = @driver.find_element(:xpath, "//*[.='name: user3']")
    assert(avatar_text.displayed?)
  end

  def test_drag_and_drop
    drag_and_drop
    assert_equal(@source.text, 'B')
    assert_equal(@target.text, 'A')
  end

  def test_select_list
    select_list('Option 1')
    el1 = @driver.find_element(:xpath, ".//option[@value='1']").attribute('selected')
    assert(el1, "true")
    select_list('Option 2')
    el2 = @driver.find_element(:xpath, ".//option[@value='2']").attribute('selected')
    assert(el2, "true")
  end

  def test_iframe
    iframe('123')
    actual_text = @driver.find_element(:css, '#tinymce>p').text
    assert(actual_text.include?('123'))
  end

  def test_key_press
    @driver.navigate.to 'https://the-internet.herokuapp.com/key_presses'

    @driver.action.send_keys(:enter).perform
    @driver.action.send_keys(:enter).perform
    text = @driver.find_element(:css, '#result').text
    assert(text.include? 'You entered: ENTER')

    @driver.action.send_keys(:tab).perform
    text = @driver.find_element(:css, '#result').text
    assert(text.include? 'You entered: TAB')

    @driver.action.send_keys(:escape).perform
    text = @driver.find_element(:css, '#result').text
    assert(text.include? 'You entered: ESCAPE')
  end

  def test_jquery_ui_menu
    jquery_ui_menu
    el = @driver.find_element(:css, "#ui-id-5>a")
    assert(el.displayed?)
  end

  def test_javascript_alert
    javascript_alert
    result = @driver.find_element(:id, 'result').text
    assert_equal(result, 'You successfuly clicked an alert')
  end

  def test_javascript_alert_cancel
    javascript_alert_cancel
    result = @driver.find_element(:id, 'result').text
    assert_equal(result, 'You clicked: Cancel')
  end

  def test_javascript_prompt
    javascript_prompt('123')
    result = @driver.find_element(:id, 'result').text
    assert_equal(result, "You entered: 123")
  end

  def test_new_window
    new_window
    actual_text = @driver.find_element(:css, '.example>h3').text
    assert_equal(actual_text, 'New Window')
  end

  def teardown
    @driver.quit
  end

end