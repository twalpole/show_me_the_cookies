module ShowMeTheCookies

  require 'show_me_the_cookies/culerity'
  require 'show_me_the_cookies/rack_test'
  require 'show_me_the_cookies/selenium'

  def current_driver_adapter
    driver = Capybara.current_session.driver
    case Capybara.current_driver
    when :selenium
      ShowMeTheCookies::Selenium.new driver
    when :rack_test
      ShowMeTheCookies::RackTest.new driver
    when :culerity
      ShowMeTheCookies::Culerity.new driver
    else
      raise "unsupported driver, use rack::test, selenium/webdriver or culerity"
    end
  end

  def show_me_the_cookies
    announce "Current cookies: #{current_driver_adapter.show_me_the_cookies}"
  end

  def delete_cookie(cookie_name)
    announce current_driver_adapter.show_me_the_cookies if @announce
    current_driver_adapter.delete_cookie(cookie_name)
    announce "Deleted cookie: #{cookie_name}" if @announce
    announce current_driver_adapter.show_me_the_cookies if @announce
  end

  def set_cookie(name, value, opts={})
    announce current_driver_adapter.show_me_the_cookies if @announce
    current_driver_adapter.set_cookie(name, value, opts)
    announce "Set cookie: #{name}" if @announce
    announce current_driver_adapter.show_me_the_cookies if @announce    
  end
  
private
  @@session_cookie_name = nil
end