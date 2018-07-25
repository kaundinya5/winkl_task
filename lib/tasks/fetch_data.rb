require 'csv'
require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'
require "selenium-webdriver"
csv_text = File.read("./instagram-list-Task-.csv")
csv = CSV.parse(csv_text)
csv.flatten!
csv.shift
  include Capybara::DSL
  chrome_bin = ENV.fetch('GOOGLE_CHROME_SHIM', nil)
  chrome_opts = chrome_bin ? { "chromeOptions" => { "binary" => chrome_bin } } : {}
  Capybara.configure do |config|
    config.default_driver = :selenium
    config.javascript_driver = :selenium
    config.run_server = false
    config.app_host = "https://kannada.pratilipi.com"
  end
  Capybara.register_driver :chrome do |app|
    Capybara::Selenium::Driver.new(app, :browser => :chrome)
  end
  Capybara.register_driver :headless_chrome do |app|
    capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(chrome_opts)
    Capybara::Selenium::Driver.new app, browser: :chrome, desired_capabilities: capabilities
  end
  @session = Capybara::Session.new(:headless_chrome)