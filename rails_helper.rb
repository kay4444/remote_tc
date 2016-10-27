require 'test/unit'
require 'selenium-webdriver'
require 'capybara'
require 'rspec'
require "rails/all"
require 'capybara/rspec'
require "page-object"
require 'rspec/expectations'
require 'securerandom'
require '..//Test_helpers//login_helper'
require 'capybara-screenshot/rspec'
require 'launchy'
# require 'chromedriver-helper'
# require 'chromedriver'

# require 'rspec/rails'

RSpec.configure do |config|
  config.include LoginHelper
  config.include RSpec::Matchers
  config.include Capybara::DSL

  environment = 'firefox'

  if environment =='chrome'
    # Selenium::WebDriver::Chrome.driver_path = '..//Resources//chromedriver'
    # Capybara.default_driver = :chrome
    # Capybara.register_driver :selenium do |app|
    #   options = {
    #       :js_errors => false,
    #       :timeout => 360,
    #       :debug => false,
    #       :inspector => false,
    #   }
      # Capybara::Selenium::Driver.new(app, :browser => :chrome)
      Capybara.register_driver :selenium do |app|
        Capybara::Selenium::Driver.new(app, :browser => :chrome)
      end
    # end
  elsif environment =='firefox'
    Capybara.default_driver = :firefox
    Capybara.register_driver :selenium do |app|
      options = {
          :js_errors => true,
          :timeout => 360,
          :debug => false,
          :inspector => false,
      }
      Capybara::Selenium::Driver.new(app, :browser => :firefox)
    end
  elsif environment == 'safari'
    Capybara.default_driver = :safari
    Capybara.register_driver :safari do |app|
      options = {
          :js_errors => false,
          :timeout => 360,
          :debug => false,
          :inspector => false,
      }
      Capybara::Selenium::Driver.new(app, :browser => :safari)
    end
  elsif environment == 'opera'
    Capybara.default_driver = :opera
    Capybara.register_driver :opera do |app|
      options = {
          :js_errors => false,
          :timeout => 360,
          :debug => false,
          :inspector => false,
      }
      Capybara::Selenium::Driver.new(app, :browser => :opera)
    end
  elsif
  Capybara.default_driver = :poltergeist
    Capybara.register_driver :poltergeist do |app|
      options = {
          :js_errors => false,
          :timeout => 360,
          :debug => false,
          :phantomjs_options => ['--load-images=no', '--disk-cache=false'],
          :inspector => false,
      }
      Capybara::Poltergeist::Driver.new(app, options)
    end
  end

  Capybara.save_path = "../Reports" # path where screenshots are saved

  config.after { |example_group| CapybaraScreenshot.save_and_open_page_path if example_group.exception }

  Capybara::Screenshot.register_filename_prefix_formatter(:rspec) do |example|
    "screenshot_#{example.description.gsub(' ', '-').gsub(/^.*\/spec\//, '')}"
  end

end

Capybara.default_max_wait_time = 15




# RSpec.configure do |config|
#
#   config.include LoginHelper # You probably want to only include this for feature tests
#   config.include RSpec::Matchers # not needed if you use the standard capybara rspec setup by including capybara/rspec
#   config.include Capybara::DSL # not needed if you use the standard capybara rspec setup by including capybara/rspec
#
# Capybara.save_path = "../Reports" # path where screenshots are saved
#
# config.after { |example_group| CapybaraScreenshot.save_and_open_page_path if example_group.exception }
#
# Capybara::Screenshot.register_filename_prefix_formatter(:rspec) do |example|
#   "screenshot_#{example.description.gsub(' ', '-').gsub(/^.*\/spec\//, '')}"
# end
#
# end
#
# Selenium::WebDriver::Chrome.driver_path = '../Resources/chromedriver.exe'
# Capybara.register_driver :selenium_chrome do |app|
#   Capybara::Selenium::Driver.new(app, :browser => :chrome)
# end
#
# Capybara.register_driver :selenium_firefox do |app|
#   Capybara::Selenium::Driver.new(app, :browser => :firefox)
# end
#
# Capybara.register_driver :selenium_safari do |app|
#   Capybara::Selenium::Driver.new(app, :browser => :safari)
# end
#
# Capybara.register_driver :selenium_opera do |app|
#   Capybara::Selenium::Driver.new(app, :browser => :opera)
# end
#
# Capybara.register_driver :poltergeist do |app|
#   options = {
#       :js_errors => false,
#       :timeout => 360,
#       :debug => false,
#       :phantomjs_options => ['--load-images=no', '--disk-cache=false'],
#       :inspector => false,
#   }
#   Capybara::Poltergeist::Driver.new(app, options)
# end
#
# Capybara.default_driver = :selenium_firefox