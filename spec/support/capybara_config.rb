require "capybara/rspec"

Capybara.register_driver(:chrome) do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.register_driver(:headless_chrome) do |app|
  capabilities =
    Selenium::WebDriver::Remote::Capabilities.chrome(
      chromeOptions: { args: %w[headless disable-gpu] }
    )

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome, desired_capabilities: capabilities
  )
end

Capybara.javascript_driver = :headless_chrome
# Capybara.javascript_driver = :chrome

Capybara.default_host = "http://rapidrubystarter.test"
Capybara.asset_host = "http://rapidrubystarter.test"
