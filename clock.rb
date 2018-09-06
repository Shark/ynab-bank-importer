require 'rubygems'

require 'bundler/setup'
require 'yaml'
require 'ynab'
require 'raven'

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |f| require f }
Dir[File.join('.', 'lib/**/*.rb')].each { |f| require f }

if ENV['DOKKU_APP_TYPE']
  Capybara.register_driver :selenium_chrome_headless do |app|
    Capybara::Selenium::Driver.load_selenium
    browser_options = ::Selenium::WebDriver::Chrome::Options.new
    browser_options.args << '--headless'
    browser_options.args << '--disable-gpu'
    browser_options.args << '--no-sandbox'
    browser_options.args << '--disable-dev-shm-usage'
    browser_options.binary = '/app/.apt/usr/lib/chromium-browser/chromium-browser'
    Capybara::Selenium::Driver.new(app, browser: :chrome, options: browser_options)
  end
end

module Clockwork
  error_handler do |error|
    Raven.capture_exception(error)
  end

  every(8 * 60 * 60, 'importer') do # 8 hours
    Importer.run
  end
end