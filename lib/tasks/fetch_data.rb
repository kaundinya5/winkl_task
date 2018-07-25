require 'csv'
require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'
require "selenium-webdriver"
require 'pry'
csv_text = File.read("./instagram-list-Task-.csv")
csv = CSV.parse(csv_text)
csv.flatten!
csv.shift
  include Capybara::DSL
  Capybara.configure do |config|
    config.default_driver = :selenium
    config.javascript_driver = :selenium
    config.run_server = false
    config.app_host = "https://kannada.pratilipi.com"
  end
Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.register_driver :headless_chrome do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
      chromeOptions: { args: %w(headless disable-gpu) }
  )

  Capybara::Selenium::Driver.new app,
                                 browser: :chrome,
                                 desired_capabilities: capabilities
end
  @session = Capybara::Session.new(:headless_chrome)
csv.delete_if do |ig_handle|
  @session.visit("https://www.instagram.com/#{ig_handle}/?hl=en")
  if @session.has_text?("Sorry, this page isn't available.")
    true
  end
end
binding.pry